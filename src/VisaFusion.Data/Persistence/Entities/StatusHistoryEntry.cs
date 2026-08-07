namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `StatusHistory` table (data-model.md §1). Append-only history
/// (spec §19). Scaffolding entity only.
/// </summary>
public class StatusHistoryEntry
{
    public long Id { get; set; }
}