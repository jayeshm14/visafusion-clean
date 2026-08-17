using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Logging;
using VisaFusion.Migration.Catalog;
using VisaFusion.Migration.Configuration;
using VisaFusion.Migration.Data;
using VisaFusion.Migration.Reporting;

namespace VisaFusion.Migration.Validation;

/// <summary>Outcome of the validation step.</summary>
public sealed class ValidationOutcome
{
    public bool Passed { get; set; }
    public List<Discrepancy> Discrepancies { get; } = new();
    public ValidationReport Report { get; set; } = new();
    public bool HasIntegrityViolation { get; set; }
}

/// <summary>
/// Validation engine (SPEC-0004 T043, FR-009; contracts/migration-cli.md §6).
/// Compares source vs target row counts and checksums for migrated tables,
/// excluding tables with approved cleansing applied (documented per table), and
/// performs referential-integrity checks on the target. Fail-fast integrity
/// violations abort the run (exit 4); other discrepancies are reported, not
/// corrected (exit 3, spec §18).
/// </summary>
public sealed class ValidationEngine
{
    private readonly string _legacyConnectionString;
    private readonly string _targetConnectionString;
    private readonly ILogger _logger;

    public ValidationEngine(string legacyConnectionString, string targetConnectionString, ILogger logger)
    {
        _legacyConnectionString = legacyConnectionString;
        _targetConnectionString = targetConnectionString;
        _logger = logger;
    }

    public async Task<ValidationOutcome> ValidateAsync(
        Snapshot.SnapshotBaseline baseline,
        IReadOnlyCollection<string> cleansingAppliedTables,
        IReadOnlyCollection<string> cleansingAppliedRules,
        CancellationToken ct = default)
    {
        var outcome = new ValidationOutcome { Report = new ValidationReport { ValidatedAtUtc = DateTime.UtcNow } };

        using var legacy = new LegacyReader(_legacyConnectionString);
        await legacy.OpenAsync(ct);
        await using var target = new SqlConnection(_targetConnectionString);
        await target.OpenAsync(ct);

        foreach (var spec in TableCatalog.Migrated)
        {
            if (spec.TargetTable is null) continue;

            // Source counts: prefer the snapshot baseline; fall back to live.
            var sourceRowCount = baseline.Get(spec.LegacyTable)?.RowCount
                ?? await legacy.RowCountAsync(spec.LegacyTable, ct);
            var sourceChecksum = baseline.Get(spec.LegacyTable)?.Checksum ?? "0";

            var targetRowCount = await TargetRowCountAsync(target, spec.TargetTable, ct);
            outcome.Report.TablesCompared++;

            // RowDelta accounts for documented row-collapsing cleansing rules
            // applied at copy time (e.g. status FR-005a merges the duplicate
            // statusID=508 row, 27 → 26). The expected target count is
            // source + RowDelta (RowDelta = 0 for all non-collapsing tables).
            var expectedTargetRowCount = sourceRowCount + spec.RowDelta;
            if (expectedTargetRowCount != targetRowCount)
            {
                outcome.Report.TablesWithCountMismatch++;
                outcome.Discrepancies.Add(new Discrepancy
                {
                    Table = spec.LegacyTable,
                    Kind = "row-count",
                    Detail = $"source={sourceRowCount}, expected={expectedTargetRowCount} (delta {spec.RowDelta}), target={targetRowCount}"
                });
            }

            // Checksum comparison is skipped for tables with approved cleansing
            // (their values intentionally differ, FR-005). Documented in report.
            var cleansingApplied = cleansingAppliedTables.Contains(spec.LegacyTable, StringComparer.OrdinalIgnoreCase);
            if (!cleansingApplied)
            {
                var targetChecksum = await TargetChecksumAsync(target, spec.TargetTable, ct);
                if (sourceChecksum != targetChecksum)
                {
                    outcome.Report.TablesWithChecksumMismatch++;
                    outcome.Discrepancies.Add(new Discrepancy
                    {
                        Table = spec.LegacyTable,
                        Kind = "checksum",
                        Detail = $"source={sourceChecksum}, target={targetChecksum} (cleansing: {string.Join(",", cleansingAppliedRules)})"
                    });
                }
            }

            _logger.LogInformation("validate: {Table} rows {Src}->{Dst}, checksum {Match}",
                spec.LegacyTable, sourceRowCount, targetRowCount,
                cleansingApplied ? "skipped (cleansing)" : sourceChecksum == "0" ? "n/a" : "compared");
        }

        // Referential-integrity checks on the target (AC-003). Only the KEPT FKs
        // (data-model.md §4, GAP-0001) are checked; DEFER-ed relationships are
        // recorded in the report, not enforced.
        outcome.HasIntegrityViolation = await CheckReferentialIntegrityAsync(target, outcome, ct);

        outcome.Passed = outcome.Discrepancies.Count == 0 && !outcome.HasIntegrityViolation;
        outcome.Report.Passed = outcome.Passed;
        outcome.Report.IntegrityViolations = outcome.HasIntegrityViolation ? 1 : 0;
        return outcome;
    }

