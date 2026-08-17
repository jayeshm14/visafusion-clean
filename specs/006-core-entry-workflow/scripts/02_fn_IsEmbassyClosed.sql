/* =====================================================================
   02_fn_IsEmbassyClosed.sql
   VisaFusion — read-only mirror of the holiday/weekly-off/Sunday rule.

   IMPORTANT: this function is NOT the authoritative rule. The
   authoritative check for the transactional entry-creation path lives
   in VisaFusion.Core.HolidayService (C#), so the Web and API front
   ends always enforce the same logic. This SQL function exists only
   so ad-hoc/reporting/BI queries written directly against the database
   don't have to hand-reimplement the rule in T-SQL and risk drifting
   from the application's version. Keep the two in sync manually
   whenever the business rule changes — this file should be regenerated
   from the same rule definition used by HolidayService, not edited
   independently.

   Rule (per documented behavior): an embassy is "closed" on a given
   date if that date is a Sunday, OR appears in holidaylist for that
   embassy, OR falls on the embassy's configured weekly-off day.

   GR-0001 RESOLVED 2026-08-16 (T033): column names verified against the
   live VisaFusion schema (INFORMATION_SCHEMA.COLUMNS) and against the
   authoritative C# rule (VisaFusion.Data/Application/HolidayService.cs):
     - holidaylist.countryID holds the embassy id (NOT an EmbassyID column)
       — HolidayService queries h.CountryId == embassyId (Holiday.CountryId
       maps holidaylist.countryID);
     - holidaylist.holiday is the date column (NOT HolidayDate) —
       HolidayService compares h.HolidayDate == day (Holiday.HolidayDate
       maps holidaylist.holiday);
     - weeklyoff.embassyid is the embassy id column (NOT EmbassyID);
     - weeklyoff.weekend stores the VBScript Weekday() number 1=SUNDAY ..
       7=SATURDAY (NOT DayOfWeek) — verified against WeeklyOffList.asp and
       HolidayService (w.Weekend == (int)date.DayOfWeek + 1). DATEPART
       (WEEKDAY, ...) yields exactly this numbering when @@DATEFIRST = 7;
       @@DATEFIRST = 7 confirmed on the target server (T033).
   ===================================================================== */

CREATE OR ALTER FUNCTION dbo.fn_IsEmbassyClosed
(
    @EmbassyId  INT,
    @CheckDate  DATE
)
RETURNS BIT
AS
BEGIN
    DECLARE @IsClosed BIT = 0;

    -- Sunday check: DATEPART(WEEKDAY, ...) = 1 is Sunday only when
    -- @@DATEFIRST = 7. Confirmed = 7 on the target server (T033) —
    -- matches HolidayService's DayOfWeek.Sunday semantics.
    IF DATEPART(WEEKDAY, @CheckDate) = 1
        SET @IsClosed = 1;

    -- Holiday check: holidaylist.countryID = embassy id AND
    -- holidaylist.holiday = the date (verified column names, GR-0001).
    IF @IsClosed = 0 AND EXISTS (
        SELECT 1
        FROM dbo.holidaylist AS h
        WHERE h.countryID = @EmbassyId
          AND h.holiday = @CheckDate
    )
        SET @IsClosed = 1;

    -- Weekly-off check: weeklyoff.embassyid = embassy id AND
    -- weeklyoff.weekend = VBScript Weekday() (1=Sun..7=Sat) of the date.
    IF @IsClosed = 0 AND EXISTS (
        SELECT 1
        FROM dbo.weeklyoff AS w
        WHERE w.embassyid = @EmbassyId
          AND w.weekend = DATEPART(WEEKDAY, @CheckDate)
    )
        SET @IsClosed = 1;

    RETURN @IsClosed;
END
GO

/* Example usage (reporting/BI only — do not call from the transactional
   entry-creation path; that path uses HolidayService in C#):

   SELECT refno, subdate
   FROM dbo.Mainentry
   WHERE dbo.fn_IsEmbassyClosed(1, subdate) = 1;   -- audit query with a
                                                    -- specific embassy id
                                                    -- (1 here); the embassy
                                                    -- id is the PaxStatus.
                                                    -- CountryID value (the
                                                    -- legacy schema keeps
                                                    -- the embassy per
                                                    -- passenger, not on
                                                    -- Mainentry) — find
                                                    -- historical entries
                                                    -- that were submitted
                                                    -- on a closed day
*/
