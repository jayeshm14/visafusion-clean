namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `bighistory` table (SPEC-0004 data-model.md §3.1, M —
/// append-only audit log, FR-006/BR-003). PK is the identity column
/// `bighistoryid` (values preserved, FR-003).
/// </summary>
public class EntryAuditLog
{
    /// <summary>Legacy `bighistoryid` (identity) — primary key, values preserved.</summary>
    public int Id { get; set; }

    public int? Refno { get; set; }
    public int? Agent { get; set; }
    public DateTime? Date { get; set; }
    public string? UpdatedBy { get; set; }
    public string? Remarks { get; set; }
}