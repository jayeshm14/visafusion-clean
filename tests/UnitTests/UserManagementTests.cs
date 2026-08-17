using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging.Abstractions;
using Microsoft.Extensions.Options;
using VisaFusion.Api.Application;
using VisaFusion.Core.Application;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;
using VisaFusion.Identity;
using VisaFusion.Identity.Persistence;

namespace VisaFusion.UnitTests;

/// <summary>
/// User-management unit tests (SPEC-0007 T007/T010, US2, FR-006/FR-023,
/// BR-004; AC-003/AC-018; contracts/admin-api.md §4/§5/§6).
///
/// Exercises the real <see cref="UserManagementService"/> (VisaFusion.Api.Application)
/// over hermetic EF InMemory stores:
///   - role whitelist on create (adm/emp/agt/guest allowed; su rejected, BR-004),
///   - duplicate username → 409 (UserManagementConflictException, CHK025),
///   - deactivate (FR-023): login locked, reversible,
///   - deactivating an su target requires the actor to be su (FR-007),
///   - su provisioning is su-only (FR-006) and audited,
///   - audit events (spec §19) for create/deactivate/provision.
/// </summary>
public class UserManagementTests
{
    private const string Password = "Str0ngPass!";

    [Theory]
    [InlineData("adm")]
    [InlineData("emp")]
    [InlineData("guest")]
    public async Task Create_Accepts_The_Whitelisted_Roles(string role)
    {
        var harness = new Harness();

        var user = await harness.Service.CreateAsync(
            new CreateUserInput($"usr-{role}", Password, "usr@example.com", role),
            actorUserId: "u-admin", actorUserName: "admin1");

        Assert.Equal($"usr-{role}", user.UserName);
        Assert.Contains(role, user.Roles);
        Assert.True(user.Active);

        // §19 user-creation audit event with the granted role.
        var audit = harness.EntryDb.AdminAuditLogs.Single(a => a.EventType == "UserCreated");
        Assert.Equal(role, audit.Role);
        Assert.Equal("admin1", audit.ActorUserName);
    }

    [Fact]
    public async Task Create_Accepts_An_Agt_Role_With_A_Valid_Agent_Link()
    {
        var harness = new Harness();
        var agentId = harness.SeedAgent();

        var user = await harness.Service.CreateAsync(
            new CreateUserInput("usr-agt", Password, "usr@example.com", "agt", agentId),
            actorUserId: "u-admin", actorUserName: "admin1");

        Assert.Contains("agt", user.Roles);
        // The AgentId claim link is stored on the Identity user (CHK026) — the
        // anchor the agent-portal scoping (BR-007) binds to.
        Assert.Equal(agentId, harness.IdentityDb.Users.Single(u => u.UserName == "usr-agt").AgentId);
    }

    [Fact]
    public async Task Create_Agt_Without_AgentId_Is_A_Validation_Failure()
    {
        var harness = new Harness();

        var ex = await Assert.ThrowsAsync<UserManagementValidationException>(() =>
            harness.Service.CreateAsync(
                new CreateUserInput("usr-agt-nolink", Password, null, "agt"),
                actorUserId: "u-admin", actorUserName: "admin1"));

        Assert.Contains("agentId", ex.Message);
    }

    [Fact]
    public async Task Create_Agt_With_Unknown_AgentId_Is_A_Validation_Failure()
    {
        var harness = new Harness();

        var ex = await Assert.ThrowsAsync<UserManagementValidationException>(() =>
            harness.Service.CreateAsync(
                new CreateUserInput("usr-agt-badlink", Password, null, "agt", AgentId: 999999),
                actorUserId: "u-admin", actorUserName: "admin1"));

        Assert.Contains("does not exist", ex.Message);
    }

    [Fact]
    public async Task Create_Rejects_Su_Role()
    {
        var harness = new Harness();

        var ex = await Assert.ThrowsAsync<UserManagementValidationException>(() =>
            harness.Service.CreateAsync(
                new CreateUserInput("usr-su", Password, null, IdentityIntegration.Roles.SuperUser),
                actorUserId: "u-admin", actorUserName: "admin1"));

        Assert.Contains("su", ex.Message);
    }

    [Fact]
    public async Task Create_Rejects_An_Unknown_Role()
    {
        var harness = new Harness();

        await Assert.ThrowsAsync<UserManagementValidationException>(() =>
            harness.Service.CreateAsync(
                new CreateUserInput("usr-unknown", Password, null, "root"),
                actorUserId: "u-admin", actorUserName: "admin1"));
    }

