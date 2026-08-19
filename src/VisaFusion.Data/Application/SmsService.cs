using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using VisaFusion.Core.Application;
using VisaFusion.Core.Options;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;

namespace VisaFusion.Data.Application;

/// <summary>
/// EF-backed SMS notification service (SPEC-0008 FR-001/FR-003, research D-3/D-7).
/// Enqueue inserts into <c>smsQueue</c>; the drain processes a bounded batch with
/// per-row transactions — the audit row (all 8 <c>smshistory</c> fields) and the
/// queue-row deletion commit together, reproducing the legacy send-once gate
/// (complete_migration_plan §10.6). Failed rows are logged with status 'failed'
/// and retained for the worker's next pass (§18 — no message loss, no silent drop).
/// </summary>
public sealed class SmsService : ISmsService
{
    private readonly VisaEntryDbContext _db;
    private readonly ISmsDispatchProvider _dispatch;
    private readonly ILogger<SmsService> _logger;
    private readonly int _batchSize;

    public SmsService(
        VisaEntryDbContext db,
        ISmsDispatchProvider dispatch,
        ILogger<SmsService> logger,
        IOptions<QueueWorkerOptions> options)
    {
        _db = db;
        _dispatch = dispatch;
        _logger = logger;
        _batchSize = options.Value.SmsBatchSize;
    }

    public async Task<int> EnqueueAsync(SmsMessage message, CancellationToken ct = default)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(message.Cellno);
        ArgumentException.ThrowIfNullOrWhiteSpace(message.Message);

        var row = new SmsQueue
        {
            Cellno = message.Cellno,
            Refno = message.Refno,
            AgentId = message.AgentId,
            Paxname = message.Paxname,
            Message = message.Message,
            Sentby = message.Sentby,
            Sentdate = DateTime.Now,
        };
        _db.SmsQueues.Add(row);
        await _db.SaveChangesAsync(ct);
        return (int)row.Id;
    }

    public async Task<QueueDrainResult> DrainNextBatchAsync(CancellationToken ct = default)
    {
        var batch = await _db.SmsQueues
            .OrderBy(q => q.Id)
            .Take(_batchSize)
            .ToListAsync(ct);

        var processed = 0;
        var failed = 0;

        foreach (var row in batch)
        {
            var message = new SmsMessage(row.Cellno!, row.Message!, row.Refno, row.AgentId, row.Paxname, row.Sentby);

            DispatchResult result;
            try
            {
                result = await _dispatch.SendAsync(message, ct);
            }
            catch (Exception ex)
            {
                // Provider threw — treated as a failed attempt (FR-006, §18).
                _logger.LogError(ex, "SMS dispatch provider failed for queue row {SmsQueueId}", row.Id);
                result = new DispatchResult(false);
            }

            try
            {
                await using var tx = await _db.Database.BeginTransactionAsync(ct);
                _db.SmsLogs.Add(new SmsLog
                {
                    Cellno = row.Cellno,
                    Refno = row.Refno,
                    AgentId = row.AgentId,
                    Paxname = row.Paxname,
                    Status = result.Success ? "sent" : "failed",
                    Message = row.Message,
                    Sentby = row.Sentby,
                    Sentdate = DateTime.Now,
                });

                if (result.Success)
                {
                    // Send-once gate: the audit row + queue-row deletion commit together.
                    _db.SmsQueues.Remove(row);
                    processed++;
                }
                else
                {
                    // §18: failed rows are retained for the next drain pass. Each attempt
                    // is logged once with its status (NFR-005); the row stays in the queue.
                    failed++;
                }

                await _db.SaveChangesAsync(ct);
                await tx.CommitAsync(ct);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Database error processing SMS queue row {SmsQueueId}; row retained for retry", row.Id);
                // Transaction rolled back automatically; row stays in queue for next pass
                failed++;
            }
        }

        var remaining = await _db.SmsQueues.CountAsync(ct);
        return new QueueDrainResult(processed, failed, remaining);
    }

    public async Task<IReadOnlyList<SmsHistoryItem>> GetHistoryAsync(
        int? refno = null,
        int? agentId = null,
        DateTime? from = null,
        DateTime? to = null,
        CancellationToken ct = default)
    {
        var query = _db.SmsLogs.AsNoTracking().AsQueryable();

        if (refno.HasValue) query = query.Where(x => x.Refno == refno);
        if (agentId.HasValue) query = query.Where(x => x.AgentId == agentId);
        if (from.HasValue) query = query.Where(x => x.Sentdate >= from);
        if (to.HasValue) query = query.Where(x => x.Sentdate <= to);

        return await query
            .OrderByDescending(x => x.Sentdate)
            .Select(x => new SmsHistoryItem(
                x.Id, x.Cellno, x.Refno, x.AgentId, x.Paxname, x.Status, x.Message, x.Sentby, x.Sentdate))
            .ToListAsync(ct);
    }
}
