# Tasks: Solution Scaffold Completion, Identity Consolidation & RBAC (SPEC-0005)

**Input**: Design documents from `/specs/005-scaffold-identity-rbac/`

**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: The spec explicitly requests automated tests — §20 Acceptance Criteria (AC-001..AC-012), §23 Test Scenarios (TS-001..TS-014), and plan.md "Phase 0 verification via automated tests". Test tasks are therefore included per story and MUST be written FIRST and fail before implementation.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- Solution root: repository root (`G:\Projects\VisaEntry`)
- Source: `src/` per plan.md §Project Structure (six-project layout from SPEC-0003)
- Tests: `tests/UnitTests`, `tests/FunctionalTests`, `tests/IntegrationTests` (existing three test projects, plan.md §Technical Context)

**User stories (from spec §5 scope delta, priority order):**
- **US1** Identity host integration (FR-005/006/007/008/009/017) — P1, MVP
- **US2** Employee day-gate enforced in login (FR-018) — P1
- **US3** Self-service change-password (FR-019) — P2
- **US4** RBAC enforcement (FR-010/011/012/015/016 + deferred contracts FR-013/014) — P2
- **US5** Legacy URL rewrite (FR-003) — P3

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Re-verify the SPEC-0003/SPEC-0004 baseline the feature builds on (scaffold already exists — no project initialization is needed) and confirm the branch is clean.

- [x] T001 Build the full solution and boot `VisaFusion.Web` with no external services beyond SQL Server (re-verifies FR-001/FR-002; `dotnet build VisaFusion.sln`) — build verified 2026-08-11: succeeded, 0 warnings / 0 errors
- [x] T002 [P] Verify the identity-store NuGet reference (`Microsoft.Extensions.Identity.Stores`) is already referenced by `src/VisaFusion.Identity/VisaFusion.Identity.csproj` and confirm no new NuGet packages are required (plan.md §Technical Context), then record the confirmation in the feature docs — VERIFIED 2026-08-11: `Microsoft.Extensions.Identity.Stores 8.0.20` present. **DEVIATION**: the plan's "no new packages" assumption is falsified — the installed 8.0.29 shared framework does not ship `Microsoft.AspNetCore.Identity.EntityFrameworkCore` (nor any EF Core assembly); `Microsoft.AspNetCore.Identity.EntityFrameworkCore 8.0.20` was added to `VisaFusion.Identity.csproj` (version aligned with EF Core/Identity.Stores 8.0.20; EF Core itself flows transitively from `VisaFusion.Data`)

**Checkpoint**: Baseline verified — Phase 2 can start.

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented.

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T003 [P] Create `VisaFusionIdentityDbContext` (IdentityDbContext<VisaFusionUser, IdentityRole, string>) mapping `AspNetUsers`/`AspNetRoles`/`AspNetUserRoles` plus the auxiliary tables (`AspNetUserClaims`, `AspNetRoleClaims`, `AspNetUserLogins`, `AspNetUserTokens`) with the custom columns `LegacyUdaanUserId`/`LegacyRegistrationId`/`AgentId` in `src/VisaFusion.Identity/Persistence/VisaFusionIdentityDbContext.cs` (spec §16, data-model.md §1) — delivered 2026-08-11
- [x] T004 [P] Extend `IdentityImporter.EnsureIdentitySchemaAsync` DDL idempotently with the four standard auxiliary Identity tables so the full store contract exists in the target `VisaFusion` database — `src/VisaFusion.Migration/Identity/IdentityImporter.cs` (spec §16; keep the identity step re-runnable) — delivered 2026-08-11 (tables added inside the same `IF OBJECT_ID('AspNetUsers','U') IS NULL` guard; step stays re-runnable)
- [x] T005 [P] Create the auth request/response contracts `LoginRequest.cs`, `LoginResponse.cs`, `RegisterRequest.cs`, `ChangePasswordRequest.cs` in `src/VisaFusion.Api/Contracts/` (reuse `ApiError.cs`; spec §15, contracts/auth-api.md) — delivered 2026-08-11

**Checkpoint**: Foundation ready — user story implementation can now begin in parallel.

---

## Phase 3: User Story 1 - Identity Host Integration (Priority: P1) 🎯 MVP

