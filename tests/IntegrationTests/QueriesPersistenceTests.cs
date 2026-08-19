using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging.Abstractions;
using Microsoft.Extensions.Options;
using VisaFusion.Core.Application;
using VisaFusion.Core.Options;
using VisaFusion.Data.Application;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// Contact-query persistence tests (SPEC-0008 T017, FR-007/FR-008, AC-001/
/// AC-002).
///
/// Exercises the REAL <see cref="VisaEntryDbContext"/> (the new `queries` and
/// `emailQueue` tables from migration 20260818101754_AddQueriesAndEmailQueue)
/// and the REAL <see cref="EmailService"/> over a live SQL Server:
///   - a persisted contact query lands in `queries` with status 'new',
///     timestamp and IP (AC-001),
///   - the office notification email enqueues to `emailQueue` and drains
///     transactionally into `sentmails` with the 0-agentsid sentinel for the
///     no-agent office email (AC-002, research D-3).
/// Test rows are deleted in a `finally` block. Tests skip when SQL Server is
/// unreachable or the required tables do not exist (existing convention).
/// </summary>
public class QueriesPersistenceTests
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
    public async Task Contact_Query_Persists_With_Timestamp_Status_And_Ip()
    {
        if (!TargetReachable()) return;
        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await TableExistsAsync(connection, "queries")) return;

        var marker = $"t017-{Guid.NewGuid():N}";
        await using var db = CreateContext();
        var query = new ContactQuery
        {
            Name = $"Name {marker}",
            Email = $"{marker}@test.local",
            Subject = "Test subject",
            Message = "Test message",
            Subdate = DateTime.Now,
            Status = "new",
            IpAddress = "127.0.0.1",
        };
        db.ContactQueries.Add(query);
        await db.SaveChangesAsync();

        try
        {
            var saved = await db.ContactQueries.SingleAsync(q => q.Id == query.Id);
            Assert.Equal("new", saved.Status); // owner Q4:A — read-only audit trail
            Assert.Equal($"Name {marker}", saved.Name);
            Assert.Equal($"{marker}@test.local", saved.Email);
            Assert.Equal("127.0.0.1", saved.IpAddress);
            Assert.True(saved.Subdate > DateTime.Now.AddMinutes(-5)); // AC-001 timestamp
        }
        finally
        {
            await db.Database.ExecuteSqlRawAsync("DELETE FROM queries WHERE id = {0}", query.Id);
        }
    }

    [Fact]
    public async Task Office_Email_Is_Enqueued_And_Drained_To_Sentmails()
    {
        if (!TargetReachable()) return;
        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await TableExistsAsync(connection, "emailQueue")) return;
        if (!await TableExistsAsync(connection, "sentmails")) return;

        var marker = $"t017-{Guid.NewGuid():N}";
        var testOfficeEmail = $"office-{marker}@test.local";
        await using var db = CreateContext();
        var options = Options.Create(new QueueWorkerOptions());
        var service = new EmailService(
            db,
            new LogOnlyEmailDispatchProvider(NullLogger<LogOnlyEmailDispatchProvider>.Instance),
            NullLogger<EmailService>.Instance,
            options);

        var queueId = await service.EnqueueAsync(new EmailMessage(
            testOfficeEmail,
            OfficeEmailTemplate.Subject,
            OfficeEmailTemplate.BuildHtmlBody($"Name {marker}", $"{marker}@test.local", "Test message")));

        try
        {
            // The drain may also process other queued rows (bounded batch) — the
            // assertions target this message's own row and the audit trail it
            // produces (research D-3: audit insert + queue delete transactional).
            var result = await service.DrainNextBatchAsync();
            Assert.True(result.Processed >= 1);
            Assert.Null(await db.EmailQueues.FindAsync((long)queueId)); // drained

            var log = await db.EmailLogs
                .Where(l => l.Toemail == testOfficeEmail
                    && l.Date > DateTime.Now.AddMinutes(-5))
                .OrderByDescending(l => l.Date)
                .FirstAsync();
            Assert.Equal(0, log.Agentsid); // 0 sentinel: no agent (AC-002)
        }
        finally
        {
            await db.Database.ExecuteSqlRawAsync(
                "DELETE FROM sentmails WHERE toemail = {0}", testOfficeEmail);
            // Also remove any leftover office-email queue row so an interrupted
            // run cannot leave a row for a later drain pass to process.
            await db.Database.ExecuteSqlRawAsync(
                "DELETE FROM emailQueue WHERE toemail = {0}", testOfficeEmail);
        }
    }
}