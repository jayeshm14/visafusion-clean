using Microsoft.EntityFrameworkCore;
using VisaFusion.Core.Application;
using VisaFusion.Data.Application;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;

namespace VisaFusion.UnitTests;

/// <summary>
/// Entry aggregate invariant unit tests (SPEC-0006 T007, US1, AC-002, FR-001/002,
/// BR-005).
///
/// Exercises the real <see cref="EntryService"/> (VisaFusion.Data) over a
/// hermetic EF InMemory <see cref="VisaEntryDbContext"/>:
///   - ≥ 1 passenger invariant (BR-005): create with no principal passenger
///     (empty paxname/passportno) is rejected,
///   - valid refno: non-positive refno rejected; duplicate refno rejected
///     (409 conflict),
///   - free-form status (clarification Q3): a stored status value is returned
///     unchanged — no transition validation, no normalization,
///   - RowVersion is populated after save (AC-011).
/// </summary>
public class EntryAggregateTests
{
    [Fact]
    public async Task Create_With_Empty_Paxname_Rejects_No_Passenger()
    {
        var (service, _) = NewService();

        var ex = await Assert.ThrowsAsync<EntryValidationException>(() =>
            service.CreateAsync(1, new CreateEntryCommand(
                Paxname: "", Passportno: "P123", DateOfBirth: null, Category: null,
                TotalPassengers: 1, TravelDate: null, Remarks: null, AgentInstruction: null)));

        Assert.Contains("passenger", ex.Message, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public async Task Create_With_Empty_Passportno_Rejects_No_Passenger()
    {
        var (service, _) = NewService();

        var ex = await Assert.ThrowsAsync<EntryValidationException>(() =>
            service.CreateAsync(1, new CreateEntryCommand(
                Paxname: "John", Passportno: "", DateOfBirth: null, Category: null,
                TotalPassengers: 1, TravelDate: null, Remarks: null, AgentInstruction: null)));

        Assert.Contains("passenger", ex.Message, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public async Task Create_With_Non_Positive_Refno_Rejects()
    {
        var (service, _) = NewService();

        var ex = await Assert.ThrowsAsync<EntryValidationException>(() =>
            service.CreateAsync(0, ValidCommand()));

        Assert.Contains("refno", ex.Message, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public async Task Create_With_Duplicate_Refno_Rejects_With_Conflict()
    {
        var (service, _) = NewService();
        await service.CreateAsync(42, ValidCommand());

        var ex = await Assert.ThrowsAsync<EntryConflictException>(() =>
            service.CreateAsync(42, ValidCommand()));

        Assert.Contains("42", ex.Message);
    }

    [Fact]
    public async Task Create_With_Valid_Data_Succeeds_And_Returns_Aggregate()
    {
        var (service, _) = NewService();

        var result = await service.CreateAsync(7, ValidCommand());

        Assert.Equal(7, result.Refno);
        Assert.Equal(7, result.Entry.Refno);
        Assert.Equal("John", result.Entry.Paxname);
        Assert.Single(result.Entry.Passengers);
        Assert.Equal("John", result.Entry.Passengers[0].Paxname);
        Assert.Equal("P123", result.Entry.Passengers[0].Passportno);
        // RowVersion population is a SQL Server rowversion behavior — the EF
        // InMemory provider does not generate it. Verified against real SQL
        // Server in the integration tests (RefnoAllocationTests/StatusChangeTests).
    }

    [Fact]
    public async Task Get_By_Refno_Returns_Aggregate_With_Passengers_And_PaxStatuses()
    {
        var (service, _) = NewService();
        await service.CreateAsync(9, ValidCommand());

        var aggregate = await service.GetByRefnoAsync(9);

        Assert.NotNull(aggregate);
        Assert.Equal(9, aggregate!.Refno);
        Assert.Single(aggregate.Passengers);
    }

    [Fact]
    public async Task Get_By_Unknown_Refno_Returns_Null()
    {
        var (service, _) = NewService();

        var aggregate = await service.GetByRefnoAsync(999);

        Assert.Null(aggregate);
    }

    [Fact]
    public async Task Free_Form_Status_Is_Returned_Unchanged()
    {
        // Clarification Q3: status is free-form per legacy — any status code is
        // writable at any time, no transition validation. A stored status value
        // (here the sentinel 999) must round-trip unchanged.
        var (service, databaseName) = NewService();
        await service.CreateAsync(11, ValidCommand());

        // A second context over the same InMemory database mutates the row
        // directly (the service exposes no write surface for status).
        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseInMemoryDatabase(databaseName)
            .Options;
        await using var db = new VisaEntryDbContext(options);
        var entry = await db.Entries.SingleAsync(e => e.Refno == 11);
        entry.Status = 999;
        await db.SaveChangesAsync();

        var aggregate = await service.GetByRefnoAsync(11);

        Assert.NotNull(aggregate);
        Assert.Equal(999, aggregate!.Status);
    }

    private static CreateEntryCommand ValidCommand() => new(
        Paxname: "John", Passportno: "P123", DateOfBirth: new DateTime(1990, 1, 1),
        Category: 1, TotalPassengers: 1, TravelDate: new DateTime(2026, 9, 1),
        Remarks: null, AgentInstruction: null);

    private static (EntryService Service, string DatabaseName) NewService()
    {
        var databaseName = $"entry-aggregate-{Guid.NewGuid():N}";
        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseInMemoryDatabase(databaseName)
            .Options;
        var db = new VisaEntryDbContext(options);
        return (new EntryService(db), databaseName);
    }
}