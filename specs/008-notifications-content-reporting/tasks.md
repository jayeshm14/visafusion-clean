# Tasks: Notifications, Content, Reporting (SPEC-0008)

**Input**: Design documents from `/specs/008-notifications-content-reporting/`

**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: Included — spec §23 explicitly requests unit, integration, functional, API, security, and golden-file test scenarios, and the Definition of Done requires automated tests.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Web app + worker host**: `src/VisaFusion.{Core,Data,Api,Jobs,Web}/`, `tests/{UnitTests,IntegrationTests,FunctionalTests}/` at repository root (7-project layout per plan.md Structure Decision)

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Spec traceability amendment and configuration required before any code changes

- [ ] T001 Amend spec: register the NEW `emailQueue` table in §16 + Assumptions (traceability from checklist CHK002/CHK014/CHK038; research D-1) and reconcile the `ReportWorker` scope contradiction (§5 completion list vs §6 out-of-scope; plan.md:20/109) in `specs/008-notifications-content-reporting/spec.md`
- [ ] T002 Add `RateLimiting:Queries` = `{ "PermitLimit": 5, "WindowSeconds": 3600 }` to `src/VisaFusion.Web/appsettings.json` (owner Q3:A — 5/hour per source enforced in v1)
- [ ] T003 [P] Add `RateLimiting:Queries` = `{ "PermitLimit": 5, "WindowSeconds": 3600 }` to `src/VisaFusion.Web/appsettings.Development.json` (owner Q3:A; local testability of AC-001)

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T004 Define `ISmsService` interface (`EnqueueAsync`, `DrainNextBatchAsync`, `GetHistoryAsync`) in `src/VisaFusion.Core/Application/SmsService.cs` (replaces the empty placeholder)
- [ ] T005 [P] Define `IEmailService` interface (`EnqueueAsync`, `DrainNextBatchAsync`, `GetHistoryAsync`) in `src/VisaFusion.Core/Application/EmailService.cs` (replaces the empty placeholder)
- [ ] T006 [P] Create shared notification contracts (`SmsMessage`, `EmailMessage`, `QueueDrainResult`, `SmsHistoryItem`, `EmailHistoryItem`) in `src/VisaFusion.Core/Application/NotificationMessages.cs` (named to avoid collision with the Api DTOs file)
- [ ] T007 [P] Create `ContactQuery` entity (NEW `queries` table: Id, Name, Email, Subject, Message, Subdate, Status default `new`, IpAddress) in `src/VisaFusion.Data/Persistence/Entities/ContactQuery.cs`
- [ ] T008 [P] Create `EmailQueue` entity (NEW `emailQueue` table: Id, Toemail, Subject, Body, Agentsid, Refno, Awb, Sentby, Sentdate) in `src/VisaFusion.Data/Persistence/Entities/EmailQueue.cs`
- [ ] T009 Register `DbSet<ContactQuery>` and `DbSet<EmailQueue>` + entity configurations in `src/VisaFusion.Data/Persistence/VisaEntryDbContext.cs`
- [ ] T010 Create additive EF migration (queries + emailQueue only; no existing table altered) + reversibility test in `src/VisaFusion.Data/Migrations/` and `tests/IntegrationTests/MigrationReversibilityTests.cs`
- [ ] T011 Implement `SmsService` (enqueue → `smsQueue`; transactional drain → `smshistory` with all 8 audit fields; history read) in `src/VisaFusion.Data/Application/SmsService.cs` (research D-3)
- [ ] T012 [P] Implement `EmailService` (enqueue → `emailQueue`; transactional drain → `sentmails`; history read) in `src/VisaFusion.Data/Application/EmailService.cs` (research D-3)
- [ ] T013 [P] Create log-only dispatch providers (`ISmsDispatchProvider`/`IEmailDispatchProvider` + LogOnly default; vendor provider config-gated) in `src/VisaFusion.Data/Application/NotificationDispatchProviders.cs` (research D-2, owner Q1:C)
- [ ] T014 Remove placeholder `ISmsService`/`IEmailService` registrations from `src/VisaFusion.Core/CoreServiceCollectionExtensions.cs` (implementations move to Data — HolidayService precedent, research D-7)
- [ ] T015 Register Data-backed services + `VisaEntryDbContext` at the Web composition root in `src/VisaFusion.Web/Program.cs`
- [ ] T016 [P] Register Data-backed services + `VisaEntryDbContext` + Serilog at the Jobs composition root in `src/VisaFusion.Jobs/Program.cs`

