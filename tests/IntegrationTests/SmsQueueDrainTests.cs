using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging.Abstractions;
using Microsoft.Extensions.Options;
using VisaFusion.Core.Application;
using VisaFusion.Core.Options;
using VisaFusion.Data.Application;
using VisaFusion.Data.Persistence;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// SMS queue drain tests (SPEC-0008 T023, FR-001/FR-004/FR-006, AC-003/AC-004;
/// contracts/notifications-api.md §5).
///
/// Exercises the REAL <see cref="SmsService"/> over a live SQL Server:
///   - enqueue → drain writes an `smshistory` row with all eight audit fields
///     and removes the queue row (AC-003); a second drain does not duplicate
///     the send (send-once gate, research D-3),
///   - failure-injection: a failing dispatch provider writes status='failed'
///     and retains the queue row; the next drain pass (success provider)
///     retries and completes the send — never silently swallowed (AC-004).
/// Test rows are deleted in a `finally` block. Tests skip when SQL Server is
/// unreachable or the required tables do not exist (existing convention).
/// </summary>
public class SmsQueueDrainTests
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

    [Fact]
    public async Task Drain_Writes_All_Eight_Audit_Fields_And_Does_Not_Duplicate()
    {
        if (!TargetReachable()) return;
        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await TableExistsAsync(connection, "smsQueue")) return;
        if (!await TableExistsAsync(connection, "smshistory")) return;

        var marker = $"t023-{Guid.NewGuid():N}";
        var cellno = $"+91{new Random().Next(100000000, 999999999)}";
        await using var db = CreateContext();
        var options = Options.Create(new QueueWorkerOptions());
        var service = new SmsService(
            db,
            new LogOnlySmsDispatchProvider(NullLogger<LogOnlySmsDispatchProvider>.Instance),
            NullLogger<SmsService>.Instance,
            options);

        var queueId = await service.EnqueueAsync(new SmsMessage(
            Cellno: cellno,
            Message: $"Audit completeness {marker}",
            Refno: 1001,
            AgentId: 42,
            Paxname: "Test Pax",
            Sentby: "emp:test-user"));

        try
        {
            var first = await service.DrainNextBatchAsync();
            Assert.True(first.Processed >= 1);

            var log = await db.SmsLogs.SingleAsync(l => l.Cellno == cellno);
            Assert.Equal(1001, log.Refno);
            Assert.Equal(42, log.AgentId);
            Assert.Equal("Test Pax", log.Paxname);
            Assert.Equal("sent", log.Status);
            Assert.Equal($"Audit completeness {marker}", log.Message);
            Assert.Equal("emp:test-user", log.Sentby);
            Assert.NotNull(log.Sentdate);
            Assert.Null(await db.SmsQueues.FindAsync((long)queueId)); // send-once gate

            // A second drain must not re-send (no duplicate audit row).
            await service.DrainNextBatchAsync();
            Assert.Equal(1, await db.SmsLogs.CountAsync(l => l.Cellno == cellno));
        }
        finally
        {
            // Suite-wide cleanup: every row this test class writes carries the
            // t023- marker prefix in Message (both tests), so a LIKE on the
            // prefix removes this run's rows AND residue left by interrupted
            // earlier runs (whose drain passes wrote rows for other tests'
            // leftover queue rows). Without it, residue would pollute the
            // shared smshistory table and break the SPEC-0004 byte-identical
            // audit checksum.
            await db.Database.ExecuteSqlRawAsync(
                "DELETE FROM smshistory WHERE Message LIKE {0}", "%t023-%");
            await db.Database.ExecuteSqlRawAsync(
                "DELETE FROM smsQueue WHERE Message LIKE {0}", "%t023-%");
        }
    }

    [Fact]
    public async Task Failed_Dispatch_Is_Logged_And_Retried_On_The_Next_Pass()
    {
        if (!TargetReachable()) return;
        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await TableExistsAsync(connection, "smsQueue")) return;
        if (!await TableExistsAsync(connection, "smshistory")) return;

        var marker = $"t023-{Guid.NewGuid():N}";
        var cellno = $"+91{new Random().Next(100000000, 999999999)}";
        await using var db = CreateContext();
        var options = Options.Create(new QueueWorkerOptions());
        var failing = new SmsService(
            db,
            new FailingSmsDispatchProvider(),
            NullLogger<SmsService>.Instance,
            options);

        var queueId = await failing.EnqueueAsync(new SmsMessage(
            Cellno: cellno,
            Message: $"Retry {marker}",
            Sentby: "emp:test-user"));

        try
        {
            // Pass 1: the provider fails — status='failed' is logged and the
            // queue row is retained for the next pass (§18, AC-004).
            var first = await failing.DrainNextBatchAsync();
            Assert.True(first.Failed >= 1);
            var failedLog = await db.SmsLogs.SingleAsync(l => l.Cellno == cellno);
            Assert.Equal("failed", failedLog.Status);
            Assert.NotNull(await db.SmsQueues.FindAsync((long)queueId)); // retained

            // Pass 2: the log-only provider succeeds — the retry completes the
            // send and the queue row is removed (send-once gate).
            var retrying = new SmsService(
                db,
                new LogOnlySmsDispatchProvider(NullLogger<LogOnlySmsDispatchProvider>.Instance),
                NullLogger<SmsService>.Instance,
                options);
            var second = await retrying.DrainNextBatchAsync();
            Assert.True(second.Processed >= 1);
            Assert.Null(await db.SmsQueues.FindAsync((long)queueId));

            var sentLog = await db.SmsLogs.SingleAsync(l => l.Cellno == cellno && l.Status == "sent");
            Assert.Equal($"Retry {marker}", sentLog.Message);
        }
        finally
        {
            // Same suite-wide cleanup as the sibling test (see above): the retry
            // test writes TWO audit rows (status 'failed' then 'sent') for the
            // same cellno, and a drain batch may also process leftover rows from
            // an interrupted earlier run.
            await db.Database.ExecuteSqlRawAsync(
                "DELETE FROM smshistory WHERE Message LIKE {0}", "%t023-%");
            await db.Database.ExecuteSqlRawAsync(
                "DELETE FROM smsQueue WHERE Message LIKE {0}", "%t023-%");
        }
    }

    /// <summary>Failure-injection provider for the retry/visibility test (AC-004).</summary>
    private sealed class FailingSmsDispatchProvider : ISmsDispatchProvider
    {
        public Task<DispatchResult> SendAsync(SmsMessage message, CancellationToken ct = default)
            => Task.FromResult(new DispatchResult(false, "injected failure"));
    }
}
