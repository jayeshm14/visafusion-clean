/* =====================================================================
   09_add_entry_rowversion.sql
   VisaFusion — adds the additive `rowversion` column to dbo.Mainentry
   for the Entry aggregate's optimistic-concurrency token (SPEC-0006 §16,
   AC-011; data-model.md §16: "RowVersion (rowversion) — ADDED BY THIS
   FEATURE — optimistic-concurrency token; ETag for If-Match on PUT").

   WHY THIS SCRIPT EXISTS (verified 2026-08-17, this session):
   - The legacy Mainentry table has no rowversion column (sqlcmd against
     dbo.VisaEntry: 0 columns named rowversion/timestamp).
   - The target dbo.Mainentry (copied schema) also lacks it (sqlcmd
     against dbo.VisaFusion: has_rowversion = 0).
   - The EF model already requires it — VisaEntryDbContext.cs line 143:
     e.Property(x => x.RowVersion).IsRowVersion().HasColumnName("rowversion");
     so ANY create/update through EntryService against the real database
     fails with "Invalid column name 'rowversion'" until this is applied
     (surfaced by EntryAuditIntegrationTests, T040).
   - Scripts 01-08 are owner-supplied and applied verbatim (GR-0001) and
     contain no DDL for this additive column; this file is the traceable
     home for it, following the same idempotent convention (NFR-001/AC-010:
     re-running is a safe no-op — the IF NOT EXISTS guard makes this so).

   SQL Server notes:
   - `rowversion` is usable as a column name and as the type name; the
     column is automatically NOT NULL and auto-generated on insert/update.
   - Additive only: no data is touched; existing rows get a value on the
     next write (rowversion is NULL until first update on migrated rows,
     which matches EF's optimistic-concurrency semantics).
   ===================================================================== */

IF COL_LENGTH('dbo.Mainentry', 'rowversion') IS NULL
BEGIN
    ALTER TABLE dbo.Mainentry
        ADD [rowversion] rowversion NOT NULL;
END;
GO

/* Verification statement (idempotent): returns 1 once applied. */
SELECT COUNT(*) AS mainentry_rowversion_present
FROM sys.columns
WHERE object_id = OBJECT_ID('dbo.Mainentry')
  AND name = 'rowversion';
GO
