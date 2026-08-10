namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `Poe` table (SPEC-0004 data-model.md §3.1, M — lookup).
/// PK is the natural key `PoeID` (referenced by <see cref="Entry.Poe"/>).
/// </summary>
public class Poe
{
    /// <summary>Legacy `PoeID` (natural key) — primary key, values preserved.</summary>
    public int PoeId { get; set; }

    public string? Description { get; set; }
    public string? Active { get; set; }
}