# CoreUI Design System — Analysis for VisaFusion

**Source**: READ-ONLY analysis of `coreui-free-bootstrap-admin-template`
v5.6.0 (commit `d4003cd`, 2026-08-13). Reference copy:
`%TEMP%\opencode\coreui-free-bootstrap-admin-template`.
**Companion docs**: `COREUI_INVENTORY.md`, `COREUI_DEPENDENCY_MAP.md`,
`COREUI_COMPONENT_CATALOG.md`.

---

## 1. Design system foundation

CoreUI Free Bootstrap Admin Template is a Bootstrap 5.3.x derivative built on
the **CoreUI component library** (`@coreui/coreui` 5.x). Its design language:

- **Bootstrap-first utility system** — layout/spacing/typography via Bootstrap
  utilities; custom CSS only where CoreUI components demand it
  (`DEVELOPMENT.md` §Styling Guidelines: "Use Bootstrap/CoreUI Classes First").
- **Design tokens as CSS custom properties** — `--cui-*` variables, theme-aware
  in light and dark mode (`DEVELOPMENT.md` §Common CSS Variables).
- **Dark mode first-class** — `[data-coreui-theme]` attribute on `<html>`
  drives the entire theme (`style.scss` uses `@include color-mode(dark)`).
- **Compact, dense admin density** — fixed header (4rem), sidebar-fixed, thin
  progress bars (`progress-thin`), badge-sm, `fs-*` scale for stat values.

## 2. Design tokens (CSS custom properties)

Verified in `src/scss/style.scss`, `DEVELOPMENT.md`, `main.js`,
`widgets.js`, and `index.pug`:

### 2.1 Color palette

| Token | Purpose | Verified in |
|---|---|---|
| `--cui-primary` (+ `-rgb`) | Brand/primary color; chart points | `DEVELOPMENT.md`, `main.js`, `widgets.js` |
| `--cui-secondary` | Secondary color | `DEVELOPMENT.md` |
| `--cui-success` | Success/positive | `DEVELOPMENT.md`, `main.js` |
| `--cui-danger` | Danger/negative; annotation line | `main.js`, `index.pug` |
| `--cui-warning` | Warning | `index.pug`, `widgets.js` |
| `--cui-info` (+ `-rgb`) | Info/accent; chart fill | `main.js`, `widgets.js`, `index.pug` |
| `--cui-body-color` | Default text | `DEVELOPMENT.md`, `main.js` |
| `--cui-body-bg` | Page background | `DEVELOPMENT.md` |
| `--cui-tertiary-bg` / `--cui-dark-bg-subtle` | Page background (light/dark) | `style.scss` (`body { background-color: var(--cui-tertiary-bg) }`, dark override) |
| `--cui-border-color`, `--cui-border-color-translucent` | Borders | `DEVELOPMENT.md`, `main.js` (chart grids) |
| `--cui-sidebar-bg` | Sidebar background | `DEVELOPMENT.md` §Naming Conventions |

### 2.2 Component-level tokens (per-element overrides)

| Token | Component | Verified in |
|---|---|---|
| `--cui-card-cap-bg` | Card header background (social cards) | `index.pug` (`style='--cui-card-cap-bg: #3b5998'`) |
| `--cui-dropdown-min-width` | Dropdown min width | `header.pug` (`style='--cui-dropdown-min-width: 8rem;'`) |
| `--cui-nav-underline-border-link-padding-x`, `--cui-nav-underline-border-gap` | Nav underline tab padding/gap | `style.scss` `.sidebar-header .nav-underline-border` |
| `--cui-footer-bg` | Footer background | `style.scss` dark-mode override |
| `--cui-sidebar-occupy-start/end` | Content offset caused by fixed sidebar | `style.scss` `.wrapper` padding-inline |
| `--ci-primary-color` | Inline SVG "currentcolor" fill | `login.pug` (eye icon paths) |

### 2.3 Chart theming tokens

- `coreui.Utils.getStyle('--cui-primary')` etc. read computed token values at
  runtime (`main.js`, `widgets.js`).
- `rgba(var(--cui-info-rgb), .1)` for chart fills (`main.js`).
- `ColorSchemeChange` event re-renders charts with new token values
  (`ARCHITECTURE.md` §Theme Switching Flow).

## 3. Theme system (light / dark / auto)

Architecture (verified in `src/js/color-modes.js`, `src/js/config.js`,
`ARCHITECTURE.md` §Theme Switching Flow):

1. `config.js` (loaded in `<head>`, `head.pug`): accepts `?theme=light|dark|auto`
   URL param → persists to `localStorage['coreui-free-bootstrap-admin-template-theme']`.
