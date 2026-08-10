namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `scheduler` table (SPEC-0004 data-model.md §3.3, COND —
/// internal messaging, archived until owner approval, BR-004). PK is the
/// identity column `messageid` (values preserved).
/// </summary>
public class Scheduler
{
    /// <summary>Legacy `messageid` (identity) — primary key, values preserved.</summary>
    public int Id { get; set; }

    public DateTime Date { get; set; }
    public string? Messageto { get; set; }
    public string? Messagefrom { get; set; }
    public string? Subject { get; set; }
    public string? Description { get; set; }
    public string? Messageread { get; set; }
    public DateTime? Sentdate { get; set; }
}