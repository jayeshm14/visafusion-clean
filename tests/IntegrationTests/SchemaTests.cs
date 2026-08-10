using Microsoft.Data.SqlClient;
using VisaFusion.Migration.Catalog;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// Target schema integration tests (SPEC-0004 T020, TS-002, FR-003, AC-003).
///
/// Verifies the target `VisaFusion` schema created by the `schema` step:
/// every migrated/COND table exists, every table has a primary key, and the
/// DROP-disposition tables are absent (BR-001). Tests skip when SQL Server is
/// unreachable.
/// </summary>
public class SchemaTests
{
    private const string DefaultTargetConnectionString =
        "Server=localhost;Database=VisaFusion;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true";

    private static string TargetConnectionString =>
        Environment.GetEnvironmentVariable("VISA_FUSION_TEST_CONNECTION") ?? DefaultTargetConnectionString;

    private static bool TargetReachable()
    {
        try
        {
            using var target = new SqlConnection(TargetConnectionString);
            target.Open();
            return true;
        }
        catch
        {
            return false;
        }
    }

    private static async Task<HashSet<string>> TargetTableNamesAsync()
    {
        await using var target = new SqlConnection(TargetConnectionString);
        await target.OpenAsync();
        var tables = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
        await using var cmd = target.CreateCommand();
        cmd.CommandText = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE'";
        await using var r = await cmd.ExecuteReaderAsync();
        while (await r.ReadAsync()) tables.Add(r.GetString(0));
        return tables;
    }

    [Fact]
    public void Catalog_Accounts_For_All_52_Legacy_Tables()
    {
        // AC-001: all 52 tables are accounted for in the catalog.
        Assert.Equal(52, TableCatalog.All.Count);
    }

    [Fact]
    public void Catalog_Has_38_Target_Tables()
    {
        // 26 M + 5 MRO + 7 COND = 38 tables with a target table.
        Assert.Equal(38, TableCatalog.All.Count(t => t.TargetTable is not null));
    }

    [Fact]
    public async Task Target_Has_Every_Catalogued_Target_Table()
    {
        if (!TargetReachable()) return;

        var tables = await TargetTableNamesAsync();
        foreach (var spec in TableCatalog.All.Where(t => t.TargetTable is not null))
            Assert.Contains(spec.TargetTable!, tables);
    }

    [Fact]
    public async Task Every_Target_Table_Has_A_Primary_Key()
    {
        if (!TargetReachable()) return;

        await using var target = new SqlConnection(TargetConnectionString);
        await target.OpenAsync();

        foreach (var spec in TableCatalog.All.Where(t => t.TargetTable is not null))
        {
            await using var cmd = target.CreateCommand();
            cmd.CommandText = @"
                SELECT COUNT(*)
                  FROM sys.key_constraints
                 WHERE type = 'PK' AND parent_object_id = OBJECT_ID(@table)";
            cmd.Parameters.AddWithValue("@table", spec.TargetTable!);
            var pkCount = Convert.ToInt32(await cmd.ExecuteScalarAsync());
            Assert.True(pkCount >= 1, $"table '{spec.TargetTable}' has no primary key (AC-003)");
        }
    }

    [Fact]
    public async Task Drop_Tables_Are_Absent_From_The_Target()
    {
        if (!TargetReachable()) return;

        var tables = await TargetTableNamesAsync();
        foreach (var drop in TableCatalog.DropTables)
            Assert.DoesNotContain(drop, tables);
    }
}