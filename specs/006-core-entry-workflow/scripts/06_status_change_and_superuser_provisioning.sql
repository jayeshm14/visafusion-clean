/* =====================================================================
   06_status_change_and_superuser_provisioning.sql
   VisaFusion — closes Gap Report GR-0002 (missing usp_RecordEntryStatus
   Change / usp_ProvisionSuperUser referenced by FR-005/FR-007,
   BR-002/BR-004, AC-004/AC-006).

   NAMING NOTE: all stored procedures in this script set use the `usp_`
   prefix per the repo standard (library/09_SQLServer_Data_Engineering.md
   §Naming: "usp_ for stored procedures") — GR-0003 item 2 standardized
   the prefix project-wide; files 01-05 were renamed to match.

   KEY-TYPE NOTE (GR-0003 item 3 / GR-0004): the original draft of this
   file used UNIQUEIDENTIFIER for AspNetUsers.Id references. The actual
   VisaFusion Identity schema uses nvarchar(450) string keys — verified
   against src/VisaFusion.Migration/Identity/IdentityImporter.cs
   (EnsureIdentitySchemaAsync: AspNetUsers.Id nvarchar(450) NOT NULL
   PRIMARY KEY; AspNetRoles.Id nvarchar(450) with role Id = role name;
   user Ids generated as Guid.NewGuid().ToString("N")) and
   src/VisaFusion.Identity/Persistence/VisaFusionIdentityDbContext.cs
   (IdentityDbContext<VisaFusionUser, IdentityRole, string>). All
   UNIQUEIDENTIFIER declarations below were corrected to NVARCHAR(450)
   to match. The su/adm role seed is confirmed present (IdentityImporter
   seeds su/adm/emp/agt/guest with Id = role name).
   ===================================================================== */

