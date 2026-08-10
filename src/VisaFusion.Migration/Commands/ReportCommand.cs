using Microsoft.Extensions.Logging;
using VisaFusion.Migration.Catalog;
using VisaFusion.Migration.Configuration;
using VisaFusion.Migration.Reporting;

namespace VisaFusion.Migration.Commands;

/// <summary>
/// `report` — writes the migration report (JSON + human summary)
/// (SPEC-0004 T046, FR-007, NFR-005; contracts/migration-cli.md §2 #8).
/// Also records the GAP-0001 deferred-FK disposition so the report is the
/// audit of the referential-integrity reconstruction decision.
/// </summary>
public sealed class ReportCommand : MigrationStep
{
    private readonly ILogger<ReportCommand> _logger;

    public ReportCommand(MigrationOptions options, ILogger<ReportCommand> logger) : base(options)
        => _logger = logger;

    public override string Name => "report";

    public override async Task ExecuteAsync(StepContext context, CancellationToken ct = default)
    {
        var report = context.Report;
        report.CompletedAt = DateTime.UtcNow;
        report.Summary ??= new SummaryReport();

        // GAP-0001 deferred FKs (data-model.md §4, verified 2026-08-09) — recorded
        // in every report so the reconstruction decision is auditable.
        AddDeferredForeignKey(report, "Mainentry", "category", "Category",
            "GAP-0001: 271,692 sentinel-0 rows with no Category lookup row");
        AddDeferredForeignKey(report, "Mainentry", "attestation", "Attestation",
            "GAP-0001: 30,176 sentinel-0 rows with no Attestation lookup row");
        AddDeferredForeignKey(report, "Mainentry", "poe", "Poe",
            "GAP-0001: 3 sentinel-0 rows with no Poe lookup row");
        AddDeferredForeignKey(report, "Mainentry", "status", "status",
            "GAP-0001: 3 sentinel-0 rows with no status lookup row");
        AddDeferredForeignKey(report, "PaxStatus", "PaxID", "entryDetails",
            "GAP-0001: 1 orphaned PaxID");
        AddDeferredForeignKey(report, "PaxStatus", "category", "Category",
            "GAP-0001: 2,755 sentinel-0 rows with no Category lookup row");
        AddDeferredForeignKey(report, "PaxStatus", "entrytype", "EntryType",
            "GAP-0001: 67 sentinel-0 rows with no EntryType lookup row");
        AddDeferredForeignKey(report, "StatusHistory", "PaxID", "entryDetails",
            "GAP-0001: 2,465 orphaned PaxID (append-only audit)");
        AddDeferredForeignKey(report, "sentmails", "agentsid", "agents",
            "GAP-0001: 9,661 orphaned agentsid");
        AddDeferredForeignKey(report, "sentawb", "agentsid", "agents",
            "GAP-0001: 404 orphaned agentsid");
        AddDeferredForeignKey(report, "smshistory", "agentID", "agents",
            "GAP-0001: 2,259 orphaned agentID");
        AddDeferredForeignKey(report, "masterbalance", "agentid", "agents",
            "GAP-0001: 117 orphaned agentid");
        AddDeferredForeignKey(report, "Ledger", "agentID", "agents",
            "GAP-0001: 525 orphaned agentID");
        AddDeferredForeignKey(report, "Ledger", "bank", "bank",
            "GAP-0001: 2 orphaned bank values");

        // AC-001: every legacy table is accounted for in the report. CopyCommand
        // adds the migrated (M/MRO) entries; the remaining dispositions
        // (COND/ARCH/DROP) are added here so the report covers all 52 tables
        // with their disposition and status (contracts/migration-report.schema.json
        // §tables: "One entry per legacy table (all 52 accounted for, AC-001)").
        foreach (var spec in TableCatalog.All)
        {
            if (report.Tables.Any(t =>
                    string.Equals(t.LegacyTable, spec.LegacyTable, StringComparison.OrdinalIgnoreCase)))
                continue;

            report.Tables.Add(new TableReport
            {
                LegacyTable = spec.LegacyTable,
                Disposition = spec.DispositionLabel,
                TargetEntity = spec.TargetEntity,
                SourceRowCount = context.Baseline.Get(spec.LegacyTable)?.RowCount ?? 0,
                TargetRowCount = 0,
                Checksum = null,
                ChecksumMatch = false,
                Status = spec.Disposition switch
                {
                    TableDisposition.Cond => "cond-pending",
                    TableDisposition.Arch => "archived",
                    TableDisposition.Drop => "dropped",
                    _ => "error"
                }
            });
        }

        var writer = new ReportWriter(Options.ReportsDirectory);
        await writer.WriteAsync(report, ct);
        _logger.LogInformation("report: written to {Dir}/migration-{RunId}.json (+ .summary.md)",
            Options.ReportsDirectory, report.RunId);
    }

    private static void AddDeferredForeignKey(MigrationReport report, string child, string column,
        string parent, string reason)
    {
        if (report.DeferredForeignKeys.Any(f =>
                f.ChildTable == child && f.ChildColumn == column))
            return;
        report.DeferredForeignKeys.Add(new DeferredForeignKey
        {
            ChildTable = child,
            ChildColumn = column,
            ParentTable = parent,
            Reason = reason
        });
    }
}
