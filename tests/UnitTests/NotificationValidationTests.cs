using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Logging.Abstractions;
using Microsoft.Extensions.Options;
using VisaFusion.Api.Contracts;
using VisaFusion.Core.Application;
using VisaFusion.Core.Options;
using VisaFusion.Data.Application;
using VisaFusion.Data.Persistence;

namespace VisaFusion.UnitTests;

/// <summary>
/// Notification validation + audit-field completeness tests (SPEC-0008 T022,
/// FR-001/FR-004, spec §17; contracts/notifications-api.md §1/§2).
///
/// Validation: the same shared DataAnnotations the endpoints run
/// (NotificationsEndpoint.TryValidate) over the SMS/email enqueue request
/// shapes — recipient required + valid, message/subject/body required with
/// length limits.
///
/// Audit-field completeness: the REAL <see cref="SmsService"/> drain over a
/// hermetic EF InMemory <see cref="VisaEntryDbContext"/> writes all eight
/// legacy `smshistory` fields (cellno, refno, agentID, paxname, status,
/// message, sentby, sentdate — FR-004) and removes the queue row (send-once
/// gate, research D-3).
/// </summary>
public class NotificationValidationTests
{
    // ---- SMS enqueue validation (spec §17) ----

    [Fact]
    public void Valid_Sms_Request_Passes()
    {
        Assert.True(TryValidate(ValidSms(), out _));
    }

    [Theory]
    [InlineData(null)]
    [InlineData("")]
    [InlineData("   ")]
    public void Missing_Or_Blank_Mobile_Fails(string? mobile)
    {
        var request = ValidSms() with { Mobile = mobile };
        Assert.False(TryValidate(request, out _));
    }

    [Theory]
    [InlineData("12345")]          // too short
    [InlineData("1234567890123456")] // too long
    [InlineData("abc12345678")]    // non-digits
    [InlineData("+91-9876543210")] // separators not allowed
    public void Invalid_Mobile_Format_Fails(string mobile)
    {
        var request = ValidSms() with { Mobile = mobile };
        Assert.False(TryValidate(request, out _));
    }

    [Theory]
    [InlineData(null)]
    [InlineData("")]
    [InlineData("   ")]
    public void Missing_Or_Blank_Message_Fails(string? message)
    {
        var request = ValidSms() with { Message = message };
        Assert.False(TryValidate(request, out _));
    }

    [Fact]
    public void Message_Over_160_Characters_Fails()
    {
        // SMS standard length limit (documented validation bound, spec §17).
        var request = ValidSms() with { Message = new string('m', 161) };
        Assert.False(TryValidate(request, out _));
    }

    // ---- Email enqueue validation (spec §17) ----

    [Fact]
    public void Valid_Email_Request_Passes()
    {
        Assert.True(TryValidate(ValidEmail(), out _));
    }

    [Theory]
    [InlineData(null)]
    [InlineData("")]
    [InlineData("   ")]
    public void Missing_Or_Blank_To_Fails(string? to)
    {
        var request = ValidEmail() with { To = to };
        Assert.False(TryValidate(request, out _));
    }

    [Theory]
    [InlineData("not-an-email")]
    [InlineData("user@")]
    public void Invalid_To_Format_Fails(string to)
    {
        var request = ValidEmail() with { To = to };
        Assert.False(TryValidate(request, out _));
    }

    [Theory]
    [InlineData(null)]
    [InlineData("")]
    public void Missing_Or_Blank_Subject_Fails(string? subject)
    {
        var request = ValidEmail() with { Subject = subject };
        Assert.False(TryValidate(request, out _));
    }

    [Theory]
    [InlineData(null)]
    [InlineData("")]
    public void Missing_Or_Blank_Body_Fails(string? body)
    {
        var request = ValidEmail() with { Body = body };
        Assert.False(TryValidate(request, out _));
    }

    [Fact]
    public void Subject_Over_256_Characters_Fails()
    {
        // The `emailQueue.subject` column caps at 256 (ConfigureEmailQueue).
        var request = ValidEmail() with { Subject = new string('s', 257) };
        Assert.False(TryValidate(request, out _));
    }

    [Fact]
    public void Body_Over_8000_Characters_Fails()
    {
        // Documented validation bound (body column is nvarchar(max); spec §17
        // requires a length limit — 8000 per data-model.md §1).
        var request = ValidEmail() with { Body = new string('b', 8001) };
        Assert.False(TryValidate(request, out _));
    }