**Checkpoint**: Foundation ready — user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Contact-Query Completion (Priority: P1) 🎯 MVP

**Goal**: Complete the SPEC-0007 carry-forward — `POST /api/v1/public/queries` persists to the new `queries` table, enforces the 5/hour rate limit, and enqueues the office-notification email (FR-007/008).

**Independent Test**: Anonymous `POST /api/v1/public/queries` → `201` + `queries` row (status `new`, subdate, ip_address); malformed body → `400`; 6th submission within an hour → `429`; office email appears in `emailQueue` and (after drain) in `sentmails` (AC-001/002).

### Tests for User Story 1 (spec §23 — write FIRST, ensure they FAIL before implementation) ⚠️

- [ ] T017 [P] [US1] Integration test: queries persistence + office-email enqueue→drain→`sentmails` in `tests/IntegrationTests/QueriesPersistenceTests.cs`
- [ ] T018 [P] [US1] Functional test: queries endpoint 201/400/429 + rate-limit enforcement + `RateLimiting:Queries` config default (5/3600, Q3:A) in `tests/FunctionalTests/QueriesEndpointTests.cs`

### Implementation for User Story 1

- [ ] T019 [US1] Complete `PublicEndpoint.SubmitQueryAsync` (persist `ContactQuery`, enqueue office email via `IEmailService`, fix the stale `querieDetail.asp` doc comment) + queries validation unit tests (name/email/subject/message limits) in `src/VisaFusion.Api/Endpoints/PublicEndpoint.cs` and `tests/UnitTests/QueriesValidationTests.cs`
- [ ] T020 [US1] Wire the queries route to `PublicEndpoint.SubmitQueryAsync` (replacing `SecuredPlaceholderEndpoint.Handle`) in `src/VisaFusion.Web/Program.cs`
- [ ] T021 [US1] Golden-file unit test: office-email payload vs the legacy `contactsendpre.asp` template (sender details + message text) in `tests/UnitTests/OfficeEmailTemplateTests.cs`

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - SMS Notification Queue (Priority: P1)

**Goal**: SMS enqueue endpoint + background worker drain with `smshistory` audit continuity and retry/failure visibility (FR-001/003/004/006).

**Independent Test**: `POST /api/v1/notifications/sms` → `202` in <1s; with `VisaFusion.Jobs` running, the `smsQueue` row is drained to an `smshistory` row with all 8 audit fields; `agt`/anonymous → `401`/`403`; failed dispatch logs `status=failed` and retries (AC-003/004/009).

### Tests for User Story 2 (spec §23) ⚠️

- [ ] T022 [P] [US2] Unit test: SMS validation rules + audit-field completeness in `tests/UnitTests/NotificationValidationTests.cs`
- [ ] T023 [P] [US2] Integration test: SMS queue drain → `smshistory` (8 fields, send-once semantics) + failure-injection retry (AC-004: failed dispatch logged with failure status, retried, never silently swallowed) in `tests/IntegrationTests/SmsQueueDrainTests.cs`
- [ ] T024 [P] [US2] Functional test: SMS enqueue/history endpoints + RBAC + enqueue latency < 1 s (AC-009) in `tests/FunctionalTests/NotificationsEndpointTests.cs`

### Implementation for User Story 2