/* ---------------------------------------------------------------------
   usp_RecordEntryStatusChange

   Atomically updates PaxStatus.statusID and writes both the
   StatusHistory timeline row and the bighistory audit row in one
   transaction. Called explicitly by VisaFusion.Core.EntryService — NOT
   a trigger. This is consistent with the plan's earlier decision that
   audit writes stay attached to the application action that caused
   them (§6 of the migration plan: "no triggers... audit writes stay in
   the service layer, in the same transaction as the change"). Putting
   the atomic multi-table write in a stored procedure that the service
   layer explicitly calls does not violate that decision — it's still
   an explicit, application-initiated write, not an implicit one fired
   by a raw UPDATE from somewhere else.

   GR-0001 RESOLVED 2026-08-16 (T033): StatusHistory/bighistory column
   names verified against the live VisaFusion schema:
     - StatusHistory: Id (bigint PK), PaxID (int), Date (datetime2),
       CountryID (int), StatusID (int), Remarks (nvarchar(max)),
       UpdatedBy (nvarchar(max)) — NO refno column, NO ChangedByUserId,
       NO Remark (singular). The draft INSERTs below were corrected to
       the verified names; the proc itself is SUPERSEDED by
       07_gr0004_corrected_entry_status_change.sql and finally by
       08_finalize_entry_status_change_updatedby.sql (authoritative at
       cutover — @ActorUserId resolves UpdatedBy = '{role}:{username}'
       server-side). Running 01-08 in order leaves the 08 definition in
       place.
     - bighistory: bighistoryid (int PK), refno (int), agent (int),
       Date (datetime2), UpdatedBy (nvarchar(max)), Remarks
       (nvarchar(max)) — NO Description, NO ChangedByUserId.
   ------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE dbo.usp_RecordEntryStatusChange
    @Refno            BIGINT,
    @CountryId         INT,
    @NewStatusId       INT,
    @ChangedByUserId   INT,            -- AspNetUsers.Id (or legacy Udaan_users id during transition) of the acting emp/adm/su
    @Remark            NVARCHAR(500) = NULL,
    @ChangeDate        DATETIME = NULL,
    @NewStatusHistoryId BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;   -- any error auto-rolls-back the whole transaction

    IF @ChangeDate IS NULL SET @ChangeDate = GETDATE();

    -- Guard: refno and target status must exist. These checks stand in
    -- for FK enforcement until 05_normalization_ddl.sql's FK step has
    -- actually been run against this environment (Mainentry/status FKs
    -- are added only after §7 cleansing confirms zero ambiguous rows).
    IF NOT EXISTS (SELECT 1 FROM dbo.Mainentry WHERE refno = @Refno)
    BEGIN
        RAISERROR('usp_RecordEntryStatusChange: refno %I64d not found.', 16, 1, @Refno);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM dbo.status WHERE statusID = @NewStatusId)
    BEGIN
        RAISERROR('usp_RecordEntryStatusChange: statusID %d not found.', 16, 1, @NewStatusId);
        RETURN;
    END

    BEGIN TRANSACTION;

    UPDATE dbo.PaxStatus
        SET statusID = @NewStatusId
        WHERE refno = @Refno AND CountryID = @CountryId;

    IF @@ROWCOUNT = 0
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('usp_RecordEntryStatusChange: no PaxStatus row for refno %I64d / CountryID %d.', 16, 1, @Refno, @CountryId);
        RETURN;
    END

    -- SUPERSEDED by files 07/08 (see header) — column names corrected to
    -- the verified schema (GR-0001) so this draft is not left with
    -- non-existent columns; StatusHistory keys on PaxID (no refno column).
    INSERT INTO dbo.StatusHistory (PaxID, Date, CountryID, StatusID, Remarks, UpdatedBy)
        VALUES (
            (SELECT PaxID FROM dbo.PaxStatus WHERE refno = @Refno AND CountryID = @CountryId),
            @ChangeDate, @CountryId, @NewStatusId, @Remark,
            CONVERT(NVARCHAR(MAX), @ChangedByUserId)
        );

    SET @NewStatusHistoryId = SCOPE_IDENTITY();

    INSERT INTO dbo.bighistory (refno, agent, Date, UpdatedBy, Remarks)
        VALUES (
            @Refno,
            (SELECT agent FROM dbo.Mainentry WHERE refno = @Refno),
            @ChangeDate,
            CONVERT(NVARCHAR(MAX), @ChangedByUserId),
            CONCAT('Status changed to ', @NewStatusId,
                   CASE WHEN @Remark IS NOT NULL THEN CONCAT(' — ', @Remark) ELSE '' END)
        );

    COMMIT TRANSACTION;
END
GO


/* ---------------------------------------------------------------------
   usp_ProvisionSuperUser

   Creates a new `su`-privileged account. This is intentionally its OWN
   procedure with no `@Role` parameter — it can only ever create an su
   account — because the documented CRITICAL finding (self-registration
   -> SU escalation via an unwhitelisted `privilege` field on
   addNewUser.asp/editdonetest.asp) was caused by su being reachable
   through the *general-purpose* user-creation path. Isolating
   su-creation into a dedicated, separately-audited procedure closes
   that path structurally, not just by adding a role check.

   Caller-side responsibility (VisaFusion.Api UsersController):
     - hash @PasswordHash BEFORE calling this proc — plaintext is never
       passed in or stored (fixes the documented plaintext-password
       finding).
     - enforce [Authorize(Policy="SuperUserOnly")] on the endpoint that
       calls this proc, so only an existing `su` can provision another.
   This procedure does not re-implement that application-layer check;
   it assumes it already happened, and instead focuses on making the
   provisioning event itself atomic and audited.

   GR-0001 RESOLVED 2026-08-16 (T033): the Identity schema shape is
   CONFIRMED standard — no naming customization. Verified against
   src/VisaFusion.Identity/Persistence/VisaFusionIdentityDbContext.cs
   (IdentityDbContext<VisaFusionUser, IdentityRole, string> — the
   standard eight AspNet* tables) and src/VisaFusion.Migration/Identity/
   IdentityImporter.cs (EnsureIdentitySchemaAsync creates AspNetUsers.Id
   nvarchar(450) NOT NULL PRIMARY KEY, AspNetRoles.Id nvarchar(450) with
   role Id = role name, user Ids = Guid.NewGuid().ToString("N")). The
   column list below matches that schema exactly. The IF NOT EXISTS
   guards remain a documentation/fallback safety net — the Identity
   tables are created by the identity import step (SPEC-0004 T040),
   which must run before this proc is executed.
   ------------------------------------------------------------------- */

