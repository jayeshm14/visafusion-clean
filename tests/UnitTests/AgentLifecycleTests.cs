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
/// Agent lifecycle unit tests (SPEC-0007 T006/T010/T011, US1, FR-001..004,
/// FR-022, BR-009; AC-001/AC-016/AC-017; contracts/agents-api.md §1/§6/§7).
///
/// Exercises the real <see cref="AgentService"/> (VisaFusion.Api.Application)
/// over hermetic EF InMemory stores — one <see cref="VisaEntryDbContext"/>
/// (the legacy `agents` table) and one <see cref="VisaFusionIdentityDbContext"/>
/// (the Identity store the service coordinates with, deviation log §8):
///   - atomic create (BR-009): agent row + `agt` login + AgentId claim link,
///   - duplicate username → 409 (AgentConflictException, CHK025),
///   - deactivate (FR-004): Active='N' + linked login locked,
///   - reactivate (FR-022): Active='Y' + login unlocked,
///   - update validation (at least one field) and 404,
///   - audit events (spec §19) for create/deactivate/reactivate.
/// </summary>
public class AgentLifecycleTests
{
    private const string Password = "Str0ngPass!";

    [Fact]
    public async Task Create_Atomically_Provisions_Agent_Login_And_Claim_Link()
    {
        var harness = new Harness();
        var input = NewInput();

        var agent = await harness.Service.CreateAsync(
            input, "agt-create-1", Password, actorUserId: "u-admin", actorUserName: "admin1");

        // Agent row created with the active convention 'Y' (R-007).
        Assert.Equal("Acme Travels", agent.Companyname);
        Assert.Equal("Y", agent.Active);
        Assert.NotNull(agent.Creationdate);

        // Linked agt login with the AgentId claim link (BR-009).
        var user = harness.IdentityDb.Users.Single(u => u.UserName == "agt-create-1");
        Assert.Equal(agent.Id, user.AgentId);
        var roles = await harness.UserManager.GetRolesAsync(user);
        Assert.Contains(IdentityIntegration.Roles.Agent, roles);

        // The stored password hash is not the plaintext password.
        Assert.False(string.Equals(Password, user.PasswordHash, StringComparison.Ordinal));

        // §19 user-creation audit event.
        var audit = harness.EntryDb.AdminAuditLogs.Single(a => a.EventType == "UserCreated");
        Assert.Equal("admin1", audit.ActorUserName);
        Assert.Equal(IdentityIntegration.Roles.Agent, audit.Role);
    }

    [Fact]
    public async Task Create_With_Duplicate_Username_Returns_Conflict()
    {
        var harness = new Harness();
        await harness.Service.CreateAsync(
            NewInput(), "agt-dup", Password, actorUserId: "u-admin", actorUserName: "admin1");

        var ex = await Assert.ThrowsAsync<AgentConflictException>(() =>
            harness.Service.CreateAsync(
                NewInput(), "agt-dup", Password, actorUserId: "u-admin", actorUserName: "admin1"));

        Assert.Contains("agt-dup", ex.Message);
    }

    [Fact]
    public async Task Create_Missing_Companyname_Is_A_Validation_Failure()
    {
        var harness = new Harness();
        var input = NewInput() with { Companyname = null };

        var ex = await Assert.ThrowsAsync<AgentValidationException>(() =>
            harness.Service.CreateAsync(input, "agt-no-name", Password, "u-admin", "admin1"));

        Assert.Contains("companyname", ex.Message);
    }

    [Fact]
    public async Task Create_Missing_Username_Or_Password_Is_A_Validation_Failure()
    {
        var harness = new Harness();

        await Assert.ThrowsAsync<AgentValidationException>(() =>
            harness.Service.CreateAsync(NewInput(), " ", Password, "u-admin", "admin1"));
        await Assert.ThrowsAsync<AgentValidationException>(() =>
            harness.Service.CreateAsync(NewInput(), "agt-no-pw", "", "u-admin", "admin1"));
    }

