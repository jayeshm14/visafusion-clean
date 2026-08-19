# CoreUI Free Bootstrap Admin Template — Complete Inventory

**Scope**: READ-ONLY analysis of
`https://github.com/coreui/coreui-free-bootstrap-admin-template` (branch
`main`, commit `d4003cd` 2026-08-13 "docs: add Scheduler section to README
(#631)").
**Local reference copy**: `%TEMP%\opencode\coreui-free-bootstrap-admin-template`
(shallow clone; the upstream repository was NOT modified).
**Template version**: **5.6.0** (`package.json`, `banner.pug`) · MIT license
(`README.md` §Copyright and license, `LICENSE`).
**Status**: COMPLETE — every file below was listed/read by a tool call this
session.

---

## 1. Repository overview

| Attribute | Value |
|---|---|
| Package | `@coreui/coreui-free-bootstrap-admin-template` |
| Version | 5.6.0 |
| License | MIT (copyright 2026 creativeLabs Łukasz Holeczek) |
| Stack | Bootstrap 5.3.x + CoreUI 5.x + Pug + Sass + vanilla ES6+ JS |
| Architecture | Static multi-page (MPA); Pug → HTML at build time (see `ARCHITECTURE.md`) |
| Build | npm scripts (`npm run build` → `dist/`) |
| Homepage/docs | https://coreui.io/bootstrap/docs/ |

Top-level layout:

```
.browserslistrc  .cursorrules  .editorconfig  .gitattributes  .gitignore
.prettierignore  .prettierrc.json  .stylelintignore  .stylelintrc
ARCHITECTURE.md  DEVELOPMENT.md  eslint.config.mjs  LICENSE  README.md
nodemon.json  package-lock.json  package.json
build/   src/   .github/
```

## 2. Configuration artifacts

| Name | Type | Source path | Purpose | VisaFusion usage |
|---|---|---|---|---|
| `.browserslistrc` | config | `/` | Browser targets: `>=0.5%`, last 2 majors, not dead, Chrome/FF >=60, FF ESR, iOS/Safari >=12, not IE<=11 | Document supported browsers for the adopted UI (older IE support excluded) |
| `.cursorrules` | AI context | `/` | Project conventions for AI coding assistants (CoreUI components, no Tailwind, Pug, Sass, JS module patterns) | Keep as reference for VisaFusion AI-assisted UI work |
| `eslint.config.mjs` | config | `/` | ESLint 9 flat config (XO + Unicorn) | Reference when introducing frontend linting |
| `.stylelintrc` | config | `/` | Stylelint with Bootstrap config | Reference for SCSS linting of adopted styles |
| `.prettierrc.json` | config | `/` | Prettier formatting (HTML output) | Reference only |
| `nodemon.json` | config | `/` | Watch config for dev reload | Not applicable (VisaFusion uses ASP.NET Core) |
| `.editorconfig` | config | `/` | Editor conventions | Already mirrored in VisaFusion root |
| `package.json` | manifest | `/` | npm manifest, scripts, deps | **Primary source for version pins** (see `COREUI_DEPENDENCY_MAP.md`) |
| `package-lock.json` | manifest | `/` | Locked dependency tree | Not needed (VisaFusion will copy dist files, not npm-install) |

## 3. Documentation artifacts

| Name | Type | Source path | Purpose |
|---|---|---|---|
| `README.md` | docs | `/` | Product overview, install/usage, component index (50+ links), AI-friendly-development notes, versioning/licensing |
| `ARCHITECTURE.md` | docs | `/` | Architecture: Pug→HTML pipeline, Sass→CSS, JS sync, theme flow, chart flow, block system, browser support, deployment, security notes |
| `DEVELOPMENT.md` | docs | `/` | Developer guide: workflows, adding pages/components/styles, JS patterns, testing, troubleshooting |
| `LICENSE` | license | `/` | MIT |

## 4. Build artifacts (`build/`)

| Name | Type | Source path | Purpose | Dependencies |
|---|---|---|---|---|
| `build/pug.mjs` | build script | `build/` | Compiles `src/pug/views/**/*.pug` → HTML (default `src/views/`, `--dest=` overridable). Injects `base`, `dir` (RTL), `readSvg` globals | pug, globby, format-html.mjs |
| `build/format-html.mjs` | build script | `build/` | HTML prettify of compiled output | prettier (via source) |
| `build/postcss.config.mjs` | build config | `build/` | PostCSS plugins: autoprefixer, postcss-combine-duplicated-selectors, postcss-drop-empty-css-vars | postcss, autoprefixer |
| `build/vendors.mjs` | build script | `build/` | Rewrites `node_modules/...` href/src/xlink:href in HTML to `vendors/<pkg>/<ext>/<file>`; copies vendor JS/CSS (+ source maps, CSS `url()` assets) into `dist/vendors/` | globby, format-html.mjs |

## 5. SCSS artifacts (`src/scss/`)

| Name | Type | Source path | Purpose | JS dep | CSS/SCSS dep | VisaFusion usage |
|---|---|---|---|---|---|---|
| `src/scss/style.scss` | SCSS entry | `src/scss/` | Main stylesheet: `@use "@coreui/coreui/scss/coreui"` (with `$enable-deprecation-messages:false`) + `@use "vendors/simplebar"` + template layout rules (`.wrapper`, `.header`, `.sidebar-*`, `.footer`, dark-mode overrides) | none | @coreui/coreui SCSS, simplebar vendor | **Reference entry** for VisaFusion's CoreUI-based `style.scss` |
| `src/scss/examples.scss` | SCSS (demo-only) | `src/scss/` | Styles the demo "example preview" blocks (`.example`, `.preview`, static dropdowns/modals, margins for stacked components) | none | @coreui/coreui variables, breakpoints, color-mode mixins | **Remove** — demo-only per head.pug comment |
| `src/scss/vendors/simplebar.scss` | SCSS partial | `src/scss/vendors/` | SimpleBar content flex layout fix (`.simplebar-content` min-height) | simplebar | — | Adopt if sidebar scrollbar customization is kept |

Note: `style-rtl.scss` is documented in `ARCHITECTURE.md` but the working tree
currently contains only `style.scss` + `examples.scss` + `vendors/simplebar.scss`;
RTL is produced via the `BUILD_RTL=true` env in `build/pug.mjs` (`dir: 'rtl'`).

## 6. JavaScript artifacts (`src/js/` — vanilla ES6 modules, copied as-is)

| Name | Type | Source path | Purpose | JS dep | CSS/SCSS dep | VisaFusion usage |
|---|---|---|---|---|---|---|
| `src/js/main.js` | JS module | `src/js/` | Dashboard charts: `card-chart1..4`, `main-chart`; Chart.js defaults + `coreui.ChartJS.customTooltips`; re-colors charts on `ColorSchemeChange` | chart.js, @coreui/chartjs, @coreui/utils | — | Reuse pattern for reporting dashboards (entry-volume charts) |
| `src/js/charts.js` | JS module | `src/js/` | Charts page demos: line, bar, doughnut, radar, pie, polarArea (`canvas-1..6`) | chart.js | — | Pattern for report chart types |
| `src/js/widgets.js` | JS module | `src/js/` | Widgets page: card charts, 6 sparklines, 3 brand-box charts; theme-aware | chart.js, @coreui/chartjs, @coreui/utils | — | KPI sparklines for agent/entry dashboards |
| `src/js/config.js` | JS module | `src/js/` | Reads `?theme=light\|dark\|auto` URL param, persists to localStorage (`coreui-free-bootstrap-admin-template-theme`) | none | — | Adapt for VisaFusion theme defaults |
| `src/js/color-modes.js` | JS module | `src/js/` | Theme switcher: localStorage persist, `prefers-color-scheme`, sets `data-coreui-theme` on `<html>`, dispatches `ColorSchemeChange`, syncs `.theme-icon-active` | none | CSS custom properties `--cui-*` | **Adopt** for dark/light/auto mode |
| `src/js/tooltips.js` | JS module | `src/js/` | Auto-init `new coreui.Tooltip(el)` for every `[data-coreui-toggle="tooltip"]` | @coreui/coreui | — | Adopt for agent/admin tooltips |
| `src/js/popovers.js` | JS module | `src/js/` | Auto-init `new coreui.Popover(el)` for every `[data-coreui-toggle="popover"]` | @coreui/coreui | — | Adopt where popovers needed |
| `src/js/toasts.js` | JS module | `src/js/` | Live-toast demo: `liveToastBtn` → `new coreui.Toast(...).show()` | @coreui/coreui | — | Pattern for notification toasts (SMS/email queue status) |

## 7. Pug templates — layouts (`src/pug/_layout/`)

| Name | Type | Source path | Purpose | Dependencies |
|---|---|---|---|---|
| `_layout/default.pug` | layout | `src/pug/` | Main layout: `html(lang=.., dir=..)` → head partial + blocks `canonical`/`styles`; body = sidebar partial + `.wrapper.d-flex.flex-column.min-vh-100` (header partial + `.body.flex-grow-1 > .container-lg.px-4 > block view` + footer partial) + search-modal + scripts partial. Blocks: `view`, `canonical`, `breadcrumb` (declared in header partial), `styles`, `scripts`, `js` | banner, mixins (breadcrumb, callout, callout-custom, docs-components, example, inline-svg), head/sidebar/header/footer/search-modal/scripts partials |
| `_layout/pages.pug` | layout | `src/pug/` | Standalone pages layout (auth/errors): `.bg-body-tertiary.min-vh-100.d-flex.flex-row.align-items-center` > `block view` + scripts. No sidebar/header/footer | banner, inline-svg, head, scripts |

## 8. Pug templates — partials (`src/pug/_partials/`)

| Name | Type | Source path | Purpose | JS dep | VisaFusion usage |
|---|---|---|---|---|---|
| `_partials/head.pug` | partial | `src/pug/` | `<head>`: viewport meta, favicon set (25 files), vendor CSS (simplebar.css ×2), `css/style.css`, `css/examples.css`, `js/config.js`, `js/color-modes.js` | config.js, color-modes.js | Replace favicon set with VisaFusion branding; drop examples.css |
| `_partials/banner.pug` | partial | `src/pug/` | License/version comment banner (v5.6.0) | — | Not applicable |
| `_partials/sidebar.pug` | partial | `src/pug/` | `.sidebar.sidebar-dark.sidebar-fixed.border-end#sidebar`: sidebar-header (brand full/signet SVGs + mobile close `btn-close.d-lg-none` toggling via `coreui.Sidebar.getInstance(...).toggle()`), `include sidebar-nav`, sidebar-footer with `button.sidebar-toggler[data-coreui-toggle="unfoldable"]` | @coreui/coreui (Sidebar) | **Base for VisaFusion `vf-sidebar`** — map roles to nav items |
| `_partials/sidebar-nav.pug` | partial | `src/pug/` | Data-driven nav (`nav` array; types `item`, `title`, `group`, `divider`; mixins `navItem`/`navGroup`; `ul.sidebar-nav[data-coreui="navigation"][data-simplebar]`). Groups: Dashboard, Charts, Components (24), Forms (18, PRO-links external), Icons (3), Widgets, Extras: Authentication (6), Error pages (2), Docs, PRO CTA. Badges (`bg-info/danger/success`), external-link icons for PRO entries | @coreui/coreui navigation, simplebar | **Role-driven nav model** (admin/agent/reporting/public menus) |
| `_partials/header.pug` | partial | `src/pug/` | `.header.header-sticky.p-0.mb-4`: header-toggler (sidebar toggle), search-button, `header-nav.ms-auto` (bell, list-rich, envelope-open), theme dropdown (light/dark/auto via `data-coreui-theme-value`), avatar dropdown (Account/Settings/Logout items), `block breadcrumb` | @coreui/coreui (Sidebar, Dropdown), color-modes | **Base for VisaFusion topbar** — replace avatar menu with agent/su menu, add notification badges |
| `_partials/footer.pug` | partial | `src/pug/` | `.footer.px-4` with CoreUI credit links | — | Replace with VisaFusion footer |
| `_partials/scripts.pug` | partial | `src/pug/` | Loads `@coreui/coreui/dist/js/coreui.bundle.min.js`, `simplebar.min.js`; inline scroll listener toggling header `shadow-sm`; `block scripts` + `block js` | @coreui/coreui bundle, simplebar | **Script include contract** for VisaFusion layouts |
| `_partials/search-button.pug` | partial | `src/pug/` | `button.search-button[data-coreui-search-button][data-coreui-shortcut="cmd+/,ctrl+/"]` toggling `#searchButtonModal` | @coreui/coreui search-button component | Optional global search (entry ref-no / agent search) |
| `_partials/search-modal.pug` | partial | `src/pug/` | `.modal.fade#searchButtonModal`: search input + "Recent searches" list-group demo | — | Wire to VisaFusion entry query endpoint |
| `_partials/docs-icons.pug` | partial | `src/pug/` | Icon-documentation helpers (icons pages) | — | Demo-only |

## 9. Pug templates — mixins (`src/pug/_mixins/`)

| Name | Type | Source path | Purpose | VisaFusion usage |
|---|---|---|---|---|
| `_mixins/breadcrumb.pug` | mixin | `src/pug/` | `+breadcrumb(items)` → `nav[aria-label="breadcrumb"] > ol.breadcrumb` with active last item | Adopt for Razor page headers |
| `_mixins/callout.pug` | mixin | `src/pug/` | `+callout(name, href)` info callout (docs-only copy) | Demo-only |
| `_mixins/callout-custom.pug` | mixin | `src/pug/` | Custom callout variant | Demo-only |
| `_mixins/docs-components.pug` | mixin | `src/pug/` | Docs banner block (PRO CTA) | Demo-only |
| `_mixins/example.pug` | mixin | `src/pug/` | `+example(url, classes)`: Preview/Code tabs + `.tab-content.preview` block — demo harness for every component example | Not applicable to VisaFusion pages |
| `_mixins/inline-svg.pug` | mixin | `src/pug/` | `+inlineSvg(src)`: inlines SVG at compile time via `readSvg`; adds `role="img" aria-label` when `alt` present; falls back to `<img>` if SVG missing | Adopt the SVG-inlining concept (or ship static SVGs in wwwroot) |

## 10. Pug views (`src/pug/views/` → `src/views/*.html`)

| View | Source path | Examples* | Purpose |
|---|---|---|---|
| Dashboard | `views/index.pug` | 0 (custom) | Stat cards (Users/Income/Conversion/Sessions) with mini charts, Traffic chart + progress footer, social cards, progress groups, user table w/ avatars + status |
| Charts | `views/charts.pug` | 6 | Line/bar/doughnut/radar/pie/polarArea demos |
| Widgets | `views/widgets.pug` | 12 | Cards, sparklines, brand boxes |
| Blank | `views/blank.pug` | 0 | Empty page scaffold |
| Login | `views/authentication/login.pug` | 0 | pages.pug layout: logo, email+password (+show-password tooltip), remember-me check, social (Google/Apple) buttons, register link |
| Register | `views/authentication/register.pug` | 0 | pages.pug layout: sign-up form |
| Reset Password | `views/authentication/reset-password.pug` | 0 | pages.pug layout |
| Change Password | `views/authentication/change-password.pug` | 0 | pages.pug layout |
| Password Changed | `views/authentication/password-changed.pug` | 0 | pages.pug layout, success state |
| Check Email | `views/authentication/check-email.pug` | 0 | pages.pug layout, "check your inbox" state |
| 404 | `views/error-pages/404.pug` | 0 | pages.pug layout: 404 + search input |
| 500 | `views/error-pages/500.pug` | 0 | pages.pug layout |
| Components ×24 | `views/components/*.pug` | 2–29 each | Accordion, alerts, badge, breadcrumb, button-group, buttons, cards, carousel, chip, chip-set, collapse, dropdowns, list-group, modals, navs-tabs, pagination, placeholders, popovers, progress, search-button, spinners, tables, toasts, tooltips |
| Forms ×9 | `views/forms/*.pug` | 4–17 each | checks-radios, chip-input, floating-labels, form-control, input-group, layout, range, select, validation |
| Icons ×3 | `views/icons/*.pug` | 0 | coreui-icons-free, coreui-icons-brand, coreui-icons-flag galleries |

\* = `+example(...)` blocks counted by grep this session (buttons 15, dropdowns 24,
tables 23, navs-tabs 19, checks-radios 17, cards 29, etc. — see
`COREUI_COMPONENT_CATALOG.md` for the full per-view counts).

## 11. Static assets (`src/assets/`)

| Group | Path | Contents | Purpose | VisaFusion usage |
|---|---|---|---|---|
| Brand | `assets/brand/` | `coreui.svg`, `coreui-full.svg`, `coreui-signet.svg` | Logo variants (full/narrow) used in sidebar/header/auth | Replace with VisaFusion brand SVGs |
| Favicon | `assets/favicon/` | 25 files (android-icon-*, apple-icon-*, ms-icon-*, favicon.ico, `manifest.json`, `browserconfig.xml`) | Multi-platform favicon set | Replace with VisaFusion branding |
| Icons (free) | `assets/icons/*.svg` | ~430 free `cil-*` icons incl. `free-symbol-defs.svg` sprite | UI icons (used via `+inlineSvg` at build time) | Copy only needed icons to wwwroot |
| Icons (brand) | `assets/icons/brands/*.svg` | ~350 `cib-*` brand icons + `brands-symbol-defs.svg` | Brand logos (social, payment cards, tech) | Select only relevant brands |
| Icons (flags) | (in free set) | `cif-*` flag SVGs (used as `assets/icons/flag/cif-us.svg`) | Country flags | **Relevant for country/embassy UI** |
| Images | `assets/img/` | `avatars/1..9.jpg`, `background-pro.jpg`, `background-pro-yellow.jpg`, `components.webp`, `full.jpg`, `icons.webp` | Demo avatars, backgrounds, promo art | Demo-only — replace with real data |

## 12. Not present / notable absences

- No `offcanvas` view page (component exists in CoreUI lib; not demonstrated).
- No dedicated `avatar`, `input-group`-beyond-forms, `tooltip` dedicated page beyond
  `components/tooltips.pug` (3 examples).
- No `dist/` committed (generated at build time); `src/views/*.html` compiled output
  is committed.
- No `node_modules/` (shallow clone, no `npm install` run — dependency analysis is
  from `package.json`/`package-lock.json` + `build/vendors.mjs` contract).

## 13. Provenance

All listings produced by `git`/`Get-ChildItem`/`Select-String`/`read` tool calls
against the local reference copy this session. Component example counts from
grep over `src/pug/views/**` (see the per-view table above).
