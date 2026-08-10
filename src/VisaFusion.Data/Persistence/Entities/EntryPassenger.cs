namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `entryDetails` table (SPEC-0004 data-model.md §3.1, M).
/// Passenger/passport record belonging to an entry. PK is the identity column
/// `PaxID` (values preserved, FR-003).
/// </summary>
public class EntryPassenger
{
    /// <summary>Legacy `PaxID` (identity) — primary key, values preserved.</summary>
    public int Id { get; set; }

    /// <summary>Legacy `refno` — FK to <see cref="Entry.Refno"/>.</summary>
    public int? Refno { get; set; }

    public string? Paxname { get; set; }
    public string? Passportno { get; set; }
    public DateTime? DateOfBirth { get; set; }
    public int? Category { get; set; }
    public int? Totalpax { get; set; }
}