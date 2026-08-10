namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `VisaInfo` table (SPEC-0004 data-model.md §3.1, M — content).
/// No identity column in the legacy schema — surrogate `Id` (bigint identity)
/// key added (FR-003).
/// </summary>
public class VisaInfo
{
    /// <summary>Surrogate key (bigint identity) — no legacy identity column exists.</summary>
    public long Id { get; set; }

    /// <summary>Legacy `countryID` — no target FK (open gap, data-model.md §4).</summary>
    public int? CountryId { get; set; }

    /// <summary>Legacy `categoryID` — FK to <see cref="Category.CategoryId"/>.</summary>
    public int? CategoryId { get; set; }

    public string? Information { get; set; }
    public int? CountryFor { get; set; }
}