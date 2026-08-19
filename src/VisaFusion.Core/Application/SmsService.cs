namespace VisaFusion.Core.Application;

/// <summary>
/// SMS notification service (SPEC-0008 FR-001/FR-003, research D-2/D-7). Enqueues
/// SMS messages into the durable <c>smsQueue</c> backing store and drains the queue
/// transactionally into the <c>smshistory</c> audit log. The interface lives in Core
/// (shared surface); the EF-backed implementation lives in VisaFusion.Data
/// (HolidayService precedent, research D-7).
/// </summary>
public interface ISmsService
{
    /// <summary>Validates and enqueues an SMS message; returns the queue row id.</summary>
    Task<int> EnqueueAsync(SmsMessage message, CancellationToken ct = default);

    /// <summary>Drains the next bounded queue batch transactionally (research D-3).</summary>
    Task<QueueDrainResult> DrainNextBatchAsync(CancellationToken ct = default);

    /// <summary>Reads SMS history (FR-004), optionally filtered.</summary>
    Task<IReadOnlyList<SmsHistoryItem>> GetHistoryAsync(
        int? refno = null,
        int? agentId = null,
        DateTime? from = null,
        DateTime? to = null,
        CancellationToken ct = default);
}
