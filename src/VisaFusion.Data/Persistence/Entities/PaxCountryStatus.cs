namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `PaxStatus` table (SPEC-0004 data-model.md §3.1, M).
/// Per-pax-per-country status row with fee columns. No identity column in the
/// legacy table — surrogate `Id` (bigint identity) key added (FR-003).
/// </summary>
public class PaxCountryStatus
{
    /// <summary>Surrogate key (bigint identity) — no legacy identity column exists.</summary>
    public long Id { get; set; }

    /// <summary>Legacy `refno` — FK to <see cref="Entry.Refno"/>.</summary>
    public int? Refno { get; set; }

    /// <summary>Legacy `PaxID` — FK to <see cref="EntryPassenger.Id"/>.</summary>
    public int? PaxId { get; set; }

    /// <summary>Legacy `CountryID` — no target FK (open gap, data-model.md §4).</summary>
    public int? CountryId { get; set; }

    public DateTime? Subdate { get; set; }
    public DateTime? Coldate { get; set; }
    public string? Colcheck { get; set; }
    public DateTime? SentDate { get; set; }
    public int? Category { get; set; }
    public int? Entrytype { get; set; }
    public int? StatusId { get; set; }
    public string? Remarks { get; set; }
    public decimal? Visafee { get; set; }
    public decimal? Handlingfee { get; set; }
    public decimal? Ddcharges { get; set; }
    public decimal? Couriercharges { get; set; }
    public decimal? Misccharges { get; set; }
    public decimal? Total { get; set; }
    public DateTime? Entrydatetime { get; set; }
    public decimal? VFSTTCharges { get; set; }
}