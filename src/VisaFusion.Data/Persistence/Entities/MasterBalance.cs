namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `masterbalance` table (SPEC-0004 data-model.md §3.1, M —
/// pending owner confirmation, migration plan §12 #11). No identity column in
/// the legacy schema — surrogate `Id` (bigint identity) key added (FR-003).
/// </summary>
public class MasterBalance
{
    /// <summary>Surrogate key (bigint identity) — no legacy identity column exists.</summary>
    public long Id { get; set; }

    /// <summary>Legacy `agentid` — FK to <see cref="Agent.Id"/>.</summary>
    public int? Agentid { get; set; }

    public decimal? Masterbalance { get; set; }
    public DateTime? Duedate { get; set; }
}