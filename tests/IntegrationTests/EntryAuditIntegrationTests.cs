using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using VisaFusion.Core.Application;
using VisaFusion.Data.Application;
using VisaFusion.Data.Persistence;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// Create/update audit-row integration tests (SPEC-0006 §19, T040; legacy
/// insertEntry.asp:233 / editEntrySubmit.asp:189).
///
/// Exercises the real <see cref="EntryService"/> over a real SQL Server
/// <see cref="VisaEntryDbContext"/> and the migrated <c>bighistory</c> table:
///   - a successful create writes exactly one bighistory row (refno, agent,
///     Date, UpdatedBy = {role}:{username}, Remarks) in the same commit,
///   - a successful update writes a second row carrying the entry's owning
///     agent and the request remark,
///   - a stale If-Match write (409) writes NO audit row — the audit insert is
///     in the same transaction as the update and rolls back with it.
/// Tests skip when SQL Server is unreachable (existing convention). A real
/// refno is allocated from the sequence and all rows created by the test are
/// deleted afterwards (parameterized SQL only — no string concatenation).
/// </summary>
public class EntryAuditIntegrationTests
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
    public async Task Create_And_Update_Write_Bighistory_Rows_And_Stale_Write_Writes_None()
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

        // A real refno from the sequence — never collides with business data.
        var refno = await service.AllocateRefnoAsync();
        try
        {
            var actor = new EntryActor("integration-tester", new[] { "emp" });

            // Create → one audit row, agent null (the modern create contract
            // carries no agent; insertEntry.asp:233's request("agent") is null).
            var created = await service.CreateAsync(
                refno, ValidCommand("created remark"), actor);
            Assert.Equal(refno, created.Refno);

            var createAudit = await ReadLatestAuditAsync(connection, refno);
            Assert.NotNull(createAudit);
            Assert.Null(createAudit!.Value.Agent);
            Assert.Equal("emp:integration-tester", createAudit.Value.UpdatedBy);
            Assert.Equal("created remark", createAudit.Value.Remarks);
            Assert.NotNull(createAudit.Value.Date);

            // Update → second row, same agent (the entry's owning agent is
            // never changed by this endpoint), remark = the request remark.
            // RowVersion is a SQL Server rowversion — populated on the real
            // DB after create (the InMemory provider cannot generate it).
            var rowVersion = created.RowVersion
                ?? throw new InvalidOperationException("RowVersion must be populated after create on real SQL Server.");
            var updated = await service.UpdateAsync(
                refno, ValidCommand("updated remark"),
                rowVersion, actor);
            Assert.Equal(refno, updated.Refno);

            var updateAudit = await ReadLatestAuditAsync(connection, refno);
            Assert.NotNull(updateAudit);
            Assert.Null(updateAudit!.Value.Agent);
            Assert.Equal("emp:integration-tester", updateAudit.Value.UpdatedBy);
            Assert.Equal("updated remark", updateAudit.Value.Remarks);

            // Stale If-Match (409): the audit insert shares the update's
            // transaction, so a rejected write leaves no audit row behind.
            var stale = new byte[] { 0, 0, 0, 0, 0, 0, 0, 0 };
            await Assert.ThrowsAsync<EntryConflictException>(() =>
                service.UpdateAsync(refno, ValidCommand("stale remark"), stale, actor));

            var audits = await ReadAllAuditsAsync(connection, refno);
            Assert.Equal(2, audits.Count); // create + update only
        }
        finally
        {
            await CleanupAsync(connection, refno);
        }
    }

    private static CreateEntryCommand ValidCommand(string remarks) => new(
        Paxname: "Integration", Passportno: "P-INTEGRATION", DateOfBirth: new DateTime(1990, 1, 1),
        Category: 1, TotalPassengers: 1, TravelDate: new DateTime(2026, 9, 1),
        Remarks: remarks, AgentInstruction: null);

    private static async Task<(int? Agent, string? UpdatedBy, string? Remarks, DateTime? Date)?>
        ReadLatestAuditAsync(SqlConnection connection, int refno)
    {
        var audits = await ReadAllAuditsAsync(connection, refno);
        return audits.Count == 0 ? null : audits[^1];
    }

    private static async Task<List<(int? Agent, string? UpdatedBy, string? Remarks, DateTime? Date)>>
        ReadAllAuditsAsync(SqlConnection connection, int refno)
    {
        var rows = new List<(int? Agent, string? UpdatedBy, string? Remarks, DateTime? Date)>();
        await using var cmd = connection.CreateCommand();
        cmd.CommandText =
            "SELECT agent, UpdatedBy, Remarks, Date FROM dbo.bighistory WHERE refno = @refno ORDER BY bighistoryid";
        cmd.Parameters.AddWithValue("@refno", refno);
        await using var r = await cmd.ExecuteReaderAsync();
        while (await r.ReadAsync())
        {
            rows.Add((
                r.IsDBNull(0) ? null : r.GetInt32(0),
                r.IsDBNull(1) ? null : r.GetString(1),
                r.IsDBNull(2) ? null : r.GetString(2),
                r.IsDBNull(3) ? null : r.GetDateTime(3)));
        }
        return rows;
    }

    private static async Task CleanupAsync(SqlConnection connection, int refno)
    {
        // FK-safe order: audit rows, passengers (entryDetails), then the entry.
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = @"
DELETE FROM dbo.bighistory WHERE refno = @refno;
DELETE FROM dbo.entryDetails WHERE refno = @refno;
DELETE FROM dbo.Mainentry WHERE refno = @refno;";
        cmd.Parameters.AddWithValue("@refno", refno);
        await cmd.ExecuteNonQueryAsync();
    }

    private static async Task<bool> ProcExistsAsync(SqlConnection connection, string proc)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = "SELECT COUNT(*) FROM sys.objects WHERE type = 'P' AND name = @proc";
        cmd.Parameters.AddWithValue("@proc", proc);
        return Convert.ToInt32(await cmd.ExecuteScalarAsync()) > 0;
    }
}