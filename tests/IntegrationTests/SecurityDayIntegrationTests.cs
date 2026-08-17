using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using VisaFusion.Core.Application;
using VisaFusion.Data.Application;
using VisaFusion.Data.Persistence;
using VisaFusion.Identity;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// Security-day open/close integration tests (SPEC-0007 T023, US3, FR-008,
/// BR-003, CHK021/CHK022; contracts/admin-api.md §1-§3).
///
/// Exercises the REAL <see cref="SecurityGateService"/> (VisaFusion.Data) over
/// a real SQL Server <see cref="VisaEntryDbContext"/> — the same implementation
/// the `POST /api/v1/admin/security-day/open|close` and
/// `GET /api/v1/admin/security-day/today` endpoints call:
///   - open a synthetic date → Opened; the row carries openingtime/openby and
///     the §19 SecurityDayOpened audit event,
///   - open the same date again → AlreadyOpen (409, CHK022),
///   - close the open row → Closed; closingtime/closedby set and the §19
///     SecurityDayClosed audit event written,
///   - close with no open row → NotFound (404, CHK021),
///   - the day-gate follows the open/close state: emp allowed while open,
///     rejected (rsn=O) after close — the same rule the login flow enforces
///     (AC-004/AC-005),
///   - concurrency (CHK022): two concurrent opens for the same date resolve to
///     exactly one Opened and one AlreadyOpen — the unique date1 index is the
///     arbiter, never a partial state.
///
/// The HTTP auth matrix (SecurityGate = adm/su) is owned by the functional
/// suite (hermetic factory stubs the service); this suite proves the real DB
/// behavior. Test rows are deleted in a `finally` block (marker openby, never
/// real data). Tests skip when SQL Server is unreachable or the required
/// tables do not exist (existing convention).
/// </summary>
public class SecurityDayIntegrationTests
{
    private const string DefaultTargetConnectionString =
        "Server=localhost;Database=VisaFusion;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true";

    private const string TestOpenBy = "T023-test";

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
    public async Task Open_Close_Gate_Against_The_Real_Database()
    {
        if (!TargetReachable()) return;

        // Synthetic date (tomorrow) — never today, so no real open/close-day
        // data is touched (the SecurityGateIntegrationTests convention).
        var date = DateTime.Today.AddDays(1);

        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await TableExistsAsync(connection, "security")) return;
        if (!await TableExistsAsync(connection, "adminauditlog")) return;

        // Skip when a real row already exists for the synthetic date — real
        // data is never deleted or modified (the SecurityGateIntegrationTests
        // convention). The open/close lifecycle needs a clean date.
        if (await CountRowsAsync(connection, date) > 0) return;