2. `color-modes.js`:
   - `getPreferredTheme()`: stored value, else `prefers-color-scheme` media query.
   - `setTheme(theme)`: sets `document.documentElement[data-coreui-theme]` to
     `light|dark|auto` (auto resolves to system dark); dispatches
     `ColorSchemeChange` on `<html>`.
   - `showActiveTheme()`: toggles `.active` among
     `[data-coreui-theme-value="light|dark|auto"]` dropdown items; swaps the
     active header icon (`[data-coreui-theme-value]` markup in `header.pug`).
   - Listens to `prefers-color-scheme` changes (auto mode follows OS).
3. SCSS responds via CoreUI's `@include color-mode(dark)` (`style.scss`) and
   token swaps.

**VisaFusion mapping**: adopt the same three-state model; the theme persistence
key must be renamed (`visafusion-theme`), and the Razor `_Layout.cshtml` must
render `<html data-coreui-theme>` server-side default (light) then let
`color-modes.js` upgrade to stored/system preference.

## 4. Layout system

### 4.1 Shell (authenticated pages — `default.pug`)

```
body
├─ .sidebar.sidebar-dark.sidebar-fixed.border-end#sidebar   (SimpleBar scroll)
│   ├─ .sidebar-header  (brand full|narrow + d-lg-none close btn)
│   ├─ ul.sidebar-nav[data-coreui="navigation"][data-simplebar]
│   │     items: nav-item / nav-group / nav-title / nav-divider
│   └─ .sidebar-footer  (sidebar-toggler[data-coreui-toggle="unfoldable"])
├─ .wrapper.d-flex.flex-column.min-vh-100
│   ├─ header.header.header-sticky.p-0.mb-4
│   │   ├─ .container-fluid.border-bottom.px-4 (toggler, search, header-nav,
│   │   │    theme dropdown, avatar dropdown)
│   │   └─ .container-fluid.px-4 > block breadcrumb
│   ├─ .body.flex-grow-1 > .container-lg.px-4 > block view
│   └─ footer.footer.px-4
└─ #searchButtonModal + scripts
```

- Fixed sidebar: `.sidebar-fixed`; content offset handled by
  `--cui-sidebar-occupy-start/end` (`style.scss` `.wrapper`).
- Unfoldable narrow mode: `.sidebar-narrow-unfoldable:not(:hover)` + toggler
  (`style.scss`).
- Sticky header with scroll shadow: inline JS in `scripts.pug` toggles
  `.shadow-sm` on `header.header` when `scrollTop > 0`.

### 4.2 Standalone pages (auth/error — `pages.pug`)

- `.bg-body-tertiary.min-vh-100.d-flex.flex-row.align-items-center` wrapper;
  content centered vertically, no sidebar/header/footer.

### 4.3 Grid / spacing

- Bootstrap 5 grid: `.row.g-4`, `.col-sm-6`, `.col-xl-3` etc.
  (dashboard stat cards `index.pug`).
- Content container: `.container-lg.px-4`.
- Density utilities: `mb-4`, `me-2`, `ms-auto`, `px-4`, `gap-4` (Bootstrap).

## 5. Typography

- Bootstrap defaults; scale via `fs-4`, `fs-5`, `fs-6`, `display-3` (404),
  `h4.card-title`, `h5` auth titles, `.small`, `.text-body-secondary`,
  `.text-truncate`, `fw-semibold`, `fw-normal`.
- Headings pattern: `.card-title` + `.small.text-body-secondary` subtitle
  (dashboard "Traffic" card, `index.pug`).

## 6. Responsive behavior (verified breakpoint usage)

| Pattern | Breakpoint | Verified in |
|---|---|---|
| Stat cards 2-up → 4-up | `col-sm-6` → `col-xl-3` | `index.pug` |
| Sidebar close button (mobile) | `d-lg-none` | `sidebar.pug` |
| Toolbar hidden on small | `d-none.d-md-block` | `index.pug` |
| Card footer 1→5 cols | `row-cols-1..row-cols-xl-5` | `index.pug` |
| Table horizontal scroll | `.table-responsive` | `index.pug` |
| Search button labels hidden | `d-none.d-sm-block` / `d-none.d-sm-inline-flex` | `search-button.pug` |
| Docs banner responsive cols | `col-xl-auto d-none.d-xl-block` | `docs-components.pug` |
| Nav group items `compact` | mobile-friendly compact list | `sidebar-nav.pug` |
| Unfoldable narrow sidebar | hover state (`:not(:hover)`) | `style.scss` |

`.browserslistrc`: Chrome/FF ≥60, iOS/Safari ≥12, no IE ≤11 — ES2015+ safe
(JS ships untranspiled).

## 7. Accessibility behavior (verified)

