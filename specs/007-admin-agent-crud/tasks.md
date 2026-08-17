# Tasks: SPEC-0007 Agent/Admin Management, Security-Day Gate, Public Site, and Professional UI Theme

**Input**: Design documents from `/specs/007-admin-agent-crud/`

**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: Test tasks are included — the VisaFusion constitution mandates automated tests for every implementation.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- Solution root: `src/` (7 projects), `tests/` (UnitTests, IntegrationTests, FunctionalTests)
- API endpoints: `src/VisaFusion.Api/Endpoints/*.cs` (minimal-API pattern, `AuthorizationPolicies`)
- Business rules: interface in `src/VisaFusion.Core/Application/`, implementation in `src/VisaFusion.Data/Application/` (one-way Data → Core)
- Web pages: `src/VisaFusion.Web/Areas/*/Pages/` (Razor Pages area pattern)

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Branch, baseline verification, and legacy-data verification

- [x] T001 Create branch `007-admin-agent-crud` from master and switch to it (git checkout -b)
- [x] T002 [P] Run all three test suites to confirm the baseline is green before any change: `dotnet test tests/UnitTests` (138), `dotnet test tests/FunctionalTests` (135), `dotnet test tests/IntegrationTests` (52)
- [x] T003 [P] Verify the legacy `agents.Active` value convention against the live `VisaEntry` database (research.md R-007); if ambiguous, produce a gap report before choosing the deactivation mapping (blocks T006)

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T004 Apply DP-001: correct the `UserManagement` policy role set from `adm,su` to `adm,emp` in `src/VisaFusion.Api/Authorization/AuthorizationPolicies.cs` (line 47); `su` still passes via the inherited `adm` claim (IdentityClaims.EffectiveRoles)
- [x] T005 [P] Extend `ISecurityGateService` with `OpenDayAsync`/`CloseDayAsync`/`GetTodayAsync` in `src/VisaFusion.Core/Application/SecurityGateService.cs` and implement them in `src/VisaFusion.Data/Application/SecurityGateService.cs` (open inserts `SecurityDay` with `Openingtime`/`Openby`; close sets `Closingtime`/`Closedby`; 409 when already open, 404 when no open row)
- [x] T006 [P] Create `IAgentService` in `src/VisaFusion.Core/Application/AgentService.cs` and implementation in `src/VisaFusion.Data/Application/AgentService.cs`: atomic create (agent row + `agt` login + AgentId claim link, BR-009), deactivate (blocks login, preserves data, FR-004), reactivate (FR-022) — depends on T003 for the `Active` value convention (implementation hosted in `src/VisaFusion.Api/Application/AgentService.cs` — deviation log §8: Data cannot reference Identity)
- [x] T007 [P] Create `IUserManagementService` in `src/VisaFusion.Core/Application/UserManagementService.cs` and implementation in `src/VisaFusion.Data/Application/UserManagementService.cs`: whitelist create (`adm`,`emp`,`agt`,`guest`; `su` rejected, BR-004), deactivate (FR-023), su provisioning (su-only, audited, FR-006) (implementation hosted in `src/VisaFusion.Api/Application/UserManagementService.cs` — deviation log §8)
- [x] T008 [P] Create the design-token system `src/VisaFusion.Web/wwwroot/css/tokens.css` (colors, typography, spacing, radii as CSS custom properties, contrast ≥ 4.5:1 at definition time) and `src/VisaFusion.Web/wwwroot/css/theme.css` consuming the tokens (research.md R-009)
- [x] T009 [P] Replace the layout shell `src/VisaFusion.Web/Pages/Shared/_Layout.cshtml` with the sidebar + topbar shell (research.md R-003); remove AdminLTE assets `wwwroot/css/adminlte*.css` and `wwwroot/js/adminlte*.js` (AC-008)
- [x] T010 [P] Unit tests for the foundational services in `tests/UnitTests/`: `AgentLifecycleTests.cs` (deactivate/reactivate/atomic create), `SecurityDayTests.cs` (open/close/409/404), `UserManagementTests.cs` (whitelist, su-only provisioning)

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Agent CRUD (Priority: P1) 🎯 MVP

**Goal**: `adm`/`su` can create (with linked `agt` login), view, update, deactivate, and reactivate agent records (FR-001..004, FR-022; AC-001, AC-002, AC-016, AC-017).

**Independent Test**: `tests/IntegrationTests/AgentCrudIntegrationTests.cs` — create agent → login as the new `agt` works; deactivate → login rejected, data intact; reactivate → login restored; `emp` gets 403 on all agent-management endpoints.

