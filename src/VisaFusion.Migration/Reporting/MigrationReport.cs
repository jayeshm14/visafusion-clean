namespace VisaFusion.Migration.Reporting;

/// <summary>
/// Migration report model — mirrors contracts/migration-report.schema.json
/// (SPEC-0004 FR-007). The `report` step serializes this to JSON and renders a
/// human summary (NFR-005). The schema is validated by ReportSchemaTests.
/// </summary>
public sealed class MigrationReport
{
    public const string SchemaVersion = "1.0";

    /// <summary>Serialized as "schemaVersion" per the report schema contract.</summary>
    [System.Text.Json.Serialization.JsonPropertyName("schemaVersion")]
    public string SchemaVersionValue { get; set; } = SchemaVersion;
    public string RunId { get; set; } = string.Empty;
    public DateTime StartedAt { get; set; }
    public DateTime CompletedAt { get; set; }
    public string Operator { get; set; } = string.Empty;
    public string SourceDatabase { get; set; } = "VisaEntry";
    public string TargetDatabase { get; set; } = "VisaFusion";
    public OfflineWindow? OfflineWindow { get; set; }
    public List<TableReport> Tables { get; set; } = new();
    public IdentityReport? Identity { get; set; }
    public List<CleansingAction> Cleansing { get; set; } = new();
    public ValidationReport? Validation { get; set; }
    public List<Discrepancy> Discrepancies { get; set; } = new();
    public List<DeferredForeignKey> DeferredForeignKeys { get; set; } = new();
    public SummaryReport? Summary { get; set; }
}

public sealed class OfflineWindow
{
    public bool LegacyAppStopped { get; set; } = true;
    public DateTime WindowStart { get; set; }
    public DateTime WindowEnd { get; set; }
}

public sealed class TableReport
{
    public string LegacyTable { get; set; } = string.Empty;
    public string Disposition { get; set; } = string.Empty;   // M | M-RO | COND | ARCH | DROP
    public string? TargetEntity { get; set; }
    public long SourceRowCount { get; set; }
    public long TargetRowCount { get; set; }
    public string? Checksum { get; set; }
    public bool ChecksumMatch { get; set; }
    public List<string> CleansingApplied { get; set; } = new();
    public string Status { get; set; } = "migrated";          // migrated | archived | dropped | cond-pending | error
    public string? Error { get; set; }
}

public sealed class IdentityReport
{
    public IdentityCounts Imported { get; set; } = new();
    public List<IdentitySkipped> SkippedDuplicates { get; set; } = new();
    public int PlaintextRemaining { get; set; }

    public sealed class IdentityCounts
    {
        public int Agents { get; set; }
        public int Registration { get; set; }
        public int UdaanUsers { get; set; }
    }

    public sealed class IdentitySkipped
    {
        public string Source { get; set; } = string.Empty;   // agents | registration | Udaan_users
        public string? Username { get; set; }
        public string? Email { get; set; }
    }
}

public sealed class CleansingAction
{
    public string Rule { get; set; } = string.Empty;   // a | b | c | d
    public string Table { get; set; } = string.Empty;
    public string Action { get; set; } = string.Empty;
    public int RowsAffected { get; set; }
    public SignOffRecord? Signoff { get; set; }

    public sealed class SignOffRecord
    {
        public string By { get; set; } = string.Empty;
        public string Approver { get; set; } = string.Empty;
        public string Date { get; set; } = string.Empty;
    }
}

public sealed class ValidationReport
{
    public bool Passed { get; set; }
    public DateTime ValidatedAtUtc { get; set; }
    public int TablesCompared { get; set; }
    public int TablesWithCountMismatch { get; set; }
    public int TablesWithChecksumMismatch { get; set; }
    public int IntegrityViolations { get; set; }
}

public sealed class Discrepancy
{
    public string Table { get; set; } = string.Empty;
    public string Kind { get; set; } = string.Empty;   // row-count | checksum | referential-integrity | other
    public string Detail { get; set; } = string.Empty;
}

public sealed class DeferredForeignKey
{
    public string ChildTable { get; set; } = string.Empty;
    public string ChildColumn { get; set; } = string.Empty;
    public string ParentTable { get; set; } = string.Empty;
    public string Reason { get; set; } = string.Empty;   // e.g. "GAP-0001: 2,465 orphaned values"
}

public sealed class SummaryReport
{
    public int TablesMigrated { get; set; }
    public long RowsMigrated { get; set; }
    public int TablesArchived { get; set; }
    public int TablesDropped { get; set; }
    public int Errors { get; set; }
}
