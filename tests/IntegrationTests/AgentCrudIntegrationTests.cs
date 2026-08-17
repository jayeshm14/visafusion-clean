using Microsoft.AspNetCore.Identity;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging.Abstractions;
using Microsoft.Extensions.Options;
using VisaFusion.Api.Application;
using VisaFusion.Core.Application;
using VisaFusion.Data.Persistence;
using VisaFusion.Identity;
using VisaFusion.Identity.Persistence;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// Agent CRUD integration tests (SPEC-0007 T012, US1, FR-001..004, FR-022,
/// BR-009; AC-001/AC-016/AC-017; contracts/agents-api.md §1/§6/§7).
///
/// Exercises the REAL <see cref="AgentService"/> (VisaFusion.Api.Application,
/// deviation log §8) over a real SQL Server — one <see cref="VisaEntryDbContext"/>
/// (the legacy `agents` table + `adminauditlog`) and one
/// <see cref="VisaFusionIdentityDbContext"/> (the Identity store the service
/// coordinates with):
///   - atomic create (BR-009): agent row (Active='Y', R-007) + linked `agt`
///     login (agt role, AgentId claim link, hashed password — never plaintext)
///     + §19 audit row; the created login is usable (not locked),
///   - duplicate username → AgentConflictException (409, CHK025),
///   - deactivate (FR-004): Active='N' + the linked login is locked — the same
///     IsLockedOutAsync check AuthEndpoint.LoginAsync performs, so
///     authentication is rejected — while the agent row and its data remain
///     intact (nothing deleted),
///   - reactivate (FR-022): Active='Y' + the linked login is unlocked — login
///     restored.
/// The DB-level lock assertions stand in for the HTTP login flow (the
/// functional suite owns the HTTP matrix; the hermetic factory stubs the
/// service there). Test rows are deleted in a `finally` block (FK-safe order:
/// audit, user roles, user, then agent — the AspNetUsers.AgentId column has no
/// FK, so the user must go before the agent only to keep cleanup tidy). Tests
/// skip when SQL Server is unreachable or the required tables do not exist
/// (existing convention).
/// </summary>
public class AgentCrudIntegrationTests
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
    public async Task Agent_CRUD_Lifecycle_Against_The_Real_Database()
    {
        if (!TargetReachable()) return;

        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await TableExistsAsync(connection, "agents")) return;
        if (!await TableExistsAsync(connection, "adminauditlog")) return;
        if (!await TableExistsAsync(connection, "AspNetUsers")) return;

        var marker = $"t012-{Guid.NewGuid():N}";
        var username = $"t012-agt-{Guid.NewGuid():N}";
        var actorUserId = $"u-{Guid.NewGuid():N}";
        var actorUserName = $"t012-admin-{Guid.NewGuid():N}";
        var agentId = 0;
        var userId = string.Empty;

        try
        {
            var harness = new Harness(connection.ConnectionString);

            // ---- Atomic create (BR-009, AC-017) ----
            var agent = await harness.Service.CreateAsync(
                NewInput(marker), username, Password, actorUserId, actorUserName);

            agentId = agent.Id;
            Assert.Equal("Y", agent.Active); // active convention (R-007)
            Assert.NotNull(agent.Creationdate);

            // Linked agt login with the AgentId claim link (BR-009).
            var user = await harness.IdentityDb.Users
                .SingleAsync(u => u.UserName == username);
            userId = user.Id;
            Assert.Equal(agent.Id, user.AgentId);
            var roles = await harness.UserManager.GetRolesAsync(user);
            Assert.Contains(IdentityIntegration.Roles.Agent, roles);

            // The stored password hash is never the plaintext password.
            Assert.False(string.Equals(Password, user.PasswordHash, StringComparison.Ordinal));

            // The login is usable: not locked + a password hash is set — the
            // state AuthEndpoint.LoginAsync requires for a successful
            // sign-in (the HTTP flow is covered by the functional suite).
            Assert.False(await harness.UserManager.IsLockedOutAsync(user));
            Assert.False(string.IsNullOrWhiteSpace(user.PasswordHash));

            // §19 user-creation audit event, same commit as the agent row.
            Assert.True(await AuditRowExistsAsync(connection, actorUserName, "UserCreated"));

            // ---- Duplicate username → 409 (CHK025) ----
            await Assert.ThrowsAsync<AgentConflictException>(() =>
                harness.Service.CreateAsync(
                    NewInput(marker + "-dup"), username, Password, actorUserId, actorUserName));

            // The failed create rolled back its fresh unreferenced agent row
            // (FR-004); only the first agent remains for this marker.
            Assert.Equal(1, await CountAgentsByEnteredByAsync(connection, actorUserName));

            // ---- Deactivate (FR-004, AC-016): login rejected, data intact ----
            var deactivated = await harness.Service.DeactivateAsync(
                agent.Id, actorUserId, actorUserName);
            Assert.Equal("N", deactivated.Active);

            // Data preserved — the agent row still exists with its fields.
            var stored = await harness.EntryDb.Agents
                .AsNoTracking().SingleAsync(a => a.Id == agent.Id);
            Assert.Equal(marker, stored.Companyname);
            Assert.Equal("N", stored.Active);

            // The linked login rejects authentication: the same
            // IsLockedOutAsync check AuthEndpoint.LoginAsync performs.
            var locked = await harness.IdentityDb.Users
                .SingleAsync(u => u.UserName == username);
            Assert.True(await harness.UserManager.IsLockedOutAsync(locked));
            Assert.True(locked.LockoutEnabled);
            Assert.NotNull(locked.LockoutEnd);

            Assert.True(await AuditRowExistsAsync(connection, actorUserName, "UserDeactivated"));

            // ---- Reactivate (FR-022): login restored ----
            var reactivated = await harness.Service.ReactivateAsync(
                agent.Id, actorUserId, actorUserName);
            Assert.Equal("Y", reactivated.Active);

            var unlocked = await harness.IdentityDb.Users
                .SingleAsync(u => u.UserName == username);
            Assert.False(await harness.UserManager.IsLockedOutAsync(unlocked));
            Assert.Null(unlocked.LockoutEnd);

            Assert.True(await AuditRowExistsAsync(connection, actorUserName, "UserReactivated"));

            // ---- Read (FR-002/FR-003) ----
            var fetched = await harness.Service.GetByIdAsync(agent.Id);
            Assert.NotNull(fetched);
            Assert.Equal(marker, fetched!.Companyname);

            var listed = await harness.Service.ListAsync(page: 1, pageSize: 50, q: marker);
            Assert.True(listed.Total >= 1);
            Assert.Contains(listed.Items, i => i.Id == agent.Id);
        }
        finally
        {
            await CleanupAsync(connection, agentId, userId, actorUserName);
        }
    }

    private static AgentInput NewInput(string companyname) => new(
        Companyname: companyname,
        Description: "t012 integration agent",
        Street1: "1 Test St",
        Street2: null,
        Area: "Downtown",
        City: "Mumbai",
        Pincode: "400001",
        Phoneno: "022-5555",
        Faxno: null,
        Emailid: null,
        Smsno: null,
        Directorname: "T012 Owner",
        DirectorPH: "9000000000",
        AcMgrPH: null,
        VisaInchargeName: null,
        VisaInchargePH: null,
        Acno: null,
        Payment: null,
        TAAI: null,
        TAFI: null,
        Membership: null,
        IATA: null);

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

    private static async Task<int> CountAgentsByEnteredByAsync(SqlConnection connection, string enteredBy)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = "SELECT COUNT(*) FROM dbo.agents WHERE Enteredby = @enteredBy";
        cmd.Parameters.AddWithValue("@enteredBy", enteredBy);
        return Convert.ToInt32(await cmd.ExecuteScalarAsync());
    }

    private static async Task CleanupAsync(
        SqlConnection connection, int agentId, string userId, string actorUserName)
    {
        // Deletes only the rows this test created (marker actor / test user /
        // test agent), never real data. FK-safe order: audit rows, user roles
        // (cascade would cover it, explicit is tidy), the user, then the agent.
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = """
            DELETE FROM dbo.adminauditlog WHERE ActorUserName = @actor;
            DELETE FROM dbo.AspNetUserRoles WHERE UserId = @userId;
            DELETE FROM dbo.AspNetUsers WHERE Id = @userId;
            DELETE FROM dbo.agents WHERE agentsID = @agentId AND Enteredby = @actor;
            """;
        cmd.Parameters.AddWithValue("@actor", actorUserName);
        cmd.Parameters.AddWithValue("@userId", userId);
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
            Service = new AgentService(EntryDb, UserManager);
        }

        public VisaEntryDbContext EntryDb { get; }

        public VisaFusionIdentityDbContext IdentityDb { get; }

        public UserManager<IdentityIntegration.VisaFusionUser> UserManager { get; }

        public AgentService Service { get; }

        private static UserManager<IdentityIntegration.VisaFusionUser> BuildUserManager(
            VisaFusionIdentityDbContext db)
        {
            // The five role rows already exist in the migrated target (identity
            // DDL seeds su/adm/emp/agt/guest with fixed Ids = names), so no
            // seeding is required here — AddToRoleAsync resolves "agt" against
            // the real AspNetRoles row.
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