**Goal**: Register ASP.NET Core Identity against the migrated store; real `POST /api/v1/auth/login` / `logout` / `POST /api/v1/public/register`; Web `/Auth/Login` + `/Auth/AccessDenied` pages; token claims carry roles + claim-bound `AgentId`; `active`→lockout import alignment. Delivers Phase 0 exit criterion "login works for all 5 roles against migrated (hashed) credentials" (AC-001/NFR-002, FR-005/006/007/008/009/017).

**Independent Test**: Functional test signs in one user per role (`su`/`adm`/`emp`/`agt`/`guest`) against the consolidated store (AC-001/TS-001 — the `emp` case runs with `ISecurityGateService` stubbed open-day), verifies no plaintext in DB/logs (AC-002/TS-002), and asserts an inactive migrated account is blocked (AC-010/TS-010).

### Tests for User Story 1 (requested by spec §20/§23) ⚠️

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [x] T006 [P] [US1] Unit tests for claim resolution — role/`AgentId`/`SuperUser` claim types and the AgentId-from-claims helper (FR-007/FR-008) in `tests/UnitTests` — delivered 2026-08-11 (`tests/UnitTests/IdentityClaimsTests.cs`, 11 tests, all green)
- [x] T007 [P] [US1] Functional test for 5-role login + token claims (AC-001/TS-001; hermetic `WebApplicationFactory`, `ISecurityGateService` stubbed open-day, token-minted with test-config key) in `tests/FunctionalTests` — delivered 2026-08-11 (`tests/FunctionalTests/AuthLoginTests.cs`, 9 tests incl. malformed-JSON→400, all green; EF InMemory store in `VisaFusionWebApplicationFactory`, test-only package deviation — see deviation log §4). NOTE: the day-gate is wired in US2, so no `ISecurityGateService` stub is needed yet — the `emp` login case passes through the gate-free path (stub arrives with T019)
- [x] T008 [P] [US1] Integration tests: inactive account cannot sign in (AC-010/TS-010) and no plaintext password retrievable in DB (AC-002/TS-002; self-skipping when SQL Server is unreachable) in `tests/IntegrationTests` — delivered 2026-08-11 (`tests/IntegrationTests/IdentityLockoutTests.cs`, 6 tests + 2 `IdentityActive` parse-rule unit tests, all green against the live `VisaFusion` DB; rows cleaned up after each test)

### Implementation for User Story 1

- [x] T009 [US1] Register `AddIdentityCore<VisaFusionUser>` + roles + `VisaFusionIdentityDbContext` + password options (min 8, no complexity) in `src/VisaFusion.Web/Program.cs` (FR-017, spec §12) — delivered 2026-08-11 (IdentityConstants.ApplicationScheme cookie scheme, LoginPath/AccessDeniedPath, config-driven cookie lifetime CHK040)
- [x] T010 [P] [US1] Create `IdentityClaims` claim types + AgentId resolution helper in `src/VisaFusion.Api/Authorization/IdentityClaims.cs` (FR-007/FR-008) — delivered 2026-08-11
- [x] T011 [US1] Implement `POST /api/v1/auth/login` (validates against the migrated store, returns JWT with role claims + claim-bound `AgentId` + `SuperUser` claim; 401 bad credentials) and `POST /api/v1/auth/logout` in `src/VisaFusion.Api/Endpoints/AuthEndpoint.cs` (depends on T010; FR-017, contracts/auth-api.md §1–2) — delivered 2026-08-11 (JwtBearer 8.0.20 added to `VisaFusion.Api.csproj` — deviation log §4; GET auth stub superseded, `ApiSurfaceTests` updated)
- [x] T012 [US1] Implement `POST /api/v1/public/register` (role fixed server-side to `guest`, password policy min 8, unique username/email, never assigns a privileged role — FR-012) with rate limiting configured per the R7 decision (configuration-driven only, no invented thresholds) in `src/VisaFusion.Api/Endpoints/PublicEndpoint.cs` (depends on T005, T009) — delivered 2026-08-11 (rate limiter registered + `UseRateLimiter` wired only when the owner supplies thresholds; orphaned-user rollback on role-assignment failure)
- [x] T013 [P] [US1] Create Web `/Auth/Login` Razor Page (cookie sign-in; renders `rsn` reason inline; legacy `relogin.asp?rsn=` mirror) in `src/VisaFusion.Web/Pages/Auth/Login.cshtml` + `.cs` (spec §14) — delivered 2026-08-11 (local-only returnUrl redirect)
- [x] T014 [P] [US1] Create Web `/Auth/AccessDenied` Razor Page in `src/VisaFusion.Web/Pages/Auth/AccessDenied.cshtml` + `.cs` (spec §14) — delivered 2026-08-11
- [x] T015 [US1] Align the identity importer with §7: read `active` from all three legacy sources, set `LockoutEnabled = !active` and a FAR-FUTURE `LockoutEnd` for inactive accounts (fixes the hardcoded `LockoutEnabled=1` deviation at `IdentityImporter.cs` line 188; the 2026-08-11 correction supersedes the earlier "past LockoutEnd" draft — a past `LockoutEnd` does NOT block `IsLockedOutAsync`) in `src/VisaFusion.Migration/Identity/IdentityImporter.cs` (FR-009, data-model.md §4.3; sequential with T004 — same file) — delivered 2026-08-11 (`IdentityActive.cs` parse rule: only explicit `'N'` is inactive; NULL/`'Y'` active — verified live, data-model.md §4.3)

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently (5-role login works).

