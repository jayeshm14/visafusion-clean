namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `holidaylist` table (SPEC-0004 data-model.md §3.1, M —
/// actively enforced embassy-holiday business rule). No identity column in the
/// legacy schema — surrogate `Id` (bigint identity) key added (FR-003).
/// </summary>
public class Holiday
{
    /// <summary>Surrogate key (bigint identity) — no legacy identity column exists.</summary>
    public long Id { get; set; }

    /// <summary>Legacy `countryID` — no target FK (open gap, data-model.md §4).</summary>
    public int? CountryId { get; set; }

    public DateTime? HolidayDate { get; set; }
    public string? Description { get; set; }
}