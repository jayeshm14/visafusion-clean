# Quickstart: Validating SPEC-0007 Agent/Admin Management, Security-Day Gate, Public Site, and Professional UI Theme

**Date**: 2026-08-17 | **Spec**: [spec.md](spec.md) | **Contracts**: [contracts/](contracts/) | **Data model**: [data-model.md](data-model.md)

This guide proves the feature works end-to-end. Implementation details live in `tasks.md` (created by `/speckit.tasks`).

## Prerequisites

- .NET 8 SDK; SQL Server instance with the `VisaFusion` target database (SPEC-0004/0005 baseline).
- Solution builds: `dotnet build VisaFusion.sln` (or the solution file at the repo root).
- Test baselines before this feature: Unit 138/138, Functional 135/135, Integration 52/52.

## Setup

```powershell
# 1. Apply any schema-affecting changes (expected: none new — deactivation reuses agents.Active, R-007)
#    Verify the legacy agents.Active value convention against the live VisaEntry DB first.

# 2. Run the full test suites
dotnet test tests/UnitTests
dotnet test tests/IntegrationTests
dotnet test tests/FunctionalTests

# 3. Run the app
dotnet run --project src/VisaFusion.Web
dotnet run --project src/VisaFusion.Api
```

## Validation scenarios

### S1 — Agent CRUD + lifecycle (FR-001..004, FR-022, AC-001, AC-016, AC-017)

1. Log in as `adm`/`su`.
2. Create an agent (single operation) → agent record + `agt` login created together (AC-017).
3. View the agent list and detail (AC-001).
4. Update the agent record.
5. Deactivate the agent → the `agt` login is rejected; the agent's data remains intact (AC-016).
6. Reactivate → login works again.
7. Log in as `emp` → agent-management endpoints return `403` (AC-002).

### S2 — User management (FR-005..007, FR-023, AC-003, AC-018)

1. As `adm`/`emp`, create a user with role `agt` → succeeds.
2. Create a user with role `su` via `POST /api/v1/admin/users` → `400` (whitelist, BR-004).
3. As `su`, provision a super-user via `POST /api/v1/admin/superusers` → succeeds, audited.
4. As `adm`, attempt to deactivate an `su` target → `403` (FR-007).
5. Deactivate a non-`su` user → login blocked, row preserved, reversible (AC-018).

### S3 — Security-day gate (FR-008..009, AC-004..005)

1. As `adm`/`su`, open the day → `200`; `GET /api/v1/admin/security-day/today` shows open.
2. As `emp`, log in → allowed (day open).
3. Close the day → `200`; `emp` login now rejected (existing gate rule, AC-005).
4. As anonymous or `agt`, call open/close → `401`/`403` (AC-004).

### S4 — Agent self-service portal (FR-017..021, AC-012..015)

1. Log in as `agt`.
2. View own entries list, own statuses, own statement → all scoped to own `AgentId` (AC-012).
3. Request another agent's `{id}` → `403`/`404` (AC-012).
4. Update own record via `PUT /api/v1/agents/{id}/self` → `200`; another agent's `{id}` → `403` (AC-014).
5. Search → results scoped to own agent (AC-015).

### S5 — Public site parity (FR-010..012, AC-006..007)

1. Browse the public pages (home, contact, queries, embassy, country info, visa info, forms, subscribe, registration) → content and behavior match legacy, rendered in the new theme, UTF-8 (AC-006).
2. Home page has **no** AdminLTE demo dropdown (AC-006, §9.2).
3. Submit a contact query anonymously → `201`; exceed the rate limit → `429` (AC-007).
4. Register publicly → `guest`-role account only (FR-012).

### S6 — Theme & accessibility (FR-013..016, AC-008..011)

1. Assert no rendered page references AdminLTE assets (AC-008).
2. Assert design tokens are the single visual source — no hard-coded colors in pages (AC-009).
3. Run WCAG-AA automated checks (e.g., axe-core) on every rendered page → pass (AC-010).
4. Assert every page and API response declares UTF-8 (AC-011).

## Expected outcomes

- All three test suites pass (baselines + new SPEC-0007 tests).
- S1-S6 scenarios pass with the stated status codes and behaviors.
- No AdminLTE assets remain in `wwwroot` or referenced by any page.
- `UserManagement` policy corrected to `adm,emp` (DP-001) with `su` still passing via the inherited `adm` claim.