---

## Phase 4: User Story 2 - Employee Day-Gate (Priority: P1)

**Goal**: Enforce the legacy day-gate for `emp` logins on both surfaces — login succeeds iff a `security` row exists for today with `closingtime IS NULL`; otherwise rejected with `rsn=O` (`rsn=C` is legacy dead code and NOT produced). Web redirects `/Auth/Login?rsn=O`; API returns 403 with `{ rsn: "O" }` (FR-018, AC-011/TS-013, `authenticate.asp` lines 62–79).

**Independent Test**: Integration test seeds the `security` table (no row today / row with closing time set / open row) and asserts `403 rsn=O` / `403 rsn=O` / success for `emp`; unit tests prove the evaluation and that `rsn=C` is never produced.

### Tests for User Story 2 (requested by spec §20/§23) ⚠️

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [ ] T016 [P] [US2] Unit tests for the day-gate evaluation (open day / no row / closed row → `rsn=O`; `rsn=C` never produced) in `tests/UnitTests` (AC-011/TS-013, FR-018)
- [ ] T017 [P] [US2] Integration test seeding the `security` table: no row today / row with closing time set / open row → `403 rsn=O` / `403 rsn=O` / success (TS-013; self-skipping when SQL Server is unreachable) in `tests/IntegrationTests`

### Implementation for User Story 2

- [ ] T018 [US2] Implement the day-gate evaluation on `ISecurityGateService`/`SecurityGateService` in `src/VisaFusion.Core/Application/SecurityGateService.cs` (single-source business rule shared by Web + API; reads `SecurityDay` via `VisaEntryDbContext` — read-only, `security` table; FR-018, data-model.md §2.1)
- [ ] T019 [US2] Wire the day-gate into the API login (`emp` only; rejected → 403 with `{ rsn: "O" }` problem-details body) in `src/VisaFusion.Api/Endpoints/AuthEndpoint.cs` (depends on T018, T011)
- [ ] T020 [US2] Wire the day-gate into the Web cookie login (`emp` only; rejected → redirect `/Auth/Login?rsn=O`) in `src/VisaFusion.Web/Pages/Auth/Login.cshtml.cs` (depends on T018, T013)

**Checkpoint**: At this point, User Stories 1 AND 2 both work independently — the Phase 0 `emp` login path is complete.

---

## Phase 5: User Story 3 - Self-Service Change-Password (Priority: P2)

**Goal**: A signed-in user changes their own password on Web (`/Auth/ChangePassword`) and API (`POST /api/v1/auth/change-password`), replacing `changepassword.asp` + `newpassword.asp`; new password meets the policy (min 8, no forced complexity), stored hashed via `UserManager.ChangePasswordAsync` without legacy lowercasing (FR-019, AC-012/TS-014). The for-agent password set is a documented contract only (deferred).

**Independent Test**: Functional test asserts change-password outcomes — `204` success with a stored hash (no lowercase, no plaintext), `400` for wrong current password, new ≠ confirm, and under-8-characters (TS-014).

