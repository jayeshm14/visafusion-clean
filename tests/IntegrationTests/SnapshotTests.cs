using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Logging.Abstractions;
using VisaFusion.Migration.Catalog;
using VisaFusion.Migration.Commands;
using VisaFusion.Migration.Configuration;
using VisaFusion.Migration.Reporting;
using VisaFusion.Migration.Snapshot;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// Snapshot integration tests (SPEC-0004 T016, FR-009).
///
/// Verifies the `snapshot` step captures the static baseline (row counts +
/// checksums) for every counted legacy table against the LIVE `VisaEntry`
/// database. The baseline is the source-vs-target comparison anchor for
/// `validate` (AC-002) and the proof the legacy was untouched (AC-006).
/// Tests skip when SQL Server is unreachable.
/// </summary>
public class SnapshotTests
{
    private const string DefaultLegacyConnectionString =
        "Server=localhost;Database=VisaEntry;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true";
    private const string DefaultTargetConnectionString =
        "Server=localhost;Database=VisaFusion;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true";

    private static string LegacyConnectionString =>
        Environment.GetEnvironmentVariable("VISAENTRY_TEST_CONNECTION") ?? DefaultLegacyConnectionString;

    private static string TargetConnectionString =>
        Environment.GetEnvironmentVariable("VISA_FUSION_TEST_CONNECTION") ?? DefaultTargetConnectionString;

    private static bool ServersReachable()
    {
        try
        {
            using var legacy = new SqlConnection(LegacyConnectionString);
            legacy.Open();
            using var target = new SqlConnection(TargetConnectionString);
            target.Open();
            return true;
        }
        catch
        {
            return false;
        }
    }

    private static MigrationOptions Options() => new()
    {
        LegacyConnectionString = LegacyConnectionString,
        TargetConnectionString = TargetConnectionString,
        Operator = "test-operator"
    };

    private static StepContext Context() => new()
    {
        RunState = new RunState(),
        Baseline = new SnapshotBaseline(),
        Report = new MigrationReport()
    };

    [Fact]
    public void Snapshot_Counts_40_Tables_With_Row_Counts()
    {
        // 52 legacy tables − 7 ARCH tables without row counts (invno, quote,
        // diary, emailid, emaild1, changes, changesbill) − 5 DROP tables
        // (dtproperties, country, Results, hits, adcount) = 40 counted tables.
        Assert.Equal(40, TableCatalog.All.Count(t => t.HasRowCount));
    }

    [Fact]
    public async Task Snapshot_Captures_Baseline_For_Every_Counted_Table()
    {
        if (!ServersReachable()) return;

        var command = new SnapshotCommand(Options(), NullLogger<SnapshotCommand>.Instance);
        var context = Context();
        await command.ExecuteAsync(context);

        var expected = TableCatalog.All.Count(t => t.HasRowCount);
        Assert.Equal(expected, context.Baseline.Tables.Count);
        Assert.Equal(context.RunState.RunId, context.Baseline.RunId);
    }

    [Fact]
    public async Task Snapshot_Records_Non_Negative_Row_Counts_For_All_Tables()
    {
        if (!ServersReachable()) return;

        var command = new SnapshotCommand(Options(), NullLogger<SnapshotCommand>.Instance);
        var context = Context();
        await command.ExecuteAsync(context);

        foreach (var row in context.Baseline.Tables)
            Assert.True(row.RowCount >= 0, $"negative row count for {row.LegacyTable}");
    }

    [Fact]
    public async Task Snapshot_Captures_Checksums_For_Every_Migrated_Table()
    {
        if (!ServersReachable()) return;

        var command = new SnapshotCommand(Options(), NullLogger<SnapshotCommand>.Instance);
        var context = Context();
        await command.ExecuteAsync(context);

        foreach (var spec in TableCatalog.Migrated)
        {
            var row = context.Baseline.Get(spec.LegacyTable);
            Assert.NotNull(row);
            // Checksum is the exact decimal string from ChecksumSql (may exceed
            // Int64 for large tables); it must be a valid number, not empty.
            Assert.False(string.IsNullOrWhiteSpace(row.Checksum), $"no checksum for {spec.LegacyTable}");
            Assert.True(long.TryParse(row.Checksum, out _) || decimal.TryParse(row.Checksum, out _),
                $"checksum for {spec.LegacyTable} is not numeric: '{row.Checksum}'");
        }
    }
}