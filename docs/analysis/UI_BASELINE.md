# UI Baseline — VisaFusion

**Scope**: Read-only discovery (2026-08-19). Every claim verified this session.
**Sources**: glob/read of `src/VisaFusion.Web` (46 `.cshtml`), `_Layout.cshtml`,
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

- Total `.cshtml`: **46** (Web/Pages + all Areas). Page-model `.cs`:
  4 under `Web/Pages`, 24 under `Web/Areas`.
- **Public** (10 anonymous pages): public query + contact surface
  (SPEC-0007 parity target; `PublicSiteParityTests.cs` in FunctionalTests).
- **Auth**: `Login`, `Register`, `ChangePassword`, `AccessDenied`.
- **Admin**: `Agents`, `Users`, `Holidays`, `ContentUpdate`, `SecurityDay`.
- **Agent**: agent portal (shared `AgentPortalPageModel`, `AgentSelf`).
- **Reporting**: 8 pages (shared `ReportingPageModel`, `EntryOperations`).
- **Placeholder areas** (markup-only `Index.cshtml`, **no page model** —
  verified `Index.cshtml.cs` does not exist): `Employee`, `Billing`,
  `Notifications`. These render but have no logic; do not assume behavior.

## 3. Layout shell (verified in `_Layout.cshtml`)

Single layout, dual shell driven by `ViewData["UseSidebar"]`:
- **Authenticated shell**: `vf-sidebar` + `vf-topnav` (bespoke VisaFusion
  design tokens).
- **Anonymous shell**: top-nav only (public site).

## 4. Static assets (`wwwroot/`)

- `css/`: `tokens.css`, `theme.css`, `bootstrap-icons.css` — the **entire**
  new-platform CSS surface.
- `fonts/`: Source Sans 3 (`source-sans-3-*.woff2`).
- `forms/`: embedded legacy form files (PDF/doc).
- `images/`, `updateimg/stm31.js` (the only JS file in `wwwroot`).

## 5. UI framework reconciliation — CRITICAL

- The current new UI is a **bespoke `vf-*` design system** built on
  `tokens.css`/`theme.css`/`bootstrap-icons.css`.
- The constitution (`.specify/memory/constitution.md` **v1.4.1**, Principle IV)
  **mandates CoreUI**
  (`https://github.com/coreui/coreui-free-bootstrap-admin-template.git`) as the
  design reference.
- **No CoreUI assets exist anywhere in `wwwroot/`**; no AdminLTE either (the
  legacy `js/adminlte.js` lives in the root legacy tree, not in the new app;
  phase-2 release notes confirm AdminLTE removal AC-008).
- This is a live contradiction between the governing constitution and the
  shipped UI → GAP_REPORT GAP-002 (owner decision required: adopt CoreUI or
  amend the constitution).

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