    [Fact]
    public async Task Failed_Create_Rolls_Back_The_Fresh_Agent_Row()
    {
        var harness = new Harness();
        await harness.Service.CreateAsync(
            NewInput(), "agt-rollback", Password, actorUserId: "u-admin", actorUserName: "admin1");

        var agent = harness.EntryDb.Agents.Single(a => a.Companyname == NewInput().Companyname);

        // A duplicate username fails AFTER the agent row was inserted; the fresh
        // unreferenced row must be rolled back (FR-004 allows deleting
        // unreferenced records) so no agent survives without its login.
        await Assert.ThrowsAsync<AgentConflictException>(() =>
            harness.Service.CreateAsync(
                NewInput(), "agt-rollback", Password, actorUserId: "u-admin", actorUserName: "admin1"));

        Assert.Single(harness.EntryDb.Agents);
    }

    [Fact]
    public async Task Deactivate_Sets_Active_No_And_Locks_The_Linked_Login()
    {
        var harness = new Harness();
        var agent = await harness.Service.CreateAsync(
            NewInput(), "agt-deact", Password, actorUserId: "u-admin", actorUserName: "admin1");
        var user = harness.IdentityDb.Users.Single(u => u.UserName == "agt-deact");

        var deactivated = await harness.Service.DeactivateAsync(
            agent.Id, actorUserId: "u-admin", actorUserName: "admin1");

        // Business state: Active = 'N' (R-007). Data preserved — nothing deleted.
        Assert.Equal("N", deactivated.Active);
        Assert.NotNull(harness.EntryDb.Agents.Single(a => a.Id == agent.Id));

        // Identity state: the linked login rejects authentication (FR-004) —
        // the same IsLockedOutAsync check AuthEndpoint.LoginAsync uses.
        Assert.True(await harness.UserManager.IsLockedOutAsync(user));
        Assert.True(user.LockoutEnabled);
        Assert.NotNull(user.LockoutEnd);

        // §19 deactivation audit event.
        Assert.Single(harness.EntryDb.AdminAuditLogs.Where(a => a.EventType == "UserDeactivated"));
    }

    [Fact]
    public async Task Deactivate_Unknown_Agent_Is_Not_Found()
    {
        var harness = new Harness();

        await Assert.ThrowsAsync<AgentNotFoundException>(() =>
            harness.Service.DeactivateAsync(999_999, "u-admin", "admin1"));
    }

    [Fact]
    public async Task Reactivate_Restores_Active_Yes_And_Unlocks_The_Login()
    {
        var harness = new Harness();
        var agent = await harness.Service.CreateAsync(
            NewInput(), "agt-react", Password, actorUserId: "u-admin", actorUserName: "admin1");
        await harness.Service.DeactivateAsync(agent.Id, "u-admin", "admin1");
        var user = harness.IdentityDb.Users.Single(u => u.UserName == "agt-react");

        var reactivated = await harness.Service.ReactivateAsync(
            agent.Id, actorUserId: "u-admin", actorUserName: "admin1");

        Assert.Equal("Y", reactivated.Active);
        Assert.False(await harness.UserManager.IsLockedOutAsync(user));
        Assert.Null(user.LockoutEnd);

        // §19 reactivation audit event.
        Assert.Single(harness.EntryDb.AdminAuditLogs.Where(a => a.EventType == "UserReactivated"));
    }

    [Fact]
    public async Task Update_Requires_At_Least_One_Field()
    {
        var harness = new Harness();
        var agent = await harness.Service.CreateAsync(
            NewInput(), "agt-update", Password, actorUserId: "u-admin", actorUserName: "admin1");
        var emptyPatch = new AgentInput(
            null, null, null, null, null, null, null, null, null, null, null,
            null, null, null, null, null, null, null, null, null, null, null);

        await Assert.ThrowsAsync<AgentValidationException>(() =>
            harness.Service.UpdateAsync(agent.Id, emptyPatch));
    }