- [ ] T025 [US2] Create `NotificationsEndpoint` (POST sms, GET sms-history) + API contracts in `src/VisaFusion.Api/Endpoints/NotificationsEndpoint.cs` and `src/VisaFusion.Api/Contracts/NotificationContracts.cs`
- [ ] T026 [US2] Implement `SmsQueueWorker` real drain loop (bounded batch, retry, telemetry) in `src/VisaFusion.Jobs/Workers/SmsQueueWorker.cs`
- [ ] T027 [US2] Wire SMS notification routes (policy `EntryOperations`) in `src/VisaFusion.Web/Program.cs`

**Checkpoint**: At this point, User Story 2 should be fully functional and testable independently

---

## Phase 5: User Story 3 - Email Notification Queue (Priority: P2)

**Goal**: Email enqueue endpoint + background worker drain with `sentmails` audit continuity (FR-002/003/005/006).

**Independent Test**: `POST /api/v1/notifications/email` → `202` in <1s; with `VisaFusion.Jobs` running, the `emailQueue` row is drained to a `sentmails` row (agentsid, date, toemail, awb); `agt`/anonymous → `401`/`403` (AC-005/009).

### Tests for User Story 3 (spec §23) ⚠️

- [ ] T028 [P] [US3] Unit test: email validation rules + `sentmails` audit-field completeness (FR-005) in `tests/UnitTests/NotificationValidationTests.cs` (append)
- [ ] T029 [P] [US3] Integration test: email queue drain → `sentmails` in `tests/IntegrationTests/EmailQueueDrainTests.cs`

### Implementation for User Story 3

- [ ] T030 [US3] Add email endpoints (POST email, GET email-history) to `src/VisaFusion.Api/Endpoints/NotificationsEndpoint.cs` (same file as T025 — sequential with US2)
- [ ] T031 [US3] Implement `EmailQueueWorker` real drain loop (bounded batch, retry, telemetry) in `src/VisaFusion.Jobs/Workers/EmailQueueWorker.cs`
- [ ] T032 [US3] Wire email notification routes (policy `EntryOperations`) in `src/VisaFusion.Web/Program.cs`

**Checkpoint**: At this point, User Stories 2 AND 3 should both work independently

---

## Phase 6: User Story 4 - dailyUpdate Content CMS (Priority: P2)

**Goal**: `AdminPanel`-gated dailyUpdate CMS (create/edit/delete) with anonymous public read (FR-010).

**Independent Test**: As `adm`/`su`, create/edit/delete dated entries → public page reflects changes anonymously; as `emp`/`agt`/anonymous → `403` on write endpoints (AC-006).

### Tests for User Story 4 (spec §23) ⚠️

- [ ] T033 [P] [US4] Functional test: CMS RBAC (403 for non-admin) + public read reflects changes in `tests/FunctionalTests/ContentCmsTests.cs`
- [ ] T034 [P] [US4] Integration test: `ContentUpdate` create/edit/delete + validation (date + description ≤ 8,000 chars) in `tests/IntegrationTests/ContentUpdateCrudTests.cs`

### Implementation for User Story 4

- [ ] T035 [US4] Create `ContentEndpoint` (POST/DELETE daily-update) + contracts in `src/VisaFusion.Api/Endpoints/ContentEndpoint.cs` and `src/VisaFusion.Api/Contracts/ContentContracts.cs`
- [ ] T036 [US4] Create Admin CMS pages (list/create/edit/delete) in `src/VisaFusion.Web/Areas/Admin/Pages/ContentUpdate/`
- [ ] T037 [US4] Create anonymous public daily-update read page in `src/VisaFusion.Web/Areas/Public/Pages/DailyUpdate.cshtml`
- [ ] T038 [US4] Wire content routes (policy `AdminPanel`) in `src/VisaFusion.Web/Program.cs`

**Checkpoint**: At this point, User Story 4 should be fully functional and testable independently

