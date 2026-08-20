# Implementation Plan: Integrate CoreUI as the Canonical VisaFusion UI Foundation

**Branch**: `009-coreui-ui-foundation` | **Date**: 2026-08-19 | **Spec**: [specs/009-coreui-ui-foundation/spec.md](spec.md)

**Input**: Feature specification from `/specs/009-coreui-ui-foundation/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command; its definition describes the execution workflow.

## Summary

SPEC-0009 adopts the CoreUI Free Bootstrap Admin Template (v5.6.0, commit
`d4003cd`) as the canonical VisaFusion UI foundation — resolving GAP-002 — by
re-skinning the existing role-based native-page application onto CoreUI
presentation, **without changing** the role-based functional architecture
(5 roles, 11 policies, 5 claims, 8 navigation groups, 41 pages, 40 routes,
20 workflows), authorization semantics, API contracts (51 routes), or database
schema.

The approach is **vendored static assets** (no node/npm toolchain in the .NET
pipeline): CoreUI dist files are copied into `wwwroot/`, the dual-mode
`_Layout.cshtml` shell is rebuilt on CoreUI layout components with a
centralized `RoleAwareNavigation` service, and the 41 native pages are
re-skinned per `docs/ui/COREUI_VISA_FUSION_MAPPING.md` using canonical reusable
partials. GAP-004 (Employee/Billing BLOCKED) and GAP-010 (stray Forms page
NOT_REQUIRED) are not re-skinned.

## Technical Context

**Language/Version**: C# 12 / .NET 8.0 (`net8.0` — verified in
`VisaFusion.Web.csproj`; shared framework via `FrameworkReference`, no online
NuGet source per SPEC-0003 T007)

**Primary Dependencies**:
- CoreUI Free Bootstrap Admin Template **v5.6.0** (commit `d4003cd`,
  2026-08-13) — vendored static copies into `wwwroot/` (adoption path (b) per
  `COREUI_DEPENDENCY_MAP.md` §9; no npm build pipeline)
- `@coreui/coreui` ^5.9.0 (Bootstrap 5.3.x peer) — `coreui.bundle.min.js` +
  `coreui.min.css` (or compiled `style.css` from the reference copy)
- `@coreui/icons` ^3.1.0 — selected `cil-*`/`cif-*` SVGs → `wwwroot/icons/`
- `simplebar` ^6.3.3 — sidebar scrollbar (css + js)
- `@coreui/chartjs` ^4.2.0 + `chart.js` ^4.5.1 + `@coreui/utils` ^2.0.2 —
  chart surfaces only (Agent Index, Agent Statement, Reporting Index,
  DailyVisaFee, DailyBill — spec §13)
- Existing: ASP.NET Core 8, EF Core 8.0.20, ASP.NET Core Identity,
  JwtBearer 8.0.20, Serilog 10.0.0, OpenTelemetry 1.17.0 (unchanged)

**Storage**: SQL Server — **no change**. No tables, columns, indexes, or
stored procedures are created, modified, or dropped (spec §16; constitution
Principles VI–VIII). The 52-table legacy schema and the `VisaFusion` target
database are untouched.

**Testing**: xUnit — `tests/UnitTests`, `tests/IntegrationTests` (EF Core +
SQL), `tests/FunctionalTests` (WebApplicationFactory). New UI tests follow the
existing `VisaFusionWebApplicationFactory` pattern. No online NuGet restore.

**Target Platform**: Windows Server + IIS (Web host `VisaFusion.Web`).
Browser baseline per CoreUI `.browserslistrc`: Chrome/FF ≥60, iOS/Safari ≥12,
no IE ≤11 (spec NFR-006).

**Project Type**: Web application (Razor Pages + minimal-API endpoints under
`/api/v1`) + class libraries (`VisaFusion.Core`, `VisaFusion.Data`,
`VisaFusion.Identity`, `VisaFusion.Api`, `VisaFusion.Migration`,
`VisaFusion.Jobs`). This feature touches **only** `VisaFusion.Web` (presentation)
plus tests, docs, and the Knowledge Graph.

**Performance Goals**: no regression in page load behavior (spec NFR-001);
CoreUI assets served from `wwwroot/` (no external CDN); chart assets loaded
only on the 5 chart surfaces (spec §13); no new database queries introduced.

**Constraints**: presentation-only feature — no business rule, authorization,
API, or database change (spec §6, §12, §15, §16); role-based native-page
architecture preserved (constitution Principle III; Addendum §1–§2); UI
visibility ≠ authorization (constitution Principle XV; Addendum §10); no
duplicated reusable components (constitution Principle XIV); GAP-004
Employee/Billing (BLOCKED) and GAP-010 stray page (NOT_REQUIRED) not re-skinned
(spec §6); theme persistence key renamed to `visafusion-theme` (spec FR-006).

**Scale/Scope**: 41 native pages (40 routable + 1 stray); 8 navigation groups;
14 canonical reusable components; 1 shell layout rebuilt; ~21 sidebar pages
re-skinned; 5 chart surfaces; 0 API changes; 0 database changes.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Gate | Check | Verdict |
|------|-------|---------|
| I. Specification-first (SDD) | SPEC-0009 exists, 24 sections + Assumptions + Clarifications; 7 ambiguities resolved 2026-08-19 (clarify); checklist 35/35 | PASS |
| II. Legacy is Evidence | Every FR mapped to legacy pages and evidence docs (§8/§24: `COREUI_VISA_FUSION_MAPPING.md`, `ROLE_*_MATRIX.md`, `@findings/modernization_plan.md` §6/§13); no invented business features | PASS |
| III. Role-Based Native Page Architecture Must Be Preserved | Core of this feature: FR-002/AC-002/AC-003; Addendum §1–§2 honored; no generic dashboard; no role flattening | PASS |
| IV. CoreUI is the UI Design System | Core of this feature: FR-001/FR-012; v5.6.0 pinned; presentation only | PASS |
| V. VisaFusion Functional Architecture Remains Authoritative | FR-002; Addendum §19; business rules stay in `VisaFusion.Core` (BR-004) | PASS |
| VI. Database Safety | No drops; only `dtproperties` ever droppable and not touched (§16) | PASS |
| VII. Data Preservation | No data semantics change (§16) | PASS |
| VIII. Database Normalization | N/A — no schema work | PASS |
| IX. Stored Procedures and SQL Functions | N/A — no DB object changes | PASS |
| X. ASP.NET Core | Existing approved architecture reused; no new frameworks (user constraint) | PASS |
| XI. SpecKit | Pipeline followed: specify → clarify → plan (this file) | PASS |
| XII. AI-Native Knowledge Graph | FR-013/AC-013: kg.json + traceability-matrix update after implementation | PASS |
| XIII. Traceability | Spec §24 matrix; Addendum §15; no orphan pages/permissions/nav/APIs | PASS |
| XIV. Reusable UI | FR-007: 14 canonical components, one implementation each | PASS |
| XV. Authorization | FR-008/AC-009: server-side policies unchanged; UI visibility ≠ security | PASS |
| XVI. Accessibility | FR-010/AC-011: WCAG-AA baseline preserved or improved | PASS |
| XVII. Responsive Design | FR-011/AC-012: desktop/tablet/mobile validated | PASS |
| XVIII. Testing | TS-001..014; role-based test matrix (Addendum §16); regression suites unchanged | PASS |
| XIX. Documentation | docs/ui/* updated; ADR records GAP-002 adoption decision | PASS |
| XX. GitHub | Branch `009-coreui-ui-foundation`; PR-based CI; traceability on GitHub | PASS |
| XXI. No Unrelated Refactoring | Only presentation surfaces touched; no business/API/DB code modified | PASS |
| XXII. Stop Conditions | No violations: no ambiguity, no authorization unknown, no destructive DB change, no invented behavior | PASS |
| XXIII. Definition of Done | All gates: spec satisfied, role behavior preserved, authorization preserved, CoreUI mapping complete, responsive + accessibility validated, KG synchronized, traceability complete | PASS |
| XXIV. Legacy Forensic Artifacts | `Udaan_users`, `udaanuma-dev`, `r&d`, backdoor query parameters untouched (BR-006) | PASS |

No violations → Complexity Tracking table intentionally empty.

## Project Structure

### Documentation (this feature)

```text
specs/009-coreui-ui-foundation/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output — design decisions D-1..D-8 (/speckit.plan)
├── data-model.md        # Phase 1 output — nav model, component catalog, theme tokens (/speckit.plan)
├── quickstart.md        # Phase 1 output — runnable validation guide (/speckit.plan)
├── contracts/           # Phase 1 output — UI contracts (/speckit.plan)
│   ├── ui-contract.md   # shell, nav model, component contract
│   └── theme-contract.md # theme system, tokens, persistence key
├── checklists/
│   └── requirements.md  # 35/35 pass (specify + clarify)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created here)
```

### Source Code (repository root)

```text
src/VisaFusion.Web/
├── Pages/Shared/
│   ├── _Layout.cshtml              # MODIFY: CoreUI shell (dual-mode: sidebar/pages)
│   ├── _CoreUIScripts.cshtml       # NEW: script include contract (bundle, simplebar, color-modes)
│   ├── _CoreUIHead.cshtml          # NEW: head partial (CSS, config.js, color-modes.js)
│   ├── _Header.cshtml              # NEW: CoreUI header partial (toggler, theme dropdown, avatar)
│   ├── _Sidebar.cshtml             # NEW: CoreUI sidebar partial (brand, nav, toggler)
│   ├── _Breadcrumb.cshtml          # NEW: role-aware breadcrumb partial
│   ├── _PageHeader.cshtml          # NEW: page header partial
│   ├── _Footer.cshtml              # NEW: CoreUI footer partial
│   ├── _AuthLayout.cshtml          # NEW: standalone pages layout (auth/error)
│   └── _ValidationScriptsPartial.cshtml  # UNCHANGED (existing)
├── Navigation/
│   ├── RoleAwareNavigation.cs      # NEW: centralized nav model service (8 groups)
│   ├── NavigationModels.cs         # NEW: NavGroup/NavItem/NavSubmenu records
│   └── NavigationData.cs           # NEW: the 8-group matrix data (ROLE_NAVIGATION_MATRIX §4)
├── Components/                     # NEW: canonical reusable partials
│   ├── _RoleDashboard.cshtml       # NEW: role landing/dashboard card layout
│   ├── _DataTable.cshtml           # NEW: table + pagination + badges wrapper
│   ├── _FormCard.cshtml            # NEW: form card wrapper (validation-ready)
│   ├── _AuthCard.cshtml            # NEW: centered auth card
│   ├── _ErrorPage.cshtml           # NEW: 404/500/access-denied surface
│   ├── _InfoPage.cshtml            # NEW: static info page wrapper
│   ├── _PublicLanding.cshtml       # NEW: public landing wrapper
│   ├── _PublicQueryForm.cshtml     # NEW: public query form wrapper
│   ├── _ConfirmModal.cshtml        # NEW: confirm-delete modal
│   ├── _ToastHost.cshtml           # NEW: toast host (Notifications placeholder)
│   ├── _DesignTokens.cshtml        # NEW: token overrides (--cui-* rebrand)
│   ├── _ComponentStyles.cshtml     # NEW: vf-* → CoreUI class mapping styles
│   └── _IconSet.cshtml             # NEW: icon sprite/partial
├── wwwroot/
│   ├── lib/coreui/                 # NEW: vendored CoreUI dist (css, js, vendors)
│   ├── lib/simplebar/              # NEW: vendored simplebar (css, js)
│   ├── lib/chartjs/                # NEW: vendored chart.js + @coreui/chartjs + @coreui/utils
│   ├── icons/                      # NEW: selected cil-*/cif-* SVGs
│   ├── js/
│   │   ├── config.js               # NEW: theme URL param → localStorage (renamed key)
│   │   ├── color-modes.js          # NEW: light/dark/auto switcher (visafusion-theme)
│   │   ├── tooltips.js             # NEW: auto-init tooltips
│   │   ├── popovers.js             # NEW: auto-init popovers
│   │   ├── toasts.js               # NEW: toast init (Notifications)
│   │   └── main.js                 # NEW: chart init (5 chart surfaces)
│   ├── css/
│   │   ├── coreui.css              # NEW: vendored CoreUI compiled CSS
│   │   ├── vf-coreui.css           # NEW: VisaFusion token overrides + vf-* mapping
│   │   ├── tokens.css              # REMOVE (replaced by --cui-* tokens)
│   │   ├── theme.css               # REMOVE (replaced by vf-coreui.css)
│   │   └── bootstrap-icons.css     # REMOVE (replaced by cil-*/cif-* SVGs)
│   └── updateimg/**                # UNCHANGED (legacy parity assets, NOT_REQUIRED)
└── Areas/                          # MODIFY: 21 sidebar pages re-skinned per mapping
    ├── Agent/Pages/*.cshtml        # 5 pages: RoleDashboard/DataTable/FormCard
    ├── Reporting/Pages/*.cshtml    # 7 pages: RoleDashboard/DataTable
    ├── Admin/Pages/**/*.cshtml     # 9 pages: DataTable/FormCard/ConfirmModal
    ├── Public/Pages/*.cshtml       # 9 pages: InfoPage/PublicLanding/PublicQueryForm
    └── Employee|Billing|Notifications/Pages/Index.cshtml  # UNCHANGED (GAP-004)

tests/
├── UnitTests/
│   └── RoleAwareNavigationTests.cs # NEW: nav model per-role correctness (TS-001)
├── IntegrationTests/
│   └── CoreUIAssetTests.cs         # NEW: wwwroot assets present, no vf-* css refs (AC-001)
└── FunctionalTests/
    ├── CoreUIShellTests.cs         # NEW: shell renders CoreUI markup, role-aware nav (TS-002/006)
    ├── CoreUIThemeTests.cs         # NEW: theme switching + persistence key (TS-007)
    ├── CoreUIAccessibilityTests.cs # NEW: a11y checks on migrated surfaces (TS-009)
    ├── CoreUIResponsiveTests.cs    # NEW: responsive validation (TS-008)
    └── (existing suites)           # UNCHANGED: regression net (TS-010)
```

**Structure Decision**: Single-project presentation change confined to
`VisaFusion.Web` (Razor Pages + wwwroot) with new `Navigation/` and
`Components/` folders; no new projects, no new frameworks, no changes to
`VisaFusion.Core`/`Data`/`Api`/`Identity`/`Jobs`/`Migration`. This matches the
existing architecture (Razor Pages + partials; no ViewComponent precedent in
the repo) and the user constraint "use existing repository architecture as the
implementation constraint".

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

No violations — table intentionally empty.

## Implementation Sequencing (dependency order)

```text
Phase A — Assets (no code dependency)
  A1. Vendor CoreUI dist → wwwroot/lib/coreui, lib/simplebar, lib/chartjs
  A2. Copy icons → wwwroot/icons (cil-*/cif-*)
  A3. Copy config.js/color-modes.js/tooltips.js/popovers.js/toasts.js/main.js → wwwroot/js
  A4. Write vf-coreui.css (token overrides + vf-* → CoreUI mapping)
  A5. Remove tokens.css/theme.css/bootstrap-icons.css (after A1–A4 land)

