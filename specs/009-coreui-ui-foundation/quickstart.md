# Quickstart: Validating SPEC-0009 CoreUI UI Foundation

**Date**: 2026-08-19 | **Spec**: [SPEC-0009](spec.md) | **Plan**: [plan.md](plan.md)

This is a validation/run guide — implementation details live in `tasks.md`
and the implementation phase.

## Prerequisites

- .NET 8 SDK; the `VisaFusion.sln` solution builds (existing baseline).
- SQL Server instance with the `VisaFusion` target database (SPEC-0004/0005
  baseline) — required only for the full functional suite; the UI validation
  scenarios below run against the Web host.
- No online NuGet source: all packages already in the local cache (SPEC-0003
  T007).
- CoreUI reference copy at `%TEMP%\opencode\coreui-free-bootstrap-admin-template`
  (v5.6.0, commit `d4003cd`) — source for vendored assets (research D-1/D-10).

## Setup

```powershell
# 1. Build the solution
dotnet build VisaFusion.sln

# 2. Run the full existing test suite (regression gate, TS-010)
dotnet test tests/UnitTests/VisaFusion.UnitTests.csproj
dotnet test tests/IntegrationTests/VisaFusion.IntegrationTests.csproj
dotnet test tests/FunctionalTests/VisaFusion.FunctionalTests.csproj
```

All existing suites must pass **unchanged** — this is the primary regression
proof that the re-skin did not alter business behavior, authorization, or
routing (spec AC-015).

## Validation scenarios

### V1 — CoreUI assets present, bespoke theme removed (AC-001)

```powershell
# Assert: wwwroot/lib/coreui/*, wwwroot/icons/*, wwwroot/js/* exist
# Assert: wwwroot/css/tokens.css, theme.css, bootstrap-icons.css are gone
# Assert: no .cshtml references vf-* classes except vf-skip-link
```

Covered by `CoreUIAssetTests` (IntegrationTests).

### V2 — Role-aware shell renders (AC-002..AC-004)

For each role (Guest, agt, emp, adm, su):

1. Log in as the role.
2. Assert the CoreUI sidebar renders the role's navigation groups/menus per
   `ROLE_NAVIGATION_MATRIX.md` §4 (8 groups).
3. Assert the landing page is the role's existing landing page (no generic
   dashboard replacement).
4. Assert breadcrumbs reflect the role-specific hierarchy.

Covered by `RoleAwareNavigationTests` (UnitTests) + `CoreUIShellTests`
(FunctionalTests).

### V3 — Authorization unchanged (AC-009)

- Every protected page and API retains its policy; the existing
  authorization suites (`AgentPortalRbacTests`, `EntriesRbacTests`,
  `SecuredWriteRoutesTests`, `SecurityDayPagesTests`, etc.) pass unchanged.
- Hiding a menu item never grants or denies access.

### V4 — Routing and redirects unchanged (AC-010)

- Login redirects, landing pages, unauthorized redirects, access-denied,
  post-login navigation, workflow redirects behave exactly as before
  (`LegacyUrlRewriteTests`, `WebLoginPageTests` pass unchanged).

### V5 — Theme system (AC-007)

1. Toggle light/dark/auto from the header dropdown.
2. Reload the page — the choice persists under the `visafusion-theme` key.
3. Assert `<html data-coreui-theme>` reflects the state.

Covered by `CoreUIThemeTests` (FunctionalTests).

### V6 — Page re-skin per mapping (AC-005)

- Every IMPLEMENTED/PARTIAL page in `COREUI_VISA_FUSION_MAPPING.md` renders
  its mapped CoreUI components with preserved functional composition.
- BLOCKED (Employee, Billing) and NOT_REQUIRED (stray Forms) pages are
  untouched.

Covered by `CoreUIShellTests` + existing page suites.

### V7 — Accessibility (AC-011)

- Semantic HTML, keyboard navigation, labels, focus handling, ARIA, contrast
  on every migrated surface (WCAG-AA baseline).

Covered by `CoreUIAccessibilityTests` (FunctionalTests).

### V8 — Responsive (AC-012)

- Desktop, tablet, and mobile breakpoints validated for every migrated
  surface (CoreUI breakpoint contract, `COREUI_DESIGN_SYSTEM.md` §6).

Covered by `CoreUIResponsiveTests` (FunctionalTests).

### V9 — Role-based visual validation (AC-016; Addendum §17)

For every role (not only administrator):

1. Login as the role.
2. Verify landing page, header, sidebar, menus, submenus, breadcrumbs,
   native pages, actions, responsive behavior, unauthorized pages, logout.

### V10 — Database and API identity (AC-014, AC-009)

- Schema and data byte-identical before/after the re-skin (no migration
  exists for this feature — spec §16).
- All 51 API routes respond identically (route, method, policy, status).

### V11 — Knowledge Graph (AC-013)

- `knowledge-graph/kg.json` and `knowledge-graph/traceability-matrix.md`
  updated with the CoreUI integration nodes/edges; KG validation passes.

## Expected outcomes

| Scenario | Pass condition |
|---|---|
| V1 | No `vf-*` CSS in use except `vf-skip-link`; CoreUI assets served from `wwwroot/` |
| V2 | 8-group nav per role; landing pages unchanged |
| V3 | All authorization suites pass unchanged |
| V4 | All routing/redirect suites pass unchanged |
| V5 | Theme persists under `visafusion-theme` |
| V6 | Mapping doc rows render their CoreUI targets |
| V7 | WCAG-AA checks pass |
| V8 | Breakpoint checks pass |
| V9 | All 5 roles visually validated |
| V10 | No DB diff; 51 API routes identical |
| V11 | KG validation passes |

## References

- UI contract: [contracts/ui-contract.md](contracts/ui-contract.md)
- Theme contract: [contracts/theme-contract.md](contracts/theme-contract.md)
- Navigation model: [data-model.md](data-model.md)
- Page mapping: `docs/ui/COREUI_VISA_FUSION_MAPPING.md`
- Role matrices: `docs/ui/ROLE_*_MATRIX.md`