namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `bighistory` table (data-model.md §1). Append-only audit
/// (spec §19). Scaffolding entity only.
/// </summary>
public class EntryAuditLog
{
    public long Id { get; set; }
}