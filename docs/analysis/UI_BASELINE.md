# UI Baseline — VisaFusion

**Scope**: Read-only discovery (2026-08-19). Every claim verified this session.
**Sources**: glob/read of `src/VisaFusion.Web` (50 `.cshtml` = 41 pages + 8
`_ViewStart`/`_ViewImports` + 1 `_Layout`), `_Layout.cshtml`,
`_ViewImports.cshtml`, `_ViewStart.cshtml`, `wwwroot/`, and root-level legacy
UI directories.

---

## 1. Rendering technology

- **Razor Pages only.** No MVC controllers anywhere in `src/` (0 `*Controller.cs`).
- No Blazor, no View Components, no custom TagHelpers, no partial views.
- `_ViewImports.cshtml` registers only the standard
  `Microsoft.AspNetCore.Mvc.TagHelpers`.
- Shared folder contains `_Layout.cshtml` only.

## 2. Page inventory

- Total `.cshtml`: **50** (41 pages + 8 `_ViewStart`/`_ViewImports` + 1
  `_Layout`). Page-model `.cs`: **26** (4 under `Web/Pages`, 22 under
  `Web/Areas`).
- **Public** (10 anonymous pages): public query + contact surface
  (SPEC-0007 parity target; `PublicSiteParityTests.cs` in FunctionalTests).
- **Auth**: `Login`, `Register`, `ChangePassword`, `AccessDenied`.
- **Admin**: `Agents`, `Users`, `Holidays`, `ContentUpdate`, `SecurityDay`.
- **Agent**: agent portal (shared `AgentPortalPageModel`, `AgentSelf`).
- **Reporting**: 7 pages (shared `ReportingPageModel`, `EntryOperations`).
- **Placeholder areas** (markup-only `Index.cshtml`, **no page model** —
  verified `Index.cshtml.cs` does not exist): `Employee`, `Billing`,
  `Notifications`. These render but have no logic; do not assume behavior.

## 3. Layout shell (verified in `_Layout.cshtml`)

Single layout, dual shell driven by `ViewData["UseSidebar"]`:
- **Authenticated shell**: `vf-sidebar` + `vf-topnav` (bespoke VisaFusion
  design tokens).
- **Anonymous shell**: top-nav only (public site).

## 4. Static assets (`wwwroot/`) — Updated 2026-08-22

- `css/`: `vf-coreui.css` (CoreUI design tokens `--cui-*`),
  `vf-component-styles.css` (VisaFusion component classes `--vf-*`).
- `js/`: `vf-coreui.js` (CoreUI JavaScript bundle).
- `lib/coreui/vendors/`: CoreUI vendor files (coreui.min.css,
  simplebar.min.css, coreui.bundle.min.js, simplebar.min.js).
- `icons/cil/`, `icons/cif/`: CoreUI free icon set SVG symbol sprites.
- `fonts/`: Source Sans 3 (`source-sans-3-*.woff2`).
- `forms/`: embedded legacy form files (PDF/doc).
- `images/`, `updateimg/stm31.js` (the only JS file in `wwwroot`).

**Deleted**: `tokens.css`, `theme.css`, `bootstrap-icons.css`, `charts.js`,
`widgets.js`, `style.scss`, `simplebar.scss` (replaced by CoreUI assets).

## 5. UI framework reconciliation — RESOLVED (2026-08-20)

- The phase-2 UI shipped a **bespoke `vf-*` design system** built on
  `tokens.css`/`theme.css`/`bootstrap-icons.css`.
- The constitution (`.specify/memory/constitution.md` **v1.4.1**, Principle IV)
  **mandates CoreUI**
  (`https://github.com/coreui/coreui-free-bootstrap-admin-template.git`) as the
  design reference.
- **RESOLVED** — ADR-0006 ratifies the constitution: CoreUI is the design
  reference and the bespoke `vf-*` UI was re-skinned to CoreUI classes
  (SPEC-0009 T076–T085). `tokens.css`/`theme.css` and the demo assets
  (charts.js, widgets.js, style.scss, simplebar.scss) are deleted; the shell
  keeps its structural wrappers (`vf-shell`/`vf-main`/`vf-content`/
  `vf-skip-link`) ported into `wwwroot/css/vf-component-styles.css` with
  `--cui-*` tokens. Behavior preserved: page models, data, and server-side
  pagination unchanged. See GAP_REPORT GAP-002 (resolved) and
  `docs/ui/COREUI_VISA_FUSION_MAPPING.md`.

## 6. Legacy UI assets at repository root (unmigrated, retained)

`css/`, `js/` (incl. legacy `adminlte.js`), `fonts/`, `forms/`, `images/`,
`HTML FOLDER/`, `UI/`, `Templates/`, `udaanuma-dev/`, `ActiveX/`,
`NewYear2006/`, `_notes/`, `_vti_cnf/`, `updateimg/` — plus ~585 root `*.asp`
files and `update*.asp` snapshots. These are the legacy surface awaiting
cutover; the new `LegacyUrlRewriteMiddleware` currently routes only a handful
of URLs (see ROLE_BASELINE §6 and GAP_REPORT GAP-006).

## 7. Provenance

All counts and file listings above were produced by `glob`/`Get-ChildItem`/
`read`/`grep` tool calls during this session; none from memory.
