# Research — SPEC-0009 CoreUI UI Foundation

Phase 0 output of `/speckit.plan`. Resolves the technical unknowns for the
CoreUI adoption against the repository evidence and the CoreUI reference copy.
All facts cited below were verified by tool calls this session (2026-08-19).

## Decision D-1 — CoreUI adoption path: vendored static copies (no npm in the .NET pipeline)

- **Decision**: Vendor the pinned CoreUI dist files into `wwwroot/` as
  committed static assets. The one-time build happens in the reference copy
  (`%TEMP%\opencode\coreui-free-bootstrap-admin-template`), outside the .NET
  pipeline; the resulting files are committed to `wwwroot/lib/`.
- **Rationale**: `COREUI_DEPENDENCY_MAP.md` §9 offers two paths — (a)
  npm-managed front-end with MSBuild/npm restore, or (b) vendored static
  copies. The repo has no node toolchain, no `package.json`, and the .NET
  pipeline has no online NuGet source (SPEC-0003 T007); path (b) keeps the
  build/deploy pipeline unchanged and satisfies spec NFR-001 (assets served
  from `wwwroot/`, no external CDN). The reference copy is read-only
  (`COREUI_INVENTORY.md` §Scope) — the build is a local, non-committed step.
- **Alternatives considered**: (a) npm-managed — rejected: introduces a node
  toolchain into a .NET-only repo and a new build-time dependency; (c) CDN
  links — rejected: spec NFR-001 forbids external CDN dependency.

## Decision D-2 — CSS strategy: vendored compiled CoreUI CSS + VisaFusion override layer

- **Decision**: Ship the compiled CoreUI stylesheet (from the reference
  copy's `src/scss/style.scss` build output — Bootstrap 5.3 + CoreUI 5.x +
  template layout rules) as `wwwroot/css/coreui.css`, plus a thin VisaFusion
  override `wwwroot/css/vf-coreui.css` that (1) rebrands `--cui-*` tokens to
  VisaFusion colors, (2) maps the 49 verified `vf-*` classes to CoreUI
  equivalents (`COREUI_VISA_FUSION_MAPPING.md` §7), and (3) keeps the
  `vf-skip-link` accessibility pattern.
