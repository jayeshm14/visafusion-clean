using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using VisaFusion.Core.Application;
using VisaFusion.Core.Options;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;

namespace VisaFusion.Data.Application;

/// <summary>
/// EF-backed email notification service (SPEC-0008 FR-002/FR-003, research D-1/D-3).
/// Enqueue inserts into the NEW <c>emailQueue</c> table; the drain processes a
/// bounded batch with per-row transactions — the audit row in <c>sentmails</c> and
/// the queue-row deletion commit together (send-once gate, research D-3). Failed
/// rows are logged and retained for the worker's next pass (§18).
/// </summary>
public sealed class EmailService : IEmailService
{
    private readonly VisaEntryDbContext _db;
    private readonly IEmailDispatchProvider _dispatch;
    private readonly ILogger<EmailService> _logger;
    private readonly int _batchSize;

    public EmailService(
        VisaEntryDbContext db,
        IEmailDispatchProvider dispatch,
        ILogger<EmailService> logger,
        IOptions<QueueWorkerOptions> options)
    {
        _db = db;
        _dispatch = dispatch;
        _logger = logger;
        _batchSize = options.Value.EmailBatchSize;
    }

    public async Task<int> EnqueueAsync(EmailMessage message, CancellationToken ct = default)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(message.Toemail);
        ArgumentException.ThrowIfNullOrWhiteSpace(message.Subject);
        ArgumentException.ThrowIfNullOrWhiteSpace(message.Body);

        var row = new EmailQueue
        {
            Toemail = message.Toemail,
            Subject = message.Subject,
            Body = message.Body,
            Agentsid = message.Agentsid,
            Refno = message.Refno,
            Awb = message.Awb,
            Sentby = message.Sentby,
            Sentdate = DateTime.Now,
        };
        _db.EmailQueues.Add(row);
        await _db.SaveChangesAsync(ct);
        return (int)row.Id;
    }

    public async Task<QueueDrainResult> DrainNextBatchAsync(CancellationToken ct = default)
    {
        var batch = await _db.EmailQueues
            .OrderBy(q => q.Id)
            .Take(_batchSize)
            .ToListAsync(ct);

        var processed = 0;
        var failed = 0;

        foreach (var row in batch)
        {
            var message = new EmailMessage(row.Toemail!, row.Subject!, row.Body!, row.Agentsid, row.Refno, row.Awb, row.Sentby);

            DispatchResult result;
            try
            {
                result = await _dispatch.SendAsync(message, ct);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Email dispatch provider failed for queue row {EmailQueueId}", row.Id);
                result = new DispatchResult(false);
            }

            try
            {
                await using var tx = await _db.Database.BeginTransactionAsync(ct);
                _db.EmailLogs.Add(new EmailLog
                {
                    // sentmails.agentsid is NOT NULL; 0 = no agent (e.g. the office
                    // contact-query notification email, AC-002).
                    Agentsid = message.Agentsid ?? 0,
                    Date = DateTime.Now,
                    Toemail = row.Toemail,
                    Awb = row.Awb,
                });

                if (result.Success)
                {
                    _db.EmailQueues.Remove(row);
                    processed++;
                }
                else
                {
                    failed++;
                }

                await _db.SaveChangesAsync(ct);
                await tx.CommitAsync(ct);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Database error processing email queue row {EmailQueueId}; row retained for retry", row.Id);
                // Transaction rolled back automatically; row stays in queue for next pass
                failed++;
            }
        }

        var remaining = await _db.EmailQueues.CountAsync(ct);
        return new QueueDrainResult(processed, failed, remaining);
    }

    public async Task<IReadOnlyList<EmailHistoryItem>> GetHistoryAsync(
        int? agentsid = null,
        DateTime? from = null,
        DateTime? to = null,
        CancellationToken ct = default)
    {
        var query = _db.EmailLogs.AsNoTracking().AsQueryable();

        if (agentsid.HasValue) query = query.Where(x => x.Agentsid == agentsid);
        if (from.HasValue) query = query.Where(x => x.Date >= from);
        if (to.HasValue) query = query.Where(x => x.Date <= to);

        return await query
            .OrderByDescending(x => x.Date)
            .Select(x => new EmailHistoryItem(x.Id, x.Agentsid, x.Date, x.Toemail, x.Awb))
            .ToListAsync(ct);
    }
}
