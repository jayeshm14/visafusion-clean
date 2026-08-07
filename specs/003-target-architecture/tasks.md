---

description: "Task list template for feature implementation"
---

# Tasks: Target Architecture

**Input**: Design documents from `/specs/003-target-architecture/`

**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: Test tasks are included because the constitution (Principle V) mandates automated tests with every implementation.

**Organization**: Tasks are grouped by deliverable increment (solution skeleton, hosting, data/core, api/auth, jobs) to enable independent implementation and testing of each increment.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story increment this task belongs to (US1-US5)
- Include exact file paths in descriptions

## Path Conventions

- **Solution**: `VisaFusion.sln` at repository root
- **Projects**: `src/VisaFusion.*` (six projects)
- **Tests**: `tests/UnitTests`, `tests/IntegrationTests`, `tests/FunctionalTests`
- Per plan.md Structure Decision (clarification Q1: six §2 names as physical projects;
  `library/08` layers as namespaces inside Core and Data)

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [x] T001 Create `VisaFusion.sln` and `src/` + `tests/` directory structure per plan.md Structure Decision
- [x] T002 Create `src/VisaFusion.Core/` project (Class Library, net8.0) with `Domain/` and `Application/` namespaces
- [x] T003 [P] Create `src/VisaFusion.Data/` project (Class Library, net8.0) with `Persistence/` and `Infrastructure/` namespaces
- [x] T004 [P] Create `src/VisaFusion.Identity/` project (Class Library, net8.0)
- [x] T005 [P] Create `src/VisaFusion.Api/` project (Class Library, net8.0) containing the `/api/v1` controllers/endpoints; hosted by the Web process (no own Program.cs, FR-002)
- [x] T006 [P] Create `src/VisaFusion.Web/` project (Razor Pages, net8.0)
- [x] T007 [P] Create `src/VisaFusion.Jobs/` project (Worker, net8.0)
- [x] T008 [P] Create test projects `tests/UnitTests/`, `tests/IntegrationTests/`, `tests/FunctionalTests/` (xUnit, net8.0)
- [x] T009 Add `.editorconfig` and `Directory.Build.props` at repository root (nullable enable, implicit usings, LangVersion latest, TreatWarningsAsErrors)
- [x] T010 Add `.gitignore` (bin/, obj/, appsettings.*.local.json, User Secrets, artifacts)

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story increment can be implemented

**âš ï¸ CRITICAL**: No user story work can begin until this phase is complete

- [x] T011 Add solution project references: Web->Core, Web->Api, Api->Core, Api->Data, Web->Data, Web->Identity, Api->Identity, Data->Core, Identity->Data, Jobs->Core, Jobs->Data
- [x] T012 [P] Configure Serilog (file sink + SQL sink) in `src/VisaFusion.Web/Program.cs` (single host; cross-cutting constants from `Directory.Build.targets`)
- [x] T013 [P] Configure OpenTelemetry (tracing + metrics) in `src/VisaFusion.Web/Program.cs` (single host)
- [x] T014 Configure `appsettings.json` + `appsettings.Development.json` with connection-string placeholder; document User Secrets setup in `README.md` (no secrets in source, NFR-004)
- [x] T015 Implement centralized exception-handling middleware in `src/VisaFusion.Web/Middleware/ExceptionHandlingMiddleware.cs` (standardized error responses, Serilog + trace propagation, spec §18)
- [x] T016 Implement standardized problem-details error format in `src/VisaFusion.Api/` (400/401/403/404/500 per `contracts/api-v1-scaffolding.md`)
- [x] T017 Add solution-level `Directory.Build.targets` for cross-cutting constants (Serilog schema, OTel service name, assembly metadata)
- [x] T018 [P] Add unit-test smoke test in `tests/UnitTests/` proving the xUnit test host runs (empty test class; build validation is covered by T019)

**Checkpoint**: Foundation ready - user story implementation can now begin

---

## Phase 3: User Story 1 - Solution Skeleton (Priority: P1) ðŸŽ¯ MVP

**Goal**: Deliver a buildable `VisaFusion.sln` with all six projects referencing the shared Core, proving FR-001 and FR-009 (buildable/deployable after every task).

**Independent Test**: `dotnet build VisaFusion.sln` succeeds with zero warnings-as-errors; all six projects present in the output.

### Tests for User Story 1

- [x] T019 [P] [US1] Add solution build smoke test in `tests/FunctionalTests/BuildValidationTests.cs` asserting all six projects are discoverable in the solution
- [x] T020 [US1] Add CI workflow `.github/workflows/build.yml` running `dotnet build VisaFusion.sln` on every push/PR (matches SPEC-0001 CI precedent)

### Implementation for User Story 1

