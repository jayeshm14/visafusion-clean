/* =====================================================================
   05_normalization_ddl.sql
   VisaFusion — supporting DDL for the normalization plan (§5):
     1) Consolidate the two confirmed duplicate dead-table pairs
        (emailid+emaild1, changes+changesbill) into archive tables.
     2) Template for adding the missing PRIMARY KEY constraints
        (audit found 20 identity columns but only 2 enforced PKs).
     3) Template for adding FOREIGN KEY constraints — run ONLY after
        the cleansing procedures in 04_migration_cleansing_procedures.sql
        have resolved the status-508 duplicate and orphaned-agent rows,
        or these will fail (by design — that's the point of cleansing
        first).
   Run once, at cutover, after §7's cleansing steps are complete and
   re-verified in staging.
   ===================================================================== */

/* ---------- 1) Archive consolidation ------------------------------- */

IF OBJECT_ID('dbo.LegacyEmailListArchive') IS NULL
BEGIN
    CREATE TABLE dbo.LegacyEmailListArchive
    (
        ArchiveId    INT IDENTITY(1,1) PRIMARY KEY,
        CompanyName  NVARCHAR(50) NULL,   -- GR-0001 RESOLVED 2026-08-16: source emailid/emaild1.companyname is varchar(50)
        EmailId      NVARCHAR(50) NULL,   -- GR-0001 RESOLVED 2026-08-16: source emailid/emaild1.emailid is varchar(50)
        SourceTable  VARCHAR(10) NOT NULL  -- 'emailid' or 'emaild1' — preserves provenance
    );
END
GO

