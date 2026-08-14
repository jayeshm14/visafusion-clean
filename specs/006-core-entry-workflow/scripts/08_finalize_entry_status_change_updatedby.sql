/* =====================================================================
   08_finalize_entry_status_change_updatedby.sql
   VisaFusion — finalizes the UpdatedBy format decision, closing the
   last open item under GR-0004 (FR-005/BR-002/AC-004).

   DECISION: UpdatedBy = '{role}:{username}', e.g. 'adm:jsmith'.
   Role precedence when a user holds multiple roles: su > adm > emp > agt.

   This CREATE OR ALTER supersedes 07_gr0004_corrected_entry_status_
   change.sql. The only functional change from file 07: @ActorIdentifier
   NVARCHAR(256) (free-text, caller-supplied) is replaced by
   @ActorUserId NVARCHAR(450) (the authenticated caller's real Identity
   id, not forgeable by the API layer) — the proc resolves
   username + highest-privilege role itself, so the audit trail cannot
   be corrupted by a caller passing an unverified role label.

   VERIFICATION (2026-08-14, this session):
   - @ActorUserId is NVARCHAR(450), NOT UNIQUEIDENTIFIER: the actual
     Identity schema uses nvarchar(450) string keys (AspNetUsers.Id;
     IdentityImporter.cs:149; VisaFusionIdentityDbContext.cs:16), and
     user Ids are Guid.NewGuid().ToString("N") 32-char strings
     (IdentityImporter.cs:245). The original draft's UNIQUEIDENTIFIER
     was corrected here — same fix already applied to usp_ProvisionSuperUser
     in file 06 (GR-0003 item 3). RAISERROR %s also requires a string.
   - PaxStatus CONFIRMED against InitialCreate.cs lines 759-799:
     Id (bigint PK), refno (int, FK->Mainentry), PaxID (int),
     CountryID (int), statusID (int, FK->status); IX_PaxStatus_PaxID
     exists (lines 896-897). The UPDATE WHERE clause is valid.
   - Mainentry owning-agent FK column is `agent` (int, FK->agents.agentsID;
     InitialCreate.cs lines 642, 677-681) — NOT `agentid`. Corrected below.
   ===================================================================== */

CREATE OR ALTER PROCEDURE dbo.usp_RecordEntryStatusChange
    @Refno              BIGINT,
    @PaxID              BIGINT,
    @CountryId          INT,
    @NewStatusId        INT,
    @ActorUserId        NVARCHAR(450),   -- authenticated caller's AspNetUsers.Id (string key) — resolved server-side, not caller-formatted text
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

    -- Resolve username + highest-privilege role for this actor.
    DECLARE @ActorUserName NVARCHAR(256) = (
        SELECT UserName FROM dbo.AspNetUsers WHERE Id = @ActorUserId
    );
    IF @ActorUserName IS NULL
    BEGIN
        RAISERROR('usp_RecordEntryStatusChange: ActorUserId %s not found in AspNetUsers.', 16, 1, @ActorUserId);
        RETURN;
    END

    DECLARE @ActorRole NVARCHAR(50) = (
        SELECT TOP 1 r.Name
        FROM dbo.AspNetUserRoles ur
            INNER JOIN dbo.AspNetRoles r ON r.Id = ur.RoleId
        WHERE ur.UserId = @ActorUserId
        ORDER BY CASE r.Name
            WHEN 'su'  THEN 1
            WHEN 'adm' THEN 2
            WHEN 'emp' THEN 3
            WHEN 'agt' THEN 4
            ELSE 5
        END
    );
    IF @ActorRole IS NULL
    BEGIN
        RAISERROR('usp_RecordEntryStatusChange: ActorUserId %s has no role assigned — refusing to record an unattributed change.', 16, 1, @ActorUserId);
        RETURN;
    END

    DECLARE @UpdatedBy NVARCHAR(256) = CONCAT(@ActorRole, ':', @ActorUserName);

    BEGIN TRANSACTION;

    -- ASSUMPTION RESOLVED (2026-08-14): PaxStatus keys on
    -- (refno, PaxID, CountryID) — CONFIRMED against InitialCreate.cs
    -- lines 759-799 (Id bigint PK, refno int FK->Mainentry, PaxID int,
    -- CountryID int, statusID int FK->status; IX_PaxStatus_PaxID at
    -- lines 896-897).
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
    VALUES (@PaxID, @ChangeDate, @CountryId, @NewStatusId, @Remarks, @UpdatedBy);

    SET @NewStatusHistoryId = SCOPE_IDENTITY();

    -- Mechanical lookup: bighistory.agent is the entry's owning agent.
    -- Column is `agent` (not `agentid`) per verified InitialCreate.cs
    -- lines 642/677-681 (FK -> agents.agentsID).
    DECLARE @AgentId INT = (SELECT agent FROM dbo.Mainentry WHERE refno = @Refno);

    INSERT INTO dbo.bighistory (refno, agent, Date, UpdatedBy, Remarks)
    VALUES (@Refno, @AgentId, @ChangeDate, @UpdatedBy, @Remarks);

    COMMIT TRANSACTION;
END
GO
