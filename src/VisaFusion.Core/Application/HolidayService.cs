namespace VisaFusion.Core.Application;

/// <summary>
/// Authoritative holiday/weekly-off/Sunday bookable-date rule (SPEC-0006 US4,
/// FR-006, BR-003, AC-005).
///
/// Rule (verified against legacy behavior, script 02 header and the legacy
/// .asp sources): an embassy is "closed" on a given date when that date is a
/// Sunday, OR the date appears in <c>holidaylist</c> for that embassy, OR the
/// date falls on the embassy's configured weekly-off day.
///
/// Semantics verified from the legacy codebase this session:
///   - <c>holidaylist.countryID</c> holds the embassy id (holidayList.asp:131
///     joins <c>holidaylist.countryid = embassy.embassyid</c>);
///   - <c>holidaylist.holiday</c> is the holiday date (insertEntry.asp compares
///     Day/Month/Year against it);
///   - <c>weeklyoff.weekend</c> uses VBScript <c>Weekday()</c> numbering —
///     1=SUNDAY .. 7=SATURDAY (WeeklyOffList.asp CASE WHEN weekend = 1 THEN
///     'SUNDAY' ... WHEN 7 THEN 'SATURDAY').
///
/// The interface lives in Core (single-source rule); the implementation
/// queries <c>VisaEntryDbContext</c> and therefore lives in VisaFusion.Data
/// (approved deviation, deviation log §1 — exact mirror of the
/// <c>ISecurityGateService</c> precedent). Registered at the composition root
/// in <c>VisaFusion.Web/Program.cs</c>.
/// </summary>
public interface IHolidayService
{
    /// <summary>
    /// Returns true when the embassy is closed on the given date (holiday,
    /// weekly-off or Sunday), false otherwise.
    /// </summary>
    /// <param name="embassyId">Embassy id (legacy <c>embassy.embassyid</c>).</param>
    /// <param name="date">The date being evaluated (date part only is used).</param>
    Task<bool> IsEmbassyClosedAsync(int embassyId, DateTime date, CancellationToken ct = default);
}
