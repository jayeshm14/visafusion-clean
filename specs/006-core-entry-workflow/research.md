# Research: Core Entry Workflow (SPEC-0006)

**Date**: 2026-08-14 | **Spec**: [SPEC-0006](spec.md)
**Sources**: `library/ExecutionPlan.md` Phase 1 (items 4-6),
`library/complete_migration_plan.md` §3/§4.2/§5, `findings/modernization_plan.md`
§4.6/§6/§13, `findings/exiting_architecture.md` (table inventory), the owner-supplied
T-SQL scripts `specs/006-core-entry-workflow/scripts/01-08`, Gap Reports GR-0001..GR-0004
(spec §Clarifications), and live repository verification on 2026-08-14
(`VisaEntryDbContext.cs`, `TableCatalog.cs`, `AuthorizationPolicies.cs`,
`EntryService.cs`, `HolidayService.cs`, `Entry.cs`, scripts 01-08).

All `NEEDS CLARIFICATION` items from the plan's Technical Context were resolved in the
spec's Clarifications section (sessions 2026-08-13 Q1-Q4, 2026-08-14 Q1-Q2) and by
repository verification. No unresolved unknowns remain. This document records the
technical decisions and their rationale.

---

## 1. Stored Procedure/Function Source (clarification Q1 → option B; GR-0001..GR-0004)

- **Decision**: Recreate the owner-supplied T-SQL scripts **verbatim** from
  `specs/006-core-entry-workflow/scripts/` (01-08, run in order at cutover). No
  behavior may be invented. Canonical object names (confirmed by owner 2026-08-14):
  `RefnoSeq`, `usp_AllocateNextRefno`, `fn_IsEmbassyClosed`,
  `usp_RecordEntryStatusChange`, `usp_ProvisionSuperUser`; all procedure prefixes
  standardized to `usp_` per GR-0003 item 2 (verified in the scripts this session:
  `01:19` `CREATE SEQUENCE dbo.RefnoSeq`, `01:48` `usp_AllocateNextRefno`,
  `02:26` `fn_IsEmbassyClosed`, `06:45`/`08:33` `usp_RecordEntryStatusChange`,
  `06:161` `usp_ProvisionSuperUser`, `06:150` `CREATE TABLE dbo.SuperUserProvisioningAudit`).
- **Rationale**: The five object names appear only in `library/ExecutionPlan.md:9`; no
  T-SQL existed in the repo (GR-0001 evidence). The owner supplied the scripts as
  artifacts; implementation recreates them verbatim. GR-0002 confirmed the renamed
  mapping (`RefnoSequence`→`RefnoSeq`, `usp_AllocateNextRefno`→`sp_AllocateNextRefno`
  as-supplied, `fn_IsBookableDate`→`fn_IsEmbassyClosed`) is canonical and supplied the
  two missing procs. GR-0003 standardized prefixes to `usp_` and corrected the Identity
  key types to `NVARCHAR(450)`. GR-0004 finalized `usp_RecordEntryStatusChange` in file
  08 (supersedes 06/07) with the `UpdatedBy = {role}:{username}` decision and the
  anti-spoofing `@ActorUserId` interface.
- **Alternatives considered**:
  - Re-derive the procs from legacy page behavior (`modernization_plan.md` §6.1/§6.2)
    — rejected: only the GR-0001 fallback if the scripts did not exist; they do.
  - Keep the as-supplied `sp_` prefixes — rejected (GR-0003 item 2): the repo standard
    (`library/09_SQLServer_Data_Engineering.md` §Naming) mandates `usp_`, matching the
    ExecutionPlan names and the owner's own `usp_` naming for the two new procs.

## 2. `fn_IsEmbassyClosed` vs `HolidayService` (FR-006, BR-003)

