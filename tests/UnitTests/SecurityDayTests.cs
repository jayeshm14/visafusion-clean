using Microsoft.EntityFrameworkCore;
using VisaFusion.Core.Application;
using VisaFusion.Data.Application;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;

namespace VisaFusion.UnitTests;

/// <summary>
/// Security-day open/close unit tests (SPEC-0007 T005/T010, FR-008, BR-003,
/// CHK022; contracts/admin-api.md §1/§2).
///
/// Exercises the real <see cref="SecurityGateService"/> (VisaFusion.Data) over
/// a hermetic EF InMemory <see cref="VisaEntryDbContext"/>:
///   - open inserts a row with opening time/by and returns Opened,
///   - open on an already-open day returns AlreadyOpen (409),
///   - close sets closing time/by on the open row and returns Closed,
///   - close with no open row returns NotFound (404),
///   - GetToday returns the day's row or null,
///   - audit events (spec §19) are written in the same commit.
///
/// The concurrent-open race (both callers pass the pre-check, the unique date1
/// index resolves the winner) cannot be reproduced over EF InMemory — the
/// InMemory provider does not enforce unique indexes — so that path is covered
/// by the integration test (T023 concurrency test, real SQL Server).
/// </summary>
public class SecurityDayTests
{
    private static readonly DateTime Date = new(2026, 8, 18);

    [Fact]
    public async Task Open_Inserts_The_Row_And_Returns_Opened()
    {
        var harness = new Harness();

        var result = await harness.Service.OpenDayAsync(Date, "admin1");

        Assert.Equal(SecurityDayOpenResult.Opened, result);
        var row = harness.Db.SecurityDays.Single(s => s.Date1 == Date);
        Assert.NotNull(row.Openingtime);
        Assert.Equal("admin1", row.Openby);
        Assert.Null(row.Closingtime);

        // §19 audit event written in the same commit.
        var audit = harness.Db.AdminAuditLogs.Single(a => a.EventType == "SecurityDayOpened");
        Assert.Equal("admin1", audit.ActorUserName);
        Assert.Contains("2026-08-18", audit.Detail);
    }

    [Fact]
    public async Task Open_On_An_Already_Open_Day_Returns_Already_Open()
    {
        var harness = new Harness();
        await harness.Service.OpenDayAsync(Date, "admin1");

        var result = await harness.Service.OpenDayAsync(Date, "admin2");

        Assert.Equal(SecurityDayOpenResult.AlreadyOpen, result);
        // Exactly one open row for the date; exactly one audit event.
        Assert.Single(harness.Db.SecurityDays.Where(s => s.Date1 == Date));
        Assert.Single(harness.Db.AdminAuditLogs.Where(a => a.EventType == "SecurityDayOpened"));
    }

    [Fact]
    public async Task Close_Sets_The_Close_Fields_And_Returns_Closed()
    {
        var harness = new Harness();
        await harness.Service.OpenDayAsync(Date, "admin1");

        var result = await harness.Service.CloseDayAsync(Date, "admin2");

        Assert.Equal(SecurityDayCloseResult.Closed, result);
        var row = harness.Db.SecurityDays.Single(s => s.Date1 == Date);
        Assert.NotNull(row.Closingtime);
        Assert.Equal("admin2", row.Closedby);

        // §19 audit event written in the same commit as the close.
        Assert.Single(harness.Db.AdminAuditLogs.Where(a => a.EventType == "SecurityDayClosed"));
    }

    [Fact]
    public async Task Close_With_No_Open_Row_Returns_NotFound()
    {
        var harness = new Harness();

        var result = await harness.Service.CloseDayAsync(Date, "admin1");

        Assert.Equal(SecurityDayCloseResult.NotFound, result);
        Assert.Empty(harness.Db.AdminAuditLogs.Where(a => a.EventType == "SecurityDayClosed"));
    }

    [Fact]
    public async Task Close_On_A_Closed_Row_Returns_NotFound()
    {
        var harness = new Harness();
        await harness.Service.OpenDayAsync(Date, "admin1");
        await harness.Service.CloseDayAsync(Date, "admin1");

        // A second close finds no OPEN row (closingtime IS NULL) → 404.
        var result = await harness.Service.CloseDayAsync(Date, "admin1");

        Assert.Equal(SecurityDayCloseResult.NotFound, result);
    }

    [Fact]
    public async Task GetToday_Returns_The_Day_Status()
    {
        var harness = new Harness();
        await harness.Service.OpenDayAsync(Date, "admin1");

        var status = await harness.Service.GetTodayAsync(Date);

        Assert.NotNull(status);
        Assert.Equal(Date, status.Date);
        Assert.Equal("admin1", status.OpenedBy);
        Assert.Null(status.ClosingTime);
        Assert.Null(status.ClosedBy);
    }

    [Fact]
    public async Task GetToday_With_No_Row_Returns_Null()
    {
        var harness = new Harness();

        var status = await harness.Service.GetTodayAsync(Date);

        Assert.Null(status);
    }

    [Fact]
    public async Task GetToday_Is_Exact_On_The_Date()
    {
        var harness = new Harness();
        await harness.Service.OpenDayAsync(Date, "admin1");

        var otherDay = await harness.Service.GetTodayAsync(Date.AddDays(1));

        Assert.Null(otherDay);
    }

    private sealed class Harness
    {
        public Harness()
        {
            var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
                .UseInMemoryDatabase($"security-day-{Guid.NewGuid():N}")
                .Options;
            Db = new VisaEntryDbContext(options);
            Service = new SecurityGateService(Db);
        }

        public VisaEntryDbContext Db { get; }

        public SecurityGateService Service { get; }
    }
}
