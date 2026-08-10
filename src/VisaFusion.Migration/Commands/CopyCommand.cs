using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Logging;
using VisaFusion.Migration.Catalog;
using VisaFusion.Migration.Configuration;
using VisaFusion.Migration.Copy;

namespace VisaFusion.Migration.Commands;

/// <summary>
/// `copy` — batch-copies migrated tables in FK-dependency order, parents first
/// (SPEC-0004 T026, FR-001/FR-002; contracts/migration-cli.md §2 #4).
///
/// Before copying anything, a <see cref="DuplicateKeyGuard"/> scan verifies the
/// legacy source has no duplicate values on the target PK columns. A duplicate
/// that is NOT resolved by an approved copy-time transform (documented,
/// sign-off-gated cleansing rule) stops the step with a precise
/// <see cref="DataQualityGapException"/> — the deterministic "never guess" path
/// (library/01). Tables covered by an approved transform are copied through it
/// (e.g. status FR-005a deduplication keeps one row per statusID).
///
/// Append-only audit tables (FR-006, BR-003) are copied verbatim without
/// UPDATE/DELETE/reorder by the same read-only pipeline; they are never modified
/// after load (validation only reads them).
/// </summary>
public sealed class CopyCommand : MigrationStep
{
    private readonly ILogger<CopyCommand> _logger;

    public CopyCommand(MigrationOptions options, ILogger<CopyCommand> logger) : base(options)
        => _logger = logger;

    public override string Name => "copy";

    public override async Task ExecuteAsync(StepContext context, CancellationToken ct = default)
    {
        var engine = new BulkCopyEngine(Options.LegacyConnectionString, Options.TargetConnectionString,
            Options.BatchSize, _logger);

        // COND tables are archived (BR-004): schema created by `schema`, but data
        // is not copied until owner confirmation. The report records them as
        // cond-pending. M/MRO tables are copied in catalog (FK) order.
        var migrated = TableCatalog.Migrated;

        // Approved copy-time transforms, keyed by legacy table. A transform is
        // active ONLY when the documented cleansing rule is sign-off-gated
        // approved (BR-005) — otherwise the duplicate reaches the guard and the
        // copy fails with a gap report instead of guessing.
        var approvedTransforms = BuildApprovedTransforms();

        await GuardDuplicateKeysAsync(approvedTransforms, ct);

        long totalRows = 0;

        foreach (var spec in migrated)
        {
            if (spec.Disposition is TableDisposition.Cond or TableDisposition.Arch or TableDisposition.Drop)
                continue;

            _logger.LogInformation("copy: {Table} -> {Target}", spec.LegacyTable, spec.TargetTable);
            approvedTransforms.TryGetValue(spec.LegacyTable, out var transform);
            var result = await engine.CopyAsync(spec, transform, ct);
            totalRows += result.RowsCopied;
            _logger.LogInformation("copy: {Table} copied {Rows} rows (identity preserved: {Identity})",
                spec.LegacyTable, result.RowsCopied, result.IdentityPreserved);

            context.Report.Tables.Add(new Reporting.TableReport
            {
                LegacyTable = spec.LegacyTable,
                Disposition = spec.DispositionLabel,
                TargetEntity = spec.TargetEntity,
                SourceRowCount = context.Baseline.Get(spec.LegacyTable)?.RowCount ?? 0,
                TargetRowCount = result.RowsCopied,
                Checksum = null,
                ChecksumMatch = false,
                Status = "migrated"
            });
        }

        context.Report.Summary = new Reporting.SummaryReport
        {
            TablesMigrated = migrated.Count,
            RowsMigrated = totalRows,
            TablesArchived = TableCatalog.All.Count(t => t.Disposition == TableDisposition.Arch),
            TablesDropped = TableCatalog.DropTables.Count,
            Errors = 0
        };
        _logger.LogInformation("copy: {Count} tables copied, {Rows} rows total.", migrated.Count, totalRows);
    }

    /// <summary>
    /// Approved copy-time transforms (SPEC-0004 FR-005a → status). Only rules
    /// whose business sign-off is recorded (BR-005) are active here.
    /// </summary>
    private Dictionary<string, CopyTransform> BuildApprovedTransforms()
    {
        var transforms = new Dictionary<string, CopyTransform>(StringComparer.OrdinalIgnoreCase);

        if (Options.SignOffs.Status508.Approved)
        {
            // FR-005a: legacy status.statusID 508 has two rows ("Withdraw" at
            // physloc (1:255:19), "Approval Awaited" at (1:255:22)); the approved
            // rule keeps one row per statusID, surviving row = first description
            // (Withdraw). Same ROW_NUMBER expression as the post-copy
            // Status508Rule, so both stages agree on the survivor.
            transforms.Add("status", new CopyTransform.DeduplicateOn("status", "statusID", "FR-005a"));
        }

        if (Options.SignOffs.Agents4114.Approved)
        {
            // FR-005e (GAP-0002, Option A): legacy agents.agentsID 4114 has two
            // rows (populated profile at physloc (0x8645…0200), all-NULL ghost at
            // (0x9445…1300)); the approved rule keeps one row per agentsID,
            // surviving row = first-ranked in allocation order (the populated
            // profile — the table is a heap, verified live). Same ROW_NUMBER
            // expression as the post-copy Agents4114Rule, so both stages agree.
            transforms.Add("agents", new CopyTransform.DeduplicateOn("agents", "agentsID", "FR-005e"));
        }

        return transforms;
    }

    /// <summary>
    /// Scans the legacy source for duplicate values on the target PK columns
    /// (target PK is authoritative) before any row is copied. An undocumented
    /// duplicate — one with no approved transform — throws
    /// <see cref="DataQualityGapException"/> (exit 2) with a precise, actionable
    /// report. This is the documented GAP convention: never guess.
    /// </summary>
    private async Task GuardDuplicateKeysAsync(
        IReadOnlyDictionary<string, CopyTransform> approvedTransforms, CancellationToken ct)
    {
        await using var legacy = new SqlConnection(Options.LegacyConnectionString);
        await legacy.OpenAsync(ct);
        await using var target = new SqlConnection(Options.TargetConnectionString);
        await target.OpenAsync(ct);

        var violations = await DuplicateKeyGuard.ScanAsync(
            legacy, target, TableCatalog.All, spec => approvedTransforms.ContainsKey(spec.LegacyTable), ct);

        if (violations.Count == 0)
            return;

        var byTable = violations.GroupBy(v => v.LegacyTable).OrderBy(g => g.Key, StringComparer.Ordinal);
        var summary = string.Join(Environment.NewLine,
            byTable.Select(g => $"  {g.Key}: " + string.Join("; ", g.Select(v => v.ToString()))));

        _logger.LogError("copy: data-quality gap detected — legacy duplicates on target PK columns:{NewLine}{Summary}",
            Environment.NewLine, summary);

        throw new DataQualityGapException(
            gapId: "GAP-0002",
            legacyTable: violations[0].LegacyTable,
            message: $"Legacy source contains duplicate values on target primary-key columns. "
                + "No approved copy-time transform resolves them and the copy must not guess. "
                + $"Gap report required (see findings/gap-0002-agents-duplicate.md). Details:{Environment.NewLine}{summary}",
            keyColumn: violations[0].KeyColumn,
            keyValue: violations[0].KeyValue);
    }
}
