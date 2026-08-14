/* =====================================================================
   07_gr0004_corrected_entry_status_change.sql
   VisaFusion — corrects usp_RecordEntryStatusChange (originally in
   06_status_change_and_superuser_provisioning.sql) against the real
   schema verified in 20260809142656_InitialCreate.cs (Gap Report
   GR-0004). This CREATE OR ALTER supersedes the version in file 06;
   usp_ProvisionSuperUser in file 06 is untouched — GR-0004 only
   verified StatusHistory/bighistory, not the Identity tables.

   SUPERSEDED 2026-08-14 by 08_finalize_entry_status_change_updatedby.sql
   (UpdatedBy = '{role}:{username}' decision, @ActorUserId anti-spoofing
   change, agent column correction, PaxStatus verification). File 08 is
   authoritative at cutover; this file is retained as a historical
   artifact of the GR-0004 correction step.

   STILL OPEN (see accompanying message — not resolved in this file):
     1) Exact content/format for @ActorIdentifier / UpdatedBy.
     2) Whether PaxStatus actually has a PaxID column — this proc's
        WHERE clause assumes it does, based on an unverified inference
        from 03_report_procedures.sql. Verify against InitialCreate.cs
        before trusting this file the way GR-0004 caught the previous
        one.

   VERIFICATION RESULT (2026-08-14, this session):
     - PaxStatus CONFIRMED against InitialCreate.cs lines 759-799:
       Id (bigint PK), refno (int, FK->Mainentry), PaxID (int),
       CountryID (int), statusID (int, FK->status). The WHERE clause
       `refno AND PaxID AND CountryID` is valid. IX_PaxStatus_PaxID
       index exists (line 896-897).
     - NEW CORRECTION applied: the original draft's agent lookup used
       `Mainentry.agentid`, which does NOT exist in the verified schema.
       Mainentry's owning-agent FK column is `agent` (int, FK->agents.
       agentsID; InitialCreate.cs lines 642, 677-681). Corrected below.
     - Type-width note: @Refno/@PaxID are BIGINT but the actual refno/
       PaxID/CountryID/statusID columns are INT (int->bigint widening is
       safe; exactness left as-is per owner's file 06 convention).
   ===================================================================== */

CREATE OR ALTER PROCEDURE dbo.usp_RecordEntryStatusChange
    @Refno              BIGINT,
    @PaxID              BIGINT,          -- required — StatusHistory keys on PaxID, not refno alone
    @CountryId          INT,
    @NewStatusId        INT,
    @ActorIdentifier    NVARCHAR(256),   -- maps to UpdatedBy (nvarchar(max)) — content format is OPEN, see header
    @Remarks            NVARCHAR(500) = NULL,
    @ChangeDate         DATETIME = NULL,
    @NewStatusHistoryId BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    IF @ChangeDate IS NULL SET @ChangeDate = GETDATE();

    IF NOT EXISTS (SELECT 1 FROM dbo.Mainentry WHERE refno = @Refno)
    BEGIN
        RAISERROR('usp_RecordEntryStatusChange: refno %I64d not found.', 16, 1, @Refno);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM dbo.status WHERE StatusID = @NewStatusId)
    BEGIN
        RAISERROR('usp_RecordEntryStatusChange: StatusID %d not found.', 16, 1, @NewStatusId);
        RETURN;
    END

    BEGIN TRANSACTION;

    -- ASSUMPTION FLAGGED IN HEADER: PaxStatus is assumed to key on
    -- (refno, PaxID, CountryID). Verify against InitialCreate.cs.
    UPDATE dbo.PaxStatus
        SET StatusID = @NewStatusId
        WHERE refno = @Refno AND PaxID = @PaxID AND CountryID = @CountryId;

    IF @@ROWCOUNT = 0
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('usp_RecordEntryStatusChange: no PaxStatus row for refno %I64d / PaxID %I64d / CountryID %d.', 16, 1, @Refno, @PaxID, @CountryId);
        RETURN;
    END

    INSERT INTO dbo.StatusHistory (PaxID, Date, CountryID, StatusID, Remarks, UpdatedBy)
    VALUES (@PaxID, @ChangeDate, @CountryId, @NewStatusId, @Remarks, @ActorIdentifier);

    SET @NewStatusHistoryId = SCOPE_IDENTITY();

    -- Mechanical lookup, not a business-ambiguous choice: bighistory.agent
    -- is populated from the entry's owning agent at Mainentry level.
    -- Column is `agent` (not `agentid`) per verified InitialCreate.cs
    -- lines 642/677-681 — corrected 2026-08-14 (see header note).
    DECLARE @AgentId INT = (SELECT agent FROM dbo.Mainentry WHERE refno = @Refno);

    INSERT INTO dbo.bighistory (refno, agent, Date, UpdatedBy, Remarks)
    VALUES (@Refno, @AgentId, @ChangeDate, @ActorIdentifier, @Remarks);

    COMMIT TRANSACTION;
END
GO
