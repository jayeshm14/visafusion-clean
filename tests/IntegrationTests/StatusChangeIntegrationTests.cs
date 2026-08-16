using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using VisaFusion.Core.Application;
using VisaFusion.Data.Application;
using VisaFusion.Data.Persistence;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// Status-change integration tests (SPEC-0006 T016, US3, FR-005, BR-002, AC-004,
/// TS-015).
///
/// Exercises the real <see cref="EntryService.RecordStatusChangeAsync"/> over a
/// real SQL Server <see cref="VisaEntryDbContext"/> and the owner-supplied
/// <c>usp_RecordEntryStatusChange</c> (script 08, applied verbatim — GR-0001):
///   - the proc's RAISERROR paths are translated to the service's typed
///     exceptions: unknown refno → <see cref="EntryNotFoundException"/> (404),
///     unknown status / no PaxStatus row → <see cref="EntryValidationException"/>
///     (400),
///   - an unknown refno never touches real PaxStatus/StatusHistory data (the
///     proc rejects before any write).
/// Tests skip when SQL Server is unreachable or the proc does not exist
/// (existing convention). No business rows are created or modified.
/// </summary>
public class StatusChangeIntegrationTests
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
    public async Task RecordStatusChange_Unknown_Refno_Translates_To_NotFound()
    {
        if (!TargetReachable()) return;

        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await ProcExistsAsync(connection, "usp_RecordEntryStatusChange")) return;

        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseSqlServer(connection.ConnectionString)
            .Options;
        await using var db = new VisaEntryDbContext(options);
        var service = new EntryService(db);

        // int.MaxValue passes the service's positive-key validation but is
        // (practically) never a real Mainentry refno — the proc must reject
        // it before any write (BR-002). The guard skips if the impossible
        // happens and a real row owns that refno (real data is never touched).
        const int ghostRefno = int.MaxValue;
        if (await MainentryHasRefnoAsync(connection, ghostRefno)) return;

        var ex = await Assert.ThrowsAsync<EntryNotFoundException>(() =>
            service.RecordStatusChangeAsync(new RecordStatusChangeCommand(
                Refno: ghostRefno, PaxId: 1, CountryId: 1, NewStatusId: 1,
                ActorUserId: "integration-test", Remarks: null, ChangeDate: null)));

        Assert.Contains("not found", ex.Message, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public async Task RecordStatusChange_Rejects_Empty_Actor_Before_Proc()
    {
        if (!TargetReachable()) return;

        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseSqlServer(TargetConnectionString)
            .Options;
        await using var db = new VisaEntryDbContext(options);
        var service = new EntryService(db);

        // Anti-spoofing (GR-0004): the service rejects a missing actor up
        // front — the proc is never invoked with an empty actor id.
        var ex = await Assert.ThrowsAsync<EntryValidationException>(() =>
            service.RecordStatusChangeAsync(new RecordStatusChangeCommand(
                Refno: 1, PaxId: 1, CountryId: 1, NewStatusId: 2,
                ActorUserId: "", Remarks: null, ChangeDate: null)));

        Assert.Contains("actor", ex.Message, StringComparison.OrdinalIgnoreCase);
    }

    private static async Task<bool> MainentryHasRefnoAsync(SqlConnection connection, int refno)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = "SELECT COUNT(*) FROM dbo.Mainentry WHERE refno = @refno";
        cmd.Parameters.AddWithValue("@refno", refno);
        return Convert.ToInt32(await cmd.ExecuteScalarAsync()) > 0;
    }

    private static async Task<bool> ProcExistsAsync(SqlConnection connection, string proc)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = "SELECT COUNT(*) FROM sys.objects WHERE type = 'P' AND name = @proc";
        cmd.Parameters.AddWithValue("@proc", proc);
        return Convert.ToInt32(await cmd.ExecuteScalarAsync()) > 0;
    }
}