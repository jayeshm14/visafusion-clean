# Data Model: Core Entry Workflow (SPEC-0006)

**Date**: 2026-08-14 | **Spec**: [SPEC-0006](spec.md)

The 52-table data model was migrated by SPEC-0004 (disposition per
`library/complete_migration_plan.md` §3). This feature hardens the `Entry` aggregate
(adds `RowVersion`), implements the stored procedures/functions from the owner-supplied
scripts, and exposes the Entries API. All tables below are documented per their role in
this feature; the physical table names are the legacy names (preserved so the
owner-supplied procs run verbatim — see plan.md Technical Context).

## 1. `Entry` aggregate root (physical table `Mainentry`, disposition M)

Mapped by `VisaFusion.Data.Persistence.Entities.Entry`
(`VisaEntryDbContext.cs:111-138`, verified this session). Column names verbatim from
the live schema.

| Column | Type | Notes |
|--------|------|-------|
| `Id` | bigint identity PK | legacy `id`, values preserved (FR-003) |
| `refno` | int | business key; `GET /api/v1/entries/{refno}` lookups; unique per BR-001/§17 |
| `paxname` | nvarchar | |
| `agent` | int? | owning-agent FK → `agents.agentsID`; 6,517 orphaned rows migrate NULL (FR-005c); **verified column is `agent` not `agentid`** (`VisaEntryDbContext.cs:116`, `InitialCreate.cs:642,677-681` per GR-0004) |
| `refferer` / `companyname` / `passportno` | nvarchar | |
| `totalpassengers` / `entries` | int? | |
| `dateofbirth` | datetime? | |
| `subdate` / `coldate` / `receivedate` / `traveldate` / `sentDate` | datetime? | |
| `entrytype` | int? | 100% NULL in source; defaulted by cleansing rule (b) (FR-005b) |
| `category` / `attestation` / `poe` / `status` | int? | |
| `externalremark` / `internalremark` / `AgentInstruction` | nvarchar | |
| `enteredby` | nvarchar | |
| `entrydatetime` | datetime? | |
| `bill` | nvarchar | |
| **`RowVersion`** (rowversion) | rowversion | **ADDED BY THIS FEATURE** (spec §16, AC-011) — optimistic-concurrency token; ETag for `If-Match` on PUT |

### 1.1 `EntryPassenger` (physical table `entryDetails`, disposition M)

Mapped by `VisaFusion.Data.Persistence.Entities.EntryPassenger`
(`VisaEntryDbContext.cs:163-171`, verified this session). Child of `Entry`
(`refno` FK).

| Column | Type | Notes |
|--------|------|-------|
| `PaxID` | int identity PK | values preserved (FR-003) |
| `refno` | int? | FK → `Entry.refno` |
| `Paxname` | nvarchar | |
| `passportno` | nvarchar | |
| `DateOfBirth` | datetime? | |
| `Category` | int? | |
| `totalpax` | int? | |

### 1.2 `PaxCountryStatus` (physical table `PaxStatus`, disposition M)

Mapped by `VisaFusion.Data.Persistence.Entities.PaxCountryStatus`
(`VisaEntryDbContext.cs:183-207`, verified this session). Per-pax-per-country status
chain (BR-005). No legacy identity column — surrogate `Id` added (FR-003). **Proc
update key `(refno, PaxID, CountryID)` verified valid** against this shape
(GR-0004; `InitialCreate.cs:759-799`, `IX_PaxStatus_PaxID` at 896-897).

| Column | Type | Notes |
|--------|------|-------|
| `Id` | bigint identity PK | surrogate (no legacy identity column) |
| `refno` | int? | FK → `Entry.refno` |
| `PaxID` | int? | FK → `EntryPassenger.Id` |
| `CountryID` | int? | no target FK (open gap, SPEC-0004 data-model §4) |
| `subdate` / `coldate` / `colcheck` / `sentDate` | datetime? / nvarchar | |
| `category` / `entrytype` | int? | |
| `statusID` | int? | FK → `status.StatusID`; updated by `usp_RecordEntryStatusChange` (AC-004) |
| `remarks` | nvarchar | |
| `visafee` / `handlingfee` / `ddcharges` / `couriercharges` / `misccharges` / `total` / `VFSTTCharges` | decimal(19,4)? | fee columns |
| `entrydatetime` | datetime? | |

## 2. Audit/history tables written by `usp_RecordEntryStatusChange` (script 08)

### 2.1 `StatusHistory` (mapped by `StatusHistoryEntry`, `VisaEntryDbContext.cs:223-231`)

Append-only (SPEC-0004). Written by the proc on every status change (AC-004).

| Column | Type | Notes |
|--------|------|-------|
| `Id` | bigint identity PK | surrogate |
| `PaxID` | int | `@PaxID` |
| `Date` | datetime | `@ChangeDate` (defaults GETDATE()) |
| `CountryID` | int | `@CountryId` |
| `StatusID` | int | `@NewStatusId` |
| `Remarks` | nvarchar | `@Remarks` |
| `UpdatedBy` | nvarchar | **`{role}:{username}`** composed by the proc (GR-0004), e.g. `adm:jsmith` |

### 2.2 `bighistory` (mapped by `EntryAuditLog`, `VisaEntryDbContext.cs:246-253`)

Append-only (SPEC-0004). Written by the proc on every status change (AC-004).

