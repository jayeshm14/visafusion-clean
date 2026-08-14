# Feature Specification: Core Entry Workflow

**Identifier**: SPEC-0006
**Title**: Core Entry Workflow
**Status**: Draft
**Created**: 2026-08-13
**Category**: database
**Input**: User description: "Core entry workflow
4. Data model: migrate §3's 52-table disposition (M/M-RO/COND/ARCH), Mainentry→Entry aggregate, entryDetails→EntryPassenger, PaxStatus chain
5. Stored procs/functions from §15: RefnoSequence, usp_AllocateNextRefno, usp_RecordEntryStatusChange, fn_IsBookableDate, usp_ProvisionSuperUser
6. Web API layer per §5, one controller set per module, reusing Phase-0 authorization policies"

> This template is the VisaFusion override of the SpecKit `spec-template`.
> It is resolved first by the Spec Kit template stack (`.specify/templates/overrides/`)
> and MUST contain the 24 required sections defined in `library/03_SpecKit_SDD_Framework.md` §4.
> Do not remove or reorder the 24 numbered sections below.

## 1. Identifier

- **SPEC-0006**: Core Entry Workflow

## 2. Title

Core Entry Workflow — Data Model Migration, Stored Procedures, and Web API Layer

## 3. Objective

Deliver the core entry workflow for VisaFusion by migrating the legacy 52-table data model (per §3 disposition), implementing the stored procedures and functions named in Phase 1 of `library/ExecutionPlan.md` (see Gap Report GR-0001 for source definitions), and exposing a Web API layer with one controller set per module that reuses the Phase-0 authorization policies. This feature establishes the foundational data structures and business logic for visa entry processing.

## 4. Business Context

The legacy Classic ASP Visa system manages visa entry processing through a complex data model centered on `Mainentry` (the primary entry record), `entryDetails` (passenger details), and `PaxStatus` (status tracking chain). The modernization must preserve all production data and legacy business behavior while normalizing the schema into a clean domain model. The 52-table disposition from §3 classifies each table as Migrate (M), Migrate Read-Only (M-RO), Conditional (COND), Archive (ARCH), or Drop (DROP). The stored procedures named in Phase 1 of `library/ExecutionPlan.md` encapsulate critical business logic for reference number allocation, status changes, bookable date validation, and super-user provisioning. The Web API layer will expose these capabilities through a module-organized controller structure.

## 5. Scope

- Migrate the 52-table disposition from §3 into the target `VisaFusion` database schema (M / M-RO / COND / ARCH / DROP)
- Implement the `Mainentry` → `Entry` aggregate, `entryDetails` → `EntryPassenger`, and `PaxStatus` → `PaxCountryStatus` domain entities
- Implement stored procedures/functions per owner-supplied scripts in `scripts/` (01-06): `RefnoSeq`/`usp_AllocateNextRefno`, `fn_IsEmbassyClosed`, `usp_RecordEntryStatusChange`, `usp_ProvisionSuperUser`, plus report/cleansing/normalization objects (see Gap Reports GR-0001/GR-0002/GR-0003; procedure prefixes standardized to `usp_` per GR-0003 item 2)
- Create Web API controllers (one set per module) under `/api/v1` with Phase-0 authorization policies
- Preserve all production data; legacy `VisaEntry` database remains read-only
- Map all work to legacy pages per `@findings/modernization_plan.md` §6 and §13

## 6. Out of Scope

- Identity/RBAC (covered by SPEC-0005)
- URL rewrite and static assets (covered by SPEC-0005)
- Migration tooling commands (covered by SPEC-0004)
- Admin user-management and agent password-set routes (deferred per `contracts/secured-write-routes.md` §3)
- Business rule implementations beyond the stored procedures/functions listed in §9 (FR-003 through FR-007)
- UI/Razor Pages for entry workflow (separate feature)

## 7. Stakeholders

- Visa processing officers (end users of the entry workflow)
- System administrators (super-user provisioning)
- Migration team (data integrity validation)
- API consumers (internal modules, future integrations)

## 8. Legacy Mapping

Per `@findings/modernization_plan.md` §6 (module map) and §13 (legacy pages):
- Core entry workflow maps to legacy pages backing the Entries module: `makeEntry`, `insertEntry`, `editentry*`, `editdone`, `sendawbgo` (per `complete_migration_plan.md` §5 line 189); plus `Default.asp` (home) — exact per-page workflow mapping deferred to `/speckit.plan`
- `Mainentry` table → `Entry` aggregate (disposition M)
- `entryDetails` table → `EntryPassenger` entity (disposition M)
- `PaxStatus` table → `PaxCountryStatus` entity (disposition M)
- Stored procedures/functions are supplied by the owner in `scripts/` (01-06), run in order at cutover; canonical object names confirmed 2026-08-14 (`RefnoSeq`, `usp_AllocateNextRefno`, `fn_IsEmbassyClosed`, `usp_RecordEntryStatusChange`, `usp_ProvisionSuperUser`) — see Gap Reports GR-0001/GR-0002; all procedure prefixes standardized to `usp_` per GR-0003 item 2; the new `SuperUserProvisioningAudit` table signed off per GR-0003 item 1; `usp_ProvisionSuperUser` key types contradicted the real Identity schema and are corrected per GR-0003 item 3 / GR-0004
- Reference number generation logic from `RefnoSeq`/`usp_AllocateNextRefno` (per `scripts/01_sequences_and_allocation.sql`)

