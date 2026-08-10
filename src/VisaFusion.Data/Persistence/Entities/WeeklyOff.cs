namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `weeklyoff` table (SPEC-0004 data-model.md §3.1, M — weekly
/// off-day business rule). No identity column in the legacy schema — surrogate
/// `Id` (bigint identity) key added (FR-003).
/// </summary>
public class WeeklyOff
{
    /// <summary>Surrogate key (bigint identity) — no legacy identity column exists.</summary>
    public long Id { get; set; }

    /// <summary>Legacy `embassyid` — FK to <see cref="Embassy.Id"/>.</summary>
    public int? Embassyid { get; set; }

    public int? Weekend { get; set; }
    public string? Description { get; set; }
}