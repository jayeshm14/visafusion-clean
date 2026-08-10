namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `Category` table (SPEC-0004 data-model.md §3.1, M — lookup).
/// PK is the natural key `CategoryID` (referenced by <see cref="Entry.Category"/>,
/// <see cref="PaxCountryStatus.Category"/>, <see cref="VisaInfo.CategoryId"/>).
/// </summary>
public class Category
{
    /// <summary>Legacy `CategoryID` (natural key) — primary key, values preserved.</summary>
    public int CategoryId { get; set; }

    public string? Description { get; set; }
    public string? Active { get; set; }
}