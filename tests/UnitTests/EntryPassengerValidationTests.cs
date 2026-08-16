using Microsoft.EntityFrameworkCore;
using VisaFusion.Core.Application;
using VisaFusion.Data.Application;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;

namespace VisaFusion.UnitTests;

/// <summary>
/// EntryPassenger validation unit tests (SPEC-0006 T008, US1, spec §17).
///
/// The legacy `entryDetails` schema requires the passenger name and passport
/// number (the principal passenger is carried at the entry level by
/// `insertEntry.asp`). The service enforces the required fields when it
/// materializes the principal <see cref="EntryPassenger"/> child of the
/// aggregate (BR-005).
/// </summary>
public class EntryPassengerValidationTests
{
    [Fact]
    public async Task Create_Rejects_Missing_Passenger_Name()
    {
        var (service, _) = NewService();

        var ex = await Assert.ThrowsAsync<EntryValidationException>(() =>
            service.CreateAsync(1, new CreateEntryCommand(
                Paxname: null, Passportno: "P123", DateOfBirth: null, Category: null,
                TotalPassengers: 1, TravelDate: null, Remarks: null, AgentInstruction: null)));

        Assert.Contains("passenger", ex.Message, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public async Task Create_Rejects_Missing_Passenger_Passport()
    {
        var (service, _) = NewService();

        var ex = await Assert.ThrowsAsync<EntryValidationException>(() =>
            service.CreateAsync(1, new CreateEntryCommand(
                Paxname: "John", Passportno: null, DateOfBirth: null, Category: null,
                TotalPassengers: 1, TravelDate: null, Remarks: null, AgentInstruction: null)));

        Assert.Contains("passenger", ex.Message, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public async Task Create_With_Whitespace_Only_Fields_Rejects()
    {
        var (service, _) = NewService();

        var ex = await Assert.ThrowsAsync<EntryValidationException>(() =>
            service.CreateAsync(1, new CreateEntryCommand(
                Paxname: "   ", Passportno: "   ", DateOfBirth: null, Category: null,
                TotalPassengers: 1, TravelDate: null, Remarks: null, AgentInstruction: null)));

        Assert.Contains("passenger", ex.Message, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public async Task Create_Persists_The_Principal_Passenger_With_All_Fields()
    {
        var (service, databaseName) = NewService();

        var result = await service.CreateAsync(5, new CreateEntryCommand(
            Paxname: "Jane", Passportno: "P999", DateOfBirth: new DateTime(1985, 5, 5),
            Category: 2, TotalPassengers: 1, TravelDate: null, Remarks: "urgent",
            AgentInstruction: "call first"));

        Assert.Single(result.Entry.Passengers);
        var passenger = result.Entry.Passengers[0];
        Assert.Equal("Jane", passenger.Paxname);
        Assert.Equal("P999", passenger.Passportno);
        Assert.Equal(new DateTime(1985, 5, 5), passenger.DateOfBirth);
        Assert.Equal(2, passenger.Category);

        // The passenger row is persisted in entryDetails (refno FK).
        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseInMemoryDatabase(databaseName)
            .Options;
        await using var db = new VisaEntryDbContext(options);
        var stored = await db.EntryPassengers.SingleAsync(p => p.Refno == 5);
        Assert.Equal("Jane", stored.Paxname);
        Assert.Equal("P999", stored.Passportno);
    }

    private static (EntryService Service, string DatabaseName) NewService()
    {
        var databaseName = $"entry-passenger-{Guid.NewGuid():N}";
        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseInMemoryDatabase(databaseName)
            .Options;
        var db = new VisaEntryDbContext(options);
        return (new EntryService(db), databaseName);
    }
}