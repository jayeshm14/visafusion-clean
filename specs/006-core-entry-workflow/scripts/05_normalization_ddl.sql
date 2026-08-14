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
        CompanyName  NVARCHAR(200) NULL,   -- TODO: confirm column name/length against emailid/emaild1
        EmailId      NVARCHAR(200) NULL,   -- TODO: confirm column name/length
        SourceTable  VARCHAR(10) NOT NULL  -- 'emailid' or 'emaild1' — preserves provenance
    );
END
GO

INSERT INTO dbo.LegacyEmailListArchive (CompanyName, EmailId, SourceTable)
SELECT companyname, emailid, 'emailid' FROM dbo.emailid;   -- TODO: confirm column names
INSERT INTO dbo.LegacyEmailListArchive (CompanyName, EmailId, SourceTable)
SELECT companyname, emailid, 'emaild1' FROM dbo.emaild1;   -- TODO: confirm column names
GO
-- Note: emailid and emaild1 are NOT dropped (only dtproperties is
-- dropped, per the plan's explicit instruction) — they remain in the
-- database, unused, alongside the new consolidated archive table.

IF OBJECT_ID('dbo.LegacyChangeLogArchive') IS NULL
BEGIN
    CREATE TABLE dbo.LegacyChangeLogArchive
    (
        ArchiveId    INT IDENTITY(1,1) PRIMARY KEY,
        Refno        BIGINT NULL,
        Description  NVARCHAR(MAX) NULL,   -- TODO: confirm column name/type
        LogType      VARCHAR(10) NOT NULL  -- 'Entry' (from `changes`) or 'Bill' (from `changesbill`)
    );
END
GO

INSERT INTO dbo.LegacyChangeLogArchive (Refno, Description, LogType)
SELECT refno, description, 'Entry' FROM dbo.changes;       -- TODO: confirm column names
INSERT INTO dbo.LegacyChangeLogArchive (Refno, Description, LogType)
SELECT refno, description, 'Bill' FROM dbo.changesbill;    -- TODO: confirm column names
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

-- Example — Mainentry.agentid -> agents.agentsID (only after
-- usp_Migrate_ReconcileOrphanAgents shows OrphanRowCount = 0):
-- ALTER TABLE dbo.Mainentry
--     ADD CONSTRAINT FK_Mainentry_Agents
--     FOREIGN KEY (agentid) REFERENCES dbo.agents(agentsID);

-- Example — PaxStatus.refno -> Mainentry.refno:
-- ALTER TABLE dbo.PaxStatus
--     ADD CONSTRAINT FK_PaxStatus_Mainentry
--     FOREIGN KEY (refno) REFERENCES dbo.Mainentry(refno);

-- Example — StatusHistory.refno -> Mainentry.refno:
-- ALTER TABLE dbo.StatusHistory
--     ADD CONSTRAINT FK_StatusHistory_Mainentry
--     FOREIGN KEY (refno) REFERENCES dbo.Mainentry(refno);

-- Example — PaxStatus.statusID -> status.statusID (only after
-- usp_Migrate_CleanseStatus508 resolves the duplicate):
-- ALTER TABLE dbo.PaxStatus
--     ADD CONSTRAINT FK_PaxStatus_Status
--     FOREIGN KEY (statusID) REFERENCES dbo.status(statusID);

-- TODO: extend this template for every relationship named in the plan's
-- §5.2 (CountryID, EmbassyID, PaxID) once column names are confirmed
-- against the live schema.

/* -- Explicitly not part of this file: dtproperties. It is the only
   table dropped per the plan, and is handled in a separate cutover
   step (DROP TABLE dbo.dtproperties;) run once at the very end, not
   bundled with the normalization DDL above. */
