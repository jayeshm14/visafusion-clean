using Microsoft.AspNetCore.Identity;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging.Abstractions;
using Microsoft.Extensions.Options;
using VisaFusion.Api.Application;
using VisaFusion.Core.Application;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;
using VisaFusion.Identity;
using VisaFusion.Identity.Persistence;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// User-management integration tests (SPEC-0007 T018, US2, FR-005..007,
/// FR-023, BR-004; AC-003/AC-018; contracts/admin-api.md §4/§5/§6).
///
/// Exercises the REAL <see cref="UserManagementService"/> (VisaFusion.Api.Application,
/// deviation log §8) over a real SQL Server — one <see cref="VisaEntryDbContext"/>
/// (the legacy `agents` table + `adminauditlog`) and one
/// <see cref="VisaFusionIdentityDbContext"/> (the Identity store the service
/// coordinates with):
///   - create with a whitelisted role: user row + role + §19 audit event,
///   - the agt claim-link rule (CHK026): agentId required for agt, must
///     reference an existing agent row, and is stored on the Identity user,
///   - duplicate username → UserManagementConflictException (409, CHK025),
///   - `su` role rejected on create (400, BR-004) — reachable only via the
///     su-only provisioning path (FR-006),
///   - deactivate (FR-023, AC-018): the linked login is locked — the same
///     IsLockedOutAsync check AuthEndpoint.LoginAsync performs, so
///     authentication is rejected — while the row and audit references are
///     preserved,
///   - the su-target rule (FR-007): deactivating an su target requires an su
///     actor.
/// The HTTP matrix is owned by the functional suite (hermetic factory stubs
/// the service); this suite proves the real DB behavior. Test rows are deleted
/// in a `finally` block (FK-safe order: audit, user roles, user, agent). Tests
/// skip when SQL Server is unreachable or the required tables do not exist
/// (existing convention).
/// </summary>
public class UserManagementIntegrationTests
{
    private const string DefaultTargetConnectionString =
        "Server=localhost;Database=VisaFusion;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true";

    private const string Password = "Str0ngPass!";

    private static string TargetConnectionString =>
        Environment.GetEnvironmentVariable("VISA_FUSION_TEST_CONNECTION") ?? DefaultTargetConnectionString;

    private static bool TargetReachable()
    {
        try
        {
            using var target = new SqlConnection(TargetConnectionString);
            target.Open();
            return true;
        }
        catch
        {
            return false;
        }
    }

    [Fact]
    public async Task User_Management_Lifecycle_Against_The_Real_Database()
    {
        if (!TargetReachable()) return;

        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await TableExistsAsync(connection, "agents")) return;
        if (!await TableExistsAsync(connection, "adminauditlog")) return;
        if (!await TableExistsAsync(connection, "AspNetUsers")) return;

        var actorUserId = $"u-{Guid.NewGuid():N}";
        var actorUserName = $"t018-admin-{Guid.NewGuid():N}";
        var username = $"t018-emp-{Guid.NewGuid():N}";
        var agtUsername = $"t018-agt-{Guid.NewGuid():N}";
        var suTargetName = $"t018-adm-{Guid.NewGuid():N}";
        var agentId = 0;
        var userId = string.Empty;
        var agtUserId = string.Empty;
        var suTargetId = string.Empty;