Phase B — Shell (depends on A)
  B1. _CoreUIHead.cshtml + _CoreUIScripts.cshtml (asset contract)
  B2. NavigationData.cs + RoleAwareNavigation.cs + NavigationModels.cs
  B3. _Header/_Sidebar/_Breadcrumb/_PageHeader/_Footer partials
  B4. _Layout.cshtml rebuild (dual-mode: sidebar shell / pages layout)
  B5. _AuthLayout.cshtml (auth/error standalone layout)

Phase C — Canonical components (depends on B)
  C1. _RoleDashboard/_DataTable/_FormCard/_AuthCard/_ErrorPage/_InfoPage
  C2. _PublicLanding/_PublicQueryForm/_ConfirmModal/_ToastHost
  C3. _DesignTokens/_ComponentStyles/_IconSet

Phase D — Page re-skin (depends on B+C; per mapping doc)
  D1. Auth pages (4) + error surfaces
  D2. Agent area (5)
  D3. Reporting area (7)
  D4. Admin area (9)
  D5. Public area (9)
  D6. Notifications placeholder (PARTIAL, presentation-only)

Phase E — Tests & validation (parallel with D)
  E1. UnitTests: RoleAwareNavigationTests
  E2. IntegrationTests: CoreUIAssetTests
  E3. FunctionalTests: CoreUIShellTests, CoreUIThemeTests,
      CoreUIAccessibilityTests, CoreUIResponsiveTests
  E4. Role-based visual validation (Addendum §17) — all 5 roles
  E5. Regression: full existing test suites (TS-010)

