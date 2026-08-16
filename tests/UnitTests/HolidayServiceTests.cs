using Microsoft.EntityFrameworkCore;
using VisaFusion.Data.Application;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;

namespace VisaFusion.UnitTests;

/// <summary>
/// HolidayService unit tests (SPEC-0006 T018, US4, FR-006, BR-003, AC-005).
///
/// The C# <see cref="HolidayService"/> is the AUTHORITATIVE bookable-date rule
/// (script 02 header; plan.md §4 — fn_IsEmbassyClosed is only the read-only
/// reporting mirror). The rule, verified against the legacy codebase:
///   - Sunday → closed,
///   - date present in holidaylist for the embassy (countryID = embassy id,
///     holiday = date) → closed,
///   - the date's weekday (VBScript Weekday() numbering: 1=SUNDAY .. 7=SATURDAY)
///     present in weeklyoff for the embassy → closed,
///   - otherwise open.
/// </summary>
public class HolidayServiceTests
{
    [Fact]
    public async Task Sunday_Is_Closed()
    {
        // 2026-08-16 is a Sunday.
        var (service, _) = NewService();

        Assert.True(await service.IsEmbassyClosedAsync(1, new DateTime(2026, 8, 16)));
    }

    [Fact]
    public async Task Holiday_In_Holidaylist_Is_Closed()
    {
        // 2026-08-17 is a Monday; a holiday row for embassy 1 closes it.
        var (service, db) = NewService();
        db.Holidays.Add(new Holiday { CountryId = 1, HolidayDate = new DateTime(2026, 8, 17) });
        await db.SaveChangesAsync();

        Assert.True(await service.IsEmbassyClosedAsync(1, new DateTime(2026, 8, 17)));
    }

    [Fact]
    public async Task Weekly_Off_Day_Is_Closed()
    {
        // 2026-08-18 is a Tuesday → VBScript Weekday() = 3.
        var (service, db) = NewService();
        db.WeeklyOffs.Add(new WeeklyOff { Embassyid = 1, Weekend = 3 });
        await db.SaveChangesAsync();

        Assert.True(await service.IsEmbassyClosedAsync(1, new DateTime(2026, 8, 18)));
    }

    [Fact]
    public async Task Normal_Weekday_Is_Open()
    {
        // 2026-08-19 is a Wednesday; no holiday / weekly-off rows exist.
        var (service, _) = NewService();

        Assert.False(await service.IsEmbassyClosedAsync(1, new DateTime(2026, 8, 19)));
    }

    [Fact]
    public async Task Holiday_For_Another_Embassy_Does_Not_Close_This_One()
    {
        // Embassy 2's holiday must not close embassy 1.
        var (service, db) = NewService();
        db.Holidays.Add(new Holiday { CountryId = 2, HolidayDate = new DateTime(2026, 8, 20) });
        db.WeeklyOffs.Add(new WeeklyOff { Embassyid = 2, Weekend = 4 });
        await db.SaveChangesAsync();

        Assert.False(await service.IsEmbassyClosedAsync(1, new DateTime(2026, 8, 20)));
    }

    private static (HolidayService Service, VisaEntryDbContext Db) NewService()
    {
        var databaseName = $"holiday-{Guid.NewGuid():N}";
        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseInMemoryDatabase(databaseName)
            .Options;
        var db = new VisaEntryDbContext(options);
        return (new HolidayService(db), db);
    }
}