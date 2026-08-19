# CoreUI Dependency Map — Analysis for VisaFusion

**Source**: READ-ONLY analysis of `coreui-free-bootstrap-admin-template`
v5.6.0 (commit `d4003cd`, 2026-08-13). Reference copy:
`%TEMP%\opencode\coreui-free-bootstrap-admin-template`.
**Note**: `npm install` was NOT run; dependency facts come from
`package.json`, `build/vendors.mjs`, `_partials/head.pug`,
`_partials/scripts.pug`, `views/index.pug`, and `ARCHITECTURE.md`.

---

## 1. Runtime dependency tree (npm `dependencies`)

| Package | Version (package.json) | Purpose | Ships to page via | Needed by VisaFusion? |
|---|---|---|---|---|
| `@coreui/coreui` | `^5.9.0` | UI component library (CSS + JS: Sidebar, Dropdown, Modal, Toast, Tooltip, Popover, SearchButton, navigation, utils) | `coreui.bundle.min.js` (`scripts.pug`); SCSS via `@use "@coreui/coreui/scss/coreui"` (`style.scss`) | **YES — core** |
| `@coreui/icons` | `^3.1.0` | SVG icon set (free `cil-*`, brand `cib-*`, flag `cif-*`) | Inlined at Pug build time via `+inlineSvg`/`readSvg` from `node_modules/@coreui/icons/svg/...` | **YES — icons** |
| `@coreui/chartjs` | `^4.2.0` | CoreUI-styled Chart.js helpers (`coreui.ChartJS.customTooltips`, `css/coreui-chartjs.css`) | `index.pug` block styles/scripts | YES — reporting charts |
| `@coreui/utils` | `^2.0.2` | `Utils.getStyle()`, `rgbToHex()` etc. (theme-aware chart colors) | `index.pug` (`@coreui/utils/dist/umd/index.js`) | YES — charts theming |
| `chart.js` | `^4.5.1` | Charts engine | `index.pug` (`chart.umd.js`) | YES — reporting charts |
| `simplebar` | `^6.3.3` | Custom scrollbars (sidebar nav) | `simplebar.css` (head), `simplebar.min.js` (scripts), `css/vendors/simplebar.css` (SCSS partial) | YES — sidebar scroll |

## 2. Build/dev dependency tree (npm `devDependencies`) — NOT for VisaFusion runtime

| Package | Version | Role in template build |
|---|---|---|
| `sass` | 1.102.0 | SCSS → CSS compile |
| `pug` | ^3.0.4 | HTML templating |
| `postcss` / `postcss-cli` | ^8.5.26 / ^11.0.1 | CSS post-processing |
| `autoprefixer` | ^10.5.4 | Vendor prefixes |
| `postcss-combine-duplicated-selectors` | ^10.0.3 | Selector dedupe |
| `postcss-drop-empty-css-vars` | ^0.0.0 | Empty var removal |
| `clean-css-cli` | ^5.6.3 | Minification |
| `browser-sync` | ^3.0.4 | Dev server |
| `sync-directory` | ^6.0.5 | Copy `src/js`, `src/assets`, `src/views` → `dist` |
| `nodemon` | ^3.1.14 | File watching |
| `npm-run-all` | ^4.1.5 | Orchestration |
| `globby` | ^16.2.3 | File globbing (build scripts) |
| `eslint` / `eslint-config-xo` / `eslint-plugin-import` / `eslint-plugin-unicorn` / `globals` | 9.x / 0.49 / 2.32 / 62 / 16.5 | JS linting |
| `stylelint` / `stylelint-config-twbs-bootstrap` | 16.26.1 / ^16.1.0 | SCSS linting |
| `prettier` | 3.9.6 | HTML formatting |
| `rimraf` | ^6.1.3 | Clean |
| `cross-env` | ^10.1.0 | Cross-platform env for zip |
| `serve` | ^14.2.6 | Static serve |

## 3. Build pipeline graph

```
npm run start (dev)                        npm run build (prod)
  ├─ clean (rimraf dist)
  ├─ pug  build/pug.mjs                    (Pug → src/views/*.html, pretty)
  │     globals: base, dir (RTL), readSvg   → inlines SVGs at compile time
  ├─ css  sass src/scss/:dist/css/          (expanded, source maps, load-path node_modules)
  │     └─ postcss (autoprefixer, dedupe selectors, drop empty vars)   [dev]
  │     └─ cleancss -O1 → *.min.css                                       [prod]
  ├─ js   syncdir src/js dist/js            (copied as-is, NO transpile/minify)
  ├─ sync syncdir src/assets, src/views → dist
  ├─ build-vendors build/vendors.mjs
  │     └─ rewrites node_modules/... → vendors/<pkg>/<ext>/<file>
  │     └─ copies vendor files + .map + CSS url() assets
  └─ localhost browser-sync (dev) | zip (prod)
```

SCSS include graph (`style.scss`):
`@use "@coreui/coreui/scss/coreui" as * with ($enable-deprecation-messages: false)`
→ Bootstrap 5.3 + CoreUI components + token variables;
`@use "vendors/simplebar"` → `.simplebar-content` flex fix;
then template rules (`.wrapper`, `.header`, `.sidebar-*`, `.footer`, dark mode).

## 4. Page-level asset load contract (verified)

