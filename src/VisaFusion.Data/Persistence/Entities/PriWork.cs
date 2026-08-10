namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `priwork` table (SPEC-0004 data-model.md §3.3, COND — internal
/// task tracking until owner approval, BR-004). PK is the identity column `id`
/// (numeric, values preserved).
/// </summary>
public class PriWork
{
    /// <summary>Legacy `id` (numeric identity) — primary key, values preserved.</summary>
    public long Id { get; set; }

    public string? Givenby { get; set; }
    public DateTime? Date { get; set; }
    public DateTime? Edate { get; set; }
    public string? Work { get; set; }
    public string? Status { get; set; }
}