### Tests for User Story 3 (requested by spec §20/§23) ⚠️

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [ ] T021 [P] [US3] Functional test for change-password outcomes (valid → 204 + stored hash, no lowercase/plaintext; wrong current / new≠confirm / under 8 chars → 400) in `tests/FunctionalTests` (AC-012/TS-014)

### Implementation for User Story 3

- [ ] T022 [P] [US3] Create Web `/Auth/ChangePassword` Razor Page (inline success / mismatch / policy-violation messages mirroring `changepassword.asp?flag=1|2|3`) in `src/VisaFusion.Web/Pages/Auth/ChangePassword.cshtml` + `.cs` (spec §14, contracts/web-ui.md §1.4)
- [ ] T023 [US3] Implement `POST /api/v1/auth/change-password` (current-password verified via `UserManager`, new password policy-validated, stored via `ChangePasswordAsync`, 204/400) in `src/VisaFusion.Api/Endpoints/AuthEndpoint.cs` (depends on T022; FR-019, contracts/auth-api.md §3)

**Checkpoint**: User Stories 1–3 all work independently (identity, day-gate, password self-service).

---

## Phase 6: User Story 4 - RBAC Enforcement (Priority: P2)

**Goal**: Authorization policy catalog (11 policies from the §4.2 matrix) applied to every endpoint; 11 §4.3 anonymous write routes re-secured with named target routes + minimum roles returning 501 until their module feature; 2 public-by-design routes stay anonymous with validation + rate limiting; backdoor query parameters inert; agent-scoped reads enforce ownership (FR-010/011/012/015/016, AC-003/004/005/006, TS-003/004/005/006).

**Independent Test**: Functional test asserts each §4.3 route: anonymous → 401, wrong role → 403, correct role → 501 (TS-004); registration escalation rejected + under-8-char password rejected (TS-005); backdoor params have no effect (TS-006); agent A reading agent B's data via manipulated id → 403 (TS-003).

### Tests for User Story 4 (requested by spec §20/§23) ⚠️

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [ ] T024 [P] [US4] Unit tests for the policy catalog — each of the 11 policies maps to the correct §4.2 role set (EntryOperations, AgentSelf, AgentLedger, BillingOperations, Search, UserManagement, HolidayAdmin, SecurityGate, PasswordSelf, AdminPanel, SuperUserOnly) in `tests/UnitTests`
- [ ] T025 [P] [US4] Functional test for the 13 §4.3 endpoints matrix — anonymous → 401, wrong role → 403, correct role → 501 (or success for the 2 public routes) in `tests/FunctionalTests` (AC-004/TS-004; token-minted per role)
- [ ] T026 [P] [US4] Functional test: registration escalation attempt rejected (privileged role in payload ignored → `guest`), registration password under 8 chars rejected (AC-005/TS-005) in `tests/FunctionalTests`
- [ ] T027 [P] [US4] Functional tests: backdoor query params (`udaanappraj123guruadm`, `udaan12345functiondisplaymarquee`) have no effect on any route (AC-006/TS-006); agent isolation — agent A requesting agent B's id → 403 (AC-003/TS-003) in `tests/FunctionalTests`

### Implementation for User Story 4

- [ ] T028 [P] [US4] Create the authorization policy catalog (11 policies derived from the §4.2 module × role matrix) in `src/VisaFusion.Api/Authorization/AuthorizationPolicies.cs` (spec §5, FR-010)
- [ ] T029 [P] [US4] Create the shared `SecuredPlaceholderEndpoint` handler (auth + role + 501 Not Implemented for routes whose module feature has not landed) in `src/VisaFusion.Api/Authorization/SecuredPlaceholderEndpoint.cs` (spec §15, plan.md §Constraints)
- [ ] T030 [US4] Register the 11 role-secured §4.3 write routes with named target routes + minimum roles (501 until module feature) and the 2 public-by-design routes (anonymous, validated, rate-limited per §17/R7 — configuration-driven only) — `POST /api/v1/entries/{refno}/status`, `POST /api/v1/billing/entries`, `DELETE /api/v1/holidays/{id}`, `POST/DELETE /api/v1/holidays`, `POST /api/v1/entries/{refno}/awb`, `POST /api/v1/reports/agent-status/today`, `POST /api/v1/admin/security-day/open`, `POST /api/v1/admin/security-day/close`, `POST /api/v1/entries`, `PUT /api/v1/agents/{id}`, `PUT /api/v1/agents/{id}/self`, `POST /api/v1/public/queries` — registered in `src/VisaFusion.Web/Program.cs` following the existing `app.MapGet("/api/v1/...")` pattern (handlers/501 placeholder in `src/VisaFusion.Api/`; depends on T028, T029; sequential with T009/T031 — shared Program.cs; FR-011/012)
- [ ] T031 [US4] Apply the policy catalog to the existing representative endpoints, replacing inline role lists, and enforce claim-bound `AgentId` scoping on agent status/statement reads (FR-010/016) in `src/VisaFusion.Api/Endpoints/` (registrations updated in `src/VisaFusion.Web/Program.cs`; depends on T028; sequential with T030 — shared Program.cs), and log authorization denials (subject, endpoint, outcome) without any password material per spec §19/NFR-006

