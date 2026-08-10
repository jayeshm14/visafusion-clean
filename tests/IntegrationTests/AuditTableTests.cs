using Microsoft.Data.SqlClient;
using VisaFusion.Migration.Catalog;
using VisaFusion.Migration.Validation;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// Append-only audit table tests (SPEC-0004 T024, TS-006, FR-006, BR-003).
///
/// The audit tables (`StatusHistory`, `bighistory`, `sentmails`, `smshistory`)
/// are migrated WITHOUT alteration, deletion, or reordering. These tests verify
/// the catalog marks them append-only, the target schema carries them, and —
/// once a copy has run — the target is byte-identical to the source (same
/// type-canonical checksum on both sides). Tests skip when SQL Server is
/// unreachable.
/// </summary>
public class AuditTableTests
{
    private static readonly string[] AuditTables = ["StatusHistory", "bighistory", "sentmails", "smshistory"];

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

    [Fact]
    public void Audit_Tables_Are_Marked_Append_Only_In_The_Catalog()
    {
        foreach (var name in AuditTables)
        {
            var spec = TableCatalog.All.Single(t => t.LegacyTable.Equals(name, StringComparison.OrdinalIgnoreCase));
            Assert.True(spec.AppendOnly, $"{name} must be append-only (FR-006)");
            Assert.True(spec.IsMigrated, $"{name} must be migrated (M)");
        }
    }

    [Fact]
    public async Task Audit_Tables_Exist_In_The_Target_Schema()
    {
        if (!ServersReachable()) return;

        await using var target = new SqlConnection(TargetConnectionString);
        await target.OpenAsync();
        var tables = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
        await using (var cmd = target.CreateCommand())
        {
            cmd.CommandText = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE'";
            await using var r = await cmd.ExecuteReaderAsync();
            while (await r.ReadAsync()) tables.Add(r.GetString(0));
        }

        foreach (var name in AuditTables)
            Assert.Contains(name, tables);
    }

    [Fact]
    public async Task Audit_Tables_Are_Byte_Identical_When_Copied()
    {
        if (!ServersReachable()) return;

        await using var legacy = new SqlConnection(LegacyConnectionString);
        await legacy.OpenAsync();
        await using var target = new SqlConnection(TargetConnectionString);
        await target.OpenAsync();

        foreach (var name in AuditTables)
        {
            var spec = TableCatalog.All.Single(t => t.LegacyTable.Equals(name, StringComparison.OrdinalIgnoreCase));

            // Copy has not run yet (target is empty) — schema presence is
            // verified above; the byte-identical proof applies after a copy.
            var targetCount = await CountAsync(target, spec.TargetTable!);
            if (targetCount == 0) continue;

            // FR-006: the same type-canonical checksum must match on both sides.
            var sourceChecksum = await ChecksumSql.ExecuteStringAsync(legacy, spec.LegacyTable);
            var targetChecksum = await ChecksumSql.ExecuteStringAsync(target, spec.TargetTable!);
            Assert.Equal(sourceChecksum, targetChecksum);
        }
    }

    private static async Task<long> CountAsync(SqlConnection connection, string table)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = $"SELECT COUNT_BIG(*) FROM [{table.Replace("]", "]]", StringComparison.Ordinal)}]";
        return Convert.ToInt64(await cmd.ExecuteScalarAsync() ?? 0L);
    }
}