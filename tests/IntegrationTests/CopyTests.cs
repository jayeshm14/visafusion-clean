using Microsoft.Data.SqlClient;
using VisaFusion.Migration.Catalog;
using VisaFusion.Migration.Copy;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// Copy-pipeline integration tests (SPEC-0004 T025/T026, FR-005a, GAP-0002).
///
/// Verifies the two deterministic copy-time safeguards against the LIVE legacy
/// `VisaEntry` and target `VisaFusion` databases:
///   1. <see cref="DuplicateKeyGuard"/> detects legacy duplicates on the target
///      PK columns BEFORE any row is written — exactly the two known tables
///      (status 508 documented FR-005a, agents 4114 undocumented GAP-0002) and
///      no others.
///   2. <see cref="CopyTransform.DeduplicateOn"/> produces a deterministic
///      single-row-per-key projection (the status FR-005a transform), and the
///      guard skips transform-covered tables.
///
/// All tests are read-only. They skip when either SQL Server is unreachable
/// (same convention as <see cref="DbContextTests"/>), so the suite stays green
/// on CI runners without a database service.
/// </summary>
public class CopyTests
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
            // No SQL Server available (CI runner without a database service).
            return false;
        }
    }

    /// <summary>
    /// The comprehensive guard scan over all migrated tables must find exactly
    /// the two known duplicate-key tables and nothing else. This is the
    /// "never guess" fail-fast contract (GAP-0002 §5).
    /// </summary>
    [Fact]
    public async Task DuplicateKeyGuard_Detects_Exactly_The_Two_Known_Key_Duplicates()
    {
        if (!ServersReachable()) return;

        await using var legacy = new SqlConnection(LegacyConnectionString);
        await legacy.OpenAsync();
        await using var target = new SqlConnection(TargetConnectionString);
        await target.OpenAsync();

        // No transform coverage: every duplicate key is reported.
        var violations = await DuplicateKeyGuard.ScanAsync(legacy, target, TableCatalog.All,
            isTransformCovered: _ => false);

        var byTable = violations
            .GroupBy(v => v.LegacyTable)
            .Select(g => (Table: g.Key, Keys: g.Select(v => v.KeyValue).OrderBy(k => k).ToArray()))
            .OrderBy(g => g.Table, StringComparer.Ordinal)
            .ToArray();

        Assert.Equal(2, byTable.Length);
        Assert.Equal("agents", byTable[0].Table);
        Assert.Equal(["4114"], byTable[0].Keys);
        Assert.Equal("status", byTable[1].Table);
        Assert.Equal(["508"], byTable[1].Keys);
    }

    /// <summary>
    /// A transform-covered table (status FR-005a) is excluded from the guard —
    /// the transform deterministically resolves the duplicate at copy time —
    /// leaving only the undocumented agents gap.
    /// </summary>
    [Fact]
    public async Task DuplicateKeyGuard_Skips_Transform_Covered_Tables()
    {
        if (!ServersReachable()) return;

        await using var legacy = new SqlConnection(LegacyConnectionString);
        await legacy.OpenAsync();
        await using var target = new SqlConnection(TargetConnectionString);
        await target.OpenAsync();

        var violations = await DuplicateKeyGuard.ScanAsync(legacy, target, TableCatalog.All,
            isTransformCovered: spec => spec.LegacyTable.Equals("status", StringComparison.OrdinalIgnoreCase));

        var tables = violations.Select(v => v.LegacyTable).Distinct(StringComparer.OrdinalIgnoreCase).OrderBy(t => t).ToArray();
        Assert.Equal(["agents"], tables);
        Assert.All(violations, v => Assert.Equal("4114", v.KeyValue));
    }

    /// <summary>
    /// The status FR-005a copy-time transform yields exactly one row per
    /// statusID — 26 rows from the 27 legacy rows (the 508 duplicate collapses)
    /// — and the surviving 508 row is the first-ranked description (Withdraw).
    /// Determinism: same expression as the post-copy Status508Rule.
    /// </summary>
    [Fact]
    public async Task DeduplicateOn_Transform_Collapses_Status_508_Duplicate()
    {
        if (!ServersReachable()) return;

        var transform = new CopyTransform.DeduplicateOn("status", "statusID", "FR-005a");
        var sql = transform.Apply("[statusID], [Description], [Active]");

        await using var legacy = new SqlConnection(LegacyConnectionString);
        await legacy.OpenAsync();
        await using var cmd = legacy.CreateCommand();
        cmd.CommandText = sql;

        var rows = new List<(int StatusId, string Description)>();
        await using (var r = await cmd.ExecuteReaderAsync())
        {
            while (await r.ReadAsync())
            {
                rows.Add((r.GetInt32(0), r.IsDBNull(1) ? "(null)" : r.GetString(1)));
            }
        }

        // 27 legacy rows → 26 distinct statusID rows.
        Assert.Equal(26, rows.Count);
        Assert.Equal(26, rows.Select(x => x.StatusId).Distinct().Count());
        Assert.Single(rows.Where(x => x.StatusId == 508));
        Assert.Equal("Withdraw", rows.Single(x => x.StatusId == 508).Description);
    }

    /// <summary>
    /// The status table spec carries the documented FR-005a row delta (-1), so
    /// validation expects 27 → 26 and the copy result aligns with the catalog.
    /// </summary>
    [Fact]
    public void Status_TableSpec_Records_FR005a_RowDelta()
    {
        var spec = TableCatalog.All.Single(t => t.LegacyTable.Equals("status", StringComparison.OrdinalIgnoreCase));
        Assert.Equal(-1, spec.RowDelta);
        Assert.True(spec.IsMigrated);
    }

    /// <summary>
    /// The embassy catalog entry preserves the legacy identity column so
    /// weeklyoff.embassyid FK references survive the copy (data-model §2/§3.1).
    /// </summary>
    [Fact]
    public void Embassy_TableSpec_Preserves_Legacy_Identity()
    {
        var spec = TableCatalog.All.Single(t => t.LegacyTable.Equals("embassy", StringComparison.OrdinalIgnoreCase));
        Assert.Equal("EmbassyID", spec.IdentityColumn);
    }

    /// <summary>
    /// With the FR-005e (agents 4114) transform approved alongside FR-005a
    /// (status 508), the guard sees NO undocumented duplicate — both known gaps
    /// are transform-covered and the copy is allowed to proceed.
    /// </summary>
    [Fact]
    public async Task DuplicateKeyGuard_No_Violations_When_All_Known_Gaps_Are_Transform_Covered()
    {
        if (!ServersReachable()) return;

        await using var legacy = new SqlConnection(LegacyConnectionString);
        await legacy.OpenAsync();
        await using var target = new SqlConnection(TargetConnectionString);
        await target.OpenAsync();

        var violations = await DuplicateKeyGuard.ScanAsync(legacy, target, TableCatalog.All,
            isTransformCovered: spec => spec.LegacyTable is "status" or "agents");

        Assert.Empty(violations);
    }

    /// <summary>
    /// The FR-005e copy-time transform (agents 4114 dedupe) yields exactly one
    /// row per agentsID — 4,217 rows from the 4,218 legacy rows — and the
    /// surviving 4114 row is the populated profile (CUSTOMER A/C), not the
    /// all-NULL ghost. Same expression as the post-copy Agents4114Rule.
    /// </summary>
    [Fact]
    public async Task DeduplicateOn_Transform_Collapses_Agents_4114_Duplicate_Keeping_Profile()
    {
        if (!ServersReachable()) return;

        var transform = new CopyTransform.DeduplicateOn("agents", "agentsID", "FR-005e");
        var sql = transform.Apply("[agentsID], [companyname], [emailid]");

        await using var legacy = new SqlConnection(LegacyConnectionString);
        await legacy.OpenAsync();
        await using var cmd = legacy.CreateCommand();
        cmd.CommandText = sql;

        var rows = new List<(int AgentId, string Company, string Email)>();
        await using (var r = await cmd.ExecuteReaderAsync())
        {
            while (await r.ReadAsync())
            {
                rows.Add((r.GetInt32(0), r.IsDBNull(1) ? "(null)" : r.GetString(1),
                    r.IsDBNull(2) ? "(null)" : r.GetString(2)));
            }
        }

        // 4,218 legacy rows → 4,217 distinct agentsID rows.
        Assert.Equal(4217, rows.Count);
        Assert.Equal(4217, rows.Select(x => x.AgentId).Distinct().Count());
        var survivor = rows.Single(x => x.AgentId == 4114);
        // Verbatim legacy value (FR-002): the profile carries a trailing space.
        Assert.Equal("CUSTOMER A/C ", survivor.Company);
        Assert.Equal("pankaj@udaanindia.com", survivor.Email);
    }

    /// <summary>
    /// The agents table spec carries the documented FR-005e row delta (-1), so
    /// validation expects 4,218 → 4,217 and the copy result aligns with the
    /// catalog (GAP-0002 Option A).
    /// </summary>
    [Fact]
    public void Agents_TableSpec_Records_FR005e_RowDelta()
    {
        var spec = TableCatalog.All.Single(t => t.LegacyTable.Equals("agents", StringComparison.OrdinalIgnoreCase));
        Assert.Equal(-1, spec.RowDelta);
        Assert.True(spec.IsMigrated);
        Assert.Equal("agentsID", spec.IdentityColumn);
    }
}