## 9. Functional Requirements

- **FR-001**: System MUST migrate all 52 tables per §3 disposition (M / M-RO / COND / ARCH / DROP) to the `VisaFusion` database
- **FR-002**: System MUST implement the `Entry` aggregate root with `EntryPassenger` child entities and the `PaxCountryStatus` chain entity
- **FR-003**: System MUST provide `RefnoSeq` sequence for deterministic reference number generation (T-SQL per owner-supplied script `scripts/01_sequences_and_allocation.sql`; GR-0001)
- **FR-004**: System MUST provide `usp_AllocateNextRefno` for atomic next-reference-number allocation (T-SQL per owner-supplied script `scripts/01_sequences_and_allocation.sql`; GR-0001; prefix standardized per GR-0003 item 2)
- **FR-005**: System MUST provide `usp_RecordEntryStatusChange` for audited status transitions, called explicitly by `VisaFusion.Core.EntryService` (not a trigger); atomically updates `PaxStatus.statusID` and writes `StatusHistory` + `bighistory` rows in one transaction (T-SQL per owner-supplied script `scripts/08_finalize_entry_status_change_updatedby.sql`, which supersedes files 06/07; GR-0002/GR-0004). `UpdatedBy` = `{role}:{username}` composed by the proc from the authenticated `@ActorUserId` (the caller passes the Identity user Id, never a formatted actor string — anti-spoofing per GR-0004)
- **FR-006**: System MUST provide `fn_IsEmbassyClosed` as the read-only reporting/BI mirror of the holiday/weekly-off/Sunday rule; the authoritative transactional check lives in `VisaFusion.Core.HolidayService` (T-SQL per owner-supplied script `scripts/02_fn_IsEmbassyClosed.sql`; GR-0001; confirmed intentional by owner 2026-08-14)
- **FR-007**: System MUST provide `usp_ProvisionSuperUser` for super-user account creation — dedicated su-only procedure (no `@Role` parameter), password passed pre-hashed, caller must enforce `SuperUserOnly` policy; also creates an audit row in the new `SuperUserProvisioningAudit` table (T-SQL per owner-supplied script `scripts/06_status_change_and_superuser_provisioning.sql`; GR-0002)
- **FR-008**: System MUST expose Web API endpoints under `/api/v1` organized by module (one controller set per module)
- **FR-009**: System MUST reuse Phase-0 authorization policies (10 role-based policies + the claim-based SuperUserOnly) for all write endpoints
- **FR-010**: System MUST preserve all production data; legacy `VisaEntry` database remains read-only
- **FR-011**: System MUST NOT drop any business tables (only `dtproperties` may be removed)

## 10. Business Rules

