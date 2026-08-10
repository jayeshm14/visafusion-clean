namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `subscriber` table (SPEC-0004 data-model.md §3.3, COND —
/// newsletter list until owner approval, BR-004). PK is the identity column
/// `id` (numeric, values preserved).
/// </summary>
public class Subscriber
{
    /// <summary>Legacy `id` (numeric identity) — primary key, values preserved.</summary>
    public long Id { get; set; }

    public string? Name { get; set; }
    public string? Email { get; set; }
}