    // ---- Audit-field completeness (FR-004) ----

    [Fact]
    public async Task Sms_Drain_Writes_All_Eight_Audit_Fields_And_Removes_The_Queue_Row()
    {
        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseInMemoryDatabase($"sms-audit-{Guid.NewGuid():N}")
            // The drain uses BeginTransactionAsync (research D-3); the InMemory
            // store treats transactions as no-ops and raises
            // TransactionIgnoredWarning — ignored here (the real transactional
            // behavior is covered by the integration tests).
            .ConfigureWarnings(w => w.Ignore(InMemoryEventId.TransactionIgnoredWarning))
            .Options;
        await using var db = new VisaEntryDbContext(options);
        var queueOptions = Options.Create(new QueueWorkerOptions());
        var service = new SmsService(
            db,
            new LogOnlySmsDispatchProvider(NullLogger<LogOnlySmsDispatchProvider>.Instance),
            NullLogger<SmsService>.Instance,
            queueOptions);

        var queueId = await service.EnqueueAsync(new SmsMessage(
            Cellno: "+919876543210",
            Message: "Your visa status has been updated",
            Refno: 1001,
            AgentId: 42,
            Paxname: "Test Pax",
            Sentby: "emp:test-user"));

        var result = await service.DrainNextBatchAsync();

        Assert.Equal(1, result.Processed);
        Assert.Equal(0, result.Failed);
        Assert.Equal(0, result.Remaining);

        var log = db.SmsLogs.Single();
        Assert.Equal("+919876543210", log.Cellno);
        Assert.Equal(1001, log.Refno);
        Assert.Equal(42, log.AgentId);
        Assert.Equal("Test Pax", log.Paxname);
        Assert.Equal("sent", log.Status);
        Assert.Equal("Your visa status has been updated", log.Message);
        Assert.Equal("emp:test-user", log.Sentby);
        Assert.NotNull(log.Sentdate);

        Assert.Null(db.SmsQueues.Find((long)queueId)); // send-once gate: row removed
    }

    [Fact]
    public async Task Sms_Drain_Logs_Failed_Status_And_Retains_The_Queue_Row()
    {
        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseInMemoryDatabase($"sms-fail-{Guid.NewGuid():N}")
            .ConfigureWarnings(w => w.Ignore(InMemoryEventId.TransactionIgnoredWarning))
            .Options;
        await using var db = new VisaEntryDbContext(options);
        var queueOptions = Options.Create(new QueueWorkerOptions());
        var service = new SmsService(
            db,
            new FailingSmsDispatchProvider(),
            NullLogger<SmsService>.Instance,
            queueOptions);

        var queueId = await service.EnqueueAsync(new SmsMessage(
            Cellno: "+919876543210",
            Message: "Will fail",
            Sentby: "emp:test-user"));

        var result = await service.DrainNextBatchAsync();

        // §18: the failure is visible in the audit log (status=failed) and the
        // queue row is retained for the next drain pass — never silently
        // swallowed (FR-006, AC-004).
        Assert.Equal(0, result.Processed);
        Assert.Equal(1, result.Failed);
        Assert.Equal(1, result.Remaining);

        var log = db.SmsLogs.Single();
        Assert.Equal("failed", log.Status);
        Assert.NotNull(db.SmsQueues.Find((long)queueId)); // retained for retry
    }

    // ---- Email audit-field completeness (FR-005, T028) ----

    [Fact]
    public async Task Email_Drain_Writes_Sentmails_Fields_And_Removes_The_Queue_Row()
    {
        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseInMemoryDatabase($"email-audit-{Guid.NewGuid():N}")
            .ConfigureWarnings(w => w.Ignore(InMemoryEventId.TransactionIgnoredWarning))
            .Options;
        await using var db = new VisaEntryDbContext(options);
        var queueOptions = Options.Create(new QueueWorkerOptions());
        var service = new EmailService(
            db,
            new LogOnlyEmailDispatchProvider(NullLogger<LogOnlyEmailDispatchProvider>.Instance),
            NullLogger<EmailService>.Instance,
            queueOptions);

        var queueId = await service.EnqueueAsync(new EmailMessage(
            Toemail: "agent@example.com",
            Subject: "Visa status update",
            Body: "Your visa application has been processed.",
            Agentsid: 42,
            Refno: 1001,
            Awb: "AWB123",
            Sentby: "emp:test-user"));

        var result = await service.DrainNextBatchAsync();

        Assert.Equal(1, result.Processed);
        Assert.Equal(0, result.Failed);

        var log = db.EmailLogs.Single();
        Assert.Equal(42, log.Agentsid);
        Assert.Equal("agent@example.com", log.Toemail);
        Assert.Equal("AWB123", log.Awb);
        Assert.NotNull(log.Date);

        Assert.Null(db.EmailQueues.Find((long)queueId)); // send-once gate
    }

