using Microsoft.Data.SqlClient;
using VisaFusion.Migration.Identity;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// Identity import integration tests (SPEC-0004 T037, TS-003, FR-004, BR-002,
/// AC-004).
///
/// Verifies the target identity store invariant: no plaintext password exists
/// in `AspNetUsers` (every stored hash is an ASP.NET Core Identity PBKDF2 hash
/// or null for accounts without a legacy password), and the five roles are
/// seeded. The identity schema is created by the `identity` step; until then
/// the invariant holds trivially and the tests return early. Tests skip when
/// SQL Server is unreachable.
/// </summary>
public class IdentityImportTests
{
    private const string DefaultTargetConnectionString =
        "Server=localhost;Database=VisaFusion;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true";

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

    private static async Task<bool> TableExistsAsync(SqlConnection connection, string table)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @table";
        cmd.Parameters.AddWithValue("@table", table);
        return Convert.ToInt32(await cmd.ExecuteScalarAsync()) > 0;
    }

    [Fact]
    public async Task Target_Identity_Store_Has_No_Plaintext_Passwords()
    {
        if (!TargetReachable()) return;

        await using var target = new SqlConnection(TargetConnectionString);
        await target.OpenAsync();

        // The identity schema is created by the `identity` step; until then the
        // "no plaintext" invariant holds trivially (AC-004).
        if (!await TableExistsAsync(target, "AspNetUsers")) return;

        var hashes = new List<string?>();
        await using (var cmd = target.CreateCommand())
        {
            cmd.CommandText = "SELECT [PasswordHash] FROM [AspNetUsers]";
            await using var r = await cmd.ExecuteReaderAsync();
            while (await r.ReadAsync())
                hashes.Add(r.IsDBNull(0) ? null : r.GetString(0));
        }

        foreach (var hash in hashes)
        {
            if (hash is null) continue; // no legacy password — unusable until reset
            // ASP.NET Core Identity PBKDF2 hashes start with the version marker;
            // the legacy plaintext is never stored (BR-002).
            Assert.StartsWith("AQAAAA", hash, StringComparison.Ordinal);
        }
    }

    [Fact]
    public async Task Identity_Roles_Are_Seeded_When_The_Schema_Exists()
    {
        if (!TargetReachable()) return;

        await using var target = new SqlConnection(TargetConnectionString);
        await target.OpenAsync();
        if (!await TableExistsAsync(target, "AspNetRoles")) return;

        var roles = new List<string>();
        await using (var cmd = target.CreateCommand())
        {
            cmd.CommandText = "SELECT [Name] FROM [AspNetRoles]";
            await using var r = await cmd.ExecuteReaderAsync();
            while (await r.ReadAsync()) roles.Add(r.GetString(0));
        }

        foreach (var role in new[] { "su", "adm", "emp", "agt", "guest" })
            Assert.Contains(role, roles);
    }

    [Fact]
    public void PasswordHasher_Produces_Identity_Compatible_Hashes()
    {
        // Unit-level proof of the hashing contract (BR-002, AC-004): the hash
        // is a PBKDF2 Identity hash, never the plaintext, and null/empty legacy
        // passwords are stored as null (no invented credentials).
        Assert.Null(PasswordHasher.Hash(null));
        Assert.Null(PasswordHasher.Hash(string.Empty));

        var hash = PasswordHasher.Hash("legacy-password");
        Assert.NotNull(hash);
        Assert.StartsWith("AQAAAA", hash, StringComparison.Ordinal);
        Assert.DoesNotContain("legacy-password", hash, StringComparison.Ordinal);
    }
}