    private static async Task<long> TargetRowCountAsync(SqlConnection target, string table, CancellationToken ct)
    {
        await using var cmd = target.CreateCommand();
        cmd.CommandText = $"SELECT COUNT_BIG(*) FROM [{table.Replace("]", "]]", StringComparison.Ordinal)}]";
        // Full-table scans over large migrated tables can exceed the 30s
        // default command timeout; 300s matches LegacyReader.ScalarAsync.
        cmd.CommandTimeout = 300;
        var result = await cmd.ExecuteScalarAsync(ct);
        return Convert.ToInt64(result ?? 0L);
    }

    private static async Task<string> TargetChecksumAsync(SqlConnection target, string table, CancellationToken ct)
    {
        var sql = await ChecksumSql.BuildAsync(target, table, ct);
        await using var cmd = target.CreateCommand();
        cmd.CommandText = sql;
        // Full-table SHA2_256 scan (see ChecksumSql.ExecuteStringAsync).
        cmd.CommandTimeout = 300;
        var result = await cmd.ExecuteScalarAsync(ct);
        return Convert.ToString(result, System.Globalization.CultureInfo.InvariantCulture) ?? "0";
    }

    /// <summary>
    /// Referential-integrity checks for the KEPT FKs (GAP-0001 disposition).
    /// Each check reports orphaned child rows; any found is an integrity
    /// violation (fail-fast, exit 4).
    /// </summary>
    private async Task<bool> CheckReferentialIntegrityAsync(SqlConnection target,
        ValidationOutcome outcome, CancellationToken ct)
    {
        var checks = new (string ChildTable, string ChildColumn, string ParentTable, string ParentColumn)[]
        {
            ("entryDetails", "refno", "Mainentry", "refno"),
            ("PaxStatus", "refno", "Mainentry", "refno"),
            ("PaxStatus", "statusID", "status", "statusID"),
            ("StatusHistory", "StatusID", "status", "statusID"),
            ("PaxAttestation", "PaxID", "entryDetails", "PaxID"),
            ("PaxAttestation", "AttestationID", "Attestation", "AttestationID"),
            ("PaxAttestation", "CertificateID", "certificate", "certificateID"),
            ("invoicedetail", "invoiceno", "invoice", "invoiceno"),
            ("VisaInfo", "categoryID", "Category", "CategoryID"),
            ("weeklyoff", "embassyid", "embassy", "EmbassyID")
        };

        var violated = false;
        foreach (var (child, childCol, parent, parentCol) in checks)
        {
            var sql = $@"
                SELECT COUNT_BIG(*)
                  FROM [{child}] c
                  LEFT JOIN [{parent}] p
                    ON p.[{parentCol}] = c.[{childCol}]
                 WHERE c.[{childCol}] IS NOT NULL AND p.[{parentCol}] IS NULL";
            await using var cmd = target.CreateCommand();
            cmd.CommandText = sql;
            // LEFT JOIN orphan scans run over large tables (entryDetails,
            // Mainentry); 300s matches the other validation commands.
            cmd.CommandTimeout = 300;
            var orphans = Convert.ToInt64(await cmd.ExecuteScalarAsync(ct) ?? 0L);
            if (orphans > 0)
            {
                violated = true;
                outcome.Discrepancies.Add(new Discrepancy
                {
                    Table = child,
                    Kind = "referential-integrity",
                    Detail = $"{orphans} orphaned [{childCol}] values (FK {child}.{childCol} -> {parent}.{parentCol})"
                });
                _logger.LogError("validate: INTEGRITY VIOLATION {Child}.{Col}: {Count} orphans.",
                    child, childCol, orphans);
            }
        }
        return violated;
    }
}
