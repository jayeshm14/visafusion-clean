using Microsoft.AspNetCore.Identity;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using VisaFusion.Identity;
using VisaFusion.Identity.Persistence;
using VisaFusion.Migration.Identity;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// Identity lockout + no-plaintext integration tests (SPEC-0005 T008, US1,
/// AC-010/TS-010, AC-002/TS-002, FR-009).
///
/// The runtime lockout semantics are asserted against the real SQL Server
/// identity store with the migration tool's row shape: an account is blocked
/// when `LockoutEnabled = 1` AND `LockoutEnd >= UtcNow` — a far-future
/// `LockoutEnd` blocks (the corrected inactive-account mechanism), a PAST
/// `LockoutEnd` does NOT (regression guard against the pre-correction
/// design), and an active account (LockoutEnabled = 0) is not locked. Also
/// proves the migrated hashes verify and never store the plaintext.
///
/// Tests self-skip when SQL Server is unreachable or the identity tables have
/// not been created by the `identity` migration step (existing convention).
/// The legacy `active` flag parse rule (`IdentityActive`) is unit-tested here
/// per the IdentityImportTests precedent (unit-level proof in the integration
/// project).
/// </summary>
public class IdentityLockoutTests
{
    private const string DefaultTargetConnectionString =
        "Server=localhost;Database=VisaFusion;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true";

    private static string TargetConnectionString =>
        Environment.GetEnvironmentVariable("VISA_FUSION_TEST_CONNECTION") ?? DefaultTargetConnectionString;

    private const string SeedPassword = "TestPass123!";

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