- **Decision**: Two implementations of the holiday/weekly-off/Sunday rule, with a
  deliberate split: `fn_IsEmbassyClosed` (script 02) is the **read-only reporting/BI
  mirror**; the **authoritative transactional check** lives in
  `VisaFusion.Core.HolidayService` (C#), which is currently a placeholder
  (verified `HolidayService.cs:12`) and is implemented by this feature. The two are
  kept in sync manually (per the owner-supplied script header).
- **Rationale**: Owner-confirmed semantic design 2026-08-14 (GR-0002 item (a)): the
  split is intentional, not a discrepancy. The Constitution Engineering Process
  requires every business rule implemented once in `VisaFusion.Core` and shared by Web
  UI and API (BR-006); the C# service is the transactional enforcement point, the SQL
  function serves reporting/BI consumers that query the database directly.
- **Alternatives considered**:
  - Make `fn_IsEmbassyClosed` the single source of truth — rejected: the owner
    confirmed the read-only-mirror design; the C# service is required for transactional
    enforcement and testability.
  - Skip the SQL function — rejected: it is an owner-supplied artifact (script 02) and
    must be recreated verbatim per GR-0001.

## 3. Reference Number Allocation (clarification Q2 → option A; FR-003/FR-004, BR-001)

- **Decision**: Legacy-compatible max+1 (next available) allocation made atomic via
  `usp_AllocateNextRefno` using `NEXT VALUE FOR dbo.RefnoSeq` (NO CACHE per the
  owner-supplied script 01). Gaps are acceptable; no duplicates, no collisions under
  concurrent load (AC-003). The sequence starts from current max in `Mainentry` + 1,
  computed at cutover (script 01 TODO).
- **Rationale**: The legacy app allocated refnos with max+1 semantics; a strict
  gap-free sequence would change business behavior. The sequence + proc make the
  allocation atomic (Risk 3 mitigation).
- **Alternatives considered**:
  - Strict gap-free sequence — rejected (clarification Q2, option B): changes legacy
    behavior.
  - Application-level allocation (C# `MAX(refno)+1` in a transaction) — rejected: not
    atomic under load; the owner-supplied proc is the canonical implementation.

## 4. Status Change Recording (FR-005, BR-002, AC-004; GR-0004)

- **Decision**: `usp_RecordEntryStatusChange` (script 08, final) is called explicitly
  by `VisaFusion.Core.EntryService` (not a trigger). It atomically updates
  `PaxStatus.statusID` and writes `StatusHistory` + `bighistory` rows in one
  transaction (verified `scripts/08_finalize_entry_status_change_updatedby.sql:91-122`:
  `BEGIN TRANSACTION` → `UPDATE dbo.PaxStatus` → `INSERT dbo.StatusHistory` →
  `INSERT dbo.bighistory` → `COMMIT`; `SET XACT_ABORT ON`). The caller passes the
  authenticated `AspNetUsers.Id` as `@ActorUserId NVARCHAR(450)`; the proc composes
  `UpdatedBy = {role}:{username}` with role precedence `su > adm > emp > agt`
  (verified `:70-89`).
- **Rationale**: GR-0004 owner decision — the audit must answer "who, in what capacity,
  at that moment"; role captured at time of action (point-in-time snapshot, not live
  join); consistent with the legacy `session("priv")` concept. Anti-spoofing: the
  caller never passes a pre-formatted actor string; the proc resolves username + role
  from the real Identity id, unforgeable by the API layer.
- **Alternatives considered**:
  - Trigger-based status change — rejected (spec FR-005): the proc is called
    explicitly by `EntryService`.
  - Caller-supplied `@ActorIdentifier` free-text — rejected (GR-0004): forgeable; the
    proc must resolve the actor itself.

## 5. Super-User Provisioning (FR-007, BR-004, AC-006; GR-0003)

- **Decision**: `usp_ProvisionSuperUser` (script 06) is a dedicated su-only procedure
  (no `@Role` parameter), password passed pre-hashed, caller must enforce the
  `SuperUserOnly` policy; it creates the `su` user with `su`+`adm` roles, refuses
  duplicate usernames, and writes the `SuperUserProvisioningAudit` row (new table,
  script 06:150, signed off per GR-0003 item 1). Key columns are `NVARCHAR(450)`
  matching the actual Identity schema (GR-0003 item 3 / GR-0004): role Id = role name,
  user Ids = 32-char GUID strings (`Guid.NewGuid().ToString("N")`).
- **Rationale**: Closes CRITICAL finding 2.2 (self-registration → SU escalation) with a
  permanent, separate audit record. The `su`/`adm` role seed is confirmed present
  (verified `IdentityImporter.cs` per GR-0003 item 3). The endpoint
  `POST /api/v1/admin/superusers` is a **documented-only deferred contract** (spec §15;
  `secured-write-routes.md` §3.1) — NOT implemented in this feature.
- **Alternatives considered**:
  - General-purpose user-provisioning proc with a `@Role` parameter — rejected
    (GR-0003): su provisioning must be gated separately from ordinary admin actions.
  - `UNIQUEIDENTIFIER` key types — rejected (GR-0003 item 3): contradicted the actual
    Identity schema; corrected to `NVARCHAR(450)`.

## 6. Optimistic Concurrency on PUT (clarify session 2026-08-14 Q1; AC-011)

- **Decision**: `RowVersion` (rowversion) column added to `Entry`; `PUT
  /api/v1/entries/{refno}` requires `If-Match` with the current ETag; stale write →
  409 Conflict (problem-details). A fresh ETag succeeds.
- **Rationale**: When two users edit the same entry concurrently, the update endpoint
  must reject the stale write rather than let the last write win (owner answer A).
  `RowVersion` is the SQL Server-native optimistic-concurrency mechanism; the ETag is
  derived from it.
- **Alternatives considered**:
  - Last-write-wins — rejected (clarification Q1, option B): loses data silently.
  - Application-level version column — rejected: `rowversion` is the standard EF Core
    mechanism (`IsRowVersion`), no new column semantics to maintain.

## 7. Bulk Entry Operations (clarify session 2026-08-14 Q2)

- **Decision**: No bulk entry endpoint in this feature. The spec §13 "bulk entry
  operations up to 1000" line is removed.
- **Rationale**: The legacy Entries pages have no bulk-entry flow; the only bulk
  operation in the plan is `bulk-collect` (Collection module, out of scope per clarify
  Q4). Inventing a bulk endpoint would add business features the legacy does not have.
- **Alternatives considered**:
  - Keep the §13 line as a future constraint — rejected (clarification Q2, option A):
    removed; no bulk endpoint in scope.

## 8. API Module Scope (clarification Q4 → option A; FR-008/FR-009)

- **Decision**: This feature delivers only the **Entries** module controller set under
  `/api/v1` (spec §15): `POST /entries`, `GET /entries/{refno}`, `PUT /entries/{refno}`,
  `POST /entries/{refno}/status`, `POST /entries/{refno}/awb` — backed by the legacy
  pages `makeEntry`, `insertEntry`, `editentry*`, `editdone`, `sendawbgo`
  (`complete_migration_plan.md` §5 line 189). All write endpoints require the Phase-0
  `EntryOperations` policy (verified `AuthorizationPolicies.cs:22,42` — emp/adm/su).
  Report endpoints (`usp_Report_*`, script 03) back the StatusReportsController, which
  is out of this feature's API scope (GR-0002).
- **Rationale**: One controller set per module per `complete_migration_plan.md` §5;
  other areas belong to their own module features (clarification Q4).
- **Alternatives considered**:
  - All 12 controller areas — rejected (clarification Q4, option B): out of scope.
  - Include the report endpoints — rejected (GR-0002): StatusReportsController is a
    separate module feature.

## 9. Data Volume Baseline (spec §13; NFR-003)

- **Decision**: Performance targets are anchored to the verified data volumes:
  `Mainentry` ≈ 271,724 rows, `entryDetails` ≈ 312,655, `bighistory` ≈ 1.4M rows
  (verified `complete_migration_plan.md` §3 rows 75-77; `findings/exiting_architecture.md`
  table inventory). List endpoints paginate (default 50, max 200); history reads
  (bighistory) use the existing indexes (`bighistory(refno)` per
  `complete_migration_plan.md` §6 item 8).
- **Rationale**: NFR-003 "normal load" must be defined against real volumes; the
  findings documents provide the baseline.
- **Alternatives considered**: None — the baseline is documented in the findings and
  adopted verbatim.

## 10. Pre-Cutover Verification Task (GR-0001 caveat, carried forward)

- **Decision**: Every `-- TODO: confirm column name` in the owner-supplied scripts must
  be verified against the live schema (`sp_help` / `INFORMATION_SCHEMA.COLUMNS`)
  before execution. This is a pre-cutover verification task, not a spec blocker.
- **Rationale**: The owner caveat (GR-0001) states every column name in the scripts is
  inferred from the documented naming convention. The EF migration
  (`VisaEntryDbContext.cs` verified this session) provides the authoritative column
  names for the mapped tables; the verification closes any residual gap.
- **Alternatives considered**: None — the caveat is owner-mandated and carried forward
  verbatim.

## 11. Script 02 Column-Name Flags Resolved (T004, verified 2026-08-14)

- **Decision**: The `-- TODO: confirm column name` flags in
  `scripts/02_fn_IsEmbassyClosed.sql` (lines 20-23, 47, 55-56) are **resolved** against
  the legacy codebase and the EF mappings. The script's inferred names are WRONG for
  three of four references; the C# `HolidayService` (authoritative rule) uses the
  verified names. The script is applied verbatim at cutover (GR-0001) — the flags are
  documentation of the inference, not a blocker, but the parity test (T019) proves the
  SQL mirror and the C# rule agree on the same seeded data.
- **Verified evidence** (this session):
  - `holidaylist.countryID` = embassy id — `holidayList.asp:131` joins
    `holidaylist.countryid = embassy.embassyid`; `insertEntry.asp:36` filters
    `countryID=<country>`. Script 02's `h.EmbassyID` (line 46) is the wrong name.
  - `holidaylist.holiday` = the holiday date — `insertEntry.asp:36` compares
    `Day(holiday)/month(holiday)/year(holiday)` against the check date. Script 02's
    `h.HolidayDate` (line 47) is the wrong name.
  - `weeklyoff.embassyid` = embassy id — `collectionSubmit.asp:81` filters
    `EmbassyID=<country>`. Script 02's `w.EmbassyID` (line 55) is the wrong name.
  - `weeklyoff.weekend` = VBScript `Weekday()` numbering (1=SUNDAY .. 7=SATURDAY) —
    `WeeklyOffList.asp:126` `CASE WHEN weekend = 1 THEN 'SUNDAY' ... WHEN 7 THEN
    'SATURDAY'`; `collectionSubmit.asp:81` matches `weekend = weekday(date)`. Script
    02's `w.DayOfWeek` (line 56) is the wrong name and its `DATEPART(WEEKDAY, ...)`
    comparison (line 39) assumes `@@DATEFIRST = 7` (US-style) — the C# rule uses
    `(int)date.DayOfWeek + 1`, which is equivalent under the default `@@DATEFIRST = 7`.
  - EF mappings confirm the verified names (`VisaEntryDbContext.cs` this session):
    `Holiday.CountryId`→`countryID`, `Holiday.HolidayDate`→`holiday`,
    `WeeklyOff.Embassyid`→`embassyid`, `WeeklyOff.Weekend`→`weekend`.
- **Rationale**: The C# `HolidayService` is the authoritative transactional rule
  (section 2); it must use the real column names. The SQL mirror keeps its inferred
  names per GR-0001 (verbatim application) — the T019 parity test guards against drift
  between the two surfaces (AC-005).
- **Alternatives considered**: Editing script 02 to the verified names — rejected:
  GR-0001 mandates verbatim application of the owner-supplied scripts; the flags are
  the owner's own documentation of the inference.