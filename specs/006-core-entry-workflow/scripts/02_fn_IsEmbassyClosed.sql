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

   TODO: confirm exact column names against the live schema —
   holidaylist and weeklyoff column names below are inferred from the
   documented naming convention (EmbassyID, HolidayDate / DayOfWeek)
   and must be verified before deployment.
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

    -- Sunday check (DATEPART(WEEKDAY, ...) = 1 assumes default
    -- SET DATEFIRST 7 / US-style week start; confirm server
    -- @@DATEFIRST setting matches this assumption before relying on it)
    IF DATEPART(WEEKDAY, @CheckDate) = 1
        SET @IsClosed = 1;

    -- Holiday check
    IF @IsClosed = 0 AND EXISTS (
        SELECT 1
        FROM dbo.holidaylist AS h
        WHERE h.EmbassyID = @EmbassyId
          AND h.HolidayDate = @CheckDate   -- TODO: confirm column name
    )
        SET @IsClosed = 1;

    -- Weekly-off check
    IF @IsClosed = 0 AND EXISTS (
        SELECT 1
        FROM dbo.weeklyoff AS w
        WHERE w.EmbassyID = @EmbassyId     -- TODO: confirm column name
          AND w.DayOfWeek = DATEPART(WEEKDAY, @CheckDate)  -- TODO: confirm representation
    )
        SET @IsClosed = 1;

    RETURN @IsClosed;
END
GO

/* Example usage (reporting/BI only — do not call from the transactional
   entry-creation path; that path uses HolidayService in C#):

   SELECT refno, subdate
   FROM dbo.Mainentry
   WHERE dbo.fn_IsEmbassyClosed(embassyID, subdate) = 1;   -- data-quality
                                                            -- audit query,
                                                            -- e.g. finding
                                                            -- historical
                                                            -- entries that
                                                            -- were somehow
                                                            -- submitted on
                                                            -- a closed day
*/
