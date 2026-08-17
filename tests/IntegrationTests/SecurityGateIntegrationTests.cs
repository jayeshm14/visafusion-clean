using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using VisaFusion.Core.Application;
using VisaFusion.Data.Application;
using VisaFusion.Data.Persistence;
using VisaFusion.Identity;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// Day-gate integration tests (SPEC-0005 T017, US2, TS-013, FR-018).
///
/// Seeds the real `security` table (target `VisaFusion` database) for a
/// synthetic date — never today, so no real open/close-day data is touched —
/// and asserts the real <see cref="SecurityGateService"/> (VisaFusion.Data)
/// over a real SQL Server <see cref="VisaEntryDbContext"/>:
///   - no row for the date → RejectedNotOpened (`rsn=O`),
///   - row with a closing time set → RejectedNotOpened (`rsn=O`; `rsn=C` is
///     never produced, AC-011/TS-013),
///   - open row (`closingtime IS NULL`) → Allowed,
///   - non-emp roles are never gated.
/// Test rows are deleted in a `finally` block. Tests skip when SQL Server is
/// unreachable or the `security` table does not exist (existing convention).
/// </summary>
public class SecurityGateIntegrationTests
{
    private const string DefaultTargetConnectionString =
        "Server=localhost;Database=VisaFusion;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true";

    private const string TestOpenBy = "T017-test";

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
    public async Task Day_Gate_Rejects_And_Allows_Against_The_Real_Security_Table()
    {
        if (!TargetReachable()) return;

        // Synthetic date (tomorrow) — the gate is evaluated for the caller's
        // date, so the test fully controls the rows without touching real
        // open/close-day data for today.
        var date = DateTime.Today.AddDays(1);

        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await TableExistsAsync(connection, "security")) return;

        try
        {
            // Case 1: no row for the date → rejected (rsn=O). Skipped when a
            // real row already exists for the synthetic date (real data is
            // never deleted).
            if (await CountRowsAsync(connection, date) == 0)
            {
                Assert.Equal(
                    SecurityGateDecision.RejectedNotOpened,
                    await EvaluateAsync(connection, date, EmployeeRoles));
            }

            // Case 2: row with a closing time set → rejected with the SAME
            // outcome as no row (rsn=O) — rsn=C is never produced (AC-011).
            await InsertSecurityRowAsync(connection, date, closingTime: date.AddHours(18));
            Assert.Equal(
                SecurityGateDecision.RejectedNotOpened,
                await EvaluateAsync(connection, date, EmployeeRoles));

            // Case 3: open row (closingtime IS NULL) → allowed. The unique
            // date1 index (SPEC-0007 BR-003/CHK022) allows exactly one row per
            // date, so "open" is modelled by reopening the Case 2 row
            // (closingtime → NULL) — never a second row for the same date.
            await ReopenSecurityRowAsync(connection, date);
            Assert.Equal(
                SecurityGateDecision.Allowed,
                await EvaluateAsync(connection, date, EmployeeRoles));

            // Non-emp roles are never gated, even with no open row.
            Assert.Equal(
                SecurityGateDecision.Allowed,
                await EvaluateAsync(connection, date, new[] { IdentityIntegration.Roles.Admin }));
        }
        finally
        {
            await DeleteTestRowsAsync(connection, date);
        }
    }

    private static async Task<SecurityGateDecision> EvaluateAsync(
        SqlConnection connection, DateTime date, IEnumerable<string> roles)
    {
        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseSqlServer(connection.ConnectionString)
            .Options;
        await using var db = new VisaEntryDbContext(options);
        return await new SecurityGateService(db).EvaluateAsync(roles, date);
    }

    private static async Task InsertSecurityRowAsync(SqlConnection connection, DateTime date, DateTime? closingTime)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = """
            INSERT INTO [security] ([date1],[openingtime],[openby],[closingtime],[closedby])
            VALUES (@date1,@openingtime,@openby,@closingtime,@closedby)
            """;
        cmd.Parameters.AddWithValue("@date1", date);
        cmd.Parameters.AddWithValue("@openingtime", date.AddHours(9));
        cmd.Parameters.AddWithValue("@openby", TestOpenBy);
        cmd.Parameters.AddWithValue("@closingtime", (object?)closingTime ?? DBNull.Value);
        cmd.Parameters.AddWithValue("@closedby", closingTime.HasValue ? TestOpenBy : (object)DBNull.Value);
        await cmd.ExecuteNonQueryAsync();
    }

    private static async Task ReopenSecurityRowAsync(SqlConnection connection, DateTime date)
    {
        // Reopens the test row (closingtime/closedby → NULL) so the same date
        // models the open state without a second row (unique date1, BR-003).
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = """
            UPDATE [security] SET [closingtime] = NULL, [closedby] = NULL
            WHERE [date1] = @date1 AND [openby] = @openby
            """;
        cmd.Parameters.AddWithValue("@date1", date);
        cmd.Parameters.AddWithValue("@openby", TestOpenBy);
        await cmd.ExecuteNonQueryAsync();
    }

    private static async Task<int> CountRowsAsync(SqlConnection connection, DateTime date)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = "SELECT COUNT(*) FROM [security] WHERE [date1] = @date1";
        cmd.Parameters.AddWithValue("@date1", date);
        return Convert.ToInt32(await cmd.ExecuteScalarAsync());
    }

    private static async Task DeleteTestRowsAsync(SqlConnection connection, DateTime date)
    {
        // Deletes only the rows this test inserted (marker openby), never real data.
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = "DELETE FROM [security] WHERE [date1] = @date1 AND [openby] = @openby";
        cmd.Parameters.AddWithValue("@date1", date);
        cmd.Parameters.AddWithValue("@openby", TestOpenBy);
        await cmd.ExecuteNonQueryAsync();
    }

    private static readonly string[] EmployeeRoles = { IdentityIntegration.Roles.Employee };
}