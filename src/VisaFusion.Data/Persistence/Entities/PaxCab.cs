namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `paxCab` table (SPEC-0004 data-model.md §3.3, COND — child of
/// `cab`, archived until owner approval, BR-004). No identity column in the
/// legacy schema — surrogate `Id` (bigint identity) key added.
/// </summary>
public class PaxCab
{
    /// <summary>Surrogate key (bigint identity) — no legacy identity column exists.</summary>
    public long Id { get; set; }

    public int? Refno { get; set; }
    public string? Name { get; set; }
    public string? Cabowner { get; set; }
    public string? Vehical { get; set; }
    public string? Cabno { get; set; }
    public string? Ac { get; set; }
    public DateTime? Sdate { get; set; }
    public DateTime? Enddate { get; set; }
    public string? Startfrom { get; set; }
    public int? Standeredkm { get; set; }
    public string? Standeredhour { get; set; }
    public int? Actualkm { get; set; }
    public string? Actualhour { get; set; }
    public int? Extrakm { get; set; }
    public string? Extrahour { get; set; }
    public string? Extrainfo { get; set; }
    public int? Extraamount { get; set; }
    public string? Mode { get; set; }
    public string? Dest { get; set; }
    public string? Orderedby { get; set; }
    public int? Ratesperday { get; set; }
    public int? Noofday { get; set; }
    public int? Total { get; set; }
    public DateTime? EntryDateTime { get; set; }
}