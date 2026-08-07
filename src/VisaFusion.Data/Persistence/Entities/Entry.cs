namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `Mainentry` table (data-model.md §1). Scaffolding entity only;
/// full column mapping is defined in the module feature specs.
/// </summary>
public class Entry
{
    public long Id { get; set; }
}