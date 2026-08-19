namespace VisaFusion.Core.Application;

/// <summary>
/// Email notification service (SPEC-0008 FR-002/FR-003, research D-2/D-7).
/// Enqueues emails into the durable <c>emailQueue</c> backing store (NEW table,
/// research D-1) and drains the queue transactionally into the <c>sentmails</c>
/// audit log. The interface lives in Core (shared surface); the EF-backed
/// implementation lives in VisaFusion.Data (HolidayService precedent, D-7).
/// </summary>
public interface IEmailService
{
    /// <summary>Validates and enqueues an email message; returns the queue row id.</summary>
    Task<int> EnqueueAsync(EmailMessage message, CancellationToken ct = default);

    /// <summary>Drains the next bounded queue batch transactionally (research D-3).</summary>
    Task<QueueDrainResult> DrainNextBatchAsync(CancellationToken ct = default);

    /// <summary>Reads email history (FR-005), optionally filtered.</summary>
    Task<IReadOnlyList<EmailHistoryItem>> GetHistoryAsync(
        int? agentsid = null,
        DateTime? from = null,
        DateTime? to = null,
        CancellationToken ct = default);
}