### Tests for User Story 1 ⚠️

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [x] T011 [P] [US1] Unit tests for agent lifecycle + atomic create in `tests/UnitTests/AgentLifecycleTests.cs` (extends T010)
- [x] T012 [P] [US1] Integration tests for agent CRUD endpoints in `tests/IntegrationTests/AgentCrudIntegrationTests.cs`

### Implementation for User Story 1

- [x] T013 [P] [US1] Create agent contracts in `src/VisaFusion.Api/Contracts/` (`CreateAgentRequest`, `UpdateAgentRequest`, `AgentResponse`) per `contracts/agents-api.md` §1/§6
- [x] T014 [US1] Implement `AgentsEndpoint` in `src/VisaFusion.Api/Endpoints/AgentsEndpoint.cs`: `POST /api/v1/agents` (AdminPanel), `GET /api/v1/agents` (AdminPanel), `PUT /api/v1/agents/{id}` (AdminPanel), `POST /api/v1/agents/{id}/deactivate` and `/reactivate` (AdminPanel) — depends on T006, T013
- [x] T015 [US1] Implement admin agent pages in `src/VisaFusion.Web/Areas/Admin/Pages/Agents/` (list, detail, create, edit) on the new shell (T009)
- [x] T016 [US1] Wire agent pages to the endpoints with field-level validation (spec §17) and error handling (spec §18)

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - User Management (Priority: P1)

**Goal**: `adm`/`emp` can create users with a role whitelist; only `su` can provision super-users; user deletion is deactivation (FR-005..007, FR-023; AC-003, AC-018).

**Independent Test**: `tests/IntegrationTests/UserManagementIntegrationTests.cs` — create user with role `agt` succeeds; role `su` via `/admin/users` returns 400; su provisioning via `/admin/superusers` works only for `su`; deactivating an `su` target by non-`su` returns 403.

### Tests for User Story 2 ⚠️

- [x] T017 [P] [US2] Unit tests for role whitelist + su-only provisioning in `tests/UnitTests/UserManagementTests.cs` (extends T010) — DONE 2026-08-17 (uncommitted delta verified green: Unit 173/173)
- [x] T018 [P] [US2] Integration tests for user endpoints in `tests/IntegrationTests/UserManagementIntegrationTests.cs` — DONE 2026-08-17 (Integration 55/55)

### Implementation for User Story 2

- [x] T019 [P] [US2] Create user contracts in `src/VisaFusion.Api/Contracts/` (`CreateUserRequest`, `ProvisionSuperUserRequest`) per `contracts/admin-api.md` §4/§5 — DONE 2026-08-17 (`AdminContracts.cs`; plus `UserResponse` for §6)
- [x] T020 [US2] Implement `AdminEndpoint` in `src/VisaFusion.Api/Endpoints/AdminEndpoint.cs`: `POST /api/v1/admin/users` (UserManagement — DP-001), `POST /api/v1/admin/superusers` (SuperUserOnly), `POST /api/v1/admin/users/{id}/deactivate` (UserManagement; SuperUserOnly when target is `su`) — depends on T007, T019 — DONE 2026-08-17 (actor + roles resolved from validated JWT claims, GR-0004; routes wired in `src/VisaFusion.Web/Program.cs`)
- [ ] T021 [US2] Implement user management pages in `src/VisaFusion.Web/Areas/Admin/Pages/Users/` (list, create, deactivate) on the new shell (T009)

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Security-Day Gate (Priority: P1)

**Goal**: `adm`/`su` can open and close the working day; `emp` logins are blocked on closed days (FR-008..009; AC-004, AC-005).

**Independent Test**: `tests/IntegrationTests/SecurityDayIntegrationTests.cs` — open day as `adm` → `200`; `emp` login allowed; close day → `200`; `emp` login rejected; anonymous/`agt` open/close → 401/403; open an already-open day → 409; close with no open row → 404; **concurrency (CHK022)**: two concurrent opens for the same date → exactly one `200`, the other `409`; open racing close → no partial state.

### Tests for User Story 3 ⚠️

- [x] T022 [P] [US3] Unit tests for open/close day in `tests/UnitTests/SecurityDayTests.cs` (extends T010) — DONE 2026-08-17 (open/close/409/404 + concurrency CHK022 covered)
- [ ] T023 [P] [US3] Integration tests for security-day endpoints in `tests/IntegrationTests/SecurityDayIntegrationTests.cs`

### Implementation for User Story 3