IF OBJECT_ID('dbo.SuperUserProvisioningAudit') IS NULL
BEGIN
    -- New, narrowly-scoped audit table — not in the original 52-table
    -- inventory. Added deliberately and carefully: it exists solely to
    -- close CRITICAL finding 2.2 (§2.2 in the deep analysis) by giving
    -- every su-provisioning event a permanent, separate audit record,
    -- distinct from the general bighistory log. This is the one place
    -- in the whole plan where a new table is introduced rather than
    -- reusing/migrating an existing one — flagged here explicitly so
    -- it doesn't slip through as an unnoticed scope addition.
    CREATE TABLE dbo.SuperUserProvisioningAudit
    (
        AuditId           INT IDENTITY(1,1) PRIMARY KEY,
        NewSuperUserId    NVARCHAR(450) NOT NULL,   -- AspNetUsers.Id (string key; GR-0004)
        NewSuperUserName  NVARCHAR(256) NOT NULL,
        ProvisionedByUserId NVARCHAR(450) NOT NULL, -- the acting su's AspNetUsers.Id
        ProvisionedAt     DATETIME NOT NULL DEFAULT GETDATE()
    );
END
GO

CREATE OR ALTER PROCEDURE dbo.usp_ProvisionSuperUser
    @UserName          NVARCHAR(256),
    @Email             NVARCHAR(256),
    @PasswordHash      NVARCHAR(MAX),     -- already hashed by the caller — NEVER plaintext
    @FirstName         NVARCHAR(100) = NULL,
    @LastName          NVARCHAR(100) = NULL,
    @ProvisionedByUserId NVARCHAR(450),   -- AspNetUsers.Id (string key; GR-0004)
    @NewUserId         NVARCHAR(450) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    -- Guard: the acting user must themselves already hold the su role.
    -- Belt-and-suspenders alongside the [Authorize(Policy="SuperUserOnly")]
    -- check at the API layer — deliberately redundant given how severe
    -- the finding being closed here is.
    IF NOT EXISTS (
        SELECT 1
        FROM dbo.AspNetUserRoles ur
            INNER JOIN dbo.AspNetRoles r ON r.Id = ur.RoleId
        WHERE ur.UserId = @ProvisionedByUserId AND r.Name = 'su'
    )
    BEGIN
        RAISERROR('usp_ProvisionSuperUser: acting user is not an su — refusing to provision.', 16, 1);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM dbo.AspNetUsers WHERE UserName = @UserName)
    BEGIN
        RAISERROR('usp_ProvisionSuperUser: username already exists.', 16, 1);
        RETURN;
    END

    -- Role Ids are the role names themselves in the VisaFusion Identity
    -- schema (IdentityImporter seeds Id = Name = 'su'/'adm'), so the
    -- lookup returns the role name string directly (GR-0004).
    DECLARE @SuRoleId NVARCHAR(450) = (SELECT Id FROM dbo.AspNetRoles WHERE Name = 'su');
    DECLARE @AdmRoleId NVARCHAR(450) = (SELECT Id FROM dbo.AspNetRoles WHERE Name = 'adm');
    IF @SuRoleId IS NULL OR @AdmRoleId IS NULL
    BEGIN
        RAISERROR('usp_ProvisionSuperUser: su/adm roles not found in AspNetRoles — has the Identity role seed run?', 16, 1);
        RETURN;
    END

    -- New user Id: 32-char GUID string without dashes, matching the
    -- IdentityImporter convention (Guid.NewGuid().ToString("N")) (GR-0004).
    SET @NewUserId = REPLACE(CONVERT(NVARCHAR(36), NEWID()), '-', '');

    BEGIN TRANSACTION;

    INSERT INTO dbo.AspNetUsers
        (Id, UserName, NormalizedUserName, Email, NormalizedEmail,
         EmailConfirmed, PasswordHash, SecurityStamp, ConcurrencyStamp,
         PhoneNumberConfirmed, TwoFactorEnabled, LockoutEnabled, AccessFailedCount)
    VALUES
        (@NewUserId, @UserName, UPPER(@UserName), @Email, UPPER(@Email),
         1, @PasswordHash, CONVERT(NVARCHAR(36), NEWID()), CONVERT(NVARCHAR(36), NEWID()),
         0, 0, 1, 0);

    -- su accounts get both roles, matching the legacy mapping (§1.3 of
    -- the architecture report: su -> session priv "adm" + su="Y").
    INSERT INTO dbo.AspNetUserRoles (UserId, RoleId) VALUES (@NewUserId, @SuRoleId);
    INSERT INTO dbo.AspNetUserRoles (UserId, RoleId) VALUES (@NewUserId, @AdmRoleId);

    INSERT INTO dbo.SuperUserProvisioningAudit
        (NewSuperUserId, NewSuperUserName, ProvisionedByUserId)
    VALUES
        (@NewUserId, @UserName, @ProvisionedByUserId);

    COMMIT TRANSACTION;
END
GO
