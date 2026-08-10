using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Logging.Abstractions;
using VisaFusion.Migration.Catalog;
using VisaFusion.Migration.Snapshot;
using VisaFusion.Migration.Validation;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// Validation engine integration tests (SPEC-0004 T041, TS-001/TS-002/TS-003,
/// FR-009).
///
/// Verifies the validation contract against the LIVE databases: a baseline that
/// matches the target state validates clean (row counts + checksums), a
/// differing baseline produces reported discrepancies (never silently
/// corrected), and tables with approved cleansing are excluded from checksum
/// comparison. Tests skip when SQL Server is unreachable.
/// </summary>
public class ValidationTests
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

    private static ValidationEngine Engine() =>
        new(LegacyConnectionString, TargetConnectionString, NullLogger.Instance);

    /// <summary>
    /// Builds a baseline from the target's ACTUAL state so row counts and
    /// checksums match by construction: source = target − RowDelta (so the
    /// engine's expected target = source + RowDelta equals the real target) and
    /// checksum = the target's own checksum. A faithful copy validates clean.
    /// </summary>
    private static async Task<SnapshotBaseline> BuildBaselineFromTargetAsync()
    {
        await using var target = new SqlConnection(TargetConnectionString);
        await target.OpenAsync();

        var baseline = new SnapshotBaseline();
        foreach (var spec in TableCatalog.Migrated)
        {
            if (spec.TargetTable is null) continue;
            var targetCount = await CountAsync(target, spec.TargetTable);
            var checksum = await ChecksumSql.ExecuteStringAsync(target, spec.TargetTable);
            baseline.Tables.Add(new SnapshotRow(spec.LegacyTable, targetCount - spec.RowDelta, checksum));
        }
        return baseline;
    }

    private static SnapshotBaseline WithCorruptedStatusChecksum(SnapshotBaseline baseline)
    {
        var status = baseline.Get("status")
            ?? throw new InvalidOperationException("baseline has no status row");
        baseline.Tables.Remove(status);
        baseline.Tables.Add(status with { Checksum = "999999999999" });
        return baseline;
    }

    [Fact]
    public async Task Validation_Passes_When_Baseline_Matches_Target_State()
    {
        if (!ServersReachable()) return;

        var baseline = await BuildBaselineFromTargetAsync();
        var outcome = await Engine().ValidateAsync(baseline, Array.Empty<string>(), Array.Empty<string>());

        Assert.True(outcome.Passed,
            "expected a clean validation; discrepancies: " +
            string.Join("; ", outcome.Discrepancies.Select(d => $"{d.Table}:{d.Kind}:{d.Detail}")));
        Assert.Empty(outcome.Discrepancies);
    }

    [Fact]
    public async Task Validation_Reports_Row_Count_Discrepancy_When_Baseline_Differs()
    {
        if (!ServersReachable()) return;

        var baseline = await BuildBaselineFromTargetAsync();
        // Corrupt one table's source count so the expected target count differs.
        var first = baseline.Tables[0];
        baseline.Tables[0] = first with { RowCount = first.RowCount + 100 };

        var outcome = await Engine().ValidateAsync(baseline, Array.Empty<string>(), Array.Empty<string>());

        Assert.False(outcome.Passed);
        Assert.Contains(outcome.Discrepancies, d => d.Kind == "row-count");
    }

    [Fact]
    public async Task Validation_Reports_Checksum_Discrepancy_Without_Cleansing_Exemption()
    {
        if (!ServersReachable()) return;

        var baseline = WithCorruptedStatusChecksum(await BuildBaselineFromTargetAsync());
        var outcome = await Engine().ValidateAsync(baseline, Array.Empty<string>(), Array.Empty<string>());

        Assert.Contains(outcome.Discrepancies, d => d.Table == "status" && d.Kind == "checksum");
    }

    [Fact]
    public async Task Validation_Skips_Checksum_For_Cleansing_Tables()
    {
        if (!ServersReachable()) return;

        // Same corrupted status checksum, but status is a cleansing table
        // (FR-005a): its checksum is intentionally excluded from comparison.
        var baseline = WithCorruptedStatusChecksum(await BuildBaselineFromTargetAsync());
        var outcome = await Engine().ValidateAsync(baseline, new[] { "status" }, new[] { "a" });

        Assert.DoesNotContain(outcome.Discrepancies, d => d.Table == "status" && d.Kind == "checksum");
    }

    private static async Task<long> CountAsync(SqlConnection connection, string table)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = $"SELECT COUNT_BIG(*) FROM [{table.Replace("]", "]]", StringComparison.Ordinal)}]";
        return Convert.ToInt64(await cmd.ExecuteScalarAsync() ?? 0L);
    }
}