namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `deleteditem` table (SPEC-0004 data-model.md §3.2, M-RO —
/// audit-only). No identity column in the legacy schema — surrogate `Id`
/// (bigint identity) key added (FR-003).
/// </summary>
public class DeletedItemAudit
{
    /// <summary>Surrogate key (bigint identity) — no legacy identity column exists.</summary>
    public long Id { get; set; }

    public int? Refno { get; set; }
    public int? Paxid { get; set; }
    public int? Countryid { get; set; }
    public string? Deletedby { get; set; }
    public string? Description { get; set; }
}