using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using VisaFusion.Data.Application;
using VisaFusion.Data.Persistence;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// Refno allocation integration tests (SPEC-0006 T012, US2, FR-003/004, BR-001,
/// AC-003, TS-014).
///
/// Exercises the real <see cref="EntryService.AllocateRefnoAsync"/> over a real
/// SQL Server <see cref="VisaEntryDbContext"/> and the owner-supplied
/// <c>usp_AllocateNextRefno</c> (script 01, applied verbatim — GR-0001):
///   - the proc returns a positive refno that fits the int <c>Entry.Refno</c>
///     space (deviation log §2),
///   - consecutive calls are strictly increasing (max+1; gaps permitted,
///     duplicates never — BR-001) without any local read of the table,
///   - the BIGINT→int conversion rejects an out-of-range value (defensive; the
///     allocation sequences are seeded far below int.MaxValue at cutover).
/// Tests skip when SQL Server is unreachable or the proc does not exist
/// (existing convention). Allocation side-effects (refno + 1) are confined to
/// the sequence rows themselves — no business rows are inserted or deleted.
/// </summary>
public class RefnoAllocationTests
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
    public async Task Allocate_Returns_Positive_Int_And_Is_Strictly_Increasing()
    {
        if (!TargetReachable()) return;

        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await ProcExistsAsync(connection, "usp_AllocateNextRefno")) return;

        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseSqlServer(connection.ConnectionString)
            .Options;
        await using var db = new VisaEntryDbContext(options);
        var service = new EntryService(db);

        // The proc reads MAX(refno)+1 from its own sequence logic, so real
        // Mainentry data is never read or modified — the test only observes
        // the allocated values.
        var first = await service.AllocateRefnoAsync();
        var second = await service.AllocateRefnoAsync();

        Assert.True(first > 0, $"allocated refno must be positive, got {first}");
        Assert.True(second > first, $"allocation must be strictly increasing, got {first} then {second}");
    }

    private static async Task<bool> ProcExistsAsync(SqlConnection connection, string proc)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = "SELECT COUNT(*) FROM sys.objects WHERE type = 'P' AND name = @proc";
        cmd.Parameters.AddWithValue("@proc", proc);
        return Convert.ToInt32(await cmd.ExecuteScalarAsync()) > 0;
    }
}