| Concern | Implementation | Verified in |
|---|---|---|
| Viewport/scale | `meta name="viewport" width=device-width, initial-scale=1.0, shrink-to-fit=no` | `head.pug` |
| Alt text on meaningful images | `alt="user@email.com"` on avatars, `alt='CoreUI Logo Full'` on brand | `header.pug`, `sidebar.pug`, `index.pug` |
| Decorative icons hidden | inline SVGs flagged `aria-hidden="true"` where decorative | `search-button.pug`, `login.pug`, `index.pug` |
| SVG role/label | `+inlineSvg` injects `role="img" aria-label` when `alt` provided | `inline-svg.pug`, `build/pug.mjs` |
| Buttons have labels | `aria-label="Close"` on close buttons; `aria-label="Show password"` | `sidebar.pug`, `login.pug` |
| Progress semantics | `role="progressbar" aria-valuenow aria-valuemin aria-valuemax` | `index.pug` |
| Dropdown semantics | `data-coreui-toggle="dropdown"`, `aria-expanded`, `aria-haspopup` | `header.pug`, `index.pug` |
| Breadcrumb semantics | `nav[aria-label="breadcrumb"]` + `ol.breadcrumb` | `breadcrumb.pug` |
| Modal semantics | `.modal.fade` `tabindex="-1"`, `aria-labelledby`, `aria-hidden` | `search-modal.pug`, `DEVELOPMENT.md` modal example |
| Form labels | `<label class="form-label">` paired with inputs | `login.pug` |
| Tabs role | `role="tablist"` / `role="tab"` / `role="tabpanel"` | `example.pug` |
| Focus states | Bootstrap 5 focus-visible rings (framework default) | (Bootstrap baseline) |
| Keyboard | CoreUI components (dropdowns, modals, sidebar) include Bootstrap keyboard support | (component lib baseline) |
| Color contrast | Theme tokens designed for both modes; `text-body-secondary` on subtle backgrounds | (token baseline) |
| Tooltip init for dynamic elements | `new coreui.Tooltip(el)` per `[data-coreui-toggle="tooltip"]` | `tooltips.js`, `login.pug` |

Caveats found (document, don't copy): `search-modal.pug` inputs and several
demo-only links are placeholders; `docs-components.pug` is a PRO-marketing
banner (exclude). The inline `style="--cui-card-cap-bg: …"` pattern is allowed
for per-instance token overrides but should be moved to CSS classes in
VisaFusion.

## 8. RTL

- `build/pug.mjs` compiles with `dir: 'rtl'` when `BUILD_RTL=true`
  (`html(lang='en' dir=dir)` in both layouts); CoreUI/Bootstrap 5.3 provide RTL
  support. Not currently required by VisaFusion (per findings, no RTL
  requirement) — documented for completeness.

## 9. VisaFusion design-system adoption mapping

| VisaFusion need | CoreUI mechanism | Adopt as |
|---|---|---|
| Dark/light/auto brand theming | `data-coreui-theme` + `--cui-*` tokens + `color-modes.js` | Keep; rename storage key; rebrand tokens via SCSS `@use ... with (...)` overrides |
| Role-based navigation (su/adm/emp/agt/guest) | `sidebar-nav.pug` data model (`item`/`group`/`title`/`divider` + badges) | Rebuild in Razor `_Layout` with per-role rendering (11 policies — see `docs/analysis/ROLE_BASELINE.md`) |
| Dense admin tables (entries, invoices, ledgers) | `.table`, `.table-responsive`, avatar cells, progress-in-table | Use CoreUI table + progress patterns in Reporting/Admin pages |
| Auth pages (Login/Register/ChangePassword/AccessDenied) | `pages.pug` layout + auth views (login, register, reset/change password, check-email, password-changed) | Re-skin existing `/Auth/*` Razor Pages with this layout |
| Error pages 404/500 | `error-pages/*.pug` (pages.pug layout) | Re-skin ASP.NET Core error pages |
| Notification surfacing (SMS/email queue, ledger alerts) | `toasts.js` + `toasts.pug` examples + header bell badge | Toast host + header badge on queue events |
| Entry/status progress | `.progress.progress-thin` + `progress-group` | Status bars on entry cards/lists |
| Form validation UX | `forms/validation.pug` (5 examples) | Client-side validation style aligned with ASP.NET Core validation |
| Charts for reporting | Chart.js + `@coreui/chartjs` (`main.js`, `charts.js`, `widgets.js`) | Reporting dashboards (entry volume, agent activity) |

**Contradiction note** (ties to `docs/analysis/GAP_REPORT.md` GAP-002): the
current VisaFusion UI ships a bespoke `vf-*` system (`tokens.css`,
`theme.css`) with no CoreUI assets. These docs are the analysis input for the
owner decision: adopt CoreUI (re-skin `wwwroot`) or amend constitution v1.4.1
Principle IV. Nothing here is implemented yet — analysis only.
