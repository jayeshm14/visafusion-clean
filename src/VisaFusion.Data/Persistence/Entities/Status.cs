namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `status` table (SPEC-0004 data-model.md §3.1, M — lookup).
/// PK is the natural key `statusID` (referenced by <see cref="Entry.Status"/>,
/// <see cref="PaxCountryStatus.StatusId"/>, <see cref="StatusHistoryEntry.StatusId"/>).
/// The duplicate `statusID=508` description is resolved by cleansing rule (a)
/// (FR-005a).
/// </summary>
public class Status
{
    /// <summary>Legacy `statusID` (natural key) — primary key, values preserved.</summary>
    public int StatusId { get; set; }

    public string? Description { get; set; }
    public string? Active { get; set; }
}