- **Rationale**: `COREUI_DESIGN_SYSTEM.md` §2 documents the `--cui-*` token
  system and §9 the rebrand mechanism ("rebrand tokens via SCSS `@use ... with
  (...)` overrides"). Since no SCSS build exists in the .NET pipeline (D-1),
  the compiled CSS is vendored and the rebrand is applied as CSS custom
  property overrides — functionally equivalent, no build step.
- **Alternatives considered**: (a) adopting the SCSS build chain — rejected:
  requires node/sass in the pipeline (D-1); (b) using stock `coreui.min.css`
  without overrides — rejected: loses VisaFusion branding and the `vf-*`
  mapping contract.

## Decision D-3 — JavaScript strategy: vendored bundle + adopted init modules

- **Decision**: Vendor `@coreui/coreui` `coreui.bundle.min.js` (all
  components: Sidebar, Dropdown, Modal, Toast, Tooltip, Popover, SearchButton,
  navigation) and `simplebar.min.js` into `wwwroot/lib/`. Adopt the reference
  copy's `src/js/` modules as-is with VisaFusion adjustments:
  `config.js` + `color-modes.js` (theme; persistence key renamed to
  `visafusion-theme` per `COREUI_DESIGN_SYSTEM.md` §3), `tooltips.js`,
  `popovers.js`, `toasts.js` (Notifications placeholder), `main.js` (charts).
  `charts.js`/`widgets.js` are patterns only — VisaFusion chart init lives in
  `main.js` for the 5 chart surfaces (spec §13).
- **Rationale**: `COREUI_DEPENDENCY_MAP.md` §5 documents the JS component
  dependency map; the bundle is the template's own choice (no tree-shaking
  needed at this scale). JS ships untranspiled ES2015+ (`.browserslistrc`),
  safe to serve as static files (spec NFR-006).
- **Alternatives considered**: (a) ESM tree-shaken build — rejected: adds a
  build step for negligible size gain at this scale; (b) per-component JS
  files — rejected: the bundle is the template's verified contract.

## Decision D-4 — Icon strategy: selected `cil-*`/`cif-*` SVGs into `wwwroot/icons/`

- **Decision**: Copy only the icons the migrated pages need from the
  reference copy's `src/assets/icons/` (524 SVGs verified) into
  `wwwroot/icons/` — `cil-*` UI icons and `cif-*` country flags (embassy/
  country-info pages). Replace `bootstrap-icons.css` (spec FR-012;
  `COREUI_VISA_FUSION_MAPPING.md` §7 IconSet row).
- **Rationale**: `COREUI_INVENTORY.md` §11 documents the icon set and the
  "copy only needed icons" guidance; `COREUI_DEPENDENCY_MAP.md` §6 confirms
  icons are SVG files with no CSS dependency.
- **Alternatives considered**: (a) full 524-icon copy — rejected: bloat
  (spec §21 asset-bloat risk); (b) icon font — rejected: CoreUI uses inline
  SVGs, no font.

## Decision D-5 — Role-aware navigation: centralized `RoleAwareNavigation` service in `VisaFusion.Web`

- **Decision**: Implement `RoleAwareNavigation` as a C# service in
  `src/VisaFusion.Web/Navigation/` consuming the 8-group matrix from
  `ROLE_NAVIGATION_MATRIX.md` §4 (Public, Account, Agent Portal, Reporting,
  Admin, Employee, Billing, Notifications) with per-role menu/submenu
  resolution, registered in DI, and rendered by the `_Sidebar.cshtml` partial.
- **Rationale**: Addendum §5 mandates a centralized role-aware navigation
  model ("Do NOT hard-code per-page nav"); the current state is 21 per-page
  `@section SidebarNav` blocks (verified `ROLE_NAVIGATION_MATRIX.md` §1–§2).
  The service is presentation-only, so it lives in the Web project (no
  business-rule coupling; constitution BR-004 keeps business rules in
  `VisaFusion.Core`).
- **Alternatives considered**: (a) ViewComponent — rejected: no ViewComponent
  precedent in the repo; Razor partials + service match the existing pattern;
  (b) per-page nav retained — rejected: violates Addendum §5 and spec FR-003.

## Decision D-6 — Shell strategy: rebuild `_Layout.cshtml` dual-mode on CoreUI

- **Decision**: Rebuild `Pages/Shared/_Layout.cshtml` preserving the verified
  dual-mode logic (`useSidebar = ViewData["UseSidebar"] ?? isAuthenticated`,
  `_Layout.cshtml` line 20): authenticated surfaces render the CoreUI sidebar
  shell (Header + Sidebar + Breadcrumb + PageHeader + content + Footer);
  anonymous/auth/error surfaces render the CoreUI standalone `pages` layout
  (`_AuthLayout.cshtml`). The `@section SidebarNav` mechanism is replaced by
  the centralized service (D-5); `@section Scripts` is preserved.
- **Rationale**: `COREUI_DESIGN_SYSTEM.md` §4 documents both layouts
  (`default.pug` shell, `pages.pug` standalone); `ROLE_BASED_NATIVE_PAGES_INVENTORY.md`
  §6 documents the target shell composition. Preserving the dual-mode
  selection preserves routing/redirect behavior (spec FR-009).
- **Alternatives considered**: (a) single shell for all pages — rejected:
  breaks the anonymous/auth split and the `pages` layout contract (spec
  FR-005); (b) per-area layouts — rejected: unnecessary; the dual-mode shell
  covers all 41 pages.

## Decision D-7 — Theme system: `data-coreui-theme` + `visafusion-theme` key

- **Decision**: Adopt the three-state theme (light/dark/auto) per
  `COREUI_DESIGN_SYSTEM.md` §3: `_Layout.cshtml` renders
  `<html data-coreui-theme="light">` server-side; `config.js` + `color-modes.js`
  upgrade to stored/system preference; persistence key renamed from
  `coreui-free-bootstrap-admin-template-theme` to `visafusion-theme`.
- **Rationale**: Spec FR-006/NFR-005; `COREUI_DESIGN_SYSTEM.md` §3 documents
  the exact mechanism and the required key rename (spec §21 risk mitigation).
- **Alternatives considered**: (a) light-only — rejected: spec FR-006 mandates
  the three-state system; (b) keep the CoreUI default key — rejected: spec §21
  collision risk.

## Decision D-8 — Reusable components: 14 canonical Razor partials

- **Decision**: Implement the 14 components proposed in
  `COREUI_VISA_FUSION_MAPPING.md` §1–§7 as Razor partials under
  `src/VisaFusion.Web/Components/`: `_RoleDashboard`, `_DataTable`, `_FormCard`,
  `_AuthCard`, `_ErrorPage`, `_InfoPage`, `_PublicLanding`, `_PublicQueryForm`,
  `_ConfirmModal`, `_ToastHost`, `_DesignTokens`, `_ComponentStyles`, `_IconSet`
  (plus `_Breadcrumb`/`_PageHeader`/`_Header`/`_Sidebar`/`_Footer` shell
  partials under `Pages/Shared/`). One canonical implementation each
  (constitution Principle XIV; Addendum §9).
- **Rationale**: The mapping doc names these components with their CoreUI
  equivalents and the pages that consume them; partials match the repo's
  existing Razor pattern (no ViewComponent precedent).
- **Alternatives considered**: (a) ViewComponents — rejected (no precedent);
  (b) tag helpers — rejected: partials are the established pattern and keep
  the mapping doc's component names as file names for traceability.

## Decision D-9 — GAP-004/GAP-010 handling (from clarify)

- **Decision**: Only `Areas/Notifications` (PARTIAL) is re-skinned
  presentation-only (`_ToastHost`); `Areas/Employee` and `Areas/Billing`
  (BLOCKED) and the stray `Areas/Public/Pages.Forms.cshtml` (NOT_REQUIRED) are
  not touched (spec §6; `COREUI_VISA_FUSION_MAPPING.md` §6, §1).
- **Rationale**: Clarify session 2026-08-19 resolved the scope contradiction;
  the mapping doc statuses are the implementation contract.
- **Alternatives considered**: re-skinning all three placeholders — rejected:
  BLOCKED pages have no page model/spec/policy; presentation work would be
  wasted and could imply scope approval.

## Decision D-10 — Asset provenance and version pinning

- **Decision**: All vendored assets are pinned to CoreUI v5.6.0 (commit
  `d4003cd`, 2026-08-13) with the package versions verified in the reference
  copy's `package.json`: `@coreui/coreui` ^5.9.0, `@coreui/icons` ^3.1.0,
  `@coreui/chartjs` ^4.2.0, `@coreui/utils` ^2.0.2, `chart.js` ^4.5.1,
  `simplebar` ^6.3.3. A `wwwroot/lib/README.md` records the source commit and
  versions for traceability.
- **Rationale**: Spec §22 and Assumptions pin the exact adopted version;
  `COREUI_DEPENDENCY_MAP.md` §8 documents the version facts.
- **Alternatives considered**: unpinned latest — rejected: violates the
  deterministic no-assumption rule.

## Open items for Phase 1

- None — all technical unknowns resolved. The 23 unresolved
  role/page/permission relationships from the role analysis are open business
  decisions, explicitly NOT resolved by this feature (spec Assumptions).