        try
        {
            var harness = new Harness(connection.ConnectionString);
            var agent = SeedAgent(harness.EntryDb, actorUserName);
            agentId = agent.Id;

            // ---- Create with a whitelisted role (FR-005, AC-003) ----
            var user = await harness.Service.CreateAsync(
                new CreateUserInput(username, Password, null, "emp"),
                actorUserId, actorUserName);

            userId = user.Id;
            Assert.True(user.Active);
            Assert.Contains("emp", user.Roles);

            var stored = await harness.IdentityDb.Users.SingleAsync(u => u.UserName == username);
            Assert.False(string.Equals(Password, stored.PasswordHash, StringComparison.Ordinal));
            Assert.False(await harness.UserManager.IsLockedOutAsync(stored));
            var roles = await harness.UserManager.GetRolesAsync(stored);
            Assert.Contains(IdentityIntegration.Roles.Employee, roles);

            // §19 user-creation audit event.
            Assert.True(await AuditRowExistsAsync(connection, actorUserName, "UserCreated"));

            // ---- agt claim-link rule (CHK026): valid agentId stored ----
            var agtUser = await harness.Service.CreateAsync(
                new CreateUserInput(agtUsername, Password, null, "agt", agentId),
                actorUserId, actorUserName);
            agtUserId = agtUser.Id;
            Assert.Contains("agt", agtUser.Roles);
            var agtStored = await harness.IdentityDb.Users.SingleAsync(u => u.UserName == agtUsername);
            Assert.Equal(agent.Id, agtStored.AgentId);

            // ---- agt without agentId → validation (400) ----
            await Assert.ThrowsAsync<UserManagementValidationException>(() =>
                harness.Service.CreateAsync(
                    new CreateUserInput($"t018-agt2-{Guid.NewGuid():N}", Password, null, "agt"),
                    actorUserId, actorUserName));

            // ---- agt with unknown agentId → validation (400) ----
            await Assert.ThrowsAsync<UserManagementValidationException>(() =>
                harness.Service.CreateAsync(
                    new CreateUserInput($"t018-agt3-{Guid.NewGuid():N}", Password, null, "agt", 99999999),
                    actorUserId, actorUserName));

            // ---- duplicate username → 409 (CHK025) ----
            await Assert.ThrowsAsync<UserManagementConflictException>(() =>
                harness.Service.CreateAsync(
                    new CreateUserInput(username, Password, null, "emp"),
                    actorUserId, actorUserName));

            // ---- su role rejected on create (BR-004) ----
            await Assert.ThrowsAsync<UserManagementValidationException>(() =>
                harness.Service.CreateAsync(
                    new CreateUserInput($"t018-su-{Guid.NewGuid():N}", Password, null, "su"),
                    actorUserId, actorUserName));

            // ---- Deactivate (FR-023, AC-018): login rejected, row preserved ----
            var deactivated = await harness.Service.DeactivateAsync(
                userId, actorUserId, actorUserName, new[] { "adm" });
            Assert.False(deactivated.Active);

            var locked = await harness.IdentityDb.Users.SingleAsync(u => u.UserName == username);
            Assert.True(await harness.UserManager.IsLockedOutAsync(locked));
            Assert.True(locked.LockoutEnabled);
            Assert.NotNull(locked.LockoutEnd);

            Assert.True(await AuditRowExistsAsync(connection, actorUserName, "UserDeactivated"));

            // ---- Deactivate unknown id → not found (404) ----
            await Assert.ThrowsAsync<UserManagementNotFoundException>(() =>
                harness.Service.DeactivateAsync(
                    $"u-{Guid.NewGuid():N}", actorUserId, actorUserName, new[] { "adm" }));
        }
        finally
        {
            await CleanupAsync(connection, agentId, new[] { userId, agtUserId, suTargetId }, actorUserName);
        }
    }

    [Fact]
    public async Task Super_User_Provisioning_And_Su_Target_Deactivation_Against_The_Real_Database()
    {
        if (!TargetReachable()) return;

        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await TableExistsAsync(connection, "adminauditlog")) return;
        if (!await TableExistsAsync(connection, "AspNetUsers")) return;

        var suActorUserId = $"u-{Guid.NewGuid():N}";
        var suActorUserName = $"t018-su-admin-{Guid.NewGuid():N}";
        var plainActorUserName = $"t018-admin-{Guid.NewGuid():N}";
        var targetName = $"t018-adm-{Guid.NewGuid():N}";
        var targetId = string.Empty;

        try
        {
            var harness = new Harness(connection.ConnectionString);

            // ---- Provision super-user (FR-006, AC-003) ----
            var target = await harness.Service.CreateAsync(
                new CreateUserInput(targetName, Password, null, "adm"),
                suActorUserId, plainActorUserName);
            targetId = target.Id;

            var provisioned = await harness.Service.ProvisionSuperUserAsync(
                target.Id, suActorUserId, suActorUserName, new[] { "su" });

            Assert.Contains("su", provisioned.Roles);
            Assert.True(provisioned.Active);
            Assert.True(await AuditRowExistsAsync(connection, suActorUserName, "SuperUserProvisioned"));

            var storedRoles = await harness.UserManager.GetRolesAsync(
                await harness.IdentityDb.Users.SingleAsync(u => u.UserName == targetName));
            Assert.Contains(IdentityIntegration.Roles.SuperUser, storedRoles);

            // ---- Non-su actor cannot provision (service re-check) ----
            await Assert.ThrowsAsync<UserManagementValidationException>(() =>
                harness.Service.ProvisionSuperUserAsync(
                    target.Id, suActorUserId, plainActorUserName, new[] { "adm" }));

            // ---- FR-007: non-su actor cannot deactivate an su target ----
            await Assert.ThrowsAsync<UserManagementValidationException>(() =>
                harness.Service.DeactivateAsync(
                    target.Id, suActorUserId, plainActorUserName, new[] { "adm" }));

            // The su actor can.
            var deactivated = await harness.Service.DeactivateAsync(
                target.Id, suActorUserId, suActorUserName, new[] { "su" });
            Assert.False(deactivated.Active);

            Assert.True(await AuditRowExistsAsync(connection, suActorUserName, "UserDeactivated"));
        }
        finally
        {
            await CleanupAsync(connection, agentId: 0, userIds: new[] { targetId }, actorUserName: suActorUserName);
        }
    }

    private static Agent SeedAgent(VisaEntryDbContext db, string enteredBy)
    {
        var agent = new Agent { Companyname = $"t018-{Guid.NewGuid():N}", Active = "Y", Enteredby = enteredBy };
        db.Agents.Add(agent);
        db.SaveChanges();
        return agent;
    }

    private static async Task<bool> TableExistsAsync(SqlConnection connection, string table)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @table";
        cmd.Parameters.AddWithValue("@table", table);
        return Convert.ToInt32(await cmd.ExecuteScalarAsync()) > 0;
    }

    private static async Task<bool> AuditRowExistsAsync(
        SqlConnection connection, string actorUserName, string eventType)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText =
            "SELECT COUNT(*) FROM dbo.adminauditlog WHERE ActorUserName = @actor AND EventType = @eventType";
        cmd.Parameters.AddWithValue("@actor", actorUserName);
        cmd.Parameters.AddWithValue("@eventType", eventType);
        return Convert.ToInt32(await cmd.ExecuteScalarAsync()) > 0;
    }

    private static async Task CleanupAsync(
        SqlConnection connection, int agentId, IEnumerable<string> userIds, string actorUserName)
    {
        // Deletes only the rows this test created (marker actor / test users /
        // test agent), never real data. FK-safe order: audit rows, user roles,
        // users, then the agent.
        foreach (var userId in userIds.Where(static id => !string.IsNullOrEmpty(id)))
        {
            await using (var userCmd = connection.CreateCommand())
            {
                userCmd.CommandText = "DELETE FROM dbo.AspNetUserRoles WHERE UserId = @userId; DELETE FROM dbo.AspNetUsers WHERE Id = @userId;";
                userCmd.Parameters.AddWithValue("@userId", userId);
                await userCmd.ExecuteNonQueryAsync();
            }
        }

        await using var cmd = connection.CreateCommand();
        cmd.CommandText = """
            DELETE FROM dbo.adminauditlog WHERE ActorUserName = @actor;
            DELETE FROM dbo.agents WHERE agentsID = @agentId AND Enteredby = @actor;
            """;
        cmd.Parameters.AddWithValue("@actor", actorUserName);
        cmd.Parameters.AddWithValue("@agentId", agentId);
        await cmd.ExecuteNonQueryAsync();
    }

    private sealed class Harness
    {
        public Harness(string connectionString)
        {
            EntryDb = new VisaEntryDbContext(
                new DbContextOptionsBuilder<VisaEntryDbContext>()
                    .UseSqlServer(connectionString)
                    .Options);

            IdentityDb = new VisaFusionIdentityDbContext(
                new DbContextOptionsBuilder<VisaFusionIdentityDbContext>()
                    .UseSqlServer(connectionString)
                    .Options);

            UserManager = BuildUserManager(IdentityDb);
            Service = new UserManagementService(EntryDb, UserManager);
        }

        public VisaEntryDbContext EntryDb { get; }

        public VisaFusionIdentityDbContext IdentityDb { get; }

        public UserManager<IdentityIntegration.VisaFusionUser> UserManager { get; }

        public UserManagementService Service { get; }

        private static UserManager<IdentityIntegration.VisaFusionUser> BuildUserManager(
            VisaFusionIdentityDbContext db)
        {
            // The five role rows already exist in the migrated target (identity
            // DDL seeds su/adm/emp/agt/guest with fixed Ids = names), so no
            // seeding is required here — AddToRoleAsync resolves the role
            // against the real AspNetRoles row. RequireUniqueEmail defaults to
            // false (matching the host — Program.cs disables it because email
            // is optional for the admin/agent creation paths, contract §4).
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