    [Fact]
    public async Task Update_Unknown_Agent_Is_Not_Found()
    {
        var harness = new Harness();
        var patch = NewInput() with { Description = "changed" };

        await Assert.ThrowsAsync<AgentNotFoundException>(() =>
            harness.Service.UpdateAsync(999_999, patch));
    }

    [Fact]
    public async Task Update_Changes_Fields_But_Never_The_Lifecycle_Flag()
    {
        var harness = new Harness();
        var agent = await harness.Service.CreateAsync(
            NewInput(), "agt-update2", Password, actorUserId: "u-admin", actorUserName: "admin1");
        var patch = new AgentInput(
            null, "new description", null, null, null, null, null, null, null, null, null,
            null, null, null, null, null, null, null, null, null, null, null);

        var updated = await harness.Service.UpdateAsync(agent.Id, patch);

        Assert.Equal("new description", updated.Description);
        Assert.Equal("Y", updated.Active); // lifecycle flag untouched by update
    }

    [Fact]
    public async Task List_Filters_By_Keyword_And_Paginates()
    {
        var harness = new Harness();
        await harness.Service.CreateAsync(
            NewInput(), "agt-list-1", Password, actorUserId: "u-admin", actorUserName: "admin1");
        await harness.Service.CreateAsync(
            NewInput() with { Companyname = "Zulu Travels" }, "agt-list-2", Password,
            actorUserId: "u-admin", actorUserName: "admin1");

        // Keyword filter on name/company (contracts/agents-api.md §5). The
        // query uses matching case: EF InMemory Contains is case-sensitive,
        // while the real SQL Server default collation is case-insensitive —
        // the service behavior is identical on the real store.
        var result = await harness.Service.ListAsync(page: 1, pageSize: 50, q: "Zulu");

        Assert.Equal(1, result.Total);
        Assert.Single(result.Items);
        Assert.Equal("Zulu Travels", result.Items[0].Companyname);
    }

    private static AgentInput NewInput() => new(
        Companyname: "Acme Travels",
        Description: "agent-1",
        Street1: "10 Main St",
        Street2: null,
        Area: "Downtown",
        City: "Mumbai",
        Pincode: "400001",
        Phoneno: "022-1234",
        Faxno: null,
        Emailid: "acme@example.com",
        Smsno: null,
        Directorname: "A. Owner",
        DirectorPH: "9000000000",
        AcMgrPH: null,
        VisaInchargeName: null,
        VisaInchargePH: null,
        Acno: "A-100",
        Payment: "Credit",
        TAAI: null,
        TAFI: null,
        Membership: "M-1",
        IATA: null);

    private sealed class Harness
    {
        public Harness()
        {
            EntryDb = new VisaEntryDbContext(
                new DbContextOptionsBuilder<VisaEntryDbContext>()
                    .UseInMemoryDatabase($"agent-lifecycle-{Guid.NewGuid():N}")
                    .Options);

            IdentityDb = new VisaFusionIdentityDbContext(
                new DbContextOptionsBuilder<VisaFusionIdentityDbContext>()
                    .UseInMemoryDatabase($"agent-identity-{Guid.NewGuid():N}")
                    .Options);

            UserManager = BuildUserManager(IdentityDb);
            Service = new AgentService(EntryDb, UserManager);
        }

        public VisaEntryDbContext EntryDb { get; }

        public VisaFusionIdentityDbContext IdentityDb { get; }

        public UserManager<IdentityIntegration.VisaFusionUser> UserManager { get; }

        public AgentService Service { get; }

        private static UserManager<IdentityIntegration.VisaFusionUser> BuildUserManager(
            VisaFusionIdentityDbContext db)
        {
            // Seed the role rows AddToRoleAsync requires (the store's
            // RoleExists check reads AspNetRoles by NORMALIZED name).
            db.Roles.Add(new IdentityRole(IdentityIntegration.Roles.Agent) { NormalizedName = "AGT" });
            db.Roles.Add(new IdentityRole(IdentityIntegration.Roles.Admin) { NormalizedName = "ADM" });
            db.Roles.Add(new IdentityRole(IdentityIntegration.Roles.Employee) { NormalizedName = "EMP" });
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
