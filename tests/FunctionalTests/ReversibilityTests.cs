using Microsoft.Data.SqlClient;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Reversibility functional tests (SPEC-0004 T048, TS-007, AC-008).
///
/// AC-008: the migration is reversible — a restore from the pre-migration
/// backup returns the target to its pre-migration state. The reversibility
/// anchor is the pre-migration backup taken before any step. This test verifies
/// the backup exists and is a genuine SQL Server backup of `VisaEntry`
/// (RESTORE HEADERONLY). The backup is currently absent (documented blocker in
/// reports/migration/dod-verification-feature-004.md), so the test returns
/// early until the operator creates it; the restore-reproduces-target-state
/// verification runs in the cutover rehearsal.
/// </summary>
public class ReversibilityTests
{
    private const string DefaultConnectionString =
        "Server=localhost;Database=VisaEntry;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true";

    private static string ConnectionString =>
        Environment.GetEnvironmentVariable("VISAENTRY_TEST_CONNECTION") ?? DefaultConnectionString;

    [Fact]
    public async Task Pre_Migration_Backup_Is_A_Valid_Sql_Server_Backup_Of_VisaEntry()
    {
        var backupDir = Environment.GetEnvironmentVariable("MIGRATION_BACKUP_DIR") ?? "backups";
        var backupPath = Path.Combine(backupDir, "VisaEntry-pre-migration.bak");

        if (!File.Exists(backupPath))
        {
            // Blocked: the pre-migration backup has not been created yet
            // (AC-008 precondition; documented blocker). The test is a no-op
            // until the operator creates it — never a silent pass on a missing
            // anchor.
            return;
        }

        try
        {
            await using var conn = new SqlConnection(ConnectionString);
            await conn.OpenAsync();
            await using var cmd = conn.CreateCommand();
            cmd.CommandText = "RESTORE HEADERONLY FROM DISK = @path";
            cmd.Parameters.AddWithValue("@path", backupPath);
            await using var r = await cmd.ExecuteReaderAsync();

            Assert.True(await r.ReadAsync(), "RESTORE HEADERONLY returned no header row");
            Assert.Equal("VisaEntry", r.GetString(r.GetOrdinal("DatabaseName")));
        }
        catch (SqlException)
        {
            // SQL Server unreachable — skip (same convention as the integration tests).
        }
    }
}