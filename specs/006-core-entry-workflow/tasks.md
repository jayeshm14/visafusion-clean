# Tasks: Core Entry Workflow (SPEC-0006)

**Input**: Design documents from `/specs/006-core-entry-workflow/`

**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/entries-api.md

**Tests**: The spec explicitly requests automated tests — §20 Acceptance Criteria (AC-001..AC-011), §23 Test Scenarios (Unit/Integration/API/Migration/Regression), and the Constitution (Principle V: every implementation must have automated tests). Test tasks are therefore included per story and MUST be written FIRST and fail before implementation (TDD per the repo's SPEC-0005 precedent).

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- Solution root: repository root
- Source: `src/` per plan.md §Project Structure (seven-project layout from SPEC-0003/0004)
- Tests: `tests/UnitTests`, `tests/FunctionalTests`, `tests/IntegrationTests` (existing three test projects, plan.md §Technical Context)
- Owner-supplied T-SQL: `specs/006-core-entry-workflow/scripts/` (01-08, applied verbatim at cutover)

**User stories (from spec §5 scope delta + FRs, priority order):**
- **US1** Entry aggregate & RowVersion (FR-001/002, BR-005, AC-002) — P1, MVP
- **US2** Reference number allocation (FR-003/004, BR-001, AC-003) — P1
- **US3** Status change recording (FR-005, BR-002, AC-004) — P1
- **US4** Bookable-date rule (FR-006, BR-003, AC-005) — P1
- **US5** Super-user provisioning proc (FR-007, BR-004, AC-006) — P2
- **US6** Entries Web API (FR-008/009, AC-007/008/011) — P2

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Re-verify the SPEC-0003/0004/0005 baseline the feature builds on (schema, entities, scripts already exist — no project initialization is needed) and confirm the branch is clean.

- [ ] T001 Build the full solution and boot `VisaFusion.Web` with no external services beyond SQL Server (re-verifies the SPEC-0004 38-entity schema compiles; `dotnet build VisaFusion.sln`)
- [ ] T002 [P] Verify the owner-supplied scripts 01-08 exist in `specs/006-core-entry-workflow/scripts/` and record the canonical object-name inventory (`RefnoSeq`, `usp_AllocateNextRefno`, `fn_IsEmbassyClosed`, `usp_RecordEntryStatusChange`, `usp_ProvisionSuperUser` + the report/cleansing/normalization objects; script 08 supersedes 06/07 per GR-0004) in `specs/006-core-entry-workflow/data-model.md`
- [ ] T003 [P] Verify the EF entity→table mappings the procs depend on (`Entry`→`Mainentry`, `EntryPassenger`→`entryDetails`, `PaxCountryStatus`→`PaxStatus`, `StatusHistoryEntry`→`StatusHistory`, `EntryAuditLog`→`bighistory` at `src/VisaFusion.Data/Persistence/VisaEntryDbContext.cs` lines 111/163/183/223/246) and confirm no entity changes are needed beyond `Entry.RowVersion`

**Checkpoint**: Baseline verified — Phase 2 can start.

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before the user stories that depend on it.

**⚠️ CRITICAL**: The pre-cutover column verification (T004) blocks ALL script-application tasks (T013, T016, T021, T023); the Entries contracts (T005) block US6; `Entry.RowVersion` (T006) blocks US1 and US6.

- [ ] T004 [P] Pre-cutover column verification (GR-0001 caveat): enumerate every `-- TODO: confirm column name` in `specs/006-core-entry-workflow/scripts/01-08`, verify each against the live schema (`sp_help` / `INFORMATION_SCHEMA.COLUMNS` on the target `VisaFusion` database), and record the verification results in the feature docs — pre-cutover verification task, not a spec blocker. ALSO verify read-access to the legacy `VisaEntry` database (`SELECT TOP 1` against each §3 disposition table; CHK049)
- [ ] T005 [P] Create the Entries API contract DTOs in `src/VisaFusion.Api/Contracts/` (reuse the existing `ApiError.cs`; contracts/entries-api.md): `CreateEntryRequest.cs`, `EntryResponse.cs` (incl. `etag` from RowVersion), `UpdateEntryRequest.cs`, `ChangeEntryStatusRequest.cs`, `RecordAwbRequest.cs`
- [ ] T006 Add `RowVersion` (rowversion) property to `Entry` in `src/VisaFusion.Data/Persistence/Entities/Entry.cs` and configure `IsRowVersion()` in `src/VisaFusion.Data/Persistence/VisaEntryDbContext.cs` (spec §16; AC-011 optimistic concurrency; blocks US1 AC-002 and US6 PUT)

**Checkpoint**: Foundation ready — user story implementation can now begin (US2-US5 in parallel once T004 completes; US5's T023 script application runs before US3's T016 — script 08 supersedes script 06's status-change proc).

---

## Phase 3: User Story 1 - Entry Aggregate & RowVersion (Priority: P1) 🎯 MVP

**Goal**: `Entry` aggregate with ≥ 1 passenger invariant (BR-005), valid refno, and free-form status (no transition validation — clarification Q3); `Entry.RowVersion` provides the concurrency token used by US6 (AC-011). The 52-table schema, entities, and mappings already exist (SPEC-0004) — this story hardens the aggregate and its service (FR-001/002, AC-002).

**Independent Test**: Unit tests assert the aggregate invariants (rejects zero passengers, rejects missing/duplicate refno, accepts any status code — no transition validation) and that `Entry.RowVersion` is populated after save.

> **NOTE on service placement (approved deviation, mirror of SPEC-0005 deviation log §5)**: `IEntryService` stays in `src/VisaFusion.Core/Application/EntryService.cs`; its implementation must live in `src/VisaFusion.Data/Application/EntryService.cs` because it queries `VisaEntryDbContext` (Core cannot reference Data; one-way Data → Core — same pattern as `SecurityGateService`). DI registration moves to the composition root `src/VisaFusion.Web/Program.cs`.

### Tests for User Story 1 (requested by spec §20/§23) ⚠️

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [ ] T007 [P] [US1] Unit tests for `Entry` aggregate invariants — ≥ 1 passenger (BR-005), valid refno, free-form status accepted (no transition validation, clarification Q3) in `tests/UnitTests/EntryAggregateTests.cs` (AC-002; fail-first)
- [ ] T008 [P] [US1] Unit tests for `EntryPassenger` validation — required fields per legacy `entryDetails` schema (spec §17) in `tests/UnitTests/EntryPassengerValidationTests.cs` (fail-first)

### Implementation for User Story 1

- [ ] T009 [US1] Implement `EntryService` (`IEntryService` interface unchanged in `src/VisaFusion.Core/Application/EntryService.cs`; implementation in `src/VisaFusion.Data/Application/EntryService.cs` — `CreateAsync` enforcing the ≥1-passenger + valid-refno invariants and free-form status, `GetByRefnoAsync` loading the aggregate with passengers + paxStatuses; BR-005, FR-002)
- [ ] T010 [US1] Register the Data-layer `EntryService` implementation at the composition root and remove the Core placeholder registration — `src/VisaFusion.Web/Program.cs` (+ remove `services.AddScoped<IEntryService, EntryService>()` from `src/VisaFusion.Core/CoreServiceCollectionExtensions.cs`; mirror the `ISecurityGateService` precedent, deviation log §5)

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently (aggregate invariants + RowVersion proven).

---

## Phase 4: User Story 2 - Reference Number Allocation (Priority: P1)

**Goal**: Atomic legacy-compatible max+1 refno allocation via `RefnoSeq` + `usp_AllocateNextRefno` (script 01 applied verbatim), surfaced through `EntryService.AllocateRefnoAsync` (FR-003/004, BR-001, AC-003). Gaps acceptable; no duplicates, no collisions under concurrent load.

**Independent Test**: Integration test calls `usp_AllocateNextRefno` concurrently (e.g. 50 parallel) and asserts unique monotonic values with no duplicates/collisions (AC-003); unit tests prove max+1 allocation semantics.

### Tests for User Story 2 (requested by spec §20/§23) ⚠️

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [ ] T011 [P] [US2] Unit tests for refno allocation semantics — max+1, monotonic, gaps permitted (BR-001) in `tests/UnitTests/RefnoAllocationTests.cs` (fail-first)
- [ ] T012 [P] [US2] Integration test: concurrent `usp_AllocateNextRefno` calls → unique, monotonic, no duplicates/collisions (AC-003; self-skipping when SQL Server is unreachable) in `tests/IntegrationTests/RefnoAllocationTests.cs`

### Implementation for User Story 2

- [ ] T013 [US2] Apply `specs/006-core-entry-workflow/scripts/01_sequences_and_allocation.sql` verbatim to the target `VisaFusion` database (creates `RefnoSeq`, `InvoiceNumberSeq`, `usp_AllocateNextRefno`, `usp_AllocateInvoiceNumber`; `CREATE OR ALTER` — re-runnable; depends on T004 column verification) — cutover execution task
- [ ] T014 [US2] Implement `EntryService.AllocateRefnoAsync` calling `usp_AllocateNextRefno` (parameterized `FromSqlRaw`/`SqlQuery`, returns the allocated `@NewRefno` — proc returns `BIGINT`, convert to `int` for `Entry.Refno` per data model §2) in `src/VisaFusion.Data/Application/EntryService.cs` (depends on T009; FR-004, BR-001)

**Checkpoint**: At this point, User Stories 1 AND 2 work independently (refno allocation proven atomic).

---

## Phase 5: User Story 3 - Status Change Recording (Priority: P1)

**Goal**: Audited status changes via `usp_RecordEntryStatusChange` (script 08 applied verbatim — the final, supersedes 06/07 per GR-0004), called explicitly by `EntryService.RecordStatusChangeAsync` with the authenticated `AspNetUsers.Id` as `@ActorUserId` (anti-spoofing; never a formatted actor string). Atomic multi-table write: `PaxStatus.statusID` + `StatusHistory` + `bighistory` in one transaction, `UpdatedBy = {role}:{username}` (FR-005, BR-002, AC-004).

**Independent Test**: Integration test executes the proc and asserts the atomic update (PaxStatus.statusID changed, StatusHistory + bighistory rows written, `UpdatedBy` = `{role}:{username}`), the rollback on error (no partial writes), and the three `RAISERROR` rejection paths (unknown refno / unknown statusID / no matching PaxStatus row).

### Tests for User Story 3 (requested by spec §20/§23) ⚠️

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [ ] T015 [P] [US3] Integration test: `usp_RecordEntryStatusChange` atomicity — PaxStatus update + StatusHistory + bighistory in one commit, `UpdatedBy` format `{role}:{username}` (su>adm>emp>agt precedence), `@NewStatusHistoryId` output, rollback on error (XACT_ABORT), and the three RAISERROR paths (AC-004; self-skipping when SQL Server is unreachable) in `tests/IntegrationTests/StatusChangeTests.cs`

### Implementation for User Story 3

- [ ] T016 [US3] Apply `specs/006-core-entry-workflow/scripts/08_finalize_entry_status_change_updatedby.sql` verbatim to the target `VisaFusion` database (final `usp_RecordEntryStatusChange`; supersedes 06/07; `CREATE OR ALTER` — re-runnable; depends on T004 and MUST run AFTER T023 — script 06 pre-creates the proc this script finalizes) — cutover execution task
- [ ] T017 [US3] Implement `EntryService.RecordStatusChangeAsync` — resolves the caller's `AspNetUsers.Id` from the JWT `sub` claim (never a formatted actor string — GR-0004 interface contract), calls `usp_RecordEntryStatusChange` parameterized, returns `statusHistoryId` + `updatedBy` in `src/VisaFusion.Data/Application/EntryService.cs` (depends on T009; FR-005, contracts/entries-api.md §4)

**Checkpoint**: At this point, User Stories 1-3 work independently (status changes audited atomically).

---

## Phase 6: User Story 4 - Bookable-Date Rule (Priority: P1)

**Goal**: Authoritative transactional holiday/weekly-off/Sunday check in `HolidayService` (C#, `VisaFusion.Core`), with `fn_IsEmbassyClosed` (script 02) as the read-only reporting/BI mirror (FR-006, BR-003, AC-005; owner-confirmed split 2026-08-14). Both surfaces must return the same verdict for the same date.

**Independent Test**: Unit tests prove `HolidayService` for holiday / weekly-off / Sunday / normal day; integration test runs `fn_IsEmbassyClosed` for the same four date classes and asserts parity (1/1/1/0) (AC-005).

### Tests for User Story 4 (requested by spec §20/§23) ⚠️

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [ ] T018 [P] [US4] Unit tests for `HolidayService` — holiday / weekly-off / Sunday / normal-day verdicts (FR-006, BR-003, AC-005) in `tests/UnitTests/HolidayServiceTests.cs` (fail-first)
- [ ] T019 [P] [US4] Integration test: `fn_IsEmbassyClosed` returns 1 for holiday / weekly-off / Sunday and 0 for a normal day, matching the C# rule (AC-005 parity; self-skipping when SQL Server is unreachable) in `tests/IntegrationTests/EmbassyClosedTests.cs`

### Implementation for User Story 4

- [ ] T020 [US4] Implement `HolidayService` — reads `Holiday`/`WeeklyOff` (and Sunday rule) via `VisaEntryDbContext`; same placement deviation as `EntryService`/`SecurityGateService` (interface `IHolidayService` in `src/VisaFusion.Core/Application/HolidayService.cs`, implementation in `src/VisaFusion.Data/Application/HolidayService.cs`, registration at the composition root in `src/VisaFusion.Web/Program.cs`; Core placeholder registration removed from `src/VisaFusion.Core/CoreServiceCollectionExtensions.cs`) — FR-006, BR-003
- [ ] T021 [US4] Apply `specs/006-core-entry-workflow/scripts/02_fn_IsEmbassyClosed.sql` verbatim to the target `VisaFusion` database (read-only reporting mirror; `CREATE OR ALTER` — re-runnable; depends on T004) — cutover execution task

**Checkpoint**: At this point, User Stories 1-4 work independently (bookable-date rule enforced + mirrored).

---

## Phase 7: User Story 5 - Super-User Provisioning Proc (Priority: P2)

**Goal**: `usp_ProvisionSuperUser` (script 06) + the new `SuperUserProvisioningAudit` table applied verbatim — su-only (no `@Role` parameter), pre-hashed password, refuses duplicate usernames, creates `su` user with `su`+`adm` roles, writes the audit row (FR-007, BR-004, AC-006). The API endpoint `POST /api/v1/admin/superusers` remains a **documented-only deferred contract** (spec §15; `secured-write-routes.md` §3.1) — NOT registered by this feature.

**Independent Test**: Integration test calls the proc and asserts the `su` user exists with `su`+`adm` roles, the `SuperUserProvisioningAudit` row is written, a duplicate username is refused, and a non-su caller is rejected; no plaintext password is stored or logged (AC-006).

### Tests for User Story 5 (requested by spec §20/§23) ⚠️

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [ ] T022 [P] [US5] Integration test: `usp_ProvisionSuperUser` — `su` user with `su`+`adm` roles, `SuperUserProvisioningAudit` row written, duplicate username refused, non-su caller rejected, no plaintext stored (AC-006; self-skipping when SQL Server is unreachable) in `tests/IntegrationTests/SuperUserProvisioningTests.cs`

### Implementation for User Story 5

- [ ] T023 [US5] Apply `specs/006-core-entry-workflow/scripts/06_status_change_and_superuser_provisioning.sql` verbatim to the target `VisaFusion` database (creates `SuperUserProvisioningAudit` + `usp_ProvisionSuperUser`; `NVARCHAR(450)` keys per GR-0003 item 3; depends on T004) — cutover execution task. NOTE: do NOT register `POST /api/v1/admin/superusers` — deferred contract (spec §15). MUST run BEFORE T016 (script 08 supersedes script 06's `usp_RecordEntryStatusChange`; script 06:45 pre-creates it)

**Checkpoint**: At this point, User Stories 1-5 work independently (all four stored procs/functions live; super-user provisioning audited).

---

## Phase 8: User Story 6 - Entries Web API (Priority: P2)

**Goal**: The Entries module controller set under `/api/v1` — `POST /entries`, `GET /entries/{refno}`, `PUT /entries/{refno}` (If-Match/ETag, stale → 409), `POST /entries/{refno}/status`, `POST /entries/{refno}/awb` — all gated by the Phase-0 `EntryOperations` policy (emp/adm/su; verified `src/VisaFusion.Api/Authorization/AuthorizationPolicies.cs:22,42`), problem-details errors, pagination-ready (FR-008/009, AC-007/008/011). Backs legacy pages `makeEntry`, `insertEntry`, `editentry*`, `editdone`, `sendawbgo` (complete_migration_plan.md §5 line 189).

**Independent Test**: Functional tests assert the 5-role matrix over all five endpoints (anonymous→401, wrong role→403, correct role→200/201/204), the optimistic-concurrency outcome (stale If-Match→409, fresh ETag→200, AC-011), and problem-details error formats; the deferred superuser route returns 404 (not registered).

### Tests for User Story 6 (requested by spec §20/§23) ⚠️

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [ ] T024 [P] [US6] Functional test: 5-role matrix over all five Entries endpoints — anonymous→401, wrong role (agt/guest)→403, correct role (emp/adm/su)→200/201/204 (AC-008; hermetic `WebApplicationFactory`, token-minted JWT per the existing convention) in `tests/FunctionalTests/EntriesRbacTests.cs` (fail-first)
- [ ] T025 [P] [US6] Functional test: optimistic concurrency — stale `If-Match` ETag → 409 (problem-details), fresh ETag → 200 with new etag (AC-011) in `tests/FunctionalTests/EntriesConcurrencyTests.cs` (fail-first)
- [ ] T026 [P] [US6] Functional test: problem-details error formats — 404 unknown refno, 400 validation (incl. nonexistent status id), 401/403 auth failures, and the deferred superuser route → 404 (AC-007; §18) in `tests/FunctionalTests/EntriesErrorTests.cs` (fail-first)

### Implementation for User Story 6

- [ ] T027 [US6] Implement `EntriesEndpoint` (minimal-API static `Handle` methods following the existing `AuthEndpoint`/`EmployeeEndpoint` pattern) — `POST /api/v1/entries` (allocates refno via US2, creates aggregate via US1, `201` + etag), `GET /api/v1/entries/{refno}` (US1 read, `200` + etag), `PUT /api/v1/entries/{refno}` (If-Match check against RowVersion, stale → 409), `POST /api/v1/entries/{refno}/status` (US3, resolves `@ActorUserId` from JWT `sub` claim), `POST /api/v1/entries/{refno}/awb` — all `[Authorize(Policy = "EntryOperations")]` — in `src/VisaFusion.Api/Endpoints/EntriesEndpoint.cs` (depends on T005, T009, T014, T017, T020)
- [ ] T028 [US6] Map the Entries endpoints and wire the service registrations in `src/VisaFusion.Web/Program.cs` (depends on T027; FR-008/009)

**Checkpoint**: At this point, all six user stories work independently — the Entries module API is complete.

---

## Phase 9: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories; verification and governance close-out (Constitution Definition of Done).

- [ ] T029 [P] Update `knowledge-graph/kg.json` and `knowledge-graph/traceability-matrix.md` with SPEC-0006 rows (FR-001..FR-011, AC-011 → architecture/domain/database/API/test/migration; Constitution Principle IV)
- [ ] T030 [P] Update the decision log and `reports/release-notes/` with SPEC-0006 decisions (optimistic concurrency Q1, no-bulk Q2, `UpdatedBy` GR-0004, `usp_` standardization GR-0003); complete spec §24 traceability matrix
- [ ] T031 [P] Security spot-checks per `quickstart.md` §5 — no plaintext password material in logs/responses, `@ActorUserId` resolved server-side (anti-spoofing), no anonymous write endpoints, parameterized SQL only (spec §12, NFR-006)
- [x] T032 Run the `quickstart.md` validation scenarios end-to-end (setup, scripts 01-08, refno/status/bookable/superuser scenarios, API matrix, concurrency, SQLi, golden-file parity where applicable). Include §13 performance assertions against real SQL Server: `usp_AllocateNextRefno` < 50 ms, `usp_RecordEntryStatusChange` < 100 ms, `fn_IsEmbassyClosed`/`HolidayService` < 10 ms, API entry operations < 500 ms (NFR-003/NFR-004); record measured timings in the validation report — DONE 2026-08-16: scripts 01-08 applied, suites 134/134 + 135/135 + 51/51 PASS, timings recorded in `validation-report.md` (refno 0.5 ms, status-change 19 ms, embassy-closed 1.8 ms); golden-file parity + live-app API timing deferred to cutover; identity import blocked by GAP-0004 (see `findings/gap-0004-oversized-agent-emails.md`)
- [ ] T033 Close the GR-0001 pre-cutover verification caveat — sign off T004 results against the executed scripts (all `-- TODO: confirm column name` resolved)
- [ ] T034 [P] Golden-file parity check — sanitized subset diff of entry create/status-change behavior vs legacy (where applicable, migration plan §10; §23 Regression)
- [ ] T035 [P] Apply `specs/006-core-entry-workflow/scripts/03_report_procedures.sql` verbatim to the target `VisaFusion` database (reporting stored procedures backing the three heaviest report pages; `CREATE OR ALTER` — re-runnable; depends on T004) — cutover execution task
- [ ] T036 [P] Apply `specs/006-core-entry-workflow/scripts/04_migration_cleansing_procedures.sql` verbatim to the target `VisaFusion` database (one-time data-cleansing procedures for the ordered migration; `CREATE OR ALTER` — re-runnable; depends on T004) — cutover execution task
- [ ] T037 [P] Apply `specs/006-core-entry-workflow/scripts/05_normalization_ddl.sql` verbatim to the target `VisaFusion` database (supporting DDL for the normalization plan (A5): archive tables + PK/FK templates; re-runnable; depends on T004) — cutover execution task
- [ ] T038 [P] AC-001/AC-009/AC-010/FR-010/FR-011 validation — (1) row counts and checksums of all 52 tables match legacy `VisaEntry` per §3 disposition (M / M-RO / COND / ARCH / DROP); record method and tables-in-scope (CHK028: deferred to SPEC-0004 validation where not already defined); (2) legacy `VisaEntry` database verified untouched/read-only (baseline snapshot before/after, AC-009/FR-010); (3) no business table dropped — only `dtproperties` removed (AC-010/FR-011) — validation task

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies — can start immediately
- **Foundational (Phase 2)**: Depends on Setup — BLOCKS all user stories (T004 blocks script applications T013/T016/T021/T023; T005/T006 block US1/US6)
- **User Stories (Phase 3+)**: All depend on Foundational completion
  - US2-US5 can proceed in parallel once T004 completes (different scripts, different test files; T023/script 06 must apply before T016/script 08 — script 08 supersedes script 06's `usp_RecordEntryStatusChange`)
  - US6 depends on US1 (aggregate service), US2 (refno), US3 (status change), US4 (bookable date)
  - US5 is independent of US1-US4 (proc + audit table only; endpoint deferred)
- **Polish (Final Phase)**: Depends on all user stories being complete

### User Story Dependencies

- **US1 (P1)**: after Foundational (T006 RowVersion) — no story dependencies
- **US2 (P1)**: after Foundational (T004) + US1 T009 (AllocateRefnoAsync lives in the US1 service) — independent of US3-US5
- **US3 (P1)**: after Foundational (T004) + US1 T009 — independent of US2/US4/US5
- **US4 (P1)**: after Foundational (T004) — independent of US2/US3/US5
- **US5 (P2)**: after Foundational (T004) — fully independent
- **US6 (P2)**: after US1 + US2 + US3 + US4 (its endpoints call those services) + T005 contracts

### Within Each User Story

- Tests MUST be written and FAIL before implementation (TDD)
- Service before endpoints; core implementation before integration
- Story complete before moving to the next priority

### Parallel Opportunities

- Phase 1: T002/T003 [P] run in parallel after T001
- Phase 2: T004/T005 [P] run in parallel; T006 sequential (blocks US1/US6)
- US2/US3/US4/US5 stories run in parallel once T004 completes (different scripts, different test files, different service methods; at cutover T023/script 06 applies before T016/script 08 — script 08 supersedes script 06's `usp_RecordEntryStatusChange`)
- All test tasks within a story marked [P] run in parallel
- US6 test tasks T024/T025/T026 [P] run in parallel before T027
- Polish tasks T029/T030/T031/T034 [P] run in parallel after implementation

---

## Parallel Example: User Story 2

```bash
# Launch the tests for User Story 2 together (fail-first):
Task: "Unit tests for refno allocation semantics in tests/UnitTests/RefnoAllocationTests.cs"
Task: "Integration test for concurrent usp_AllocateNextRefno in tests/IntegrationTests/RefnoAllocationTests.cs"
```

```bash
# After tests pass, apply the script and implement the service:
Task: "Apply scripts/01_sequences_and_allocation.sql verbatim (T013)"
Task: "Implement EntryService.AllocateRefnoAsync in src/VisaFusion.Data/Application/EntryService.cs (T014)"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (T004/T005/T006)
3. Complete Phase 3: User Story 1 (aggregate + RowVersion)
4. **STOP and VALIDATE**: Test US1 independently (invariants + RowVersion)
5. Deploy/demo if ready

### Incremental Delivery

1. Complete Setup + Foundational → foundation ready
2. Add US1 → test → demo (MVP)
3. Add US2-US4 (P1 procs, parallelizable) → test each independently → demo
4. Add US5 (P2 proc) → test → demo
5. Add US6 (P2 API) → test → demo — the Entries module API completes the feature
6. Polish + validation close-out (Phase 9)

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once T004 (column verification) is done:
   - Developer A: US2 (refno) — script 01 + AllocateRefnoAsync
   - Developer B: US3 (status change) — script 08 + RecordStatusChangeAsync
   - Developer C: US4 (bookable date) — script 02 + HolidayService
   - Developer D: US5 (super-user) — script 06 (independent)
3. All four merge → US1 service integration → US6 API on top

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to a specific user story for traceability
- Each user story is independently completable and testable
- Verify tests fail before implementing (TDD)
- Commit after each task or logical group
- Stop at any checkpoint to validate the story independently
- Owner-supplied scripts are applied **verbatim** — never edited, never re-derived (GR-0001); the only script-related code changes are the C# service methods that call them
- The script application tasks (T013/T016/T021/T023) are cutover execution tasks, not source edits — the scripts live in `specs/006-core-entry-workflow/scripts/` and are executed with `sqlcmd -S <server> -d VisaFusion -i <script>` per quickstart.md §2
- T006 (RowVersion) requires an EF Core migration (or the SPEC-0004 tooling convention) to apply to the target `VisaFusion` database — follow the repo's existing migration step convention

---

## Phase 10: Convergence

**Purpose**: Close the gaps found by `/speckit.converge` (2026-08-17) between the spec/plan/tasks intent and the implemented codebase. Two partial gaps remain: FR-005b's `entrytype` default is a documented no-op pending an owner-approved value, and the legacy create-audit `bighistory` insert (spec §19) is not replicated by `EntryService.CreateAsync`.

- [ ] T039 Implement the approved `entrytype` default value in `EntryTypeDefaultRule` — obtain the owner-approved default for the 100%-NULL `Mainentry.entrytype` (GAP-0001 §4.2), apply it in `src/VisaFusion.Migration/Cleansing/EntryTypeDefaultRule.cs` (currently a documented no-op preserving NULL verbatim), and add a dedicated test (none exists today) per FR-005b (partial)
- [x] T040 Replicate the legacy create-audit `bighistory` insert in `EntryService.CreateAsync` — write the `bighistory` row (refno, agent, timestamp, updatedby resolved from the JWT identity, remark) per `insertEntry.asp:233` and spec §19, and audit the PUT update path (subject, endpoint, outcome) per §19; add tests per spec §19 (partial) — DONE 2026-08-17: `EntryService.CreateAsync`/`UpdateAsync` write `bighistory` rows in the same commit (legacy insertEntry.asp:233 / editEntrySubmit.asp:189); actor resolved server-side from JWT claims (`ResolveActorAsync`), `UpdatedBy` composed `{role}:{username}` with su>adm>emp>agt precedence (GR-0004); new `tests/UnitTests/EntryAuditTests.cs` (4) and `tests/IntegrationTests/EntryAuditIntegrationTests.cs` (1). Two defects fixed and logged (deviation log T040): `UpdateAsync`'s AC-011 concurrency check was vacuous (explicit `SequenceEqual` token comparison now); `Mainentry.rowversion` column was missing from the target schema (new idempotent script `scripts/09_add_entry_rowversion.sql` applied; `ChecksumSql` excludes value-generated rowversion/timestamp columns). Suites: Unit 138/138, Functional 135/135, Integration 52/52.