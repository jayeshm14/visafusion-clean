namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `dailyUpdate` table (SPEC-0004 data-model.md §3.1, M — CMS
/// content used by `dailyupdate.asp`). No identity column in the legacy schema —
/// surrogate `Id` (bigint identity) key added (FR-003).
/// </summary>
public class ContentUpdate
{
    /// <summary>Surrogate key (bigint identity) — no legacy identity column exists.</summary>
    public long Id { get; set; }

    public DateTime? Entrydate { get; set; }
    public string? Description { get; set; }
}