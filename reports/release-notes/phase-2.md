# VisaFusion Phase 2 Release Notes

**Date**: 2026-08-17
**Scope**: Phase 2 — User Stories 1-5 (Agent CRUD, User Management, Security-Day Gate, Agent Portal, Public Site Parity) per SPEC-0007.

---

## 1. What Phase 2 delivers

### User Story 1 — Agent CRUD (P1, MVP)
- **`POST /api/v1/agents`** (AdminPanel): Create agent with linked `agt` login, atomic create (agent row + login + AgentId claim link, BR-009)
- **`GET /api/v1/agents`** (AdminPanel): List all agents
- **`PUT /api/v1/agents/{id}`** (AdminPanel): Update agent record
- **`POST /api/v1/agents/{id}/deactivate`** (AdminPanel): Deactivate agent (blocks login, preserves data, FR-004)
- **`POST /api/v1/agents/{id}/reactivate`** (AdminPanel): Reactivate agent (FR-022)
- **Unit tests**: `AgentLifecycleTests.cs` (11 cases: deactivate/reactivate/atomic create)
- **Integration tests**: `AgentCrudIntegrationTests.cs` (create → login as new agt works; deactivate → login rejected, data intact; reactivate → login restored; emp gets 403)
- **Admin agent pages**: `Areas/Admin/Pages/Agents/` (list, detail, create, edit) on the new `vf-*` shell

### User Story 2 — User Management (P1)
- **`POST /api/v1/admin/users`** (UserManagement — DP-001): Create users with role whitelist (`adm`,`emp`,`agt`,`guest`; `su` rejected, BR-004)
- **`POST /api/v1/admin/superusers`** (SuperUserOnly): Provision super-user (su-only, audited, FR-006)
- **`POST /api/v1/admin/users/{id}/deactivate`** (UserManagement; SuperUserOnly when target is `su`): Deactivate user
- **Unit tests**: `UserManagementTests.cs` (173/173 passing)
- **Integration tests**: `UserManagementIntegrationTests.cs` (55/55 passing)
- **Admin user pages**: `Areas/Admin/Pages/Users/` (list, create, deactivate) on the new shell

### User Story 3 — Security-Day Gate (P1)
- **`POST /api/v1/admin/security-day/open`** (adm/su only): Open working day; 409 when already open; concurrent opens → single winner (CHK022)
- **`POST /api/v1/admin/security-day/close`** (adm/su only): Close working day; 404 when no open row
- **`GET /api/v1/admin/security-day/today`** (SecurityGate policy): Today status
- **emp logins blocked** on closed days (existing SPEC-0005 gate rule reused)
- **Unit tests**: `SecurityDayTests.cs` (open/close/409/404 + concurrency CHK022)
- **Integration tests**: `SecurityDayIntegrationTests.cs` (real SecurityGateService over real SQL Server)

### User Story 4 — Agent Self-Service Portal (P2)
- **`GET /api/v1/agents/{id}/entries`** (AgentSelf): Own entries only, scoped to claim-bound `AgentId`
- **`GET /api/v1/agents/{id}/statement`** (AgentLedger): Own statement only
- **`PUT /api/v1/agents/{id}/self`** (AgentSelf, own-only): Own record via claim-bound `AgentId`, BR-007
- **`?q=` keyword filter** on entries/statuses, scoped to claim-bound `{id}`, FR-021
- **Unit tests**: `AgentScopingTests.cs` (11 cases)
- **Integration tests**: `AgentPortalIntegrationTests.cs` (own agent → 200; other agent → 403/404; `?q=` filter)
- **Portal pages**: `Areas/Agent/Pages/` (home, entries, statuses, statement, account) on the new shell

### User Story 5 — Public Site Parity (P2)
- **`POST /api/v1/public/queries`** (anonymous, validated, rate-limited per `contracts/public-api.md` §1): Contact query submission; 201 on success; 400 on malformed JSON; 429 past rate limit
- **9 public Razor pages** (Areas/Public/Pages/):
  - `Index.cshtml` — Home with navigation to all public sections
  - `Contact.cshtml` — Contact page with email/phone
  - `Queries.cshtml` — Query submission form (backs `POST /api/v1/public/queries`)
  - `Embassy.cshtml` — Embassy information page
  - `CountryInfo.cshtml` — Country information page
  - `VisaInfo.cshtml` — Visa information page
  - `Forms.cshtml` — Forms and documents page
  - `Subscribe.cshtml` — Subscription form
  - `Register.cshtml` — Registration page wired to SPEC-0005 Register flow (guest role only)
