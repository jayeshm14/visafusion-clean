namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `sentmails` table (SPEC-0004 data-model.md §3.1, M —
/// append-only email dispatch log, FR-006/BR-003). PK is the identity column
/// `id` (numeric, values preserved, FR-003).
/// </summary>
public class EmailLog
{
    /// <summary>Legacy `id` (numeric identity) — primary key, values preserved.</summary>
    public long Id { get; set; }

    /// <summary>Legacy `agentsid` — FK to <see cref="Agent.Id"/>.</summary>
    public int Agentsid { get; set; }

    public DateTime? Date { get; set; }
    public string? Toemail { get; set; }
    public string? Awb { get; set; }
}