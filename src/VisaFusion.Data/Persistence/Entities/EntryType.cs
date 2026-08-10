namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `EntryType` table (SPEC-0004 data-model.md §3.1, M — lookup).
/// PK is the natural key `EntryTypeID` (referenced by <see cref="Entry.Entrytype"/>,
/// <see cref="PaxCountryStatus.Entrytype"/>).
/// </summary>
public class EntryType
{
    /// <summary>Legacy `EntryTypeID` (natural key) — primary key, values preserved.</summary>
    public int EntryTypeId { get; set; }

    public string? Description { get; set; }
    public string? Active { get; set; }
}