**Checkpoint**: User Stories 1–4 all work independently — the full trust boundary is enforced.

---

## Phase 7: User Story 5 - Legacy URL Rewrite (Priority: P3)

**Goal**: Middleware maps the documented legacy entry URLs (`Default.asp`, `authenticate.asp`, `logon.asp`, `regsub*.asp`) to `/`, `/Auth/Login`, `/Auth/Register` via 301 redirects; any other `.asp` URL → clear 404, no wildcard forwarding (FR-003, NFR-005, AC-007/TS-007).

**Independent Test**: Functional test asserts legacy entry URLs resolve to their rewritten targets and an unknown `.asp` URL returns 404 (TS-007).

### Tests for User Story 5 (requested by spec §20/§23) ⚠️

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [ ] T032 [P] [US5] Unit tests for the rewrite mapping table (known entry URLs → target routes; unknown/ambiguous `.asp` → 404) in `tests/UnitTests` (AC-007/TS-007)
- [ ] T033 [P] [US5] Functional test: bookmarked legacy `.asp` URLs resolve; unknown legacy URLs → 404 (AC-007/TS-007) in `tests/FunctionalTests`

### Implementation for User Story 5

- [ ] T034 [US5] Implement `LegacyUrlRewriteMiddleware` (301 redirects for the four documented entry URL patterns; 404 for other `.asp` URLs; no extra round trip) in `src/VisaFusion.Web/Middleware/LegacyUrlRewriteMiddleware.cs` (FR-003, NFR-005)
- [ ] T035 [US5] Register the rewrite middleware in the pipeline in `src/VisaFusion.Web/Program.cs` (depends on T034; sequential with T009 — same file)

**Checkpoint**: All user stories independently functional.

---

## Phase 8: Polish & Cross-Cutting Concerns

**Purpose**: Phase 0 verification, governance, and repository hygiene that touch multiple user stories.

- [ ] T036 [P] Run the Phase 0 end-to-end verification per `quickstart.md`: build + boot + 5-role login, static assets self-hosted (AC-008/TS-008), SQL-injection regression `'` inputs stay parameterized (TS-011), golden-file parity where applicable (TS-012), identity import re-run is a no-op (AC-009/TS-009) — complements T007 (the functional 5-role login test); this task is the post-implementation end-to-end validation run
- [ ] T037 [P] Security spot-checks per `quickstart.md` §5: no plaintext password material in logs/responses/config, backdoor params inert, `ProductionSecretsGuard` fails fast in Production
- [ ] T038 [P] Update the knowledge graph (`knowledge-graph/kg.json` + `knowledge-graph/traceability-matrix.md`) with SPEC-0005 completion — FR/AC/TS → components/endpoints/tests per spec §24 — and update the decision log (no new ADR required: ADR-0001 baseline + the two 2026-08-11 clarification decisions are already recorded); per the constitution Mission (knowledge graph updated after every completed task), sync `kg.json` at each completed implementation milestone during the run, not only at the end
- [ ] T039 [P] Documentation updates: this feature's docs (contracts remain current), solution-level release notes for Phase 0, and the spec traceability matrix cross-check (constitution Principle IV/V)

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies — baseline re-verification
- **Foundational (Phase 2)**: Depends on Setup — BLOCKS all user stories (`VisaFusionIdentityDbContext`, auxiliary DDL, contracts)
- **User Stories (Phase 3+)**: All depend on Foundational completion
  - US2 depends on US1 login flow (T019 on T011, T020 on T013) — same `AuthEndpoint.cs`/`Login` files
  - US3 depends on US1 (change-password on the registered identity services)
  - US4 depends on US1 (identity/auth host) but is otherwise independent of US2/US3
  - US5 depends only on Foundational — fully parallel to US1–US4