    [Fact]
    public async Task Create_Duplicate_Username_Returns_Conflict()
    {
        var harness = new Harness();
        await harness.Service.CreateAsync(
            new CreateUserInput("usr-dup", Password, null, "emp"),
            actorUserId: "u-admin", actorUserName: "admin1");

        var ex = await Assert.ThrowsAsync<UserManagementConflictException>(() =>
            harness.Service.CreateAsync(
                new CreateUserInput("usr-dup", Password, null, "emp"),
                actorUserId: "u-admin", actorUserName: "admin1"));

        Assert.Contains("usr-dup", ex.Message);
    }

    [Fact]
    public async Task Create_Missing_Username_Or_Password_Is_A_Validation_Failure()
    {
        var harness = new Harness();

        await Assert.ThrowsAsync<UserManagementValidationException>(() =>
            harness.Service.CreateAsync(
                new CreateUserInput(" ", Password, null, "emp"), "u-admin", "admin1"));
        await Assert.ThrowsAsync<UserManagementValidationException>(() =>
            harness.Service.CreateAsync(
                new CreateUserInput("usr-nopw", "", null, "emp"), "u-admin", "admin1"));
    }

    [Fact]
    public async Task Deactivate_Locks_The_Login_And_Preserves_The_Row()
    {
        var harness = new Harness();
        var created = await harness.Service.CreateAsync(
            new CreateUserInput("usr-deact", Password, null, "emp"),
            actorUserId: "u-admin", actorUserName: "admin1");
        var user = harness.IdentityDb.Users.Single(u => u.UserName == "usr-deact");

        var deactivated = await harness.Service.DeactivateAsync(
            created.Id, actorUserId: "u-admin", actorUserName: "admin1", actorRoles: new[] { "adm" });

        // Row preserved; login locked (FR-023) — IsLockedOutAsync is the exact
        // check AuthEndpoint.LoginAsync and LoginModel use.
        Assert.False(deactivated.Active);
        Assert.NotNull(harness.IdentityDb.Users.Single(u => u.UserName == "usr-deact"));
        Assert.True(await harness.UserManager.IsLockedOutAsync(user));
        Assert.NotNull(user.LockoutEnd);

        // §19 deactivation audit event.
        Assert.Single(harness.EntryDb.AdminAuditLogs.Where(a => a.EventType == "UserDeactivated"));
    }

    [Fact]
    public async Task Deactivate_Unknown_User_Is_Not_Found()
    {
        var harness = new Harness();

        await Assert.ThrowsAsync<UserManagementNotFoundException>(() =>
            harness.Service.DeactivateAsync(
                "no-such-id", actorUserId: "u-admin", actorUserName: "admin1",
                actorRoles: new[] { "adm" }));
    }

    [Fact]
    public async Task Deactivating_An_Su_Target_Requires_An_Su_Actor()
    {
        var harness = new Harness();
        var suTarget = await harness.Service.CreateAsync(
            new CreateUserInput("usr-su-target", Password, null, "adm"),
            actorUserId: "u-admin", actorUserName: "admin1");
        await harness.UserManager.AddToRoleAsync(
            harness.IdentityDb.Users.Single(u => u.UserName == "usr-su-target"),
            IdentityIntegration.Roles.SuperUser);

        // Non-su actor (adm) → rejected (FR-007).
        var ex = await Assert.ThrowsAsync<UserManagementValidationException>(() =>
            harness.Service.DeactivateAsync(
                suTarget.Id, actorUserId: "u-admin", actorUserName: "admin1",
                actorRoles: new[] { "adm" }));
        Assert.Contains("super-user", ex.Message);

        // The su actor succeeds.
        var deactivated = await harness.Service.DeactivateAsync(
            suTarget.Id, actorUserId: "u-su", actorUserName: "su1",
            actorRoles: new[] { "su", "adm" });
        Assert.False(deactivated.Active);
    }

