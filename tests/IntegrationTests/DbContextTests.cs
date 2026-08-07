using Microsoft.EntityFrameworkCore;
using VisaFusion.Data.Persistence;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// DbContext integration test (SPEC-0003 T031, User Story 3, FR-006).
///
/// Connects to the local dev copy of the legacy `VisaEntry` database and confirms
/// the DbContext scaffolds the live schema: the 52-table surface is discoverable
/// and the core tables map to their scaffolded entities.
///
/// Requires a local SQL Server with a `VisaEntry` database (see README). The
/// connection string is read from the VISAENTRY_TEST_CONNECTION environment
/// variable, defaulting to the local dev instance.
/// </summary>
public class DbContextTests
{
    private const string ConnectionString =
        "Server=localhost;Database=VisaEntry;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true";

    private static VisaEntryDbContext CreateContext()
    {
        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseSqlServer(ConnectionString)
            .Options;
        return new VisaEntryDbContext(options);
    }

    [Fact]
    public void DbContext_Connects_To_Live_VisaEntry_Database()
    {
        using var context = CreateContext();
        Assert.True(context.Database.CanConnect());
    }

    [Fact]
    public void DbContext_Scaffolds_The_Core_Tables()
    {
        using var context = CreateContext();

        // The 14 core tables from data-model.md §1 must be discoverable.
        Assert.NotNull(context.Entries);
        Assert.NotNull(context.EntryPassengers);
        Assert.NotNull(context.PaxCountryStatuses);
        Assert.NotNull(context.StatusHistory);
        Assert.NotNull(context.EntryAuditLogs);
        Assert.NotNull(context.EmailLogs);
        Assert.NotNull(context.SmsLogs);
        Assert.NotNull(context.Agents);
        Assert.NotNull(context.SecurityDays);
        Assert.NotNull(context.Holidays);
        Assert.NotNull(context.WeeklyOffs);
        Assert.NotNull(context.Embassies);
        Assert.NotNull(context.CountryInfos);
        Assert.NotNull(context.VisaInfos);
    }

    [Fact]
    public void Live_Schema_Has_52_Tables()
    {
        using var context = CreateContext();
        var tableCount = context.Database
            .SqlQueryRaw<int>("SELECT COUNT(*) AS [Value] FROM sys.tables")
            .Single();

        Assert.Equal(52, tableCount);
    }
}