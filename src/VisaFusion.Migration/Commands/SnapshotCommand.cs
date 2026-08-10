using Microsoft.Extensions.Logging;
using VisaFusion.Migration.Catalog;
using VisaFusion.Migration.Configuration;
using VisaFusion.Migration.Data;

namespace VisaFusion.Migration.Commands;

/// <summary>
/// `snapshot` — captures the static baseline (row counts + checksums of all 52
/// legacy tables) before any copy (SPEC-0004 T018, FR-009). The baseline is used
/// by `validate` for source-vs-target comparison (AC-002) and proves the legacy
/// database was untouched (AC-006).
/// </summary>
public sealed class SnapshotCommand : MigrationStep
{
    private readonly ILogger<SnapshotCommand> _logger;

    public SnapshotCommand(MigrationOptions options, ILogger<SnapshotCommand> logger) : base(options)
        => _logger = logger;

    public override string Name => "snapshot";

    public override async Task ExecuteAsync(StepContext context, CancellationToken ct = default)
    {
        using var legacy = new LegacyReader(Options.LegacyConnectionString);
        await legacy.OpenAsync(ct);

        var baseline = new Snapshot.SnapshotBaseline { RunId = context.RunState.RunId };

        foreach (var spec in TableCatalog.All)
        {
            if (!spec.HasRowCount) continue;

            var rowCount = await legacy.RowCountAsync(spec.LegacyTable, ct);
            string? checksum = null;
            if (spec.IsMigrated)
                checksum = await legacy.ChecksumAsync(spec.LegacyTable, ct);

            baseline.Tables.Add(new Snapshot.SnapshotRow(spec.LegacyTable, rowCount, checksum ?? "0"));
            _logger.LogInformation("snapshot: {Table,-16} rows={Rows,10} checksum={Sum,16}",
                spec.LegacyTable, rowCount, checksum);
        }

        if (baseline.Tables.Count == 0)
            throw new InvalidOperationException("Snapshot captured no tables.");

        context.Baseline = baseline;
        _logger.LogInformation("snapshot: baseline captured for {Count} tables.", baseline.Tables.Count);
    }
}