| Column | Type | Notes |
|--------|------|-------|
| `bighistoryid` | bigint identity PK | |
| `refno` | int | `@Refno` |
| `agent` | int | entry's owning agent — **mechanical lookup** `SELECT agent FROM dbo.Mainentry` (GR-0004; verified column `agent` at `VisaEntryDbContext.cs:250`) |
| `Date` | datetime | `@ChangeDate` |
| `UpdatedBy` | nvarchar | `{role}:{username}` |
| `Remarks` | nvarchar | `@Remarks` |

## 3. Reference number allocation (script 01)

- **`dbo.RefnoSeq`** — SQL Server sequence, `NEXT VALUE FOR` with NO CACHE (per
  owner-supplied script 01:19), starts from current max in `Mainentry` + 1 computed at
  cutover (script TODO). BR-001: max+1 legacy semantics, gaps acceptable.
- **`dbo.usp_AllocateNextRefno`** — atomic next-refno allocation (script 01:48).
  `@NewRefno INT OUTPUT`. FR-004, AC-003.
- **`dbo.InvoiceNumberSeq`** / **`dbo.usp_AllocateInvoiceNumber`** (script 01:31,62) —
  Billing-gated (Risk #1), created per script but out of this feature's API scope
  (GR-0002).

## 4. `fn_IsEmbassyClosed` (script 02)

- **`dbo.fn_IsEmbassyClosed(@Date)`** → bit: 1 for holidays / weekly-off / Sunday,
  0 otherwise (script 02:26). **Read-only reporting/BI mirror** (FR-006, BR-003);
  authoritative transactional check lives in `VisaFusion.Core.HolidayService` (C#,
  implemented by this feature from the placeholder `HolidayService.cs:12`).

## 5. `usp_RecordEntryStatusChange` (script 08 — final, supersedes 06/07)

Signature (verified `scripts/08_finalize_entry_status_change_updatedby.sql:33-41`):

| Parameter | Type | Notes |
|-----------|------|-------|
| `@Refno` | BIGINT | entry refno (int→bigint widening, safe per GR-0004 type-width note) |
| `@PaxID` | BIGINT | passenger id |
| `@CountryId` | INT | country |
| `@NewStatusId` | INT | must exist in `dbo.status` (`StatusID`) |
| `@ActorUserId` | NVARCHAR(450) | **authenticated caller's `AspNetUsers.Id`** — never a formatted actor string (anti-spoofing, GR-0004) |
| `@Remarks` | NVARCHAR(500) = NULL | |
| `@ChangeDate` | DATETIME = NULL | defaults GETDATE() |
| `@NewStatusHistoryId` | BIGINT OUTPUT | `SCOPE_IDENTITY()` of the StatusHistory row |

Atomic behavior (AC-004): `XACT_ABORT ON`; `UPDATE dbo.PaxStatus SET StatusID` WHERE
`refno AND PaxID AND CountryID`; `INSERT dbo.StatusHistory`; `INSERT dbo.bighistory`;
one commit, rollback on any error. `UpdatedBy` composed from `AspNetUsers.UserName` +
highest-privilege role (`su > adm > emp > agt`, `AspNetUserRoles`/`AspNetRoles` join)
(verified `:60-89`).

## 6. `usp_ProvisionSuperUser` + `SuperUserProvisioningAudit` (script 06)

- **`dbo.SuperUserProvisioningAudit`** (script 06:150) — **the one genuinely new table
  in the whole plan**, signed off by owner (GR-0003 item 1). Key columns
  `NVARCHAR(450)` matching the actual Identity schema (GR-0003 item 3 / GR-0004):
  role Id = role name; user Ids = 32-char GUID strings (`Guid.NewGuid().ToString("N")`).
- **`dbo.usp_ProvisionSuperUser`** (script 06:161) — su-only (no `@Role` parameter),
  password passed **pre-hashed** (never plaintext, NFR-006/§12), refuses duplicate
  usernames (409), creates `su` user with `su`+`adm` roles, writes the audit row.
  Endpoint `POST /api/v1/admin/superusers` is **documented-only, deferred** (spec §15;
  `secured-write-routes.md` §3.1) — the proc is created per script, the route is NOT
  registered by this feature.

## 7. Out-of-API-scope objects (created per scripts, GR-0002)

- Script 03: `usp_Report_PendingList`, `usp_Report_DailyAgentStatus`,
  `usp_Report_TodayCollection` — back the StatusReportsController (separate module
  feature; clarify Q4).
- Script 04: `usp_Migrate_CleanseStatus508`, `usp_Migrate_QuarantineJunkDates` (+
  `DataQualityQuarantine_JunkDates` table, 04:79), `usp_Migrate_ReconcileOrphanAgents`
  — Phase 4 §7 cleansing tooling, `WhatIfOnly=1` default.
- Script 05: `LegacyEmailListArchive`, `LegacyChangeLogArchive`, PK/FK templates —
  Phase 4 §5/§16 normalization DDL.

## 8. Validation Rules (spec §17)

- Reference number: numeric, unique, monotonic (max+1; gaps permitted — BR-001).
- Entry must have ≥ 1 passenger (`EntryPassenger`) — enforced by
  `VisaFusion.Core.EntryService` (BR-005).
- Status free-form per legacy — any status code writable at any time, no transition
  validation (clarification Q3; BR-005).
- Bookable date: not holiday, not weekly-off, not Sunday — enforced transactionally by
  `HolidayService` (BR-003).
- Passenger data: required fields per legacy `entryDetails` schema.
- Super-user email unique; password policy 8+ chars, hashed (never plaintext).

## 9. State Transitions

None — status is free-form per legacy (clarification Q3). `usp_RecordEntryStatusChange`
records the change with audit trail but performs no transition validation.