---

## Phase 7: User Story 5 - Holiday/Weekly-Off Management CRUD (Priority: P2)

**Goal**: `HolidayAdmin`-gated holiday/weekly-off CRUD feeding the SPEC-0006 `HolidayService` rule (FR-011).

**Independent Test**: As `adm`/`su`, create/delete holidays and weekly-off weekdays → `201`/`204`; duplicates → `409`; invalid weekday → `400`; created rows immediately honored by `IHolidayService.IsEmbassyClosedAsync` (AC-007).

### Tests for User Story 5 (spec §23) ⚠️

- [ ] T039 [P] [US5] Integration test: holiday/weekly-off CRUD parity vs `IHolidayService` in `tests/IntegrationTests/HolidayCrudParityTests.cs`
- [ ] T040 [P] [US5] Functional test: holiday endpoints RBAC + 409 duplicates + weekday numbering boundaries (BR-006: 1–7 accepted, 0/8 rejected) in `tests/FunctionalTests/HolidayCrudEndpointTests.cs`

### Implementation for User Story 5

- [ ] T041 [US5] Create `HolidaysEndpoint` (POST/DELETE holidays + weekly-off) + contracts in `src/VisaFusion.Api/Endpoints/HolidaysEndpoint.cs` and `src/VisaFusion.Api/Contracts/HolidayContracts.cs`
- [ ] T042 [US5] Create Admin holiday/weekly-off pages in `src/VisaFusion.Web/Areas/Admin/Pages/Holidays/`
- [ ] T043 [US5] Wire holiday routes (policy `HolidayAdmin`; replace the `SecuredPlaceholderEndpoint` mappings for `POST /api/v1/holidays` and `DELETE /api/v1/holidays/{id}`) in `src/VisaFusion.Web/Program.cs`

**Checkpoint**: At this point, User Story 5 should be fully functional and testable independently

---

## Phase 8: User Story 6 - Operational Reports (Priority: P3)

**Goal**: Six on-screen reports for `emp`/`adm`/`su` with parameterized data access only (FR-012).

**Independent Test**: Each report surface renders for `emp`/`adm`/`su`; `agt`/`guest` → `403`; invalid date inputs → `400` before query execution; same inputs → same ordering (AC-008).

### Tests for User Story 6 (spec §23) ⚠️

- [ ] T044 [P] [US6] Functional test: report RBAC (403 for `agt`/`guest`) in `tests/FunctionalTests/ReportEndpointTests.cs`
- [ ] T045 [P] [US6] Integration test: report queries parameterized (no SQLi) + deterministic + date validation in `tests/IntegrationTests/ReportParameterizedSqlTests.cs`

### Implementation for User Story 6

- [ ] T046 [US6] Create `ReportsEndpoint` (7 GETs: agent-status/today + pending, today-submission, today-collection, today-transaction, daily-visa-fee, daily-bill) + contracts in `src/VisaFusion.Api/Endpoints/ReportsEndpoint.cs` and `src/VisaFusion.Api/Contracts/ReportContracts.cs`
- [ ] T047 [US6] Create Reporting pages (6 surfaces) in `src/VisaFusion.Web/Areas/Reporting/Pages/`
- [ ] T048 [US6] Wire report routes (policy `EntryOperations`; replace the `SecuredPlaceholderEndpoint` mapping for `POST /api/v1/reports/agent-status/today`) in `src/VisaFusion.Web/Program.cs`

**Checkpoint**: All user stories should now be independently functional

---