-- GR-0001 RESOLVED 2026-08-16 (T033): the dead tables emailid/emaild1/
-- changes/changesbill are dispositioned ARCH (§3) and were NOT copied into
-- the target VisaFusion database (verified: absent from sys.tables). The
-- archive INSERTs therefore read from the legacy VisaEntry database
-- (read-only, FR-010) via the explicit VisaEntry.dbo cross-database
-- reference — same server, same credentials. Column names confirmed:
-- emailid/emaild1 (companyname varchar(50), emailid varchar(50)),
-- changes/changesbill (refno int, description varchar(50)).
INSERT INTO dbo.LegacyEmailListArchive (CompanyName, EmailId, SourceTable)
SELECT companyname, emailid, 'emailid' FROM VisaEntry.dbo.emailid;
INSERT INTO dbo.LegacyEmailListArchive (CompanyName, EmailId, SourceTable)
SELECT companyname, emailid, 'emaild1' FROM VisaEntry.dbo.emaild1;
GO
-- Note: emailid and emaild1 are NOT dropped (only dtproperties is
-- dropped, per the plan's explicit instruction) — they remain in the
-- legacy database, unused, alongside the new consolidated archive table.

IF OBJECT_ID('dbo.LegacyChangeLogArchive') IS NULL
BEGIN
    CREATE TABLE dbo.LegacyChangeLogArchive
    (
        ArchiveId    INT IDENTITY(1,1) PRIMARY KEY,
        Refno        BIGINT NULL,
        Description  NVARCHAR(50) NULL,   -- GR-0001 RESOLVED 2026-08-16: source changes/changesbill.description is varchar(50)
        LogType      VARCHAR(10) NOT NULL  -- 'Entry' (from `changes`) or 'Bill' (from `changesbill`)
    );
END
GO

INSERT INTO dbo.LegacyChangeLogArchive (Refno, Description, LogType)
SELECT refno, description, 'Entry' FROM VisaEntry.dbo.changes;
INSERT INTO dbo.LegacyChangeLogArchive (Refno, Description, LogType)
SELECT refno, description, 'Bill' FROM VisaEntry.dbo.changesbill;
GO

/* ---------- 2) Missing PRIMARY KEY template -------------------------
   Repeat this pattern for every table with an identity column but no
   declared PK (audit finding: 20 identity columns, 2 PKs). Query
   sys.identity_columns joined to sys.key_constraints to generate the
   full list mechanically rather than guessing which 18 are missing.
   ------------------------------------------------------------------- */

-- Discovery query — run this first to get the real list:
-- SELECT t.name AS TableName, c.name AS IdentityColumn
-- FROM sys.identity_columns c
--     INNER JOIN sys.tables t ON t.object_id = c.object_id
-- WHERE NOT EXISTS (
--     SELECT 1 FROM sys.key_constraints kc
--     WHERE kc.parent_object_id = t.object_id AND kc.type = 'PK'
-- );

-- Example (repeat per table returned above, substituting real names):
-- ALTER TABLE dbo.<TableName>
--     ADD CONSTRAINT PK_<TableName> PRIMARY KEY CLUSTERED (<IdentityColumn>);

/* ---------- 3) Foreign key template -----------------------------------
   Run ONLY after cleansing (§7) confirms zero remaining orphans /
   ambiguous statusID=508 rows for the referenced table.
   ------------------------------------------------------------------- */

-- Example — Mainentry.agent -> agents.agentsID (only after
-- usp_Migrate_ReconcileOrphanAgents shows OrphanRowCount = 0).
-- GR-0001 RESOLVED 2026-08-16: Mainentry's owning-agent FK column is
-- `agent` (int), NOT `agentid` (verified; FK_Mainentry_agents_agent is
-- already enforced in the EF-migrated VisaFusion schema):
-- ALTER TABLE dbo.Mainentry
--     ADD CONSTRAINT FK_Mainentry_Agents
--     FOREIGN KEY (agent) REFERENCES dbo.agents(agentsID);

-- Example — PaxStatus.refno -> Mainentry.refno (already enforced in the
-- EF-migrated schema as FK_PaxStatus_Mainentry_refno; Mainentry.refno is
-- UNIQUE via IX_Mainentry_refno):
-- ALTER TABLE dbo.PaxStatus
--     ADD CONSTRAINT FK_PaxStatus_Mainentry
--     FOREIGN KEY (refno) REFERENCES dbo.Mainentry(refno);

-- GR-0001 RESOLVED 2026-08-16: the draft's "StatusHistory.refno ->
-- Mainentry.refno" example was INVALID — StatusHistory has no refno
-- column (verified: Id, PaxID, Date, CountryID, StatusID, Remarks,
-- UpdatedBy). StatusHistory links to Mainentry through PaxStatus.PaxID;
-- the EF-migrated schema already enforces FK_StatusHistory_status_StatusID
-- and FK_PaxStatus_status_statusID.

-- Example — PaxStatus.statusID -> status.statusID (only after
-- usp_Migrate_CleanseStatus508 resolves the duplicate; already enforced
-- in the EF-migrated schema as FK_PaxStatus_status_statusID):
-- ALTER TABLE dbo.PaxStatus
--     ADD CONSTRAINT FK_PaxStatus_Status
--     FOREIGN KEY (statusID) REFERENCES dbo.status(statusID);

-- GR-0001 RESOLVED 2026-08-16 (T033): the §5.2 relationship template is
-- now complete — CountryID/EmbassyID/PaxID column names verified against
-- the live schema (PaxStatus.CountryID, PaxStatus.PaxID, weeklyoff.
-- embassyid, holidaylist.countryID, embassy.EmbassyID). The EF-migrated
-- VisaFusion schema already enforces the PK/UNIQUE/FK set (PK_Mainentry,
-- PK_PaxStatus, PK_StatusHistory, PK_bighistory, IX_Mainentry_refno,
-- FK_Mainentry_agents_agent, FK_PaxStatus_Mainentry_refno,
-- FK_PaxStatus_status_statusID, FK_StatusHistory_status_StatusID,
-- FK_weeklyoff_embassy_embassyid, FK_entryDetails_Mainentry_refno,
-- FK_invoicedetail_invoice_invoiceno, FK_PaxAttestation_*,
-- FK_smsQueue_agents_agentID, FK_VisaInfo_Category_categoryID) — the
-- templates above are retained for the legacy VisaEntry database, where
-- the audit found 20 identity columns but only 2 enforced PKs.

/* -- Explicitly not part of this file: dtproperties. It is the only
   table dropped per the plan, and is handled in a separate cutover
   step (DROP TABLE dbo.dtproperties;) run once at the very end, not
   bundled with the normalization DDL above. */