    [Fact]
    public async Task Provision_SuperUser_Is_Su_Only()
    {
        var harness = new Harness();
        var target = await harness.Service.CreateAsync(
            new CreateUserInput("usr-provision", Password, null, "adm"),
            actorUserId: "u-admin", actorUserName: "admin1");
        var targetUser = harness.IdentityDb.Users.Single(u => u.UserName == "usr-provision");

        // Non-su actor → rejected (FR-006, AC-003).
        await Assert.ThrowsAsync<UserManagementValidationException>(() =>
            harness.Service.ProvisionSuperUserAsync(
                target.Id, actorUserId: "u-admin", actorUserName: "admin1",
                actorRoles: new[] { "adm" }));

        // su actor → su role granted.
        var provisioned = await harness.Service.ProvisionSuperUserAsync(
            target.Id, actorUserId: "u-su", actorUserName: "su1",
            actorRoles: new[] { "su", "adm" });
        Assert.Contains(IdentityIntegration.Roles.SuperUser, provisioned.Roles);
        Assert.True(await harness.UserManager.IsInRoleAsync(targetUser, IdentityIntegration.Roles.SuperUser));

        // §19 su-provisioning audit event.
        var audit = harness.EntryDb.AdminAuditLogs.Single(a => a.EventType == "SuperUserProvisioned");
        Assert.Equal("su1", audit.ActorUserName);
        Assert.Equal(IdentityIntegration.Roles.SuperUser, audit.Role);
    }

    [Fact]
    public async Task Provision_SuperUser_Unknown_User_Is_Not_Found()
    {
        var harness = new Harness();

        await Assert.ThrowsAsync<UserManagementNotFoundException>(() =>
            harness.Service.ProvisionSuperUserAsync(
                "no-such-id", actorUserId: "u-su", actorUserName: "su1",
                actorRoles: new[] { "su", "adm" }));
    }

    private sealed class Harness
    {
        public Harness()
        {
            EntryDb = new VisaEntryDbContext(
                new DbContextOptionsBuilder<VisaEntryDbContext>()
                    .UseInMemoryDatabase($"user-management-{Guid.NewGuid():N}")
                    .Options);

            IdentityDb = new VisaFusionIdentityDbContext(
                new DbContextOptionsBuilder<VisaFusionIdentityDbContext>()
                    .UseInMemoryDatabase($"user-identity-{Guid.NewGuid():N}")
                    .Options);

            UserManager = BuildUserManager(IdentityDb);
            Service = new UserManagementService(EntryDb, UserManager);
        }

        public VisaEntryDbContext EntryDb { get; }

        public VisaFusionIdentityDbContext IdentityDb { get; }

        public UserManager<IdentityIntegration.VisaFusionUser> UserManager { get; }

        public UserManagementService Service { get; }

        /// <summary>Seeds an agent row (the agt claim-link target, CHK026) and returns its id.</summary>
        public int SeedAgent()
        {
            var agent = new Agent { Companyname = "Seed Co", Active = "Y" };
            EntryDb.Agents.Add(agent);
            EntryDb.SaveChanges();
            return agent.Id;
        }

        private static UserManager<IdentityIntegration.VisaFusionUser> BuildUserManager(
            VisaFusionIdentityDbContext db)
        {
            // Seed the role rows AddToRoleAsync requires (the store's
            // RoleExists check reads AspNetRoles by NORMALIZED name).
            db.Roles.Add(new IdentityRole(IdentityIntegration.Roles.Admin) { NormalizedName = "ADM" });
            db.Roles.Add(new IdentityRole(IdentityIntegration.Roles.Employee) { NormalizedName = "EMP" });
            db.Roles.Add(new IdentityRole(IdentityIntegration.Roles.Agent) { NormalizedName = "AGT" });
            db.Roles.Add(new IdentityRole(IdentityIntegration.Roles.Guest) { NormalizedName = "GUEST" });
            db.Roles.Add(new IdentityRole(IdentityIntegration.Roles.SuperUser) { NormalizedName = "SU" });
            db.SaveChanges();

            var store = new Microsoft.AspNetCore.Identity.EntityFrameworkCore
                .UserStore<IdentityIntegration.VisaFusionUser, IdentityRole,
                    VisaFusionIdentityDbContext, string>(db);
            return new UserManager<IdentityIntegration.VisaFusionUser>(
                store,
                Options.Create(new IdentityOptions()),
                new PasswordHasher<IdentityIntegration.VisaFusionUser>(),
                new[] { new UserValidator<IdentityIntegration.VisaFusionUser>() },
                new[] { new PasswordValidator<IdentityIntegration.VisaFusionUser>() },
                new UpperInvariantLookupNormalizer(),
                new IdentityErrorDescriber(),
                services: null!,
                new NullLogger<UserManager<IdentityIntegration.VisaFusionUser>>());
        }
    }
}
