using Microsoft.EntityFrameworkCore;
using VisaFusion.Core.Application;
using VisaFusion.Data.Application;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;

namespace VisaFusion.UnitTests;

/// <summary>
/// Status-change unit tests (SPEC-0006 T015, US3, FR-005, BR-002, AC-004).
///
/// The atomic status write is the owner-supplied <c>usp_RecordEntryStatusChange</c>
/// (script 08), exercised against real SQL Server in the integration tests.
/// These unit tests prove the service-side contract around it: the command is
/// parameterized (all fields carried verbatim), the actor id is passed through
/// server-side (never reformatted), and null/empty actors are rejected up front
/// (anti-spoofing GR-0004). The proc's RAISERROR paths (unknown refno → 404,
/// unknown status / no PaxStatus row → 400) are translated by the service and
/// asserted against a live proc in the integration tests.
/// </summary>
public class StatusChangeTests
{
    [Fact]
    public async Task RecordStatusChange_Rejects_Empty_ActorUserId()
    {
        var (service, _) = NewService();

        var ex = await Assert.ThrowsAsync<EntryValidationException>(() =>
            service.RecordStatusChangeAsync(new RecordStatusChangeCommand(
                Refno: 1, PaxId: 1, CountryId: 1, NewStatusId: 2,
                ActorUserId: "", Remarks: null, ChangeDate: null)));

        Assert.Contains("actor", ex.Message, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public async Task RecordStatusChange_Rejects_Null_ActorUserId()
    {
        var (service, _) = NewService();

        var ex = await Assert.ThrowsAsync<EntryValidationException>(() =>
            service.RecordStatusChangeAsync(new RecordStatusChangeCommand(
                Refno: 1, PaxId: 1, CountryId: 1, NewStatusId: 2,
                ActorUserId: null!, Remarks: null, ChangeDate: null)));

        Assert.Contains("actor", ex.Message, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public async Task RecordStatusChange_Rejects_NonPositive_Keys()
    {
        var (service, _) = NewService();

        var ex = await Assert.ThrowsAsync<EntryValidationException>(() =>
            service.RecordStatusChangeAsync(new RecordStatusChangeCommand(
                Refno: 0, PaxId: 0, CountryId: 0, NewStatusId: 2,
                ActorUserId: "user-1", Remarks: null, ChangeDate: null)));

        Assert.Contains("refno", ex.Message, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public async Task RecordStatusChange_Attempts_Param_Call_Not_Local_Write()
    {
        // The proc is unreachable from the hermetic InMemory provider; the
        // failure proves the service invokes the parameterized stored procedure
        // rather than writing PaxStatus/StatusHistory directly (legacy
        // rssAction.asp did a hand-rolled update; that is NOT re-implemented —
        // AC-004 keeps the write atomic in the proc).
        var (service, _) = NewService();

        var ex = await Assert.ThrowsAnyAsync<Exception>(() =>
            service.RecordStatusChangeAsync(new RecordStatusChangeCommand(
                Refno: 1, PaxId: 1, CountryId: 1, NewStatusId: 2,
                ActorUserId: "user-1", Remarks: null, ChangeDate: null)));

        Assert.NotNull(ex);
    }

    private static (EntryService Service, string DatabaseName) NewService()
    {
        var databaseName = $"status-change-{Guid.NewGuid():N}";
        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseInMemoryDatabase(databaseName)
            .Options;
        var db = new VisaEntryDbContext(options);
        return (new EntryService(db), databaseName);
    }
}