### Every page (`head.pug` + `scripts.pug`)
```
<link> node_modules/simplebar/dist/simplebar.css          → vendors/simplebar/css/simplebar.css
<link> css/vendors/simplebar.css                          (compiled SCSS partial)
<link> css/style.css                                      (Bootstrap + CoreUI + template)
<link> css/examples.css                                   [DEMO-ONLY — drop in VisaFusion]
<script src=js/config.js>                                 (URL ?theme= → localStorage)
<script src=js/color-modes.js>                            (theme switcher)
<script src=@coreui/coreui/dist/js/coreui.bundle.min.js>  → vendors/... (in body)
<script src=simplebar.min.js>                             (in body)
inline: header scroll → .shadow-sm
block scripts / block js  (page-specific)
```

### Dashboard only (`views/index.pug`)
```
<link> @coreui/chartjs/dist/css/coreui-chartjs.css
<script> chart.js/dist/chart.umd.js
<script> @coreui/chartjs/dist/js/coreui-chartjs.js
<script> @coreui/utils/dist/umd/index.js
<script> js/main.js
```

### Component/forms demo pages
- `tooltips` → `js/tooltips.js`; `popovers` → `js/popovers.js`;
  `toasts` → `js/toasts.js`; `charts` → `js/charts.js`; `widgets` → `js/widgets.js`
  (each declared in the view's `block scripts`).

## 5. JS component dependency map (who needs what)

| Component | JS | Notes |
|---|---|---|
| Sidebar (fixed, unfoldable, toggler, mobile close) | `@coreui/coreui` (`coreui.Sidebar.getInstance(...).toggle()`, `data-coreui-toggle="unfoldable"`, `data-coreui="navigation"`) + simplebar | `sidebar.pug`, `header.pug` |
| Dropdowns (header menus, row actions) | `@coreui/coreui` (`data-coreui-toggle="dropdown"`) | `header.pug`, `index.pug` |
| Modal (search) | `@coreui/coreui` (`data-coreui-toggle="modal"`, `data-coreui-dismiss`) | `search-modal.pug`, `search-button.pug` |
| Search Button | `@coreui/coreui` (`data-coreui-search-button`, `data-coreui-shortcut`) | `search-button.pug` |
| Tooltip | `@coreui/coreui` + `tooltips.js` | `login.pug` (show password) |
| Popover | `@coreui/coreui` + `popovers.js` | `components/popovers.pug` |
| Toast | `@coreui/coreui` + `toasts.js` | `components/toasts.pug` |
| Tabs/Collapse/Accordion/Carousel | `@coreui/coreui` bundle (`data-coreui-toggle`) | components views |
| Charts | chart.js + @coreui/chartjs + @coreui/utils | `main.js`, `charts.js`, `widgets.js` |
| Theme | `config.js` + `color-modes.js` (no library) | all pages |

## 6. CSS/SCSS dependency map (per artifact)

| Artifact | Depends on |
|---|---|
| `css/style.css` (compiled) | Bootstrap 5.3 + CoreUI SCSS (`@coreui/coreui/scss/coreui`), `vendors/simplebar.scss`, template overrides |
| `css/vendors/simplebar.css` | simplebar core css + partial fix |
| `css/examples.css` (compiled) | CoreUI variables/mixins (breakpoints, color-mode) — demo-only |
| `coreui-chartjs.css` | @coreui/chartjs (charts page + dashboard) |
| Icons | `@coreui/icons/svg/free|cib|flag` — no CSS (SVG inlined at build) |

## 7. Vendor rewrite contract (`build/vendors.mjs`)

Source patterns rewritten in compiled HTML:
`(href|src|xlink:href)="node_modules/<pkg>/<path>"` →
`vendors/<pkg>/<ext>/<basename>` (ext = css/js/svg …). CSS `url(...)` assets
(not http/data) inside copied vendor CSS are copied relative to the vendor
file. `.map` files copied when present. Dedup by URL (`seen` set).

## 8. Version pinning facts for VisaFusion adoption

- CoreUI 5.9.x requires Bootstrap **5.3.x** (peer; pulled transitively through
  `@coreui/coreui/scss/coreui`).
- JS ships **untranspiled ES2015+** (`.browserslistrc` → no IE ≤11) — safe to
  serve as static files behind ASP.NET Core.
- `@coreui/coreui` bundle includes ALL components; tree-shaking would require
  the ESM `dist/js/coreui.esm.js` path (bundle is the template's choice).

## 9. What VisaFusion must consume (minimal runtime set)

1. `@coreui/coreui` — `dist/css/coreui.min.css` OR compiled custom
   `style.scss` (token overrides) + `dist/js/coreui.bundle.min.js`.
2. `@coreui/icons` — selected `cil-*`/`cib-*`/`cif-*` SVGs → `wwwroot/icons/`.
3. `simplebar` — css + js (sidebar scrollbar).
4. Optional: `@coreui/chartjs` + `chart.js` + `@coreui/utils` (reporting
   charts), `color-modes.js`/`config.js` pattern (theme), `toasts.js`-style
   init script (notifications).
5. NOT consumed: pug, node build, browser-sync, examples.css, PRO links.

Adoption paths (decision needed — see `docs/analysis/GAP_REPORT.md` GAP-002):
(a) npm-managed front-end with MSBuild/npm restore producing `wwwroot`
vendors, or (b) vendored static copies of the pinned dist files committed to
`wwwroot/` (no node toolchain in the .NET pipeline).