        try
        {
            // ---- Open (FR-008, BR-003) ----
            var opened = await OpenDayAsync(connection, date);
            Assert.Equal(SecurityDayOpenResult.Opened, opened);

            var row = await GetRowAsync(connection, date);
            Assert.NotNull(row);
            Assert.NotNull(row!.Openingtime);
            Assert.Equal(TestOpenBy, row.Openby);
            Assert.Null(row.Closingtime);
            Assert.True(await AuditRowExistsAsync(connection, "SecurityDayOpened"));

            // The gate allows emp while the day is open (AC-004).
            Assert.Equal(
                SecurityGateDecision.Allowed,
                await EvaluateAsync(connection, date, EmployeeRoles));

            // ---- Open again → AlreadyOpen (409, CHK022) ----
            Assert.Equal(
                SecurityDayOpenResult.AlreadyOpen,
                await OpenDayAsync(connection, date));

            // ---- Close (FR-008, BR-003) ----
            var closed = await CloseDayAsync(connection, date);
            Assert.Equal(SecurityDayCloseResult.Closed, closed);

            row = await GetRowAsync(connection, date);
            Assert.NotNull(row);
            Assert.NotNull(row!.Closingtime);
            Assert.Equal(TestOpenBy, row.Closedby);
            Assert.True(await AuditRowExistsAsync(connection, "SecurityDayClosed"));

            // The gate rejects emp after close — the same rsn=O outcome as no
            // row at all (AC-011/TS-013; AC-005).
            Assert.Equal(
                SecurityGateDecision.RejectedNotOpened,
                await EvaluateAsync(connection, date, EmployeeRoles));

            // ---- Close again → NotFound (404, CHK021) ----
            Assert.Equal(
                SecurityDayCloseResult.NotFound,
                await CloseDayAsync(connection, date));
        }
        finally
        {
            await DeleteTestRowsAsync(connection, date);
        }
    }

    [Fact]
    public async Task Concurrent_Opens_Resolve_To_A_Single_Winner()
    {
        if (!TargetReachable()) return;

        // A second synthetic date so the two tests never share rows.
        var date = DateTime.Today.AddDays(2);

        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await TableExistsAsync(connection, "security")) return;

        // Skip when a real row already exists for the synthetic date — the
        // concurrency assertion needs a clean date (real data is never deleted).
        if (await CountRowsAsync(connection, date) > 0) return;

        try
        {
            // CHK022: the unique date1 index makes concurrent opens resolve to
            // a single winner — exactly one Opened, the other AlreadyOpen.
            var results = await Task.WhenAll(
                OpenDayAsync(connection, date),
                OpenDayAsync(connection, date));

            Assert.Equal(1, results.Count(r => r == SecurityDayOpenResult.Opened));
            Assert.Equal(1, results.Count(r => r == SecurityDayOpenResult.AlreadyOpen));
        }
        finally
        {
            await DeleteTestRowsAsync(connection, date);
        }
    }

    // ---- helpers (SecurityGateIntegrationTests convention) ----

    private static async Task<SecurityDayOpenResult> OpenDayAsync(SqlConnection connection, DateTime date)
    {
        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseSqlServer(connection.ConnectionString)
            .Options;
        await using var db = new VisaEntryDbContext(options);
        return await new SecurityGateService(db).OpenDayAsync(date, TestOpenBy);
    }

    private static async Task<SecurityDayCloseResult> CloseDayAsync(SqlConnection connection, DateTime date)
    {
        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseSqlServer(connection.ConnectionString)
            .Options;
        await using var db = new VisaEntryDbContext(options);
        return await new SecurityGateService(db).CloseDayAsync(date, TestOpenBy);
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

    private static async Task<SecurityRow?> GetRowAsync(SqlConnection connection, DateTime date)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = """
            SELECT [openingtime],[openby],[closingtime],[closedby]
            FROM [security] WHERE [date1] = @date1 AND [openby] = @openby
            """;
        cmd.Parameters.AddWithValue("@date1", date);
        cmd.Parameters.AddWithValue("@openby", TestOpenBy);
        await using var reader = await cmd.ExecuteReaderAsync();
        if (!await reader.ReadAsync())
        {
            return null;
        }

        return new SecurityRow(
            reader.IsDBNull(0) ? null : reader.GetDateTime(0),
            reader.IsDBNull(1) ? null : reader.GetString(1),
            reader.IsDBNull(2) ? null : reader.GetDateTime(2),
            reader.IsDBNull(3) ? null : reader.GetString(3));
    }

    private static async Task<bool> AuditRowExistsAsync(SqlConnection connection, string eventType)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText =
            "SELECT COUNT(*) FROM dbo.adminauditlog WHERE ActorUserName = @actor AND EventType = @eventType";
        cmd.Parameters.AddWithValue("@actor", TestOpenBy);
        cmd.Parameters.AddWithValue("@eventType", eventType);
        return Convert.ToInt32(await cmd.ExecuteScalarAsync()) > 0;
    }

    private static async Task<bool> TableExistsAsync(SqlConnection connection, string table)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @table";
        cmd.Parameters.AddWithValue("@table", table);
        return Convert.ToInt32(await cmd.ExecuteScalarAsync()) > 0;
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
        // Deletes only the rows this test inserted (marker openby), never real
        // data. FK-safe order: audit rows first, then the security row.
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = """
            DELETE FROM dbo.adminauditlog WHERE ActorUserName = @openby;
            DELETE FROM [security] WHERE [date1] = @date1 AND [openby] = @openby;
            """;
        cmd.Parameters.AddWithValue("@date1", date);
        cmd.Parameters.AddWithValue("@openby", TestOpenBy);
        await cmd.ExecuteNonQueryAsync();
    }

    private sealed record SecurityRow(
        DateTime? Openingtime, string? Openby, DateTime? Closingtime, string? Closedby);

    private static readonly string[] EmployeeRoles = { IdentityIntegration.Roles.Employee };
}