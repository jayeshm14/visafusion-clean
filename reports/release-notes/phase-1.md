# VisaFusion Phase 1 Release Notes

**Date**: 2026-08-16
**Scope**: Phase 1 — core entry workflow (SPEC-0006): Entry aggregate hardening,
reference-number allocation, audited status change, bookable-date rule,
super-user provisioning proc, and the Entries module Web API under `/api/v1`.

---

## 1. What Phase 1 delivers

### Entry aggregate & RowVersion (US1, FR-001/002, BR-005, AC-002)
- `Entry` entity hardened with `RowVersion` (rowversion) — the optimistic
  concurrency token exposed as the ETag (AC-011).
- `EntryService` (`IEntryService` interface in `VisaFusion.Core`, implementation
  in `VisaFusion.Data` per deviation-log entry 1 — mirror of the SPEC-0005
  `SecurityGateService` precedent) enforces the ≥ 1-passenger invariant
  (BR-005), valid refno, and free-form status (no transition validation,
  clarification Q3).

### Reference-number allocation (US2, FR-003/004, BR-001, AC-003)
- `RefnoSeq` sequence + `usp_AllocateNextRefno` (script 01, applied verbatim —
  GR-0001) make the legacy max+1 allocation atomic; gaps acceptable, no
  duplicates/collisions under concurrent load (proven by the 50-parallel
  integration test).
- `EntryService.AllocateRefnoAsync` calls the proc parameterized and converts
  the `BIGINT` output to `int` for `Entry.Refno` (deviation-log entry 2).

### Audited status change (US3, FR-005, BR-002, AC-004)
- `usp_RecordEntryStatusChange` (script 08 — final, supersedes 06/07 per
  GR-0004) atomically updates `PaxStatus.statusID` and writes `StatusHistory` +
  `bighistory` in one transaction (`XACT_ABORT ON`).
- `@ActorUserId` is the authenticated caller's `AspNetUsers.Id` resolved
  server-side from the JWT `sub` claim — never a formatted actor string
  (anti-spoofing, GR-0004). The proc composes `UpdatedBy = {role}:{username}`
  with role precedence `su > adm > emp > agt`.

### Bookable-date rule (US4, FR-006, BR-003, AC-005)
- `HolidayService` (C#, `VisaFusion.Data` implementation of the shared Core
  interface) is the authoritative transactional holiday/weekly-off/Sunday
  check; `fn_IsEmbassyClosed` (script 02) is the read-only reporting/BI mirror.
  Parity proven by the unit + integration tests (1/1/1/0 for
  holiday/weekly-off/Sunday/normal).

### Super-user provisioning proc (US5, FR-007, BR-004, AC-006)
- `usp_ProvisionSuperUser` + the new `SuperUserProvisioningAudit` table
  (script 06, applied verbatim; the one genuinely new table in the plan,
  GR-0003 item 1). su-only, pre-hashed password, refuses duplicate usernames,
  creates the `su` user with `su`+`adm` roles, writes the audit row.
- `POST /api/v1/admin/superusers` remains a **documented-only deferred
  contract** (spec §15) — the route is NOT registered (404).

### Entries Web API (US6, FR-008/009, AC-007/008/011)
- Five endpoints under `/api/v1`, all gated by the Phase-0 `EntryOperations`
  policy (emp/adm/su):
  - `POST /api/v1/entries` — allocates refno, creates the aggregate, `201` + etag
  - `GET /api/v1/entries/{refno}` — aggregate read, `200` + etag
  - `PUT /api/v1/entries/{refno}` — `If-Match`/ETag optimistic concurrency,
    stale write → `409` (AC-011)
  - `POST /api/v1/entries/{refno}/status` — audited status change (US3)
  - `POST /api/v1/entries/{refno}/awb` — sent-AWB record (legacy
    `sendawbgo.asp` guard + dedupe preserved)
- Problem-details errors with correlation IDs; backs the legacy pages
  `makeEntry`, `insertEntry`, `editentry*`, `editdone`, `sendawbgo`
  (`complete_migration_plan.md` §5 line 189).

## 2. Test status (2026-08-16)

| Suite | Result |
|-------|--------|
| `tests/UnitTests` | 134/134 passed (incl. EntryAggregateTests, EntryPassengerValidationTests, RefnoAllocationTests, HolidayServiceTests) |
| `tests/FunctionalTests` | 135/135 passed (incl. EntriesRbacTests 5-role matrix, EntriesConcurrencyTests, EntriesErrorTests) |
| `tests/IntegrationTests` | 51/51 passed against a live SQL Server (RefnoAllocationTests 50-parallel, StatusChangeTests atomicity/rollback/RAISERROR paths, EmbassyClosedTests parity, SuperUserProvisioningTests) |

Build: `VisaFusion.sln` — 0 warnings / 0 errors.

> Note: the deviation-log entry 3 environmental block (net8.0 host on the .NET 9
> runtime, `PipeWriter.UnflushedBytes` incompatibility) is **resolved** — the
> .NET 8 runtime (8.0.20/8.0.29/8.0.30) is now installed and the full functional
> suite passes natively. One test-data defect found during the Phase 9
> verification pass was fixed: `EntriesRbacTests` used `NewStatusId = 2` (not a
> legacy status code) on the status success path; corrected to `101` (Dox
> Received, deepanalysis.md §4.4).

## 3. Decisions recorded (SPEC-0006)

- **Optimistic concurrency (Q1)**: `RowVersion` + `If-Match`/ETag on PUT; stale
  write → 409 (research.md §6).
- **No bulk entry endpoint (Q2)**: the §13 bulk line is removed — the legacy
  Entries pages have no bulk flow (research.md §7).
- **`UpdatedBy = {role}:{username}` (GR-0004)**: role captured at time of
  action with precedence `su > adm > emp > agt`; `@ActorUserId` anti-spoofing
  interface (research.md §4).
- **`usp_` prefix standardization (GR-0003 item 2)**: all stored procedures
  standardized to `usp_` per `library/09` §Naming.
- **`SuperUserProvisioningAudit` (GR-0003 item 1)**: the one genuinely new
  table, owner-signed; `NVARCHAR(450)` Identity keys (GR-0003 item 3).
- **Service placement (deviation-log entry 1)**: `EntryService`/`HolidayService`
  implementations in `VisaFusion.Data`, interfaces in `VisaFusion.Core` —
  mirror of the SPEC-0005 `SecurityGateService` precedent.

## 4. Known limitations / deferred

- `POST /api/v1/admin/superusers` is a documented-only deferred contract — the
  proc and audit table exist, the route is not registered (spec §15).
- Report/cleansing/normalization objects (scripts 03/04/05) are created per the
  scripts but are out of this feature's API scope (GR-0002) — they back the
  StatusReportsController and Phase 4 tooling.
- `InvoiceNumberSeq`/`usp_AllocateInvoiceNumber` (script 01) are Billing-gated
  (Risk #1) — created per script, not exposed.
- The `-- TODO: confirm column name` flags in the owner-supplied scripts are
  pre-cutover verification items (GR-0001 caveat); script 02's inferred names
  are documented as wrong for three of four references (research.md §11) — the
  C# `HolidayService` uses the verified names and the T019 parity test guards
  against drift.

## 5. Phase 1 exit criterion

"Data model migrated, stored procs/functions live, Entries API exposed under
`/api/v1` with Phase-0 policies" (`library/ExecutionPlan.md` Phase 1, items
4-6) — proven by the quickstart.md §3 validation scenarios and the automated
test suites above.