- **BR-001**: Reference numbers are allocated via legacy-compatible max+1 (next available) semantics, made atomic via `usp_AllocateNextRefno`; gaps are acceptable (clarification Q2, option A)
- **BR-002**: Entry status changes are audited via `usp_RecordEntryStatusChange` with timestamp, actor, and reason — atomic multi-table write (PaxStatus + StatusHistory + bighistory, one commit), no triggers (per owner-supplied `scripts/08_finalize_entry_status_change_updatedby.sql`, superseding file 06/07; GR-0004)
- **BR-003**: Bookable dates exclude holidays, weekly-off days, and Sundays; enforced transactionally by `VisaFusion.Core.HolidayService` (C#), with `fn_IsEmbassyClosed` as the read-only reporting/BI mirror (per owner-supplied `scripts/02_fn_IsEmbassyClosed.sql`)
- **BR-004**: Super-user provisioning requires explicit audit trail via the dedicated `usp_ProvisionSuperUser` and the new `SuperUserProvisioningAudit` table (per owner-supplied `scripts/06_status_change_and_superuser_provisioning.sql`)
- **BR-005**: Entry aggregate enforces invariants: at least one passenger, valid reference number (status is free-form per legacy — no transition validation, clarification Q3)
- **BR-006**: All business rules implemented once in `VisaFusion.Core` and shared by Web UI and API (Constitution §Engineering Process)

## 11. Non-functional Requirements

- **NFR-001**: Data migration must be idempotent and reversible where practical (Constitution Principle III)
- **NFR-002**: Migration must validate row counts and checksums before and after (SPEC-0004 validation)
- **NFR-003**: API response time for entry operations < 500ms under normal load
- **NFR-004**: Stored procedures must execute within 100ms for single-row operations
- **NFR-005**: Zero data loss during migration; all production rows preserved
- **NFR-006**: All errors and audit events carry a correlation ID; no password material in any log (Constitution Principle V)

## 12. Security

- All write endpoints require authentication and authorization (Phase-0 policies)
- No plaintext passwords in stored procedures or API
- No query-string identity; all identity via claims/JWT
- No string-concatenated SQL in stored procedures or EF Core queries
- Super-user provisioning endpoint gated by `SuperUserOnly` policy
- Legacy `connection.asp` backdoor removed (already done in SPEC-0005)

## 13. Performance

- Reference number allocation (`usp_AllocateNextRefno`) < 50ms
- Status change recording (`usp_RecordEntryStatusChange`) < 100ms
- Bookable date check (`fn_IsEmbassyClosed` / `HolidayService`) < 10ms
- API list endpoints support pagination (default 50, max 200)
- Data volume baseline for sizing and load tests (verified in findings): `Mainentry` ≈ 271,724 rows, `entryDetails` ≈ 312,655, `bighistory` ≈ 1.4M rows for history reads (`modernization_plan.md` §4.6; `exiting_architecture.md` §Table inventory) — NFR-003 "normal load" anchored to these figures

## 14. UI Requirements

- Not in scope for this feature (separate UI feature)
- API contracts defined here will drive future Razor Pages

## 15. API Contracts

Per `library/complete_migration_plan.md` §5 (line 189), one controller set per module under `/api/v1`. This feature delivers the **Entries** module controller set (backing legacy pages: `makeEntry`, `insertEntry`, `editentry*`, `editdone`, `sendawbgo`):

- **POST /api/v1/entries** — Create entry (requires `EntryOperations` policy)
- **GET /api/v1/entries/{refno}** — Get entry by reference number
- **PUT /api/v1/entries/{refno}** — Update entry (requires `EntryOperations` policy; optimistic concurrency — `If-Match` with current ETag required, stale write → 409; clarify session 2026-08-14 Q1)
- **POST /api/v1/entries/{refno}/status** — Change entry status (requires `EntryOperations` policy)
- **POST /api/v1/entries/{refno}/awb** — Record sent-AWB (requires `EntryOperations` policy)

Deferred (documented-only, per `contracts/secured-write-routes.md` §3.1 — NOT implemented in this feature):
- **POST /api/v1/admin/superusers** — Provision super-user (requires `SuperUserOnly` policy; backing proc `usp_ProvisionSuperUser`)

All endpoints return problem-details JSON on error (Phase-0 exception handling).

## 16. Database Changes

- Create `Entry` entity (mapped via `ToTable` to physical table `Mainentry` — legacy name preserved so owner-supplied procs run verbatim; migration lines 635, 1070)
- Add `RowVersion` (rowversion) column to `Entry` for optimistic concurrency (If-Match on PUT; clarify session 2026-08-14 Q1)
- Create `EntryPassenger` entity (mapped via `ToTable` to physical table `entryDetails` — legacy name preserved; migration lines 735, 1058)
- Create `PaxCountryStatus` entity (mapped via `ToTable` to physical table `PaxStatus` — legacy name preserved; migration lines 759, 1010)
- Create the remaining tables per §3 disposition (M / M-RO / COND / ARCH / DROP; DROP applies only to `Results`, `country`, `hits`, `adcount`, `dtproperties`)
- Create sequence `RefnoSeq` for reference number generation (per `scripts/01_sequences_and_allocation.sql`)
- Create sequence `InvoiceNumberSeq` + `usp_AllocateInvoiceNumber` (per `scripts/01_sequences_and_allocation.sql`; Billing-gated, Risk #1)
- Create stored procedure: `usp_AllocateNextRefno` (per `scripts/01_sequences_and_allocation.sql`)
- Create function: `fn_IsEmbassyClosed` (read-only reporting mirror; per `scripts/02_fn_IsEmbassyClosed.sql`)
- Create stored procedures: `usp_RecordEntryStatusChange` (per `scripts/08_finalize_entry_status_change_updatedby.sql`), `usp_ProvisionSuperUser` (per `scripts/06_status_change_and_superuser_provisioning.sql`)
- Create new audit table: `SuperUserProvisioningAudit` (per `scripts/06_status_change_and_superuser_provisioning.sql`) — **the one genuinely new table in the whole plan, not in the 52-table inventory; signed off by owner per GR-0003 item 1; key columns `NVARCHAR(450)` matching the actual Identity schema (GR-0003 item 3 / GR-0004)**
- Create report procedures: `usp_Report_PendingList`, `usp_Report_DailyAgentStatus`, `usp_Report_TodayCollection` (per `scripts/03_report_procedures.sql`; back StatusReportsController — **out of this feature's API scope per clarify Q4, see Gap Report GR-0002**)
- Create cleansing procedures: `usp_Migrate_CleanseStatus508`, `usp_Migrate_QuarantineJunkDates`, `usp_Migrate_ReconcileOrphanAgents` (per `scripts/04_migration_cleansing_procedures.sql`; Phase 4 §7 tooling, WhatIfOnly=1 default)
- Create normalization DDL: `LegacyEmailListArchive`, `LegacyChangeLogArchive`, PK/FK templates (per `scripts/05_normalization_ddl.sql`; Phase 4 §5/§16)
- Add indexes for common query patterns (refno, status, date ranges)
- All migrations reversible where practical; `dtproperties` only table that may be dropped

## 17. Validation Rules

- Reference number format: numeric, unique, monotonic (max+1 allocation; gaps permitted per clarification Q2)
- Entry must have at least one passenger (`EntryPassenger`)
- Status is free-form per legacy (any status code writable at any time; no transition validation — clarification Q3)
- Bookable date: not holiday, not weekly-off, not Sunday
- Passenger data: required fields per legacy `entryDetails` schema
- Super-user email unique, password meets policy (8+ chars, hashed)

## 18. Error Handling

- Duplicate reference number → 409 Conflict (problem-details)
- Stale write on PUT (If-Match ETag mismatch) → 409 Conflict (problem-details; clarify session 2026-08-14 Q1)
- Nonexistent status code → 400 Bad Request (problem-details with valid taxonomy reference)
- Non-bookable date → 400 Bad Request (problem-details with reason)
- Super-user already exists → 409 Conflict
- Not found → 404 Not Found
- Unauthorized → 401 Unauthorized (problem-details)
- Forbidden → 403 Forbidden (problem-details)
- All errors logged with correlation ID (NFR-006)

## 19. Audit Requirements

- All entry create/update/delete operations audited (subject, endpoint, outcome)
- Reference number allocations audited
- Status changes audited via `usp_RecordEntryStatusChange` (timestamp, actor, old/new status, reason) — `StatusHistory` + `bighistory`, one transaction
- Super-user provisioning audited via `usp_ProvisionSuperUser` + the dedicated `SuperUserProvisioningAudit` table (new table, GR-0003)
- No password material in any audit log (NFR-006, Constitution Principle V)

## 20. Acceptance Criteria

- **AC-001**: All 52 tables migrated per §3 disposition (M / M-RO / COND / ARCH / DROP); row counts and checksums match legacy `VisaEntry`
- **AC-002**: `Entry` aggregate with `EntryPassenger` and `PaxCountryStatus` chain persists and retrieves correctly
- **AC-003**: `usp_AllocateNextRefno` returns unique, monotonic max+1 values that are atomic under concurrent load (gaps permitted; no duplicates, no collisions) (clarification Q2, option A)
- **AC-004**: `usp_RecordEntryStatusChange` atomically updates `PaxStatus.statusID` and writes both `StatusHistory` and `bighistory` rows with correct timestamp, actor, old/new status, and reason (one commit; rollback on any error) (per `scripts/08_finalize_entry_status_change_updatedby.sql`; GR-0004)
- **AC-005**: `fn_IsEmbassyClosed` returns 1 for holidays, weekly-off, Sundays; 0 otherwise; and `HolidayService` (C#) enforces the same rule transactionally
- **AC-006**: `usp_ProvisionSuperUser` creates an `su` user with `su`+`adm` roles, rejects non-su callers, refuses duplicate usernames, and writes the `SuperUserProvisioningAudit` row; password is never passed or stored in plaintext (per `scripts/06_status_change_and_superuser_provisioning.sql`)
- **AC-007**: All API endpoints return correct status codes and problem-details on error
- **AC-011**: `PUT /api/v1/entries/{refno}` rejects stale writes via If-Match (ETag from `Entry.RowVersion`) with 409 Conflict; a fresh ETag succeeds (clarify session 2026-08-14 Q1)
- **AC-008**: All write endpoints enforce Phase-0 authorization policies (401/403/501 as appropriate)
- **AC-009**: Zero data loss; legacy `VisaEntry` database unchanged and read-only
- **AC-010**: Migration scripts are idempotent and reversible (except `dtproperties`)

## 21. Risks

- **Risk 1**: Data migration complexity — 52 tables with mixed dispositions (M / M-RO / COND / ARCH / DROP) may have hidden dependencies. *Mitigation*: Run validation suite (SPEC-0004) before/after; stage migration by disposition.
- **Risk 2**: Stored procedure behavior divergence — legacy T-SQL may have undocumented edge cases. *Mitigation*: Golden-file testing against legacy outputs; Gap Report for ambiguities.
- **Risk 3**: Reference number concurrency — `usp_AllocateNextRefno` must be atomic under load. *Mitigation*: `NEXT VALUE FOR dbo.RefnoSeq` (NO CACHE) per owner-supplied script; stress test.
- **Risk 4**: Status chain integrity — `PaxStatus` chain must remain consistent. *Mitigation*: Database constraints + aggregate root validation in `VisaFusion.Core`.
- **Risk 5**: Authorization policy misalignment — Phase-0 policies may not cover all entry workflow actions. *Mitigation*: Map each endpoint to §4.2 matrix; extend policies if needed (ADR).

## 22. Dependencies

- SPEC-0003 (Solution scaffold) — complete
- SPEC-0004 (Data model migration tooling) — complete
- SPEC-0005 (Identity/RBAC/Phase-0 policies) — complete
- `VisaFusion.Core` shared business rules library
- SQL Server instance with `VisaFusion` database
- Legacy `VisaEntry` database (read-only access for migration)

## 23. Test Scenarios

- **Unit**: `Entry` aggregate invariants, `EntryPassenger` validation, free-form status recording (no transition validation), `HolidayService`/`fn_IsEmbassyClosed` rule parity, reference number allocation
- **Integration**: Stored procedure execution against real SQL Server, migration script idempotency, checksum validation
- **API**: All endpoints with 5-role matrix (anonymous→401, wrong role→403, correct role→200/201/501), problem-details format, optimistic-concurrency test (stale If-Match → 409, fresh ETag → 200; AC-011)
- **Migration**: Row count parity, checksum parity, `dtproperties` only dropped, legacy `VisaEntry` untouched
- **Regression**: Legacy page behavior parity for entry workflow (where applicable per migration plan §10)

## 24. Traceability Matrix

| Requirement | Architecture | Domain | Database | API | UI | Test | Migration |
|-------------|--------------|--------|----------|-----|----|------|-----------|
| FR-001      |              |        |          |     |    |      |           |
| FR-002      |              |        |          |     |    |      |           |
| FR-003      |              |        |          |     |    |      |           |
| FR-004      |              |        |          |     |    |      |           |
| FR-005      |              |        |          |     |    |      |           |
| FR-006      |              |        |          |     |    |      |           |
| FR-007      |              |        |          |     |    |      |           |
| FR-008      |              |        |          |     |    |      |           |
| FR-009      |              |        |          |     |    |      |           |
| FR-010      |              |        |          |     |    |      |           |
| FR-011      |              |        |          |     |    |      |           |
| AC-011      |              |        |          |     |    |      |           |

## Assumptions

- The §3 52-table disposition is documented in `library/complete_migration_plan.md` §3 (verified 2026-08-13; legend includes M / M-RO / COND / ARCH / DROP)
- The six owner-supplied T-SQL scripts are stored in `specs/006-core-entry-workflow/scripts/` (01-06, run in order at cutover). Canonical object names confirmed by owner 2026-08-14: `RefnoSeq`, `usp_AllocateNextRefno`, `fn_IsEmbassyClosed`, `usp_RecordEntryStatusChange`, `usp_ProvisionSuperUser` (see Gap Reports GR-0001/GR-0002; all procedure prefixes standardized to `usp_` per GR-0003 item 2)
- `fn_IsEmbassyClosed` is intentionally a read-only reporting/BI mirror; the authoritative holiday/weekly-off/Sunday check lives in `VisaFusion.Core.HolidayService` (owner-confirmed semantic design, 2026-08-14)
- `usp_ProvisionSuperUser` targets the actual VisaFusion Identity schema: `nvarchar(450)` string keys (`AspNetUsers.Id`/`AspNetRoles.Id`/`AspNetUserRoles.UserId`/`RoleId`), role Id = role name, user Ids as 32-char GUID strings (`Guid.NewGuid().ToString("N")`); the `su`/`adm` role seed is confirmed present (verified against `IdentityImporter.cs` `EnsureIdentitySchemaAsync` and `VisaFusionIdentityDbContext.cs`; GR-0003 item 3 / GR-0004)
- Legacy `VisaEntry` database is accessible for migration reads
- Phase-0 authorization policies (10 role-based + SuperUserOnly) are sufficient for entry workflow; any gaps will be addressed via ADR
- The holiday/weekly-off/Sunday rule is enforced transactionally by `VisaFusion.Core.HolidayService` (C#); `fn_IsEmbassyClosed` is a read-only reporting/BI mirror kept in sync manually (per owner-supplied `scripts/02_fn_IsEmbassyClosed.sql`)
- Reference number sequence starts from current max in `Mainentry` + 1 (computed at cutover, per `scripts/01_sequences_and_allocation.sql` TODO)
- Super-user provisioning is an admin-only operation, not self-service
- API versioning follows `/api/v1` base path; no breaking changes within v1
- All business rules live in `VisaFusion.Core` per Constitution Engineering Process

## Clarifications

### Session 2026-08-14

- Q: When two users edit the same entry concurrently, should the update endpoint reject the stale write or let the last write win? → A: **A — optimistic concurrency: `RowVersion` on `Entry`; PUT requires `If-Match`; stale write → 409 Conflict.**
- Q: The spec's §13 says "Bulk entry operations support batch sizes up to 1000", but §15 defines no bulk entry endpoint and the legacy Entries pages have no bulk-entry flow — should that line be removed, kept as a future constraint, or does a bulk entry endpoint belong in scope? → A: **A — remove the §13 bulk line; no bulk entry endpoint in this feature.**

### Session 2026-08-13

- Q: Must the new reference-number allocation preserve the legacy behavior of allowing gaps and non-sequential refnos, or is a strict gap-free sequence a requirement? → A: **A — legacy-compatible allocation: max+1 (next available) semantics made atomic; gaps are acceptable.**
- Q: Should the new system enforce a strict allowed-transition state machine for `PaxCountryStatus`, or preserve the legacy free-form status-setting behavior? → A: **A — preserve legacy free-form status setting; no transition validation.**
- Q: For this feature, should the Web API layer deliver only the Entries module controller set, or all 12 controller areas listed in §5? → A: **A — Entries module controller set only; other areas belong to their own module features.**
- Q: Where should the implementation of the five named procedures (`RefnoSequence`, `usp_AllocateNextRefno`, `usp_RecordEntryStatusChange`, `fn_IsBookableDate`, `usp_ProvisionSuperUser`) actually come from? → A: **B — owner supplies the five T-SQL scripts as artifacts; recreate them verbatim.** (Supplied 2026-08-14 in `specs/006-core-entry-workflow/scripts/`; object names differ from the ExecutionPlan names and two objects are missing — see Gap Report GR-0002; **both items RESOLVED 2026-08-14 per GR-0002**.)
- Q: Exact list of 52 tables and their dispositions (M/M-RO/COND/ARCH) from §3 → A: **Resolved** — the full 52-table disposition is `library/complete_migration_plan.md` §3 (lines 69-128), including the DROP disposition (`Results`, `country`, `hits`, `adcount`, `dtproperties`). Target entity names verified in `src/VisaFusion.Migration/Catalog/TableCatalog.cs` (`Mainentry`→`Entry` line 114, `entryDetails`→`EntryPassenger` line 117, `PaxStatus`→`PaxCountryStatus` line 118).
- Q: Exact legacy page mappings for entry workflow from @findings/modernization_plan.md §13 → A: **Resolved** — legacy page mappings per `complete_migration_plan.md` §5 API table (line 189): EntriesController backed by `makeEntry`, `insertEntry`, `editentry*`, `editdone`, `sendawbgo`. Module map per constitution §II (`modernization_plan.md` §6); file inventory appendix is §13.
- Q: Complete T-SQL definitions of the 5 stored procedures/functions from §15 → A: **Resolved (session 2026-08-13, clarify Q1 → option B)** — "§15" does not exist in any repo document (complete_migration_plan.md ends at §12; modernization_plan.md at §13). The five object names appear only in `library/ExecutionPlan.md` Phase 1 item 5. No T-SQL exists in `database.sql`, any `.asp` file, or any findings doc. Owner will supply the five T-SQL scripts as repo artifacts; implementation recreates them verbatim (Gap Report GR-0001, status RESOLVED).
- Q: Holiday/weekly-off calendar data source for `fn_IsBookableDate` → A: **Resolved** — §3 disposition row 97 (`holidaylist` → `Holiday`, disposition M) and row 98 (`weeklyoff` → `WeeklyOff`, disposition M) establish the calendar tables; business rule is defined once in `VisaFusion.Core` per constitution. Exact legacy function behavior still to be extracted from legacy code at implement time.
- Q: Super-user provisioning flow — API only or also UI? → A: **Resolved** — `POST /api/v1/admin/superusers` is a documented-only deferred contract per `contracts/secured-write-routes.md` §3.1 (NOT implemented in this feature). This feature implements the `usp_ProvisionSuperUser` stored proc and registers the route as deferred.

### Gap Report GR-0001 — Stored proc/function source definitions

- **Status**: **RESOLVED (2026-08-14)** — owner supplied six T-SQL scripts, stored in `specs/006-core-entry-workflow/scripts/` (01-06, run in order at cutover). Implementation recreates them verbatim; no behavior may be invented. *(File 07 `07_gr0004_corrected_entry_status_change.sql` superseded the file-06 `usp_RecordEntryStatusChange` with verified column mappings; file 08 `08_finalize_entry_status_change_updatedby.sql` finalized the `UpdatedBy` format and superseded file 07. The script set is now 01-08, run in order at cutover.)*
- **Artifacts**: `01_sequences_and_allocation.sql` (RefnoSeq, InvoiceNumberSeq, sp_AllocateNextRefno, sp_AllocateInvoiceNumber) · `02_fn_IsEmbassyClosed.sql` (fn_IsEmbassyClosed, read-only mirror) · `03_report_procedures.sql` (sp_Report_PendingList, sp_Report_DailyAgentStatus, sp_Report_TodayCollection) · `04_migration_cleansing_procedures.sql` (sp_Migrate_CleanseStatus508, sp_Migrate_QuarantineJunkDates, sp_Migrate_ReconcileOrphanAgents) · `05_normalization_ddl.sql` (LegacyEmailListArchive, LegacyChangeLogArchive, PK/FK templates). *(Names as-supplied; all procedure prefixes later standardized to `usp_` per GR-0003 item 2.)*
- **Owner caveat (carried forward)**: every column name in the scripts is inferred from the documented naming convention and marked `-- TODO: confirm column name`; must be verified against the live schema (`sp_help` / `INFORMATION_SCHEMA.COLUMNS`) before execution. This is a pre-cutover verification task, not a spec blocker.
- **Evidence**: The five names appear only in `library/ExecutionPlan.md:9`. Absent from `database.sql` (no CREATE PROC/FUNCTION/SEQUENCE matches), all 585 legacy `.asp` files, `findings/modernization_plan.md`, `findings/deepanalysis.md`, and `findings/exiting_architecture.md`. No document in the repo has a §15.
- **Fallback**: If the owner-supplied scripts do not exist in the live database either, they must be re-derived from the legacy page behavior documented in `modernization_plan.md` §6.1/§6.2 with a follow-up Gap Report — never guessed.

### Gap Report GR-0002 — Supplied artifacts vs spec-named objects (contradiction)

- **Status**: **RESOLVED (2026-08-14)** — owner closed both blocking items:
  - **(a) Renamed mapping confirmed canonical**: `RefnoSeq`/`sp_AllocateNextRefno`/`fn_IsEmbassyClosed` are correct as-supplied. The `fn_IsEmbassyClosed` semantic split (read-only reporting mirror; authoritative transactional check in C# `HolidayService`) is intentional, not a discrepancy — confirmed working as designed.
  - **(b) Missing procs supplied**: `usp_RecordEntryStatusChange` and `usp_ProvisionSuperUser` delivered in `scripts/06_status_change_and_superuser_provisioning.sql`.
- **Historical record (kept for traceability)**: the scripts originally differed from the ExecutionPlan names (`RefnoSequence` → `RefnoSeq`, `usp_AllocateNextRefno` → `sp_AllocateNextRefno`, `fn_IsBookableDate` → `fn_IsEmbassyClosed`); the two procs were initially absent.
- **Out-of-scope extras supplied** (not part of this feature's five; flagged for planning, unchanged):
  - `InvoiceNumberSeq`/`sp_AllocateInvoiceNumber` (01) — Billing-gated (Risk #1), not Phase 1
  - `sp_Report_PendingList`/`sp_Report_DailyAgentStatus`/`sp_Report_TodayCollection` (03) — back `StatusReportsController`, which clarify Q4 scoped OUT of this feature
  - Cleansing procs (04) and normalization DDL (05) — Phase 4 §7/§5/§16 tooling, not Phase 1
- **Loose end carried to GR-0003**: mixed `sp_`/`usp_` prefix convention across the six scripts (01-04 `sp_`, 06 `usp_`) — a real standardization decision the owner explicitly declined to make silently on the spec's behalf.

### Gap Report GR-0003 — New table + prefix standardization + Identity assumptions (owner sign-off)

- **Status**: **RESOLVED (2026-08-14)** — all three items closed by owner instruction ("resolve gr 0003 gaps"). Item 3's verification surfaced a further contradiction in `usp_RecordEntryStatusChange` → new Gap Report GR-0004.
- **1. `SuperUserProvisioningAudit` is a genuinely new table** — **SIGNED OFF (2026-08-14)** by owner. Kept in scope. It exists solely to close CRITICAL finding 2.2 (self-registration → SU escalation) with a permanent, separate audit record; the one table added rather than migrated/consolidated in the entire plan.
- **2. Prefix standardization**: **RESOLVED — all stored procedures standardized to `usp_`** per the repo standard (`library/09_SQLServer_Data_Engineering.md` §Naming: "`usp_` for stored procedures"), matching the ExecutionPlan names and the owner's own `usp_` naming for the two new procs. Applied to scripts 01/03/04/05 (`sp_AllocateNextRefno`→`usp_AllocateNextRefno`, `sp_AllocateInvoiceNumber`→`usp_AllocateInvoiceNumber`, `sp_Report_*`→`usp_Report_*`, `sp_Migrate_*`→`usp_Migrate_*`). Script 06 already used `usp_`. Canonical names updated throughout this spec.
- **3. Identity schema assumptions in `usp_ProvisionSuperUser`**: **VERIFIED (2026-08-14)** against the actual Identity schema:
  - **Role seed: CONFIRMED** — `IdentityImporter.cs:174-179` seeds `su`/`adm`/`emp`/`agt`/`guest` with role Id = role name.
  - **Key type: CONTRADICTED and CORRECTED** — the supplied draft used `UNIQUEIDENTIFIER`; the actual schema uses `nvarchar(450)` string keys (`IdentityImporter.cs:149,169,181`; `VisaFusionIdentityDbContext.cs:16` `IdentityDbContext<..., string>`; user Ids = `Guid.NewGuid().ToString("N")` 32-char strings, `IdentityImporter.cs:245`). Script 06 corrected: `@ProvisionedByUserId`/`@NewUserId` → `NVARCHAR(450)`, role lookups → `NVARCHAR(450)` (role Id = role name), `@NewUserId` generated as 32-char GUID string, `SuperUserProvisioningAudit` key columns → `NVARCHAR(450)`. See GR-0004 for the full record.
- **Carried forward (all scripts)**: every `-- TODO: confirm column name` must be verified against live schema (`sp_help` / `INFORMATION_SCHEMA.COLUMNS`) before execution — pre-cutover verification task.

### Gap Report GR-0004 — `usp_RecordEntryStatusChange` column names contradict the actual target schema

- **Status**: **RESOLVED (2026-08-14)** — owner decision on `UpdatedBy` format received; final proc in `scripts/08_finalize_entry_status_change_updatedby.sql` (supersedes file 07). All three mechanical fixes from file 07 carried forward and re-verified; two regressions in the file-08 draft caught and corrected this session (see below).
- **`UpdatedBy` format decision (owner, 2026-08-14)**: `{role}:{username}` — e.g. `adm:jsmith`, `su:jsmith`, `emp:jsmith`, `agt:jsmith` — using the lowercase role codes already established system-wide (`su`/`adm`/`emp`/`agt`), username from `AspNetUsers.UserName`. Rationale: audit must answer "who, in what capacity, at that moment"; role captured at time of action (point-in-time snapshot, not live join); consistent with legacy `session("priv")` access-control concept.
- **Anti-spoofing change (owner, part of the decision)**: the caller no longer passes a pre-formatted `@ActorIdentifier` string. The proc takes the authenticated user's real Identity id as `@ActorUserId` (resolved server-side from auth claims, unforgeable by the API layer) and composes `role:username` itself — same defense-in-depth pattern as `usp_ProvisionSuperUser`. **Interface contract change for `VisaFusion.Core.EntryService`**: pass the authenticated `AspNetUsers.Id` (string) as `@ActorUserId`; do NOT pass a formatted actor string.
- **Role precedence (owner)**: when a user holds multiple roles (e.g. an `su` also holds `adm` per the dual-role assignment in `usp_ProvisionSuperUser`), the label uses the highest-privilege role: `su > adm > emp > agt`. Implemented via `ORDER BY CASE r.Name WHEN 'su' THEN 1 ... ELSE 5 END` over `AspNetUserRoles`/`AspNetRoles`.
- **Regressions in the file-08 draft, caught and corrected this session**:
  - `@ActorUserId UNIQUEIDENTIFIER` → **`NVARCHAR(450)`**: the actual Identity schema uses nvarchar(450) string keys (`AspNetUsers.Id`; `IdentityImporter.cs:149`; `VisaFusionIdentityDbContext.cs:16`), user Ids are `Guid.NewGuid().ToString("N")` 32-char strings (`IdentityImporter.cs:245`). Same fix already applied to `usp_ProvisionSuperUser` in file 06 (GR-0003 item 3). `RAISERROR %s` also requires a string argument.
  - `SELECT agentid FROM dbo.Mainentry` → **`SELECT agent FROM dbo.Mainentry`**: `Mainentry`'s owning-agent FK column is `agent` (int, FK→`agents.agentsID`, migration lines 642, 677-681). This regressed the correction already applied to file 07.
- **`PaxStatus` verification — CONFIRMED (this session, closes the owner's flagged item)**: `PaxStatus` has `Id` (bigint PK), `refno` (int, FK→Mainentry), `PaxID` (int), `CountryID` (int), `statusID` (int, FK→status) — migration lines 759-799; `IX_PaxStatus_PaxID` index at lines 896-897. The proc's `UPDATE ... WHERE refno AND PaxID AND CountryID` clause is valid. The "STILL OPEN" header note in the file-08 draft is resolved.
- **Type-width note (non-blocking)**: `@Refno`/`@PaxID` are `BIGINT` while the actual `refno`/`PaxID`/`CountryID`/`statusID` columns are `INT` — int→bigint widening is safe; left as-is per the owner's file 06 convention.
- **Fallback**: if the legacy `StatusHistory`/`bighistory` shapes differ from the EF migration, the migration itself must be reconciled first (SPEC-0004 scope).