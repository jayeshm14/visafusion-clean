namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `StatusHistory` table (SPEC-0004 data-model.md §3.1, M —
/// append-only audit chain, FR-006/BR-003). No identity column in the legacy
/// schema — surrogate `Id` (bigint identity) key added (FR-003). Migrated
/// without alteration, deletion, or reordering.
/// </summary>
public class StatusHistoryEntry
{
    /// <summary>Surrogate key (bigint identity) — no legacy identity column exists.</summary>
    public long Id { get; set; }

    /// <summary>Legacy `PaxID` — FK to <see cref="EntryPassenger.Id"/>.</summary>
    public int? PaxId { get; set; }

    public DateTime? Date { get; set; }

    /// <summary>Legacy `CountryID` — no target FK (open gap, data-model.md §4).</summary>
    public int? CountryId { get; set; }

    /// <summary>Legacy `StatusID` — FK to <see cref="Status.StatusId"/>.</summary>
    public int? StatusId { get; set; }

    public string? Remarks { get; set; }
    public string? UpdatedBy { get; set; }
}