using Microsoft.EntityFrameworkCore;
using VisaFusion.Core.Application;
using VisaFusion.Data.Persistence;

namespace VisaFusion.Data.Application;

/// <summary>
/// Authoritative holiday/weekly-off/Sunday rule (SPEC-0006 T020, US4, FR-006,
/// BR-003, AC-005).
///
/// Placed in VisaFusion.Data (approved deviation, deviation log §1): the
/// interface is the shared Core rule, but the implementation queries
/// <c>VisaEntryDbContext</c> (<c>holidaylist</c>/<c>weeklyoff</c>), which Core
/// cannot reference (one-way Data → Core). Exact mirror of the
/// <c>SecurityGateService</c> precedent.
///
/// Rule (verified against the legacy codebase this session):
///   - Sunday → closed (insertEntry.asp etc. flag weekend dates),
///   - date present in <c>holidaylist</c> for the embassy → closed
///     (<c>countryID</c> = embassy id per holidayList.asp:131; <c>holiday</c>
///     = the date, compared by Day/Month/Year in insertEntry.asp),
///   - the date's weekday present in <c>weeklyoff</c> for the embassy → closed
///     (<c>weekend</c> uses VBScript <c>Weekday()</c> numbering: 1=SUNDAY ..
///     7=SATURDAY per WeeklyOffList.asp; collectionSubmit.asp matches
///     <c>weekend = weekday(date)</c>),
///   - otherwise open.
///
/// The EF entity property names (<c>Holiday.CountryId</c>/<c>HolidayDate</c>,
/// <c>WeeklyOff.Embassyid</c>/<c>Weekend</c>) are the VERIFIED column mappings
/// (VisaEntryDbContext.ConfigureHoliday/ConfigureWeeklyOff); the T-SQL mirror
/// fn_IsEmbassyClosed (script 02) uses inferred names (EmbassyID/HolidayDate/
/// DayOfWeek) that carry TODO-verification flags — the C# side is the
/// authoritative implementation of the rule.
/// </summary>
public sealed class HolidayService : IHolidayService
{
    private readonly VisaEntryDbContext _db;

    public HolidayService(VisaEntryDbContext db) => _db = db;

    public async Task<bool> IsEmbassyClosedAsync(
        int embassyId, DateTime date, CancellationToken ct = default)
    {
        // Sunday check (VBScript Weekday() = 1, i.e. DayOfWeek.Sunday).
        if (date.DayOfWeek == DayOfWeek.Sunday)
        {
            return true;
        }

        var day = date.Date;

        // Holiday check: holidaylist.countryID = embassy id AND holiday = date.
        if (await _db.Holidays.AnyAsync(
                h => h.CountryId == embassyId && h.HolidayDate == day, ct))
        {
            return true;
        }

        // Weekly-off check: weeklyoff.embassyid = embassy id AND
        // weeklyoff.weekend = VBScript Weekday() of the date (1=Sun..7=Sat).
        var weekday = (int)date.DayOfWeek + 1;
        if (await _db.WeeklyOffs.AnyAsync(
                w => w.Embassyid == embassyId && w.Weekend == weekday, ct))
        {
            return true;
        }

        return false;
    }
}
