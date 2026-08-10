namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `security` table (SPEC-0004 data-model.md §3.1, M). Daily
/// open/close-day gate. No identity column in the legacy schema — surrogate
/// `Id` (bigint identity) key added (FR-003).
/// </summary>
public class SecurityDay
{
    /// <summary>Surrogate key (bigint identity) — no legacy identity column exists.</summary>
    public long Id { get; set; }

    public DateTime? Date1 { get; set; }
    public DateTime? Openingtime { get; set; }
    public string? Openby { get; set; }
    public DateTime? Closingtime { get; set; }
    public string? Closedby { get; set; }
}