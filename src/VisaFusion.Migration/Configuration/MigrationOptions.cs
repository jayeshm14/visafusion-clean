namespace VisaFusion.Migration.Configuration;

/// <summary>
/// Configuration model for the migration run (SPEC-0004 T008).
/// Bound from <c>appsettings.json</c> / environment / User Secrets — no secrets
/// in source (NFR-004). Connection strings are placeholders resolved from
/// environment variables <c>Legacy__VisaEntry</c> and <c>Target__VisaFusion</c>
/// (see appsettings.json).
/// </summary>
public sealed class MigrationOptions
{
    /// <summary>Legacy database connection string (read-only access).</summary>
    public string LegacyConnectionString { get; set; } = string.Empty;

    /// <summary>Target database connection string (write access).</summary>
    public string TargetConnectionString { get; set; } = string.Empty;

    /// <summary>Rows per SqlBulkCopy batch (NFR-002 performance tuning).</summary>
    public int BatchSize { get; set; } = 10_000;

    /// <summary>Maximum maintenance window in hours (NFR-002; abort if exceeded).</summary>
    public int MaintenanceWindowHours { get; set; } = 4;

    /// <summary>Directory for the migration report outputs (FR-007).</summary>
    public string ReportsDirectory { get; set; } = "reports";

    /// <summary>Directory for Serilog file logs (NFR-006).</summary>
    public string LogsDirectory { get; set; } = "logs";

    /// <summary>Operator who runs the migration (spec §19).</summary>
    public string Operator { get; set; } = Environment.UserName;

    /// <summary>Directory of the pre-migration legacy backup (FR-008, AC-008).</summary>
    public string BackupDirectory { get; set; } = "backups";

    /// <summary>Sign-off records for the four approved cleansing rules (BR-005).</summary>
    public CleansingSignOffs SignOffs { get; set; } = new();
}

/// <summary>
/// Business sign-off records gating each approved cleansing rule (FR-005, BR-005).
/// A rule with an empty <see cref="SignOff.Approver"/> is not approved and the
/// cleanse step must not apply it.
/// </summary>
public sealed class CleansingSignOffs
{
    public SignOff Status508 { get; set; } = new();
    public SignOff EntryTypeDefault { get; set; } = new();
    public SignOff OrphanAgent { get; set; } = new();
    public SignOff JunkDateClamp { get; set; } = new();
    public SignOff Agents4114 { get; set; } = new();

    /// <summary>All approved cleansing rules (a–e) are signed off (approver + date).</summary>
    public bool AllApproved => Status508.Approved && EntryTypeDefault.Approved
        && OrphanAgent.Approved && JunkDateClamp.Approved && Agents4114.Approved;
}

/// <summary>A single sign-off record (spec §19 audit).</summary>
public sealed class SignOff
{
    public string By { get; set; } = string.Empty;
    public string Approver { get; set; } = string.Empty;
    public string Date { get; set; } = string.Empty;

    public bool Approved => !string.IsNullOrWhiteSpace(Approver) && !string.IsNullOrWhiteSpace(Date);
}
