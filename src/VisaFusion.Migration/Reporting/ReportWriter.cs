using System.Text.Json;
using VisaFusion.Migration.Reporting;

namespace VisaFusion.Migration.Reporting;

/// <summary>
/// Report writer (SPEC-0004 T045, FR-007, NFR-005). Serializes the migration
/// report to JSON conforming to contracts/migration-report.schema.json and
/// renders a human-readable Markdown summary. Outputs:
///   reports/migration-&lt;runId&gt;.json
///   reports/migration-&lt;runId&gt;.summary.md
/// </summary>
public sealed class ReportWriter
{
    private static readonly JsonSerializerOptions JsonOptions = new()
    {
        WriteIndented = true,
        // Nulls are serialized (not omitted): the report schema requires the
        // table item properties to be present even when null (e.g. targetEntity
        // for ARCH/DROP tables, contracts/migration-report.schema.json §tables).
        PropertyNamingPolicy = JsonNamingPolicy.CamelCase
    };

    private readonly string _reportsDirectory;

    public ReportWriter(string reportsDirectory) => _reportsDirectory = reportsDirectory;

    public async Task WriteAsync(MigrationReport report, CancellationToken ct = default)
    {
        Directory.CreateDirectory(_reportsDirectory);
        var jsonPath = Path.Combine(_reportsDirectory, $"migration-{report.RunId}.json");
        var summaryPath = Path.Combine(_reportsDirectory, $"migration-{report.RunId}.summary.md");

        await File.WriteAllTextAsync(jsonPath, JsonSerializer.Serialize(report, JsonOptions), ct);
        await File.WriteAllTextAsync(summaryPath, RenderSummary(report), ct);
    }

    public static string RenderSummary(MigrationReport report)
    {
        var sb = new System.Text.StringBuilder();
        sb.AppendLine($"# Migration Report {report.RunId}");
        sb.AppendLine();
        sb.AppendLine($"- Schema version: {report.SchemaVersionValue}");
        sb.AppendLine($"- Run: {report.StartedAt:O} → {report.CompletedAt:O}");
        sb.AppendLine($"- Operator: {report.Operator}");
        sb.AppendLine($"- Source: {report.SourceDatabase} → Target: {report.TargetDatabase}");
        sb.AppendLine();

        if (report.Summary is not null)
        {
            sb.AppendLine("## Summary");
            sb.AppendLine();
            sb.AppendLine($"| Tables migrated | Rows migrated | Tables archived | Tables dropped | Errors |");
            sb.AppendLine($"|---|---|---|---|---|");
            sb.AppendLine($"| {report.Summary.TablesMigrated} | {report.Summary.RowsMigrated} | " +
                          $"{report.Summary.TablesArchived} | {report.Summary.TablesDropped} | {report.Summary.Errors} |");
            sb.AppendLine();
        }

        if (report.Tables.Count > 0)
        {
            sb.AppendLine("## Tables");
            sb.AppendLine();
            sb.AppendLine("| Legacy table | Disposition | Source rows | Target rows | Checksum match | Status |");
            sb.AppendLine("|---|---|---|---|---|---|");
            foreach (var t in report.Tables.OrderBy(t => t.LegacyTable, StringComparer.Ordinal))
            {
                sb.AppendLine($"| {t.LegacyTable} | {t.Disposition} | {t.SourceRowCount} | {t.TargetRowCount} | " +
                              $"{(t.CleansingApplied.Count > 0 ? "n/a (cleansing)" : t.ChecksumMatch.ToString())} | {t.Status} |");
            }
            sb.AppendLine();
        }

        if (report.Cleansing.Count > 0)
        {
            sb.AppendLine("## Cleansing (approved, BR-005)");
            sb.AppendLine();
            sb.AppendLine("| Rule | Table | Action | Rows | Approver |");
            sb.AppendLine("|---|---|---|---|---|");
            foreach (var c in report.Cleansing)
            {
                sb.AppendLine($"| {c.Rule} | {c.Table} | {c.Action} | {c.RowsAffected} | {c.Signoff?.Approver} |");
            }
            sb.AppendLine();
        }

        if (report.Identity is not null)
        {
            sb.AppendLine("## Identity");
            sb.AppendLine();
            sb.AppendLine($"- Imported: agents={report.Identity.Imported.Agents}, " +
                          $"registration={report.Identity.Imported.Registration}, " +
                          $"udaanUsers={report.Identity.Imported.UdaanUsers}");
            sb.AppendLine($"- Plaintext passwords remaining: {report.Identity.PlaintextRemaining} (must be 0, AC-004)");
            sb.AppendLine($"- Skipped duplicates: {report.Identity.SkippedDuplicates.Count}");
            sb.AppendLine();
        }

        if (report.DeferredForeignKeys.Count > 0)
        {
            sb.AppendLine("## Deferred foreign keys (GAP-0001)");
            sb.AppendLine();
            sb.AppendLine("| Child | Column | Parent | Reason |");
            sb.AppendLine("|---|---|---|---|");
            foreach (var fk in report.DeferredForeignKeys)
                sb.AppendLine($"| {fk.ChildTable} | {fk.ChildColumn} | {fk.ParentTable} | {fk.Reason} |");
            sb.AppendLine();
        }

        if (report.Discrepancies.Count > 0)
        {
            sb.AppendLine("## Discrepancies (reported, not corrected)");
            sb.AppendLine();
            sb.AppendLine("| Table | Kind | Detail |");
            sb.AppendLine("|---|---|---|");
            foreach (var d in report.Discrepancies)
                sb.AppendLine($"| {d.Table} | {d.Kind} | {d.Detail} |");
            sb.AppendLine();
        }

        sb.AppendLine($"## Validation: {(report.Validation?.Passed == true ? "PASSED" : "NOT PASSED")}");
        return sb.ToString();
    }
}
