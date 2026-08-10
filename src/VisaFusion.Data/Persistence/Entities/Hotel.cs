namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `hotel` table (SPEC-0004 data-model.md §3.3, COND — archived
/// until owner confirmation, BR-004). PK is the natural key `hotelid`.
/// </summary>
public class Hotel
{
    /// <summary>Legacy `hotelid` (natural key) — primary key, values preserved.</summary>
    public int Hotelid { get; set; }

    public string? Description { get; set; }
}