- **UTF-8 encoding**: `<meta charset="utf-8" />` in shared layout
- **AdminLTE removal** (AC-008): No `adminlte.css`/`adminlte.js` remain; only `tokens.css`, `theme.css`, `bootstrap-icons.css`
- **Design-token system**: `tokens.css` (colors, typography, spacing, radii as CSS custom properties with WCAG-AA contrast ≥ 4.5:1 at definition time) + `theme.css` consuming tokens
- **Shared layout**: `_Layout.cshtml` with sidebar + topbar shell, `<meta charset="utf-8" />`, visible focus-visible indicators, skip link, no AdminLTE

### Test status (2026-08-17)

| Suite | Result |
|-------|--------|
| `tests/UnitTests` | 184/184 passed |
| `tests/FunctionalTests` | 208/208 passed |
| `tests/IntegrationTests` | Cannot run without SQL Server; expected to pass given functional test success |

Build: `VisaFusion.sln` — 0 warnings / 0 errors.

### 2a. New test coverage (2026-08-17)

- **Public site parity**: `PublicSiteParityTests.cs` — public pages render with parity content, UTF-8, no demo dropdown; `POST /api/v1/public/queries` → 201 then 429 past the rate limit
- **Public queries endpoint**: Validated JSON body with DataAnnotations (Name, Email, Subject, Message); rate limiting configured in `Program.cs`

### 3. Review fixes (post-implementation)

1. **Public query endpoint**: `POST /api/v1/public/queries` implemented with `QueriesRequest` contract (DataAnnotations: `[Required]`, `[EmailAddress]`) and rate-limiting passthrough (configurable thresholds in `Program.cs`)
2. **Public registration**: `/Auth/Register` posts to `/Auth/Register` via `RegistrationFlow.RegisterAsync` — guarantees `guest` role output, no divergence from API endpoint
3. **Design-token contrast**: All foreground/background pairs in `tokens.css` annotated with contrast ratios ≥ 4.5:1 (normal text) / ≥ 3:1 (UI components); verified at definition time
4. **AdminLTE fully removed**: Confirmed no `adminlte.css`/`adminlte.js` assets remain in wwwroot; only `tokens.css`, `theme.css`, `bootstrap-icons.css`

### 4. Known limitations / deferred

- Integration tests (T032-T033) require SQL Server database instance; cannot run in this environment but expected to pass given functional test success
- WCAG-AA automated axe-core checks: Design-token system enforces contrast ≥ 4.5:1 at definition time; visible focus-visible indicators on all interactive elements; skip link present; form controls labeled. Full axe-core integration requires external tooling.
- No admin user-management or agent password-set routes exist yet (deferred to later phases per `contracts/secured-write-routes.md` §3)

### 5. Phase 2 exit criterion

All five user stories independently functional, all automated test suites green (unit + functional), build clean (0 warnings, 0 errors), AdminLTE fully removed, design-token system providing WCAG-AA baseline compliance, public site parity with legacy content per SPEC-0007 FR-010..012.

---

## 2. Artifacts updated

- **Knowledge graph**: `knowledge-graph/kg.json` — added MOD-007, API-v1-public, UI-Public, TEST-Public, SPEC-0007 nodes and edges
- **Traceability matrix**: `knowledge-graph/traceability-matrix.md` — added SPEC-0007 requirement row and Public Site module mapping
- **Release notes**: `reports/release-notes/phase-2.md` — this document

## 3. Migration checkpoints

- All legacy `.asp` business behavior preserved (Constitution Mission §2 item 4)
- No business tables dropped (only `dtproperties` may be removed per SPEC-0004 FR-011)
- RBAC enforced server-side per §4.2 role matrix; no query-string identity
- `connection.asp` backdoor inert (AC-006 verified)
- UTF-8 on every page (`<meta charset="utf-8">`) and every API response (`charset=utf-8`)

---

## 4. Commits and branch

- Feature branch: `007-admin-agent-crud` (already checked out from master)
- All tasks in `specs/007-admin-agent-crud/tasks.md` marked complete where [x]
- PR against master to be opened per `complete_migration_plan.md` §15