- [ ] T024 [P] [US3] Create security-day contracts in `src/VisaFusion.Api/Contracts/` (`OpenDayRequest`, `CloseDayRequest`, `SecurityDayResponse`) per `contracts/admin-api.md` §1-§3
- [ ] T025 [US3] Implement security-day endpoints in `src/VisaFusion.Api/Endpoints/AdminEndpoint.cs`: `POST /api/v1/admin/security-day/open`, `POST /api/v1/admin/security-day/close`, `GET /api/v1/admin/security-day/today` (SecurityGate policy) — depends on T005, T024
- [ ] T026 [US3] Implement the security-day page in `src/VisaFusion.Web/Areas/Admin/Pages/SecurityDay/` (today status + open/close actions, `securityHome.asp` parity) on the new shell (T009)

**Checkpoint**: At this point, User Stories 1, 2 AND 3 should all work independently

---

## Phase 6: User Story 4 - Agent Self-Service Portal (Priority: P2)

**Goal**: `agt` can view their own entries, statuses, and statement, search their own data, and update their own record — all scoped to the claim-bound `AgentId` (FR-017..021; AC-012..015).

**Independent Test**: `tests/IntegrationTests/AgentPortalIntegrationTests.cs` — `agt` reads own entries/statement → 200; another agent's `{id}` → 403/404; `PUT /agents/{id}/self` own → 200, other → 403; search scoped to own agent.

### Tests for User Story 4 ⚠️

- [ ] T027 [P] [US4] Unit tests for own-agent scoping in `tests/UnitTests/AgentScopingTests.cs`
- [ ] T028 [P] [US4] Integration tests for portal endpoints in `tests/IntegrationTests/AgentPortalIntegrationTests.cs`

### Implementation for User Story 4

- [ ] T029 [P] [US4] Create portal contracts in `src/VisaFusion.Api/Contracts/` (`AgentEntriesResponse`, `AgentStatementResponse`) per `contracts/agents-api.md` §3/§4
- [ ] T030 [US4] Implement portal endpoints in `src/VisaFusion.Api/Endpoints/AgentsEndpoint.cs`: `GET /api/v1/agents/{id}/entries` (AgentSelf), `GET /api/v1/agents/{id}/statement` (AgentLedger), `PUT /api/v1/agents/{id}/self` (AgentSelf, own-only via claim-bound `AgentId`, BR-007) — depends on T014, T029
- [ ] T031 [US4] Implement portal pages in `src/VisaFusion.Web/Areas/Agent/Pages/` (home, entries, statuses, statement, account) on the new shell (T009)
- [ ] T046 [P] [US4] Implement `GET /api/v1/agents/{id}/statuses` (AgentSelf, own-only via claim-bound `AgentId`) in `src/VisaFusion.Api/Endpoints/AgentsEndpoint.cs` per `contracts/agents-api.md` §3a — adds FR-018 coverage (post-analyze F1 remediation)
- [ ] T047 [P] [US4] Implement `?q=` keyword filter on `GET /api/v1/agents/{id}/entries` and `/statuses` (`Search` policy, scoped to the claim-bound `{id}`, FR-021) in `src/VisaFusion.Api/Endpoints/AgentsEndpoint.cs` — post-analyze F2 remediation
- [ ] T048 [P] [US4] Integration tests for statuses + scoped search in `tests/IntegrationTests/AgentPortalIntegrationTests.cs` (own agent `?q=` → 200 filtered; other agent's `{id}` → 403/404; **CHK026**: `agt` without a linked `AgentId` claim → 403 on portal routes)

**Checkpoint**: At this point, User Stories 1-4 should all work independently

---

## Phase 7: User Story 5 - Public Site Parity (Priority: P2)

**Goal**: Public pages render with functional and content parity under the new theme, with the AdminLTE demo dropdown removed; contact queries are anonymous, validated, and rate-limited (FR-010..012; AC-006, AC-007).

**Independent Test**: `tests/FunctionalTests/PublicSiteParityTests.cs` — public pages render with parity content, UTF-8, no demo dropdown; `POST /api/v1/public/queries` → 201 then 429 past the rate limit.

### Tests for User Story 5 ⚠️

- [ ] T032 [P] [US5] Integration tests for the public queries endpoint in `tests/IntegrationTests/PublicQueriesIntegrationTests.cs`
- [ ] T033 [P] [US5] Functional tests for public pages in `tests/FunctionalTests/PublicSiteParityTests.cs`

### Implementation for User Story 5

- [ ] T034 [P] [US5] Implement `POST /api/v1/public/queries` in `src/VisaFusion.Api/Endpoints/PublicEndpoint.cs` (anonymous, validated, rate-limited per `contracts/public-api.md` §1)
- [ ] T035 [US5] Implement public pages in `src/VisaFusion.Web/Areas/Public/Pages/` (home, contact, queries, embassy, country info, visa info, forms, subscribe) per `contracts/ui-contract.md` §5 — no AdminLTE demo dropdown on home (AC-006)
- [ ] T036 [US5] Wire the public registration page to the existing SPEC-0005 Register flow (guest role only, FR-012)

**Checkpoint**: All user stories should now be independently functional

---

## Phase 8: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T037 [P] Run WCAG-AA automated checks (axe-core) against every rendered page; fix any contrast/focus/keyboard/label violations (AC-010)
- [ ] T038 [P] Verify UTF-8 on every page (`<meta charset="utf-8">`) and every API response (`charset=utf-8`) (AC-011)
- [ ] T039 [P] Assert no rendered page references AdminLTE assets and the assets are removed from `wwwroot` (AC-008)
- [ ] T040 [P] Verify audit events for user creation/deactivation, su provisioning, and security-day open/close (spec §19)
- [ ] T049 [P] Add observability for the new endpoints (spec §19 CHK030): structured Serilog events for auth failures, security-day gate conflicts (409), and deactivate/reactivate; OTel counters for public-query submissions and security-day open/close — in `src/VisaFusion.Api` (extend existing logging/telemetry wiring)
- [ ] T050 [P] Zero-state coverage (spec §14 CHK027): agent list, entries, statuses, and statement pages render an explicit empty-state message with no data — asserted in the functional suites
- [ ] T041 Run all three test suites: `dotnet test tests/UnitTests`, `dotnet test tests/IntegrationTests`, `dotnet test tests/FunctionalTests` — all green
- [ ] T042 Run the quickstart.md validation scenarios S1-S6 end-to-end
- [ ] T043 Update the knowledge graph: `knowledge-graph/kg.json` and `knowledge-graph/traceability-matrix.md` (constitution G4)
- [ ] T044 Update documentation: deviation log, validation report, release notes (constitution DoD)
- [ ] T045 Commit the feature branch and push; open the PR against master

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - User stories can then proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2)
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 2 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 3 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 4 (P2)**: Depends on US1 (reuses `AgentsEndpoint` T014) but is independently testable
- **User Story 5 (P2)**: Can start after Foundational (Phase 2) - No dependencies on other stories

