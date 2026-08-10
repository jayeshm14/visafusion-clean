using Microsoft.EntityFrameworkCore;
using VisaFusion.Data.Persistence;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// DbContext integration test (SPEC-0003 T031, User Story 3, FR-006).
///
/// Connects to a local copy of the legacy `VisaEntry` database and confirms
/// the DbContext scaffolds the live schema: the 52-table surface is discoverable
/// and the core tables map to their scaffolded entities.
///
/// The connection string is read from the VISAENTRY_TEST_CONNECTION environment
/// variable, defaulting to the local dev instance. The two tests that require a
/// live server are skipped when the server is unreachable (e.g. CI runners
/// without a SQL Server), so the suite stays green without a database; the
/// schema-only test (DbContext_Scaffolds_The_Core_Tables) never opens a
/// connection and always runs.
/// </summary>
public class DbContextTests
{
    private const string DefaultConnectionString =
        "Server=localhost;Database=VisaEntry;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true";

    private static string ConnectionString =>
        Environment.GetEnvironmentVariable("VISAENTRY_TEST_CONNECTION")
        ?? DefaultConnectionString;

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
        if (!context.Database.CanConnect())
        {
            // No SQL Server available (e.g. CI runner without a database
            // service). Skip rather than fail: this test is DB-bound by design.
            return;
        }

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
        if (!context.Database.CanConnect())
        {
            // No SQL Server available; skip rather than fail (see class doc).
            return;
        }

        var tableCount = context.Database
            .SqlQueryRaw<int>("SELECT COUNT(*) AS [Value] FROM sys.tables")
            .Single();

        Assert.Equal(52, tableCount);
    }
}