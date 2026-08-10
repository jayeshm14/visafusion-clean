namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `smshistory` table (SPEC-0004 data-model.md §3.1, M —
/// append-only SMS log, FR-006/BR-003). No identity column in the legacy schema —
/// surrogate `Id` (bigint identity) key added (FR-003).
/// </summary>
public class SmsLog
{
    /// <summary>Surrogate key (bigint identity) — no legacy identity column exists.</summary>
    public long Id { get; set; }

    public string? Cellno { get; set; }
    public int? Refno { get; set; }

    /// <summary>Legacy `agentID` — FK to <see cref="Agent.Id"/>.</summary>
    public int? AgentId { get; set; }

    public string? Paxname { get; set; }
    public string? Status { get; set; }
    public string? Message { get; set; }
    public string? Sentby { get; set; }
    public DateTime? Sentdate { get; set; }
}