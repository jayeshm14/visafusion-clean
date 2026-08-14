/* =====================================================================
   01_sequences_and_allocation.sql
   VisaFusion — atomic ID allocation
   Fixes the documented race condition: legacy entry.asp allocated
   Mainentry.refno via "select max(refno)+1" guarded only by an
   application-level lock (deepanalysis.md / modernization_plan.md §9.2).
   invno is retired as a live counter per the normalization plan (§5.4)
   and replaced the same way; invno's existing rows stay in the
   database as LegacyInvoiceCounterArchive, never dropped.
   ===================================================================== */

/* ---------- Sequences ------------------------------------------------ */

-- TODO: set START WITH to (SELECT MAX(refno) FROM dbo.Mainentry) + 1
-- at cutover time so numbering continues from the migrated data instead
-- of restarting at 1. Do not hardcode that value here — compute it at
-- deploy time against the actual cleansed data.
IF NOT EXISTS (SELECT 1 FROM sys.sequences WHERE name = 'RefnoSeq')
    CREATE SEQUENCE dbo.RefnoSeq
        AS BIGINT
        START WITH 1          -- TODO: replace at cutover, see note above
        INCREMENT BY 1
        NO CACHE;              -- NO CACHE trades a little throughput for
                                -- zero risk of losing/reusing numbers on
                                -- an unexpected SQL Server restart
GO

-- TODO: set START WITH to (SELECT MAX(invoiceno) FROM dbo.invoice) + 1
-- at cutover time, same reasoning as RefnoSeq above.
IF NOT EXISTS (SELECT 1 FROM sys.sequences WHERE name = 'InvoiceNumberSeq')
    CREATE SEQUENCE dbo.InvoiceNumberSeq
        AS BIGINT
        START WITH 1           -- TODO: replace at cutover
        INCREMENT BY 1
        NO CACHE;
GO

/* ---------- usp_AllocateNextRefno -------------------------------------
   Called once per new Mainentry insert, from VisaFusion.Core.EntryService,
   inside the same transaction as the Mainentry INSERT so a failed insert
   does not "burn" a refno unnecessarily under NO CACHE... note: with
   sequences, a rolled-back transaction *can* still leave a gap in the
   sequence (this is expected/standard SQL Server sequence behavior) —
   gaps are acceptable here since refno was never guaranteed contiguous
   in the legacy system either; the fix targets *uniqueness under
   concurrency*, not contiguity.
   ----------------------------------------------------------------------*/
CREATE OR ALTER PROCEDURE dbo.usp_AllocateNextRefno
    @NewRefno BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET @NewRefno = NEXT VALUE FOR dbo.RefnoSeq;
END
GO

/* ---------- usp_AllocateInvoiceNumber ----------------------------------
   Replaces the old invno-table allocation pattern. Called from
   VisaFusion.Core.BillingService when Billing is enabled
   (gated behind Risk #1 in the plan — invoice/billing revival decision).
   ----------------------------------------------------------------------*/
CREATE OR ALTER PROCEDURE dbo.usp_AllocateInvoiceNumber
    @NewInvoiceNumber BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET @NewInvoiceNumber = NEXT VALUE FOR dbo.InvoiceNumberSeq;
END
GO