- [x] T021 [P] [US1] Define assembly-level metadata (`VisaFusion.Web`, `VisaFusion.Api`, `VisaFusion.Core`, `VisaFusion.Data`, `VisaFusion.Identity`, `VisaFusion.Jobs`) in `Directory.Build.props`
- [x] T022 [US1] Add solution folder organization in `VisaFusion.sln` (src/, tests/ solution folders)
- [x] T023 [US1] Wire `VisaFusion.Web` and `VisaFusion.Api` to the shared `VisaFusion.Core` business-rule surface (DI registration of Core services; project references already added in T011, FR-003)

**Checkpoint**: Solution builds cleanly - User Story 1 complete and testable independently

---

## Phase 4: User Story 2 - Single-Process Hosting + Web Areas (Priority: P1)

**Goal**: Host Web and Api from one ASP.NET Core process (FR-002) with the eight Razor Pages Areas (FR-005), cookie authentication for Web, static assets self-hosted (§14).

**Independent Test**: `dotnet run --project src/VisaFusion.Web` boots; all eight Areas render their default pages; root URL serves the Web UI.

### Tests for User Story 2

- [x] T024 [P] [US2] Add functional test in `tests/FunctionalTests/HostingTests.cs` asserting Web UI and Api respond from a single hosted process
- [x] T025 [US2] Add functional test asserting all eight Areas (`Public`, `Auth`, `Employee`, `Agent`, `Admin`, `Billing`, `Reporting`, `Notifications`) resolve to pages

### Implementation for User Story 2

- [x] T026 [P] [US2] Configure single-process hosting in `src/VisaFusion.Web/Program.cs` (add MVC/Razor Pages and Web API controllers from `VisaFusion.Api` in the same host, FR-002)
- [x] T027 [P] [US2] Create the eight Area folders under `src/VisaFusion.Web/Areas/` (`Public`, `Auth`, `Employee`, `Agent`, `Admin`, `Billing`, `Reporting`, `Notifications`) each with `Pages/Index.cshtml`
- [x] T028 [US2] Register Area routing in `src/VisaFusion.Web/Program.cs` (`MapControllerRoute` with `{area:exists}` convention)
- [x] T029 [US2] Configure cookie authentication in `src/VisaFusion.Web/Program.cs` (`AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)`)
- [x] T030 [US2] Copy static asset folders (`forms/`, `updateimg/`, `images/`, `css/`, `js/`, `fonts/`) into `src/VisaFusion.Web/wwwroot/` from the legacy repo per migration plan §8.2 (self-hosted, no CDN)

**Checkpoint**: Web UI and Areas serve from the single process - User Story 2 complete

---

## Phase 5: User Story 3 - Data + Core Layering (Priority: P1)

**Goal**: EF Core DbContext over the existing `VisaEntry` database (FR-006) with `library/08` layers as namespaces, parameterized queries only (NFR-003), no schema changes (§16).

**Independent Test**: `dotnet build` succeeds; `tests/IntegrationTests` connects to the local `VisaEntry` dev copy and confirms the DbContext scaffolds the live schema.

### Tests for User Story 3

- [x] T031 [P] [US3] Add integration test in `tests/IntegrationTests/DbContextTests.cs` asserting the DbContext models the live `VisaEntry` schema (52 tables discoverable)
- [x] T032 [US3] Add unit test asserting no string-concatenated SQL pattern exists in `src/VisaFusion.Data/` (static scan test, NFR-003)

### Implementation for User Story 3

- [x] T033 [P] [US3] Create `VisaFusion.Data/Persistence/VisaEntryDbContext.cs` with `OnModelCreating` mapping the core tables (`Mainentry`, `entryDetails`, `PaxStatus`, `StatusHistory`, `bighistory`, `sentmails`, `smshistory`, `agents`, `holidaylist`, `weeklyoff`, `embassy`, `CountryInfo`, `VisaInfo`, `security`) per `data-model.md` §1
- [x] T034 [P] [US3] Add EF Core 8 packages (`Microsoft.EntityFrameworkCore.SqlServer`, `Microsoft.EntityFrameworkCore.Design`) to `src/VisaFusion.Data/VisaFusion.Data.csproj`
- [x] T035 [US3] Configure EF Core registration in `src/VisaFusion.Web/Program.cs` (`AddDbContext<VisaEntryDbContext>` with `UseSqlServer` from configuration)
- [x] T036 [US3] Create placeholder domain services in `VisaFusion.Core/Application/` (`EntryService`, `StatusService`, `BillingService`, `SmsService`, `EmailService`, `SecurityGateService`, `HolidayService`) with empty method signatures, proving the shared-Core surface (FR-003, FR-008 dependencies)
- [x] T037 [US3] Add domain service registration in `src/VisaFusion.Web/Program.cs` (DI scoped lifetimes)
- [x] T038 [US3] Implement one representative shared business rule in `VisaFusion.Core/Application/` (e.g., Canada DOB validation) with a concrete, testable method signature (proves the shared-Core surface, AC-003, TS-003)
- [x] T039 [US3] Add functional test in `tests/FunctionalTests/SharedRuleTests.cs` asserting the representative rule (T038) returns the same result when invoked via the Web service and via the employee representative Api endpoint (T045) (AC-003, TS-003)

