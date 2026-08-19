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
/// Email queue drain tests (SPEC-0008 T029, FR-002/FR-005/FR-006, AC-005;
/// contracts/notifications-api.md §5).
///
/// Exercises the REAL <see cref="EmailService"/> over a live SQL Server:
///   - enqueue → drain writes a `sentmails` row (agentsid, date, toemail, awb —
///     AC-005) and removes the `emailQueue` row (send-once gate, research D-3);
///     a second drain does not duplicate the send,
///   - failure-injection: a failing dispatch provider retains the queue row for
///     the next pass; the retry completes the send (AC-004).
/// Test rows are deleted in a `finally` block. Tests skip when SQL Server is
/// unreachable or the required tables do not exist (existing convention).
/// </summary>
public class EmailQueueDrainTests
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
    public async Task Drain_Writes_Sentmails_Fields_And_Does_Not_Duplicate()
    {
        if (!TargetReachable()) return;
        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await TableExistsAsync(connection, "emailQueue")) return;
        if (!await TableExistsAsync(connection, "sentmails")) return;

        var marker = $"t029-{Guid.NewGuid():N}";
        var toemail = $"{marker}@test.local";
        await using var db = CreateContext();
        var options = Options.Create(new QueueWorkerOptions());
        var service = new EmailService(
            db,
            new LogOnlyEmailDispatchProvider(NullLogger<LogOnlyEmailDispatchProvider>.Instance),
            NullLogger<EmailService>.Instance,
            options);

        var queueId = await service.EnqueueAsync(new EmailMessage(
            Toemail: toemail,
            Subject: $"Subject {marker}",
            Body: $"Body {marker}",
            Agentsid: 42,
            Refno: 1001,
            Awb: "AWB123",
            Sentby: "emp:test-user"));

        try
        {
            var first = await service.DrainNextBatchAsync();
            Assert.True(first.Processed >= 1);

            var log = await db.EmailLogs.SingleAsync(l => l.Toemail == toemail);
            Assert.Equal(42, log.Agentsid);
            Assert.Equal("AWB123", log.Awb);
            Assert.NotNull(log.Date);
            Assert.Null(await db.EmailQueues.FindAsync((long)queueId)); // send-once gate

            // A second drain must not re-send (no duplicate audit row).
            await service.DrainNextBatchAsync();
            Assert.Equal(1, await db.EmailLogs.CountAsync(l => l.Toemail == toemail));
        }
        finally
        {
            // sentmails has no subject column (id/agentsid/date/toemail/awb
            // only), so the marker is matched through the suite-wide
            // @test.local test-address pattern — this also removes residue left
            // by interrupted earlier runs whose drain passes wrote rows for
            // other tests' leftover queue rows (those rows would otherwise
            // break the SPEC-0004 byte-identical audit checksum).
            await db.Database.ExecuteSqlRawAsync(
                "DELETE FROM sentmails WHERE toemail LIKE {0}", "%@test.local");
            await db.Database.ExecuteSqlRawAsync(
                "DELETE FROM emailQueue WHERE toemail LIKE {0}", "%@test.local");
        }
    }

    [Fact]
    public async Task Failed_Dispatch_Is_Retried_On_The_Next_Pass()
    {
        if (!TargetReachable()) return;
        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await TableExistsAsync(connection, "emailQueue")) return;
        if (!await TableExistsAsync(connection, "sentmails")) return;

        var marker = $"t029-{Guid.NewGuid():N}";
        var toemail = $"{marker}@test.local";
        await using var db = CreateContext();
        var options = Options.Create(new QueueWorkerOptions());
        var failing = new EmailService(
            db,
            new FailingEmailDispatchProvider(),
            NullLogger<EmailService>.Instance,
            options);

        var queueId = await failing.EnqueueAsync(new EmailMessage(
            Toemail: toemail,
            Subject: $"Subject {marker}",
            Body: $"Body {marker}"));

        try
        {
            // Pass 1: the provider fails — the audit row is still written and
            // the queue row is retained for the next pass (§18, AC-004).
            var first = await failing.DrainNextBatchAsync();
            Assert.True(first.Failed >= 1);
            Assert.Single(await db.EmailLogs.Where(l => l.Toemail == toemail).ToListAsync());
            Assert.NotNull(await db.EmailQueues.FindAsync((long)queueId)); // retained

            // Pass 2: the log-only provider succeeds — the retry completes the
            // send and the queue row is removed (send-once gate).
            var retrying = new EmailService(
                db,
                new LogOnlyEmailDispatchProvider(NullLogger<LogOnlyEmailDispatchProvider>.Instance),
                NullLogger<EmailService>.Instance,
                options);
            var second = await retrying.DrainNextBatchAsync();
            Assert.True(second.Processed >= 1);
            Assert.Null(await db.EmailQueues.FindAsync((long)queueId));
        }
        finally
        {
            // Same suite-wide cleanup as the sibling test (see above): the retry
            // test writes TWO audit rows for the same toemail, and a drain
            // batch may also process leftover rows from an interrupted earlier
            // run.
            await db.Database.ExecuteSqlRawAsync(
                "DELETE FROM sentmails WHERE toemail LIKE {0}", "%@test.local");
            await db.Database.ExecuteSqlRawAsync(
                "DELETE FROM emailQueue WHERE toemail LIKE {0}", "%@test.local");
        }
    }

    /// <summary>Failure-injection provider for the retry/visibility test (AC-004).</summary>
    private sealed class FailingEmailDispatchProvider : IEmailDispatchProvider
    {
        public Task<DispatchResult> SendAsync(EmailMessage message, CancellationToken ct = default)
            => Task.FromResult(new DispatchResult(false, "injected failure"));
    }
}