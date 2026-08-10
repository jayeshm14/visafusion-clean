namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `sentawb` table (SPEC-0004 data-model.md §3.1, M). PK is the
/// identity column `id` (numeric preserved, FR-003).
/// </summary>
public class AwbLog
{
    /// <summary>Legacy `id` (numeric identity) — primary key, values preserved.</summary>
    public long Id { get; set; }

    /// <summary>Legacy `agentsid` — FK to <see cref="Agent.Id"/>.</summary>
    public int Agentsid { get; set; }

    public DateTime? Date { get; set; }
    public string? Toemail { get; set; }
    public string? Remark { get; set; }
    public string? Awb { get; set; }
}