**Checkpoint**: Data layer and shared Core wired - User Story 3 complete

---

## Phase 6: User Story 4 - Api Surface + Bearer Auth (Priority: P2)

**Goal**: `/api/v1` versioned JSON surface with health/version endpoint plus one representative endpoint per area (FR-004), bearer-token (JWT) authentication (FR-010).

**Independent Test**: `dotnet run --project src/VisaFusion.Web`; `GET /api/v1/health` returns 200 `{"status":"ok",...}`; representative endpoints return 401 without a token and 200 with one.

### Tests for User Story 4

- [x] T040 [P] [US4] Add functional test in `tests/FunctionalTests/ApiSurfaceTests.cs` asserting `GET /api/v1/health` returns 200 with `status: ok`
- [x] T041 [P] [US4] Add functional test asserting a representative endpoint (e.g. `GET /api/v1/employee`) returns 401 without a bearer token and 200 with one
- [x] T042 [US4] Add contract test validating the problem-details error shape for 401/403 in `tests/FunctionalTests/ApiErrorFormatTests.cs`

### Implementation for User Story 4

- [x] T043 [P] [US4] Configure JWT bearer authentication in `src/VisaFusion.Web/Program.cs` (single host; `AddAuthentication().AddJwtBearer()` with issuer/audience/key from configuration, NOT source)
- [x] T044 [P] [US4] Implement `GET /api/v1/health` endpoint in `src/VisaFusion.Api/Endpoints/HealthEndpoint.cs` returning status/version/environment per `contracts/api-v1-scaffolding.md`
- [x] T045 [US4] Implement one representative read-only endpoint per area (public, auth, employee, agent, admin, billing, reporting, notifications) in `src/VisaFusion.Api/Endpoints/` returning a minimal stub DTO (empty list + count) per `contracts/api-v1-scaffolding.md`; the employee representative endpoint invokes the shared rule from T038 (e.g., Canada DOB validation) to prove shared-Core wiring end-to-end (FR-004, AC-003)
- [x] T046 [US4] Configure `/api/v1` route versioning in `src/VisaFusion.Web/Program.cs` (single host; route prefix `api/v1`, version constraint)
- [x] T047 [US4] Add `[Authorize]` policy wiring for representative endpoints per the migration plan §4 role matrix (scaffolding enforces the policy)

**Checkpoint**: Api surface authenticates and responds - User Story 4 complete

---

## Phase 7: User Story 5 - Identity + Jobs (Priority: P2)

**Goal**: Identity project integration point (FR-007) and Jobs BackgroundService host (FR-008).

**Independent Test**: Solution builds; Jobs project starts with the host and registers the SMS/email/report worker placeholders; Identity project references ASP.NET Core Identity packages and compiles.

### Tests for User Story 5

- [x] T048 [P] [US5] Add functional test in `tests/FunctionalTests/JobsHostTests.cs` asserting the Jobs workers register and start with the host
- [x] T049 [US5] Add unit test asserting `VisaFusion.Identity` compiles against the ASP.NET Core Identity store contract (store interface placeholder present)

### Implementation for User Story 5

- [x] T050 [P] [US5] Add ASP.NET Core Identity packages to `src/VisaFusion.Identity/VisaFusion.Identity.csproj` (`Microsoft.AspNetCore.Identity`, `Microsoft.Extensions.Identity.Stores`)
- [x] T051 [P] [US5] Create Identity integration point in `src/VisaFusion.Identity/IdentityIntegration.cs` documenting the legacy mapping (`Udaan_users`/`agents`/`registration` -> `AspNetUsers`, `data-model.md` §2); store implementation deferred to Identity Consolidation feature
- [x] T052 [P] [US5] Create `SmsQueueWorker.cs`, `EmailQueueWorker.cs`, and `ReportWorker.cs` (BackgroundService placeholders) in `src/VisaFusion.Jobs/Workers/`
- [x] T053 [US5] Register workers in `src/VisaFusion.Jobs/Program.cs` (Jobs is a separate Worker process; HostedService registration in the Jobs host, spec FR-008)
- [x] T054 [US5] Ensure Jobs workers use the shared Core service surface (SmsService, EmailService placeholders) for queue processing