    private static async Task<bool> TableExistsAsync(SqlConnection connection, string table)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @table";
        cmd.Parameters.AddWithValue("@table", table);
        return Convert.ToInt32(await cmd.ExecuteScalarAsync()) > 0;
    }

    // ---- Legacy `active` flag parse rule (FR-009; verified live 2026-08-11) ----

    [Fact]
    public void IdentityActive_Explicit_N_Is_Inactive()
    {
        Assert.True(IdentityActive.IsInactive("N"));
        Assert.True(IdentityActive.IsInactive("n"));
        Assert.True(IdentityActive.IsInactive(" N "));
    }

    [Fact]
    public void IdentityActive_Y_And_Null_Are_Active()
    {
        Assert.False(IdentityActive.IsInactive("Y"));
        Assert.False(IdentityActive.IsInactive("y"));
        Assert.False(IdentityActive.IsInactive(null));
        Assert.False(IdentityActive.IsInactive(string.Empty));
        // No value other than explicit 'N' (the deactivation value the legacy
        // writes — addnewagents.asp line 57) means inactive. This preserves
        // today's login behavior: `authenticate.asp` never checks `active`, and
        // Udaan_users has zero 'N' rows (929 'Y' + 1436 NULL), registration is
        // all NULL, agents are Y/N/NULL.
        Assert.False(IdentityActive.IsInactive("X"));
    }

    // ---- Runtime lockout semantics against the real SQL Server store ----

    [Fact]
    public async Task Inactive_Account_With_Far_Future_Lockout_Is_Blocked()
    {
        var row = await SeedIdentityRowAsync(lockoutEnabled: true, lockoutEnd: DateTimeOffset.UtcNow.AddYears(100));
        if (row is null) return;

        try
        {
            using var scope = await NewUserManagerScopeAsync();
            var userManager = scope.ServiceProvider.GetRequiredService<UserManager<IdentityIntegration.VisaFusionUser>>();

            var user = await userManager.FindByIdAsync(row.Value.Id);
            Assert.NotNull(user);
            // AC-010/TS-010: the inactive-account import shape (LockoutEnabled=1 +
            // far-future LockoutEnd) actually blocks sign-in — a past LockoutEnd
            // would not (verified against the installed 8.0.29 shared framework;
            // spec §16 correction 2026-08-11).
            Assert.True(await userManager.IsLockedOutAsync(user!));
        }
        finally
        {
            await DeleteIdentityRowAsync(row.Value.Id);
        }
    }

    [Fact]
    public async Task Account_With_Past_LockoutEnd_Is_Not_Blocked()
    {
        // Regression guard: the pre-correction design wrote a PAST LockoutEnd,
        // which `IsLockedOutAsync` (LockoutEnd >= UtcNow) ignores — the account
        // would sign in. The importer must write a far-future LockoutEnd.
        var row = await SeedIdentityRowAsync(lockoutEnabled: true, lockoutEnd: DateTimeOffset.UtcNow.AddDays(-1));
        if (row is null) return;

        try
        {
            using var scope = await NewUserManagerScopeAsync();
            var userManager = scope.ServiceProvider.GetRequiredService<UserManager<IdentityIntegration.VisaFusionUser>>();

            var user = await userManager.FindByIdAsync(row.Value.Id);
            Assert.NotNull(user);
            Assert.False(await userManager.IsLockedOutAsync(user!));
        }
        finally
        {
            await DeleteIdentityRowAsync(row.Value.Id);
        }
    }

    [Fact]
    public async Task Active_Account_Is_Not_Locked_And_Password_Verifies()
    {
        var row = await SeedIdentityRowAsync(lockoutEnabled: false, lockoutEnd: null);
        if (row is null) return;

        try
        {
            using var scope = await NewUserManagerScopeAsync();
            var userManager = scope.ServiceProvider.GetRequiredService<UserManager<IdentityIntegration.VisaFusionUser>>();

            var user = await userManager.FindByIdAsync(row.Value.Id);
            Assert.NotNull(user);
            Assert.False(await userManager.IsLockedOutAsync(user!));
            // AC-001/TS-001: the migrated (hashed) credential verifies — the
            // legacy lowercased plaintext is replaced by the import hash.
            Assert.True(await userManager.CheckPasswordAsync(user!, SeedPassword));
        }
        finally
        {
            await DeleteIdentityRowAsync(row.Value.Id);
        }
    }

    [Fact]
    public async Task Stored_Hash_Is_Not_The_Plaintext()
    {
        var row = await SeedIdentityRowAsync(lockoutEnabled: false, lockoutEnd: null);
        if (row is null) return;

        try
        {
            await using var target = new SqlConnection(TargetConnectionString);
            await target.OpenAsync();
            await using var cmd = target.CreateCommand();
            cmd.CommandText = "SELECT [PasswordHash] FROM [AspNetUsers] WHERE [Id] = @id";
            cmd.Parameters.AddWithValue("@id", row.Value.Id);
            var hash = (string?)await cmd.ExecuteScalarAsync();

            // AC-002/TS-002: the runtime store keeps only the PBKDF2 hash —
            // never the plaintext (BR-002).
            Assert.NotNull(hash);
            Assert.StartsWith("AQAAAA", hash, StringComparison.Ordinal);
            Assert.DoesNotContain(SeedPassword, hash, StringComparison.Ordinal);
        }
        finally
        {
            await DeleteIdentityRowAsync(row.Value.Id);
        }
    }

    // ---- Helpers ----

    private async Task<(string Id, string UserName)?> SeedIdentityRowAsync(
        bool lockoutEnabled, DateTimeOffset? lockoutEnd)
    {
        if (!TargetReachable()) return null;

        await using var target = new SqlConnection(TargetConnectionString);
        await target.OpenAsync();
        if (!await TableExistsAsync(target, "AspNetUsers")) return null;

        var id = Guid.NewGuid().ToString("N");
        var userName = $"vf-lockout-{Guid.NewGuid():N}";
        var hash = PasswordHasher.Hash(SeedPassword);
        var sql = @"
            INSERT INTO AspNetUsers (Id, UserName, NormalizedUserName, Email, NormalizedEmail,
                EmailConfirmed, PasswordHash, SecurityStamp, ConcurrencyStamp,
                PhoneNumber, PhoneNumberConfirmed, TwoFactorEnabled, LockoutEnd,
                LockoutEnabled, AccessFailedCount, LegacyUdaanUserId, LegacyRegistrationId, AgentId)
            VALUES (@id, @userName, @normUser, @email, @normEmail, 0, @hash,
                NEWID(), NEWID(), NULL, 0, 0, @lockoutEnd, @lockoutEnabled, 0, NULL, NULL, NULL);";
        await using var cmd = target.CreateCommand();
        cmd.CommandText = sql;
        cmd.Parameters.AddWithValue("@id", id);
        cmd.Parameters.AddWithValue("@userName", userName);
        cmd.Parameters.AddWithValue("@normUser", userName.ToUpperInvariant());
        cmd.Parameters.AddWithValue("@email", $"{userName}@test.local");
        cmd.Parameters.AddWithValue("@normEmail", $"{userName}@TEST.LOCAL");
        cmd.Parameters.AddWithValue("@hash", hash);
        cmd.Parameters.AddWithValue("@lockoutEnd", (object?)lockoutEnd ?? DBNull.Value);
        cmd.Parameters.AddWithValue("@lockoutEnabled", lockoutEnabled ? 1 : 0);
        await cmd.ExecuteNonQueryAsync();

        return (id, userName);
    }

    private async Task DeleteIdentityRowAsync(string id)
    {
        try
        {
            await using var target = new SqlConnection(TargetConnectionString);
            await target.OpenAsync();
            await using var cmd = target.CreateCommand();
            cmd.CommandText = "DELETE FROM [AspNetUsers] WHERE [Id] = @id";
            cmd.Parameters.AddWithValue("@id", id);
            await cmd.ExecuteNonQueryAsync();
        }
        catch
        {
            // Cleanup best-effort; the rows carry a unique id and cannot collide
            // with imported data (first-source-wins dedup keys on username).
        }
    }

    private static async Task<IServiceScope> NewUserManagerScopeAsync()
    {
        var services = new ServiceCollection();
        services.AddLogging();
        services.AddDbContext<VisaFusionIdentityDbContext>(options =>
            options.UseSqlServer(TargetConnectionString));
        services.AddIdentityCore<IdentityIntegration.VisaFusionUser>()
            .AddRoles<IdentityRole>()
            .AddEntityFrameworkStores<VisaFusionIdentityDbContext>();
        var provider = services.BuildServiceProvider();
        var scope = provider.CreateScope();
        await Task.CompletedTask; // scope is returned asynchronously for symmetry; keep simple
        return scope;
    }
}
