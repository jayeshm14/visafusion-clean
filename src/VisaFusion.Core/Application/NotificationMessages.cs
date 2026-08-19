namespace VisaFusion.Core.Application;

/// <summary>
/// Shared notification contracts (SPEC-0008 T006). Records are shared between the
/// Web enqueue path, the Jobs drain path, and the API layer. Named to avoid
/// collision with the Api-layer DTOs (NotificationContracts.cs).
/// </summary>

/// <summary>An SMS message to enqueue (FR-001).</summary>
public sealed record SmsMessage(
    string Cellno,
    string Message,
    int? Refno = null,
    int? AgentId = null,
    string? Paxname = null,
    string? Sentby = null);

/// <summary>An email message to enqueue (FR-002).</summary>
public sealed record EmailMessage(
    string Toemail,
    string Subject,
    string Body,
    int? Agentsid = null,
    int? Refno = null,
    string? Awb = null,
    string? Sentby = null);

/// <summary>Outcome of one queue drain pass (research D-3).</summary>
public sealed record QueueDrainResult(int Processed, int Failed, int Remaining);

/// <summary>One SMS history row — all eight legacy <c>smshistory</c> fields (FR-004).</summary>
public sealed record SmsHistoryItem(
    long Id,
    string? Cellno,
    int? Refno,
    int? AgentId,
    string? Paxname,
    string? Status,
    string? Message,
    string? Sentby,
    DateTime? Sentdate);

/// <summary>One email history row — legacy <c>sentmails</c> fields (FR-005).</summary>
public sealed record EmailHistoryItem(
    long Id,
    int Agentsid,
    DateTime? Date,
    string? Toemail,
    string? Awb);
