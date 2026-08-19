using System.Text.Json;
using Microsoft.AspNetCore.Http;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using VisaFusion.Api.Endpoints;
using VisaFusion.Data.Persistence;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// Report query parameterization + determinism + date validation tests
/// (SPEC-0008 T045, US6, FR-012, AC-008, NFR-002/NFR-006;
/// contracts/reports-api.md).
///
/// Exercises the REAL <see cref="ReportsEndpoint"/> handlers against the REAL
/// SQL Server database through a <see cref="DefaultHttpContext"/>:
///   - every report handler returns 200 for a valid range (the EF Core LINQ
///     translates to parameterized SQL — NFR-002),
///   - a hostile date string is rejected with 400 BEFORE any query runs and
///     the database is left intact (no SQL injection surface),
///   - dateTo &lt; dateFrom → 400 (spec §17),
///   - the same inputs produce byte-identical output on repeat calls
///     (deterministic ORDER BY — NFR-006).
/// Tests skip when SQL Server is unreachable or the required tables do not
/// exist (existing convention).
/// </summary>
public class ReportParameterizedSqlTests
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
        await using var command = connection.CreateCommand();
        command.CommandText = "SELECT COUNT(*) FROM sys.tables WHERE name = @name";
        command.Parameters.AddWithValue("@name", table);
        var count = (int)(await command.ExecuteScalarAsync())!;
        return count > 0;
    }

    private static VisaEntryDbContext CreateContext()
    {
        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseSqlServer(TargetConnectionString)
            .Options;
        return new VisaEntryDbContext(options);
    }

    private static async Task<(int StatusCode, string Body)> RunHandlerAsync(
        Func<HttpContext, VisaEntryDbContext, Task> handler, string queryString)
    {
        var context = new DefaultHttpContext();
        context.Request.QueryString = new QueryString(queryString);
        context.Response.Body = new MemoryStream();

        await using var db = CreateContext();
        await handler(context, db);

        context.Response.Body.Position = 0;
        using var reader = new StreamReader(context.Response.Body);
        var body = await reader.ReadToEndAsync();
        return (context.Response.StatusCode, body);
    }

    [Fact]
    public async Task All_Report_Handlers_Return_200_For_A_Valid_Range()
    {
        if (!TargetReachable()) return;
        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await TableExistsAsync(connection, "paxstatus")) return;

        var handlers = new (string Name, Func<HttpContext, VisaEntryDbContext, Task> Handler)[]
        {
            ("agent-status/today", ReportsEndpoint.AgentStatusTodayAsync),
            ("pending", ReportsEndpoint.PendingAsync),
            ("today-submission", ReportsEndpoint.TodaySubmissionAsync),
            ("today-collection", ReportsEndpoint.TodayCollectionAsync),
            ("today-transaction", ReportsEndpoint.TodayTransactionAsync),
            ("daily-visa-fee", ReportsEndpoint.DailyVisaFeeAsync),
            ("daily-bill", ReportsEndpoint.DailyBillAsync),
        };

        foreach (var (name, handler) in handlers)
        {
            var (status, _) = await RunHandlerAsync(handler, "?dateFrom=2026-01-01&dateTo=2026-12-31");
            Assert.True(status == StatusCodes.Status200OK,
                $"report {name} should return 200 for a valid range, got {status}");
        }
    }

    [Fact]
    public async Task Hostile_Date_Input_Is_Rejected_And_Database_Stays_Intact()
    {
        // NFR-002: the endpoint validates the date with a strict ISO-8601
        // parse BEFORE any query runs, so a SQL-injection payload can never
        // reach the database. The invoice table must still exist afterwards.
        if (!TargetReachable()) return;
        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await TableExistsAsync(connection, "invoice")) return;

        var (status, _) = await RunHandlerAsync(
            ReportsEndpoint.DailyBillAsync,
            "?dateFrom=2026-01-01'; DROP TABLE invoice;--");

        Assert.Equal(StatusCodes.Status400BadRequest, status);
        Assert.True(await TableExistsAsync(connection, "invoice"),
            "the invoice table must be untouched by a hostile date input");
    }

    [Fact]
    public async Task Reversed_Date_Range_Returns_400()
    {
        if (!TargetReachable()) return;
        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await TableExistsAsync(connection, "paxstatus")) return;

        var (status, _) = await RunHandlerAsync(
            ReportsEndpoint.PendingAsync,
            "?dateFrom=2026-02-01&dateTo=2026-01-01");

        Assert.Equal(StatusCodes.Status400BadRequest, status);
    }

    [Fact]
    public async Task Same_Inputs_Produce_Identical_Output_On_Repeat_Calls()
    {
        // NFR-006: fixed ORDER BY — the same inputs yield the same rows in the
        // same order, byte for byte.
        if (!TargetReachable()) return;
        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await TableExistsAsync(connection, "paxstatus")) return;

        var (firstStatus, firstBody) = await RunHandlerAsync(
            ReportsEndpoint.PendingAsync, "?dateFrom=2026-01-01&dateTo=2026-12-31");
        var (secondStatus, secondBody) = await RunHandlerAsync(
            ReportsEndpoint.PendingAsync, "?dateFrom=2026-01-01&dateTo=2026-12-31");

        Assert.Equal(StatusCodes.Status200OK, firstStatus);
        Assert.Equal(firstBody, secondBody);

        // The body is valid JSON (a JSON array of pending rows).
        using var document = JsonDocument.Parse(firstBody);
        Assert.Equal(JsonValueKind.Array, document.RootElement.ValueKind);
    }
}