    [Fact]
    public async Task Email_Drain_No_Agent_Logs_The_Zero_Sentinel()
    {
        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseInMemoryDatabase($"email-noagent-{Guid.NewGuid():N}")
            .ConfigureWarnings(w => w.Ignore(InMemoryEventId.TransactionIgnoredWarning))
            .Options;
        await using var db = new VisaEntryDbContext(options);
        var queueOptions = Options.Create(new QueueWorkerOptions());
        var service = new EmailService(
            db,
            new LogOnlyEmailDispatchProvider(NullLogger<LogOnlyEmailDispatchProvider>.Instance),
            NullLogger<EmailService>.Instance,
            queueOptions);

        await service.EnqueueAsync(new EmailMessage(
            Toemail: "office@example.com",
            Subject: "Query",
            Body: "Body"));

        await service.DrainNextBatchAsync();

        // sentmails.agentsid is NOT NULL; 0 = no agent (e.g. the office
        // contact-query notification email, AC-002).
        Assert.Equal(0, db.EmailLogs.Single().Agentsid);
    }

[Fact]
    public async Task Email_Drain_Failed_Dispatch_Retains_The_Queue_Row_For_Retry()
    {
        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseInMemoryDatabase($"email-fail-{Guid.NewGuid():N}")
            .ConfigureWarnings(w => w.Ignore(InMemoryEventId.TransactionIgnoredWarning))
            .Options;
        await using var db = new VisaEntryDbContext(options);
        var queueOptions = Options.Create(new QueueWorkerOptions());
        var service = new EmailService(
            db,
            new FailingEmailDispatchProvider(),
            NullLogger<EmailService>.Instance,
            queueOptions);

        var queueId = await service.EnqueueAsync(new EmailMessage(
            Toemail: "agent@example.com",
            Subject: "Visa status update",
            Body: "Body"));

        var result = await service.DrainNextBatchAsync();

        // The failure is visible in the audit log (the sentmails row is written)
        // and the queue row is retained for the next drain pass (FR-006, §18).
        Assert.Equal(0, result.Processed);
        Assert.Equal(1, result.Failed);
        Assert.Equal(1, result.Remaining);
        Assert.Single(db.EmailLogs);
        Assert.NotNull(db.EmailQueues.Find((long)queueId)); // retained for retry
    }

    private static bool TryValidate<T>(T request, out string detail)
        where T : class
    {
        var results = new List<ValidationResult>();
        var isValid = Validator.TryValidateObject(
            request, new ValidationContext(request), results, validateAllProperties: true);
        detail = isValid
            ? ""
            : string.Join("; ", results.Select(r => r.ErrorMessage));
        return isValid;
    }

    private static SmsEnqueueRequest ValidSms() => new()
    {
        Mobile = "+919876543210",
        Message = "Your visa status has been updated",
    };

    private static EmailEnqueueRequest ValidEmail() => new()
    {
        To = "agent@example.com",
        Subject = "Visa status update",
        Body = "Your visa application has been processed.",
    };

    /// <summary>Failure-injection provider for the SMS retry/visibility test (AC-004).</summary>
    private sealed class FailingSmsDispatchProvider : ISmsDispatchProvider
    {
        public Task<DispatchResult> SendAsync(SmsMessage message, CancellationToken ct = default)
            => Task.FromResult(new DispatchResult(false, "injected failure"));
    }

    /// <summary>Failure-injection provider for the email retry/visibility test (AC-004).</summary>
    private sealed class FailingEmailDispatchProvider : IEmailDispatchProvider
    {
        public Task<DispatchResult> SendAsync(EmailMessage message, CancellationToken ct = default)
            => Task.FromResult(new DispatchResult(false, "injected failure"));
    }
}