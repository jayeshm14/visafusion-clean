namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `cab` table (SPEC-0004 data-model.md §3.3, COND — archived
/// until owner approval, BR-004). PK is the natural key `Cabid`.
/// </summary>
public class Cab
{
    /// <summary>Legacy `cabid` (natural key) — primary key, values preserved.</summary>
    public int Cabid { get; set; }

    public string? Description { get; set; }
}