### Within Each User Story

- Tests MUST be written and FAIL before implementation
- Contracts before endpoints
- Endpoints before pages
- Core implementation before integration
- Story complete before moving to next priority

### Parallel Opportunities

- All Setup tasks marked [P] can run in parallel
- All Foundational tasks marked [P] can run in parallel (within Phase 2)
- Once Foundational phase completes, US1, US2, US3, and US5 can start in parallel (US4 after US1)
- All tests for a user story marked [P] can run in parallel
- Different user stories can be worked on in parallel by different team members

---

## Parallel Example: User Story 1

```bash
# Launch all tests for User Story 1 together:
Task: "Unit tests for agent lifecycle + atomic create in tests/UnitTests/AgentLifecycleTests.cs"
Task: "Integration tests for agent CRUD endpoints in tests/IntegrationTests/AgentCrudIntegrationTests.cs"

# Launch contracts and pages for User Story 1 together:
Task: "Create agent contracts in src/VisaFusion.Api/Contracts/"
Task: "Implement admin agent pages in src/VisaFusion.Web/Areas/Admin/Pages/Agents/"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1 (Agent CRUD)
4. **STOP and VALIDATE**: Test User Story 1 independently
5. Deploy/demo if ready

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 (Agent CRUD) → Test independently → Deploy/Demo (MVP!)
3. Add User Story 2 (User Management) → Test independently → Deploy/Demo
4. Add User Story 3 (Security-Day Gate) → Test independently → Deploy/Demo
5. Add User Story 4 (Agent Portal) → Test independently → Deploy/Demo
6. Add User Story 5 (Public Site) → Test independently → Deploy/Demo
7. Each story adds value without breaking previous stories

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: User Story 1 (Agent CRUD)
   - Developer B: User Story 2 (User Management)
   - Developer C: User Story 3 (Security-Day Gate)
   - Developer D: User Story 5 (Public Site)
3. Developer A then continues with User Story 4 (Agent Portal) after US1
4. Stories complete and integrate independently

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Verify tests fail before implementing
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- Known gap carried from the quality checklist: initial-password delivery for new agent logins (CHK002) — the create contract includes the password field; out-of-band delivery is assumed until email/SMS lands in Phase 2
- Avoid: vague tasks, same file conflicts, cross-story dependencies that break independence