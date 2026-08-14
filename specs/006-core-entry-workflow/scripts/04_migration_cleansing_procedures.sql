/* =====================================================================
   04_migration_cleansing_procedures.sql
   VisaFusion — one-time data-cleansing procedures for the ordered
   remediation steps in the plan (§7). Retired/dropped after cutover —
   these are migration tooling, not part of the live application.

   RUN ONLY AGAINST A STAGING COPY FIRST. Every procedure below only
   QUARANTINES/FLAGS ambiguous data by default (WhatIfOnly = 1) rather
   than silently altering it, per the plan's explicit instruction not
   to guess-correct data. Business sign-off is required (Risk #8 in
   the plan) before running any of these with @WhatIfOnly = 0 against
   production.
   ===================================================================== */

/* ---------- usp_Migrate_CleanseStatus508 --------------------------------
   The legacy `status` table has TWO descriptions for statusID 508
   ("Withdraw" / "Approval Awaited" — deepanalysis.md §4.4/§9.4).
   This procedure does NOT decide which meaning is correct — that is a
   business decision (Risk #8). It only reports which PaxStatus/
   StatusHistory rows used 508 and when, so the business can review
   them and tell you how to split/relabel.

   TODO: once the business confirms the split rule (e.g. "508 rows
   before 2015-01-01 meant Withdraw, after meant Approval Awaited", or
   some other rule), extend the UPDATE section below accordingly. Do
   not invent that rule here.
   ------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE dbo.usp_Migrate_CleanseStatus508
    @WhatIfOnly BIT = 1
AS
BEGIN
    SET NOCOUNT ON;

    -- Reporting pass: always runs, regardless of @WhatIfOnly
    SELECT
        ps.refno,
        ps.CountryID,
        ps.statusID,
        sh.Date              AS StatusHistoryDate   -- TODO: confirm column name
    INTO #Status508Rows
    FROM dbo.PaxStatus AS ps
        LEFT JOIN dbo.StatusHistory AS sh
            ON sh.refno = ps.refno AND sh.statusID = ps.statusID
    WHERE ps.statusID = 508;

    SELECT COUNT(*) AS AmbiguousRowCount FROM #Status508Rows;
    SELECT * FROM #Status508Rows ORDER BY StatusHistoryDate;

    IF @WhatIfOnly = 1
    BEGIN
        PRINT 'WhatIfOnly=1: no data changed. Review the rows above with the business before re-running with @WhatIfOnly=0 and a confirmed split rule.';
        DROP TABLE #Status508Rows;
        RETURN;
    END

    -- TODO: business-confirmed split/relabel logic goes here, e.g.:
    -- UPDATE dbo.PaxStatus SET statusID = <NewID>
    -- FROM dbo.PaxStatus ps INNER JOIN #Status508Rows t ON t.refno = ps.refno
    -- WHERE <business-confirmed condition>;

    DROP TABLE #Status508Rows;
END
GO

/* ---------- usp_Migrate_QuarantineJunkDates -------------------------------
   Flags Mainentry rows with implausible dates (near 1970 or 2207,
   caused by bad UsrToSysDate string-to-date conversions in the legacy
   app — deepanalysis.md §4.3/§9.4). Writes them to a quarantine table
   for manual business review; never auto-corrects a guessed date.
   ------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE dbo.usp_Migrate_QuarantineJunkDates
    @WhatIfOnly BIT = 1
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('dbo.DataQualityQuarantine_JunkDates') IS NULL
    BEGIN
        CREATE TABLE dbo.DataQualityQuarantine_JunkDates
        (
            QuarantineId INT IDENTITY(1,1) PRIMARY KEY,
            refno        BIGINT NOT NULL,
            ColumnName   VARCHAR(50) NOT NULL,
            OriginalValue DATETIME NULL,
            QuarantinedAt DATETIME NOT NULL DEFAULT GETDATE()
        );
    END

    SELECT refno, 'subdate' AS ColumnName, subdate AS OriginalValue
    INTO #JunkDates
    FROM dbo.Mainentry
    WHERE subdate IS NOT NULL
      AND (YEAR(subdate) <= 1971 OR YEAR(subdate) >= 2100)
    UNION ALL
    SELECT refno, 'traveldate', traveldate
    FROM dbo.Mainentry
    WHERE traveldate IS NOT NULL
      AND (YEAR(traveldate) <= 1971 OR YEAR(traveldate) >= 2100);
    -- TODO: extend to coldate/receivedate/sentDate if the same defect
    -- is confirmed present in those columns during schema review.

    SELECT COUNT(*) AS JunkDateRowCount FROM #JunkDates;
    SELECT * FROM #JunkDates;

    IF @WhatIfOnly = 1
    BEGIN
        PRINT 'WhatIfOnly=1: no data changed. Rows listed above for review.';
        DROP TABLE #JunkDates;
        RETURN;
    END

    INSERT INTO dbo.DataQualityQuarantine_JunkDates (refno, ColumnName, OriginalValue)
    SELECT refno, ColumnName, OriginalValue FROM #JunkDates;

    DROP TABLE #JunkDates;
END
GO

/* ---------- usp_Migrate_ReconcileOrphanAgents -----------------------------
   Flags the 6,517 Mainentry rows referencing a non-existent agentid
   (deepanalysis.md §4.3/§9.4) so the FK Mainentry.agentid -> agents.
   agentsID can be added afterward without failing. Does not resolve
   the orphan automatically — the plan requires an owner decision
   between (a) match to correct agent, (b) point at a placeholder
   "Unknown/Legacy Agent" row, or (c) archive-partition the rows.
   This procedure implements option (b) ONLY when explicitly requested
   via @ApplyPlaceholderAgent = 1, since it's the only one of the three
   options that's mechanical rather than requiring human judgment.
   ------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE dbo.usp_Migrate_ReconcileOrphanAgents
    @WhatIfOnly BIT = 1,
    @ApplyPlaceholderAgent BIT = 0,
    @PlaceholderAgentId INT = NULL   -- required if @ApplyPlaceholderAgent = 1;
                                       -- must point at a pre-created
                                       -- "Unknown/Legacy Agent" row
AS
BEGIN
    SET NOCOUNT ON;

    SELECT m.refno, m.agentid AS OrphanAgentId
    INTO #OrphanRows
    FROM dbo.Mainentry AS m
    WHERE NOT EXISTS (
        SELECT 1 FROM dbo.agents AS a WHERE a.agentsID = m.agentid
    );

    SELECT COUNT(*) AS OrphanRowCount FROM #OrphanRows;

    IF @WhatIfOnly = 1
    BEGIN
        SELECT * FROM #OrphanRows;
        PRINT 'WhatIfOnly=1: no data changed.';
        DROP TABLE #OrphanRows;
        RETURN;
    END

    IF @ApplyPlaceholderAgent = 1
    BEGIN
        IF @PlaceholderAgentId IS NULL
            OR NOT EXISTS (SELECT 1 FROM dbo.agents WHERE agentsID = @PlaceholderAgentId)
        BEGIN
            RAISERROR('PlaceholderAgentId must reference an existing agents row.', 16, 1);
            DROP TABLE #OrphanRows;
            RETURN;
        END

        UPDATE m
        SET m.agentid = @PlaceholderAgentId
        FROM dbo.Mainentry AS m
            INNER JOIN #OrphanRows o ON o.refno = m.refno;

        PRINT 'Orphan rows repointed at placeholder agent ' + CAST(@PlaceholderAgentId AS VARCHAR(10)) + '.';
    END
    ELSE
    BEGIN
        PRINT 'No action taken — @ApplyPlaceholderAgent=0. Resolve manually per business decision (match/placeholder/archive).';
    END

    DROP TABLE #OrphanRows;
END
GO