Phase F — Knowledge Graph, docs, ADR (after E)
  F1. kg.json + traceability-matrix update (FR-013)
  F2. docs/ui/* update (mapping statuses, matrices, inventory)
  F3. ADR for GAP-002 adoption decision (constitution Principle XIII)
  F4. README/UI_BASELINE sync
```

## Rollback Considerations

- **Asset rollback**: `wwwroot/lib/*`, `wwwroot/icons/`, `wwwroot/js/*` are
  additive — removing them restores the pre-feature state. The three removed
  CSS files (`tokens.css`, `theme.css`, `bootstrap-icons.css`) are restored
  from git history (they are committed files, not generated).
- **Shell rollback**: `_Layout.cshtml` and the new partials are single-file
  reversions — `git revert` of the shell commit restores the dual-mode
  `vf-*` shell byte-identically.
- **Page rollback**: each re-skinned `.cshtml` is reverted per-page from git;
  page models (`.cshtml.cs`) are untouched by this feature, so functional
  behavior is never at risk.
- **No database migration** exists for this feature — no DB rollback needed
  (spec §16).
- **No API change** — no contract rollback needed (spec §15).
- **Test rollback**: new test files are additive; existing suites are
  unchanged and serve as the regression gate (TS-010).
- **Cutover strategy**: land assets (Phase A) and shell (Phase B) as
  independent commits; the shell commit is the single point of visual cutover
  and the single revert point if visual validation fails.