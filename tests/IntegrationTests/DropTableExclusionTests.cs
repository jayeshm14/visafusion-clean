using Microsoft.Data.SqlClient;
using VisaFusion.Migration.Catalog;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// DROP-disposition exclusion tests (SPEC-0004 T054, BR-001).
///
/// Only `dtproperties` (SQL Server system table) and the confirmed-empty /
/// scratch tables (`country`, `Results`, `hits`, `adcount`) are excluded from
/// the target; no business table is ever dropped. These tests assert the
/// catalog lists exactly those five and that they are absent from the target
/// schema. Tests skip when SQL Server is unreachable.
/// </summary>
public class DropTableExclusionTests
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

    [Fact]
    public void Catalog_Lists_Exactly_The_Five_Drop_Tables()
    {
        Assert.Equal(5, TableCatalog.DropTables.Count);
        Assert.Contains("dtproperties", TableCatalog.DropTables);
        Assert.Contains("country", TableCatalog.DropTables);
        Assert.Contains("Results", TableCatalog.DropTables);
        Assert.Contains("hits", TableCatalog.DropTables);
        Assert.Contains("adcount", TableCatalog.DropTables);
    }

    [Fact]
    public void Drop_Tables_Have_No_Target_Entity_And_Are_Not_Migrated()
    {
        foreach (var drop in TableCatalog.DropTables)
        {
            var spec = TableCatalog.All.Single(t => t.LegacyTable.Equals(drop, StringComparison.Ordinal));
            Assert.Null(spec.TargetTable);
            Assert.Null(spec.TargetEntity);
            Assert.False(spec.IsMigrated);
            Assert.Equal(TableDisposition.Drop, spec.Disposition);
        }
    }

    [Fact]
    public async Task Drop_Tables_Are_Absent_From_The_Target_Schema()
    {
        if (!TargetReachable()) return;

        await using var target = new SqlConnection(TargetConnectionString);
        await target.OpenAsync();
        var tables = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
        await using (var cmd = target.CreateCommand())
        {
            cmd.CommandText = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE'";
            await using var r = await cmd.ExecuteReaderAsync();
            while (await r.ReadAsync()) tables.Add(r.GetString(0));
        }

        foreach (var drop in TableCatalog.DropTables)
            Assert.DoesNotContain(drop, tables);
    }
}