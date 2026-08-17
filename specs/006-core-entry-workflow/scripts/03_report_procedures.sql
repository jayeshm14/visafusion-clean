/* =====================================================================
   03_report_procedures.sql
   VisaFusion — reporting stored procedures backing the three heaviest
   report pages (StatusReportsController in the API, §8 of the plan):
     - pendinglist.asp        -> usp_Report_PendingList
     - todayAgentStatus*.asp  -> usp_Report_DailyAgentStatus
     - todayCollection*.asp   -> usp_Report_TodayCollection

   These join across Mainentry / PaxStatus / StatusHistory / agents,
   which hold 270K-1.4M+ rows each — a stored procedure with explicit
   indexed columns is safer here than relying on EF LINQ to always
   pick an efficient plan for this exact query shape. Called from
   VisaFusion.Data via FromSqlInterpolated (parameterized).

   GR-0001 RESOLVED 2026-08-16 (T033): every column name below verified
   against the live VisaFusion schema (INFORMATION_SCHEMA.COLUMNS):
     - agents.agentsID / agents.Description CONFIRMED
     - status.statusID / status.Description CONFIRMED
     - Mainentry.refno / Mainentry.subdate / Mainentry.agent CONFIRMED —
       the owning-agent FK column is `agent` (int), NOT `agentid`; the
       EF-migrated schema enforces FK_Mainentry_agents_agent (same
       correction GR-0004 applied to files 07/08). All `m.agentid`
       references below were corrected to `m.agent`.
     - PaxStatus.CountryID / PaxStatus.statusID / PaxStatus.coldate /
       PaxStatus.visafee CONFIRMED (visafee is decimal).
   Nothing here invents a new business rule — the three reports themselves
   are the specific, already-documented pages named above; only the exact
   column spelling was a placeholder pending schema verification.
   ===================================================================== */

/* ---------- usp_Report_PendingList --------------------------------------
   All entries currently in a "Pending" family status (401-411 per the
   documented status taxonomy) for a given agent (or all agents if
   @AgentId IS NULL, admin/employee view only — enforce that at the
   API/controller layer, not here).
   ------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE dbo.usp_Report_PendingList
    @AgentId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        m.refno,
        m.agent,
        a.Description   AS AgentName,
        ps.CountryID,
        ps.statusID,
        s.Description   AS StatusDescription,
        m.subdate
    FROM dbo.Mainentry AS m
        INNER JOIN dbo.PaxStatus AS ps ON ps.refno = m.refno
        INNER JOIN dbo.status    AS s  ON s.statusID = ps.statusID
        LEFT JOIN  dbo.agents    AS a  ON a.agentsID = m.agent
    WHERE ps.statusID BETWEEN 401 AND 411
      AND (@AgentId IS NULL OR m.agent = @AgentId)
    ORDER BY m.subdate ASC;
END
GO

/* ---------- usp_Report_DailyAgentStatus ----------------------------------
   Per-agent status snapshot "as of" a given date (defaults to today) —
   backs the todayAgentStatus*.asp family of pages.
   ------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE dbo.usp_Report_DailyAgentStatus
    @AsOfDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @AsOfDate IS NULL SET @AsOfDate = CAST(GETDATE() AS DATE);

    SELECT
        a.agentsID,
        a.Description        AS AgentName,
        COUNT(DISTINCT m.refno)                   AS TotalEntries,
        SUM(CASE WHEN ps.statusID BETWEEN 401 AND 411 THEN 1 ELSE 0 END) AS PendingCount,
        SUM(CASE WHEN ps.statusID = 601 THEN 1 ELSE 0 END)               AS SentCount,
        SUM(CASE WHEN ps.statusID = 501 THEN 1 ELSE 0 END)               AS CollectedCount
    FROM dbo.agents AS a
        LEFT JOIN dbo.Mainentry AS m  ON m.agent = a.agentsID
                                       AND CAST(m.subdate AS DATE) <= @AsOfDate
        LEFT JOIN dbo.PaxStatus AS ps ON ps.refno = m.refno
    GROUP BY a.agentsID, a.Description
    ORDER BY a.Description;
END
GO

/* ---------- usp_Report_TodayCollection ------------------------------------
   Entries collected today (statusID 501) — backs todayCollection*.asp.
   ------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE dbo.usp_Report_TodayCollection
    @CollectionDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @CollectionDate IS NULL SET @CollectionDate = CAST(GETDATE() AS DATE);

    SELECT
        m.refno,
        m.agent,
        a.Description   AS AgentName,
        ps.CountryID,
        ps.coldate,
        ps.visafee
    FROM dbo.Mainentry AS m
        INNER JOIN dbo.PaxStatus AS ps ON ps.refno = m.refno
        LEFT JOIN  dbo.agents    AS a  ON a.agentsID = m.agent
    WHERE ps.statusID = 501
      AND CAST(ps.coldate AS DATE) = @CollectionDate
    ORDER BY ps.coldate;
END
GO
