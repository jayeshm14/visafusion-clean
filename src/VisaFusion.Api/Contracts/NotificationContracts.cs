using System.ComponentModel.DataAnnotations;

namespace VisaFusion.Api.Contracts;

/// <summary>
/// Request body for POST /api/v1/notifications/sms (SPEC-0008 FR-001;
/// contracts/notifications-api.md §1). Validation per spec §17: recipient
/// mobile required and valid, message required with a length limit.
///
/// The mobile format rule is a documented modernization decision: the legacy
/// `SendSMSManually.asp` only checked non-empty (`if (message &lt;&gt;"" and
/// cellno &lt;&gt;"")`), while the contract requires a "valid format" — a
/// conservative international mobile pattern (10-15 digits, optional leading
/// +) is enforced here.
/// </summary>
public sealed record SmsEnqueueRequest
{
    /// <summary>Recipient mobile — required, valid format.</summary>
    [Required]
    [RegularExpression(@"^\+?[0-9]{10,15}$",
        ErrorMessage = "mobile must be a valid phone number (10-15 digits, optional leading +)")]
    public string? Mobile { get; init; }

    /// <summary>Message text — required, length limit 160 (SMS standard).</summary>
    [Required]
    [StringLength(160)]
    public string? Message { get; init; }

    /// <summary>Optional entry reference (legacy `refno` context).</summary>
    public int? Refno { get; init; }

    /// <summary>Optional agent context (legacy `agentID`).</summary>
    public int? AgentId { get; init; }
}

/// <summary>
/// Request body for POST /api/v1/notifications/email (SPEC-0008 FR-002;
/// contracts/notifications-api.md §2). Validation per spec §17: recipient
/// email required and valid, subject and body required with length limits.
/// Subject caps at the `emailQueue.subject` column limit (256); body caps at
/// 8000 — the column is nvarchar(max) with no schema limit, so 8000 is the
/// documented validation bound (same bound as the `dailyUpdate.Description`
/// column, data-model.md §1).
/// </summary>
public sealed record EmailEnqueueRequest
{
    /// <summary>Recipient email — required, valid.</summary>
    [Required]
    [EmailAddress]
    [StringLength(256)]
    public string? To { get; init; }

    /// <summary>Subject — required, length limit 256.</summary>
    [Required]
    [StringLength(256)]
    public string? Subject { get; init; }

    /// <summary>Body — required, length limit 8000.</summary>
    [Required]
    [StringLength(8000)]
    public string? Body { get; init; }

    /// <summary>Optional entry reference (legacy `refno` context).</summary>
    public int? Refno { get; init; }

    /// <summary>Optional agent context (maps to `sentmails.agentsid`).</summary>
    public int? AgentId { get; init; }
}