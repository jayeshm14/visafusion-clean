namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `sentmails` table (data-model.md §1). Append-only (spec §19).
/// Scaffolding entity only.
/// </summary>
public class EmailLog
{
    public long Id { get; set; }
}