**Checkpoint**: Identity and Jobs projects integrated - User Story 5 complete

---

## Phase 8: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T055 [P] Security scan: grep `src/` and `tests/` for `pwd=|password=|uid=sa|sa123|connection string literals` (expect zero matches, AC-004, quickstart TS-004)
- [ ] T056 [P] SQL-injection scan: grep `src/` for string-concatenated SQL patterns (expect zero, AC-005, NFR-003)
- [ ] T057 [P] Backdoor check: verify `udaanappraj123guruadm` and `udaan12345functiondisplaymarquee` query parameters are not handled anywhere (AC-006, quickstart TS-005)
- [ ] T058 Run `specs/003-target-architecture/quickstart.md` end-to-end (TS-001..TS-005) and record results in the quickstart
- [ ] T059 [P] Update `knowledge-graph/kg.json` and `knowledge-graph/traceability-matrix.md` with SPEC-0003 nodes/edges (constitution Principle IV)
- [ ] T060 [P] Update `adr/ADR-0001.md` if any architecture decision changed during implementation, else add a new ADR for any new decision (e.g., JWT bearer for Api, Serilog+OTel)
- [ ] T061 Update feature documentation: mark spec status `Approved`, update `specs/003-target-architecture/checklists/requirements.md` and `checklists/architecture.md` check items to `[x]`
- [ ] T062 Final validation: `dotnet build VisaFusion.sln` + `dotnet test VisaFusion.sln` pass; commit increment with clean working tree

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - US1 -> US2 -> US3 -> US4 -> US5 sequential in priority order
  - US4 depends on US3 (uses shared Core surface); US5 depends on US3 (uses Core services)
- **Polish (Phase 8)**: Depends on all user stories complete

### User Story Dependencies

- **US1 (P1)**: Solution skeleton - after Foundational
- **US2 (P1)**: Hosting + Areas - after US1 (builds on buildable solution)
- **US3 (P1)**: Data + Core - after US1; independently testable against dev DB
- **US4 (P2)**: Api surface - after US3 (representative endpoints use Core services)
- **US5 (P2)**: Identity + Jobs - after US3; independently testable

### Within Each User Story

- Tests (included per constitution Principle V) MUST be written and FAIL before implementation
- Infrastructure before endpoints
- Core implementation before integration
- Story complete before moving to next priority

### Parallel Opportunities

- All Setup tasks marked [P] can run in parallel (project scaffolding)
- All Foundational tasks marked [P] can run in parallel (Serilog/OTel/tests)
- US3 and US2 can partially proceed in parallel after US1 (different projects)
- All Polish tasks marked [P] can run in parallel (scans, KG, ADR, docs)

---

## Parallel Example: User Story 1

```bash
# Launch solution-build smoke test and CI workflow together:
Task: "Add solution build smoke test in tests/FunctionalTests/BuildValidationTests.cs"
Task: "Add CI workflow .github/workflows/build.yml running dotnet build on every push/PR"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1 (buildable solution skeleton)
4. **STOP and VALIDATE**: `dotnet build VisaFusion.sln` passes
5. Commit; then proceed to US2/US3

### Incremental Delivery

1. Setup + Foundational -> Foundation ready
2. US1 Solution skeleton -> buildable -> MVP!
3. US2 Hosting + Areas -> runnable Web UI
4. US3 Data + Core -> DbContext + shared services
5. US4 Api surface + JWT -> `/api/v1` responds
6. US5 Identity + Jobs -> workers registered
7. Polish -> security scans, KG, ADR, docs

### Parallel Team Strategy

1. Team completes Setup + Foundational together
2. After US1: Developer A works US2 (Web), Developer B works US3 (Data/Core)
3. After US3: Developer A works US4 (Api), Developer B works US5 (Identity/Jobs)
4. Stories complete and integrate independently

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to the deliverable increment for traceability
- Each user story should be independently completable and testable
- Verify tests fail before implementing
- Commit after each task or logical group
- Stop at any checkpoint to validate the increment independently
- Avoid: vague tasks, same file conflicts, cross-story dependencies that break independence
- No schema changes in this feature (§16); Data Remediation feature (SPEC-0004) owns cleansing/FKs/indexes/drops
- Performance validation of high-volume history tables (NFR-002, spec §13) is deferred to the
  Data Remediation feature (indexes) and later module load testing; this feature only proves
  the schema is discoverable (T033)
- Single host resolution (spec FR-002): `VisaFusion.Web/Program.cs` is the one process hosting
  Razor Pages + `/api/v1` controllers; `VisaFusion.Api` is a class library (no Program.cs);
  `VisaFusion.Jobs` is a separate Worker process