- **Polish (Phase 8)**: Depends on all user stories complete (Phase 0 verification)

### User Story Dependencies

- **US1 (P1)**: Can start after Foundational — no dependencies on other stories
- **US2 (P1)**: Can start after Foundational + US1 (needs the login endpoints)
- **US3 (P2)**: Can start after Foundational + US1 (needs registered identity services)
- **US4 (P2)**: Can start after Foundational + US1 (needs the auth host)
- **US5 (P3)**: Can start after Foundational — no dependency on US1–US4

### Within Each User Story

- Tests MUST be written and FAIL before implementation
- Core domain rule before endpoints (T018 before T019/T020)
- Shared-file edits are ordered: `Program.cs` (T009 → T030/T031 → T035), `AuthEndpoint.cs` (T011 → T019 → T023), `IdentityImporter.cs` (T004 → T015)

### Parallel Opportunities

- All Setup/Foundational tasks marked [P] can run in parallel (T002, T003, T004, T005)
- All tests within a story marked [P] run in parallel (T006–T008, T016–T017, T024–T027, T032–T033)
- Story phases can proceed in parallel once Foundational is complete (US1 + US5; then US2/US3/US4 after US1's login)
- Polish tasks T036–T039 run in parallel after the user stories

---

## Parallel Example: User Story 1

```text
# Launch all tests for User Story 1 together:
Task: "Unit tests for claim resolution in tests/UnitTests"
Task: "Functional test for 5-role login + token claims in tests/FunctionalTests"
Task: "Integration tests: inactive account + no-plaintext in tests/IntegrationTests"

# Launch all implementation leaf tasks together:
Task: "Create IdentityClaims helper in src/VisaFusion.Api/Authorization/IdentityClaims.cs"
Task: "Create Web /Auth/Login page in src/VisaFusion.Web/Pages/Auth/Login.cshtml"
Task: "Create Web /Auth/AccessDenied page in src/VisaFusion.Web/Pages/Auth/AccessDenied.cshtml"
```

---

## Parallel Example: User Story 4

```text
Task: "Unit tests for the policy catalog in tests/UnitTests"
Task: "Functional test for the §4.3 endpoints matrix in tests/FunctionalTests"
Task: "Create AuthorizationPolicies catalog in src/VisaFusion.Api/Authorization/AuthorizationPolicies.cs"
Task: "Create SecuredPlaceholderEndpoint in src/VisaFusion.Api/Authorization/SecuredPlaceholderEndpoint.cs"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup (baseline re-verification)
2. Complete Phase 2: Foundational (CRITICAL — blocks all stories)
3. Complete Phase 3: User Story 1 (identity host integration)
4. **STOP and VALIDATE**: 5-role login works (AC-001/TS-001) with the day-gate stubbed open-day
5. Deploy/demo if ready — Phase 0 exit criterion largely met

### Incremental Delivery

1. Complete Setup + Foundational → foundation ready
2. Add US1 → test independently → 5-role login works (Phase 0 exit criterion)
3. Add US2 → test independently → `emp` day-gate enforced (full Phase 0)
4. Add US3 → test independently → password self-service
5. Add US4 → test independently → full RBAC trust boundary
6. Add US5 → test independently → legacy URL transition window
7. Polish → Phase 0 verification + governance

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: US1 (identity host integration)
   - Developer B: US5 (URL rewrite — fully independent)
3. Once US1 lands:
   - Developer A: US2 (day-gate)
   - Developer B: US3 (change-password)
   - Developer C: US4 (RBAC)
4. Stories complete and integrate independently; shared-file edits (`Program.cs`, `AuthEndpoint.cs`) follow the ordered sequence above

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Verify tests fail before implementing
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- Avoid: vague tasks, same file conflicts, cross-story dependencies that break independence
- Grounding: every file path above comes from plan.md §Project Structure; every FR/AC/TS citation from spec.md §5/§9/§15/§20/§23 (as re-clarified 2026-08-11); no invented identifiers