## Phase 9: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T049 [P] Append secrets-guard test (AC-010 — no SMS/SMTP credentials in source or logs) in `tests/UnitTests/ProductionSecretsGuardTests.cs`
- [ ] T050 [P] Append audit-continuity integration test (BR-001 — `smshistory`/`sentmails` writes flow through the same tables) in `tests/IntegrationTests/AuditTableTests.cs`
- [ ] T051 Create ADR-0005 for the `emailQueue` table + Data-backed notification services (research D-1/D-7) in `adr/ADR-0005.md` (next free number — ADR-0001..0004 exist)
- [ ] T052 Run full test suites + quickstart validation scenarios S1..S7 per `specs/008-notifications-content-reporting/quickstart.md`
- [ ] T053 Update the knowledge graph (`knowledge-graph/kg.json`, `knowledge-graph/traceability-matrix.md`) with SPEC-0008 components

**Note**: `ReportWorker` (`src/VisaFusion.Jobs/Workers/ReportWorker.cs`) intentionally remains a placeholder — Phase-4 report generation is out of scope (spec §6).

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies — can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion — BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - User stories can then proceed in parallel (if staffed)
  - Or sequentially in priority order (US1 → US2 → US3 → US4 → US5 → US6)
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **US1 (P1)**: Can start after Foundational — no dependencies on other stories (office-email enqueue uses the foundational `IEmailService.EnqueueAsync`; drain service is foundational)
- **US2 (P1)**: Can start after Foundational — no dependencies on other stories
- **US3 (P2)**: Can start after Foundational — shares `NotificationsEndpoint.cs` with US2 (sequential within that file only)
- **US4 (P2)**: Can start after Foundational — no dependencies on other stories
- **US5 (P2)**: Can start after Foundational — no dependencies on other stories
- **US6 (P3)**: Can start after Foundational — no dependencies on other stories

### Within Each User Story

- Tests MUST be written and FAIL before implementation
- Models before services
- Services before endpoints
- Core implementation before integration
- Story complete before moving to next priority

### Parallel Opportunities

- Phase 1: T003 [P] runs in parallel with T001/T002
- Phase 2: T005/T006/T007/T008/T012/T013/T016 [P] run in parallel; T011 and T012 in parallel; T015 and T016 in parallel
- Once Foundational completes, US1..US6 can start in parallel (different files)
- All tests within a story marked [P] run in parallel
- **Same-file constraints (NOT parallel)**: all `src/VisaFusion.Web/Program.cs` wiring tasks (T020, T027, T032, T038, T043, T048) are sequential; T025 and T030 share `NotificationsEndpoint.cs`; T022/T028 share `NotificationValidationTests.cs`

---

## Parallel Example: User Story 1

```bash
# Launch all tests for User Story 1 together:
Task: "Integration test: queries persistence + office-email enqueue→drain→sentmails in tests/IntegrationTests/QueriesPersistenceTests.cs"
Task: "Functional test: queries endpoint 201/400/429 + rate-limit enforcement in tests/FunctionalTests/QueriesEndpointTests.cs"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL — blocks all stories)
3. Complete Phase 3: User Story 1 (contact-query completion — closes the SPEC-0007 security-relevant carry-forward)
4. **STOP and VALIDATE**: Test User Story 1 independently
5. Deploy/demo if ready

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Test independently → Deploy/Demo (MVP!)
3. Add User Story 2 (SMS queue) → Test independently → Deploy/Demo
4. Add User Story 3 (email queue) → Test independently → Deploy/Demo
5. Add User Stories 4/5 (CMS + holiday CRUD) → Test independently → Deploy/Demo
6. Add User Story 6 (reports) → Test independently → Deploy/Demo
7. Each story adds value without breaking previous stories

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: US1 (queries) + US4 (CMS)
   - Developer B: US2 (SMS) + US5 (holiday)
   - Developer C: US3 (email) + US6 (reports)
3. Stories complete and integrate independently (mind the same-file constraints above)

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Verify tests fail before implementing
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- Avoid: vague tasks, same file conflicts, cross-story dependencies that break independence
- Owner decisions 2026-08-18 honored throughout: Q1:C (enqueue-and-log), Q2:A (report set, no email dispatch), Q3:A (rate limit enforced), Q4:A (`queries.status` write-once `new`)