using Microsoft.Data.SqlClient;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// Super-user provisioning integration tests (SPEC-0006 T022, US5, FR-007,
/// BR-004, AC-006).
///
/// Exercises the owner-supplied <c>usp_ProvisionSuperUser</c> (script 06,
/// applied verbatim — GR-0001) over a real SQL Server:
///   - a new su user is created with BOTH the su and adm roles (legacy
///     su → priv "adm" + su="Y" mapping, script 06:221-224),
///   - a <c>SuperUserProvisioningAudit</c> row is written (script 06:226-229),
///   - the password is stored pre-hashed (never plaintext — the caller passes
///     the hash; the stored value equals the passed hash, NFR-006),
///   - a duplicate username is refused (RAISERROR, script 06:189-193),
///   - a non-su acting user is refused (RAISERROR, script 06:178-187).
/// Seeds a synthetic acting-su user and a synthetic non-su user, and deletes
/// every seeded row in a <c>finally</c> block. Tests skip when SQL Server is
/// unreachable or the proc does not exist (existing convention).
/// </summary>
public class SuperUserProvisioningTests
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

    [Fact]
    public async Task Provision_SuperUser_Creates_Roles_Audit_And_Rejects_Duplicate_And_NonSu()
    {
        if (!TargetReachable()) return;

        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await ProcExistsAsync(connection, "usp_ProvisionSuperUser")) return;

        var actingSuId = Guid.NewGuid().ToString("N");
        var actingSuName = $"t022-su-{Guid.NewGuid():N}";
        var nonSuId = Guid.NewGuid().ToString("N");
        var nonSuName = $"t022-emp-{Guid.NewGuid():N}";
        var newUserName = $"t022-new-{Guid.NewGuid():N}";
        var passwordHash = "AQAAAAEAACcQAAAAE-test-hash-not-plaintext";
        var provisionedUserId = string.Empty;

        try
        {
            // Seed the acting su user (su role) and a non-su user (emp role).
            await InsertUserAsync(connection, actingSuId, actingSuName);
            await InsertUserRoleAsync(connection, actingSuId, "su");
            await InsertUserAsync(connection, nonSuId, nonSuName);
            await InsertUserRoleAsync(connection, nonSuId, "emp");

            // Happy path: acting su provisions a new su.
            var newUserId = await ProvisionAsync(
                connection, newUserName, passwordHash, actingSuId);
            provisionedUserId = newUserId;

            Assert.False(string.IsNullOrWhiteSpace(newUserId));
            Assert.True(await HasRoleAsync(connection, newUserId, "su"));
            Assert.True(await HasRoleAsync(connection, newUserId, "adm"));
            Assert.True(await AuditRowExistsAsync(connection, newUserId, actingSuId));
            Assert.Equal(passwordHash, await StoredPasswordHashAsync(connection, newUserId));

            // Duplicate username refused.
            var dup = await Assert.ThrowsAsync<SqlException>(() =>
                ProvisionAsync(connection, newUserName, passwordHash, actingSuId));
            Assert.Contains("already exists", dup.Message, StringComparison.OrdinalIgnoreCase);

            // Non-su acting user refused.
            var nonSu = await Assert.ThrowsAsync<SqlException>(() =>
                ProvisionAsync(connection, $"t022-other-{Guid.NewGuid():N}", passwordHash, nonSuId));
            Assert.Contains("not an su", nonSu.Message, StringComparison.OrdinalIgnoreCase);
        }
        finally
        {
            await DeleteTestRowsAsync(connection, actingSuId, nonSuId, provisionedUserId);
        }
    }

    private static async Task<string> ProvisionAsync(
        SqlConnection connection, string userName, string passwordHash, string actingUserId)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = "dbo.usp_ProvisionSuperUser";
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@UserName", userName);
        cmd.Parameters.AddWithValue("@Email", $"{userName}@test.local");
        cmd.Parameters.AddWithValue("@PasswordHash", passwordHash);
        cmd.Parameters.AddWithValue("@FirstName", "T022");
        cmd.Parameters.AddWithValue("@LastName", "Test");
        cmd.Parameters.AddWithValue("@ProvisionedByUserId", actingUserId);
        var newUserId = cmd.CreateParameter();
        newUserId.ParameterName = "@NewUserId";
        newUserId.DbType = System.Data.DbType.String;
        newUserId.Size = 450;
        newUserId.Direction = System.Data.ParameterDirection.Output;
        cmd.Parameters.Add(newUserId);
        await cmd.ExecuteNonQueryAsync();
        return newUserId.Value?.ToString() ?? string.Empty;
    }

    private static async Task InsertUserAsync(SqlConnection connection, string id, string userName)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = """
            INSERT INTO dbo.AspNetUsers
                (Id, UserName, NormalizedUserName, Email, NormalizedEmail,
                 EmailConfirmed, PasswordHash, SecurityStamp, ConcurrencyStamp,
                 PhoneNumberConfirmed, TwoFactorEnabled, LockoutEnabled, AccessFailedCount)
            VALUES
                (@id, @userName, UPPER(@userName), @userName + '@test.local', UPPER(@userName + '@test.local'),
                 1, 'x', NEWID(), NEWID(), 0, 0, 1, 0)
            """;
        cmd.Parameters.AddWithValue("@id", id);
        cmd.Parameters.AddWithValue("@userName", userName);
        await cmd.ExecuteNonQueryAsync();
    }

    private static async Task InsertUserRoleAsync(SqlConnection connection, string userId, string roleName)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = "INSERT INTO dbo.AspNetUserRoles (UserId, RoleId) VALUES (@userId, @roleName)";
        cmd.Parameters.AddWithValue("@userId", userId);
        cmd.Parameters.AddWithValue("@roleName", roleName);
        await cmd.ExecuteNonQueryAsync();
    }

    private static async Task<bool> HasRoleAsync(SqlConnection connection, string userId, string roleName)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = "SELECT COUNT(*) FROM dbo.AspNetUserRoles WHERE UserId = @userId AND RoleId = @roleName";
        cmd.Parameters.AddWithValue("@userId", userId);
        cmd.Parameters.AddWithValue("@roleName", roleName);
        return Convert.ToInt32(await cmd.ExecuteScalarAsync()) > 0;
    }

    private static async Task<bool> AuditRowExistsAsync(SqlConnection connection, string newUserId, string provisionedBy)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = """
            SELECT COUNT(*) FROM dbo.SuperUserProvisioningAudit
            WHERE NewSuperUserId = @newUserId AND ProvisionedByUserId = @provisionedBy
            """;
        cmd.Parameters.AddWithValue("@newUserId", newUserId);
        cmd.Parameters.AddWithValue("@provisionedBy", provisionedBy);
        return Convert.ToInt32(await cmd.ExecuteScalarAsync()) > 0;
    }

    private static async Task<string> StoredPasswordHashAsync(SqlConnection connection, string userId)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = "SELECT PasswordHash FROM dbo.AspNetUsers WHERE Id = @userId";
        cmd.Parameters.AddWithValue("@userId", userId);
        return (await cmd.ExecuteScalarAsync())?.ToString() ?? string.Empty;
    }

    private static async Task DeleteTestRowsAsync(
        SqlConnection connection, string actingSuId, string nonSuId, string provisionedUserId)
    {
        // Deletes only the seeded acting/non-su users and their roles, plus
        // the provisioned user and its audit row — never real data.
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = """
            DELETE FROM dbo.SuperUserProvisioningAudit WHERE ProvisionedByUserId = @actingSuId;
            DELETE FROM dbo.AspNetUserRoles WHERE UserId IN (@actingSuId, @nonSuId, @provisionedUserId);
            DELETE FROM dbo.AspNetUsers WHERE Id IN (@actingSuId, @nonSuId, @provisionedUserId);
            """;
        cmd.Parameters.AddWithValue("@actingSuId", actingSuId);
        cmd.Parameters.AddWithValue("@nonSuId", nonSuId);
        cmd.Parameters.AddWithValue("@provisionedUserId", provisionedUserId);
        await cmd.ExecuteNonQueryAsync();
    }

    private static async Task<bool> ProcExistsAsync(SqlConnection connection, string proc)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = "SELECT COUNT(*) FROM sys.objects WHERE type = 'P' AND name = @proc";
        cmd.Parameters.AddWithValue("@proc", proc);
        return Convert.ToInt32(await cmd.ExecuteScalarAsync()) > 0;
    }
}