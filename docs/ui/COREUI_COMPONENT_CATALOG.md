# CoreUI Component Catalog — Analysis for VisaFusion

**Source**: READ-ONLY analysis of `coreui-free-bootstrap-admin-template`
v5.6.0 (commit `d4003cd`, 2026-08-13). Reference copy:
`%TEMP%\opencode\coreui-free-bootstrap-admin-template`.
Example counts = `+example(...)` blocks per view (grep, this session).

**Legend** — Dependencies:
- **JS**: `bundle` = `@coreui/coreui` bundle (`coreui.bundle.min.js`); `chart` =
  chart.js/@coreui/chartjs/@coreui/utils; `simplebar`; `none` = CSS/data-attr only.
- **CSS/SCSS**: `coreui` = compiled from `@coreui/coreui/scss/coreui`;
  `bs` = Bootstrap base; `template` = template `style.scss` overrides.
- **Responsive**: verified breakpoint behavior from views/layout.
- **A11y**: verified ARIA/roles/attributes from views.

---

## 1. Layout & shell components

### 1.1 Sidebar
| Field | Value |
|---|---|
| Name | Sidebar (`sidebar-dark`, `sidebar-fixed`) |
| Type | Layout component |
| Source | `_partials/sidebar.pug`, `_partials/sidebar-nav.pug`, `style.scss` (§4.1) |
| Purpose | Fixed left navigation shell with brand header, data-driven nav, footer toggler |
| Dependencies | bundle (Sidebar, navigation), simplebar (scroll), inline-svg, `--cui-sidebar-*` tokens |
| JS dependency | `coreui.bundle.min.js` (`data-coreui="navigation"`, `coreui.Sidebar.getInstance().toggle()`, `data-coreui-toggle="unfoldable"`); simplebar on `ul.sidebar-nav` |
| CSS/SCSS dep | coreui + template (`--cui-sidebar-occupy-start/end` wrapper offset; `.sidebar-narrow-unfoldable`) |
| Responsive | `.d-lg-none` close button on mobile; unfoldable narrow mode on hover; fixed offset via tokens |
| A11y | `aria-label="Close"` on mobile close; brand SVG `alt`; nav links are anchors |
| VisaFusion usage | **Role-driven navigation shell** for su/adm/emp/agt (see ROLE_BASELINE); keep fixed + unfoldable, SimpleBar scroll |

### 1.2 Header
| Field | Value |
|---|---|
| Name | Header (`header-sticky`) |
| Type | Layout component |
| Source | `_partials/header.pug` |
| Purpose | Top bar: sidebar toggler, global search button, icon nav, theme dropdown, avatar/account dropdown, breadcrumb block |
| Dependencies | bundle (Dropdown), inline-svg, `color-modes.js`, `--cui-dropdown-min-width` |
| JS dependency | bundle; scroll shadow inline script (`scripts.pug`) |
| CSS/SCSS dep | coreui + template (`.header > .container-fluid` 4rem, second row 3rem) |
| Responsive | 4rem min-height; `d-flex` rows; icon+dropdown layout shrinks on small screens |
| A11y | `aria-expanded`/`aria-haspopup` on dropdowns; avatar `alt`; `.vr` separators |
| VisaFusion usage | Topbar with real agent/su identity + logout (`/Auth` routes), notification badge counts |

### 1.3 Footer
| Field | Value |
|---|---|
| Name | Footer |
| Type | Layout component |
| Source | `_partials/footer.pug`, `style.scss` |
| Purpose | Page footer with credit links |
| Dependencies | none |
| JS dependency | none |
| CSS/SCSS dep | coreui + template (`.footer` 3rem, dark-mode `--cui-footer-bg`) |
| Responsive | `ms-auto` right-aligned second block |
| A11y | Links are anchors |
| VisaFusion usage | Brand footer; replace CoreUI credits |

### 1.4 Breadcrumb
| Field | Value |
|---|---|
| Name | Breadcrumb |
| Type | Navigation component |
| Source | `_mixins/breadcrumb.pug`, `views/components/breadcrumb.pug` (1 example) |
| Purpose | Page trail; last item active |
| Dependencies | none |
| JS dependency | none |
| CSS/SCSS dep | bs (`.breadcrumb`) + coreui |
| Responsive | None specific |
| A11y | `nav[aria-label="breadcrumb"]`, `ol.breadcrumb`, `.active` on current |
| VisaFusion usage | Header trail on Admin/Reporting/Agent pages |

### 1.5 Avatar
| Field | Value |
|---|---|
| Name | Avatar (+ status) |
| Type | Media component |
| Source | `header.pug`, `index.pug` (table rows) — no dedicated view |
| Purpose | User image with online/offline status dot |
| Dependencies | coreui (avatar styles) |
| JS dependency | none |
| CSS/SCSS dep | coreui (`.avatar`, `.avatar-md`, `.avatar-img`, `.avatar-status.bg-*`) |
| Responsive | Fixed sizes (`.avatar-md`) |
| A11y | `alt="user@email.com"` on image |
| VisaFusion usage | Agent/admin user representations in tables and header |

## 2. Navigation components

### 2.1 Navs & Tabs
| Field | Value |
|---|---|
| Name | Navs & Tabs |
| Type | Navigation component |
| Source | `views/components/navs-tabs.pug` (19 examples); `_mixins/example.pug` (tablist) |
| Purpose | Tab panels, underline navs, pills, vertical navs |
| Dependencies | bundle (Tab) |
| JS dependency | bundle (`data-coreui-toggle="tab"`); `example.pug` uses `nav-underline-border` |
| CSS/SCSS dep | coreui (`--cui-nav-underline-border-*`), bs |
| Responsive | Flex-wrap by default; compact on mobile |
| A11y | `role="tablist"`/`role="tab"`/`role="tabpanel"` in example harness |
| VisaFusion usage | Entry detail tabs (passenger/status/history), report filters |

### 2.2 Dropdowns
| Field | Value |
|---|---|
| Name | Dropdowns |
| Type | Overlay component |
| Source | `views/components/dropdowns.pug` (24 examples); `header.pug`, `index.pug` |
| Purpose | Menus, headers, dividers, aligned end/up, custom min-width |
| Dependencies | bundle (Dropdown) |
| JS dependency | bundle (`data-coreui-toggle="dropdown"`) |
| CSS/SCSS dep | coreui + bs (`--cui-dropdown-min-width`) |
| Responsive | `.dropdown-menu-end` for edge alignment; `dropup` variants |
| A11y | `aria-expanded`, `aria-haspopup`, `.dropdown-header`/`.dropdown-divider` |
| VisaFusion usage | Row actions (info/edit/delete) on entry/invoice/ledger tables; account menu |

### 2.3 Pagination
| Field | Value |
|---|---|
| Name | Pagination |
| Type | Navigation component |
| Source | `views/components/pagination.pug` (8 examples) |
| Purpose | Paged navigation, sizes, disabled/active states, alignment |
| Dependencies | none |
| JS dependency | none |
| CSS/SCSS dep | bs + coreui |
| Responsive | Sized variants (`pagination-sm/lg`); wraps naturally |
| A11y | `aria-label` on nav; `.active`/`.disabled` states |
| VisaFusion usage | Paging large legacy datasets (Mainentry 271k rows, bighistory 1.4M) |

### 2.4 Search Button
| Field | Value |
|---|---|
| Name | Search Button (+ modal) |
| Type | Command component |
| Source | `_partials/search-button.pug`, `_partials/search-modal.pug`, `views/components/search-button.pug` (3 examples) |
| Purpose | Global search trigger with keyboard shortcut (`cmd+/`, `ctrl+/`) opening modal |
| Dependencies | bundle (SearchButton, Modal) |
| JS dependency | bundle (`data-coreui-search-button`, `data-coreui-shortcut`, `data-coreui-toggle="modal"`) |
| CSS/SCSS dep | coreui (search-button) + bs (modal) |
| Responsive | Placeholder/keys hidden on xs (`d-none.d-sm-*`) |
| A11y | Icon `aria-hidden="true"`; modal `aria-labelledby`/`aria-hidden`; close `aria-label` |
| VisaFusion usage | Entry ref-no / agent / passenger quick search |

## 3. Content & display components

### 3.1 Cards
| Field | Value |
|---|---|
| Name | Cards |
| Type | Content container |
| Source | `views/components/cards.pug` (29 examples); `index.pug`, `widgets.pug` |
| Purpose | Stat cards, headers/footers, color variants, borders, text alignment |
| Dependencies | none |
| JS dependency | none (charts inside cards use chart) |
| CSS/SCSS dep | coreui + bs (`.card`, `.card-header`, `.card-footer`, `--cui-card-cap-bg`) |
| Responsive | Grid-driven (`col-sm-6 col-xl-3`) |
| A11y | `.card-title`/`card-text` semantic; icons decorative |
| VisaFusion usage | Dashboard KPI cards, entry summaries, agent/billing panels |

### 3.2 Tables
| Field | Value |
|---|---|
| Name | Tables |
| Type | Data component |
| Source | `views/components/tables.pug` (23 examples); `index.pug` (user table) |
| Purpose | Striped/hover/bordered tables, responsive, active rows, small variants |
| Dependencies | none |
| JS dependency | none (row-action dropdowns use bundle) |
| CSS/SCSS dep | bs + coreui (`.table-responsive`, `.table-sm`, `table.border`) |
| Responsive | `.table-responsive` horizontal scroll on small screens |
| A11y | `th` with `bg-body-secondary` headers; `aria-label` toolbar (`index.pug`) |
| VisaFusion usage | **Primary data grid** for entries (insertEntry/listforagents), invoices, ledgers, SMS logs |

### 3.3 List Group
| Field | Value |
|---|---|
| Name | List Group |
| Type | Content/list component |
| Source | `views/components/list-group.pug` (12 examples); `search-modal.pug` |
| Purpose | Item lists, actions, flush, numbered, horizontal |
| Dependencies | none |
| JS dependency | none |
| CSS/SCSS dep | bs + coreui |
| Responsive | `.list-group-horizontal-*` variants |
| A11y | `.list-group-item-action` focus styles |
| VisaFusion usage | Recent searches, quick links, contact lists |

### 3.4 Progress (+ groups)
| Field | Value |
|---|---|
| Name | Progress / Progress Group |
| Type | Status indicator |
| Source | `views/components/progress.pug` (8 examples); `index.pug` (progress-group dashboard) |
| Purpose | Value bars, `progress-thin`, stacked, labeled, groups with prepend/header |
| Dependencies | none |
| JS dependency | none |
| CSS/SCSS dep | coreui + template (`.progress-thin`, `.progress-group`, `.progress-group-bars`) |
| Responsive | Width-driven; adapts to column widths |
| A11y | `role="progressbar"` + `aria-valuenow/min/max` everywhere |
| VisaFusion usage | Status/processing percentages, quota usage, embassy-processing progress |

### 3.5 Alerts / Callouts
| Field | Value |
|---|---|
| Name | Alerts (+ Callout mixin) |
| Type | Feedback component |
| Source | `views/components/alerts.pug` (4 examples); `_mixins/callout.pug`, `callout-custom.pug` |
| Purpose | Contextual messages, links, dismissible |
| Dependencies | bundle (close/alert) |
| JS dependency | bundle (`data-coreui-dismiss`) for dismissible |
| CSS/SCSS dep | bs + coreui (`.callout.callout-info`) |
| Responsive | None specific |
| A11y | `role="alert"` on alerts |
| VisaFusion usage | Form validation banners, data-quality notices, security messages |

### 3.6 Badges
| Field | Value |
|---|---|
| Name | Badges |
| Type | Label component |
| Source | `views/components/badge.pug` (4 examples); `sidebar-nav.pug` (NEW/PRO), `header.pug` (8/42 counts) |
| Purpose | Counts, statuses, nav markers (`badge-sm`) |
| Dependencies | none |
| JS dependency | none |
| CSS/SCSS dep | coreui (`badge-sm`) + bs (`bg-*`) |
| Responsive | Inline; `ms-auto`/`ms-2` placement |
| A11y | Text-based labels (not icon-only) |
| VisaFusion usage | Queue counts, entry status chips, role markers |

### 3.7 Spinners & Placeholders
| Field | Value |
|---|---|
| Name | Spinners / Placeholders |
| Type | Loading indicators |
| Source | `views/components/spinners.pug` (13 examples); `views/components/placeholders.pug` (6 examples) |
| Purpose | Busy states, skeletons, button spinners |
| Dependencies | none |
| JS dependency | none (CSS animation) |
| CSS/SCSS dep | bs + coreui |
| Responsive | Size variants |
| A11y | `aria-hidden` decorative; screen readers use text |
| VisaFusion usage | Async table loads, report generation, save actions |

## 4. Overlay & feedback components

### 4.1 Modals
| Field | Value |
|---|---|
| Name | Modals |
| Type | Overlay component |
| Source | `views/components/modals.pug` (11 examples); `search-modal.pug`; `DEVELOPMENT.md` example |
| Purpose | Dialogs: sizes, centered, scrollable, static-backdrop, fullscreen |
| Dependencies | bundle (Modal) |
| JS dependency | bundle (`data-coreui-toggle="modal"`, `data-coreui-dismiss`) |
| CSS/SCSS dep | coreui + bs |
| Responsive | `.modal-fullscreen` variants; dialog width classes |
| A11y | `tabindex="-1"`, `aria-labelledby`, `aria-hidden`, close `aria-label="Close"` |
| VisaFusion usage | Confirm dialogs (delete/void), entry quick-view, approval flows |

### 4.2 Toasts
| Field | Value |
|---|---|
| Name | Toasts |
| Type | Notification component |
| Source | `views/components/toasts.pug` (7 examples); `src/js/toasts.js` |
| Purpose | Transient notifications, live demo, placement, stacking |
| Dependencies | bundle (Toast) |
| JS dependency | bundle + `toasts.js` (`new coreui.Toast(el).show()`) |
| CSS/SCSS dep | coreui + bs |
| Responsive | `.toast-container` placement |
| A11y | `role="status"`/`aria-live` semantics (component baseline) |
| VisaFusion usage | **Queue/notification surfacing** (SMS/email send status, save confirmations) |

### 4.3 Tooltips
| Field | Value |
|---|---|
| Name | Tooltips |
| Type | Hover hint |
| Source | `views/components/tooltips.pug` (3 examples); `src/js/tooltips.js`; `login.pug` |
| Purpose | Text hints on hover/focus; icon buttons |
| Dependencies | bundle (Tooltip) |
| JS dependency | bundle + `tooltips.js` auto-init `[data-coreui-toggle="tooltip"]` |
| CSS/SCSS dep | coreui + bs |
| Responsive | Auto placement |
| A11y | `data-coreui-original-title`, `aria-label` on icon-only buttons |
| VisaFusion usage | Form field help, action icons, show-password toggle |

### 4.4 Popovers
| Field | Value |
|---|---|
| Name | Popovers |
| Type | Click content |
| Source | `views/components/popovers.pug` (4 examples); `src/js/popovers.js` |
| Purpose | Rich content popups (direction/placement/dismiss) |
| Dependencies | bundle (Popover) |
| JS dependency | bundle + `popovers.js` auto-init `[data-coreui-toggle="popover"]` |
| CSS/SCSS dep | coreui + bs |
| Responsive | Placement variants |
| A11y | `tabindex="0"` trigger support (component baseline) |
| VisaFusion usage | Inline help, field descriptions in dense entry forms |

## 5. Interactive controls

### 5.1 Buttons & Button Group
| Field | Value |
|---|---|
| Name | Buttons / Button Group |
| Type | Action control |
| Source | `views/components/buttons.pug` (15 examples); `views/components/button-group.pug` (13 examples) |
| Purpose | Variants, sizes, outline, disabled, block, toolbars, radio/checkbox toggles |
| Dependencies | bundle (button-group toggle) |
| JS dependency | bundle for `data-coreui-toggle="buttons"` / `btn-check` |
| CSS/SCSS dep | bs + coreui (`.btn-outline`, `.btn-transparent`, `.btn.btn-link`) |
| Responsive | `d-none d-md-block` toolbars; stacking groups |
| A11y | `role="toolbar"`, `aria-label="Toolbar with buttons"`, `.btn-check` labels |
| VisaFusion usage | Primary/outline actions, filter toggles, bulk actions |

### 5.2 Accordion & Collapse
| Field | Value |
|---|---|
| Name | Accordion / Collapse |
| Type | Disclosure |
| Source | `views/components/accordion.pug` (2 examples); `views/components/collapse.pug` (3 examples) |
| Purpose | Expandable sections, accordion groups, flush |
| Dependencies | bundle (Collapse) |
| JS dependency | bundle (`data-coreui-toggle="collapse"`) |
| CSS/SCSS dep | coreui + bs |
| Responsive | Full width |
| A11y | `data-coreui-parent`, `aria-expanded`/`aria-controls` (component baseline) |
| VisaFusion usage | Collapsible search filters, FAQ/help, multi-part entry forms |

### 5.3 Carousel
| Field | Value |
|---|---|
| Name | Carousel |
| Type | Media rotator |
| Source | `views/components/carousel.pug` (6 examples) |
| Purpose | Slideshow with controls/indicators/captions |
| Dependencies | bundle (Carousel) |
| JS dependency | bundle (`data-coreui-ride`) |
| CSS/SCSS dep | coreui + bs |
| Responsive | Fluid images |
| A11y | `aria-label` controls (baseline), slide alt text |
| VisaFusion usage | Public site (per SPEC-0007) if imagery is needed; low priority |

### 5.4 Chip & Chip-set (CoreUI extensions)
| Field | Value |
|---|---|
| Name | Chip / Chip-set / Chip-input |
| Type | Tag/token input |
| Source | `views/components/chip.pug` (6), `chip-set.pug` (5), `views/forms/chip-input.pug` (6) |
| Purpose | Tag pills, removable selections, tag input |
| Dependencies | bundle (Chip) |
| JS dependency | bundle (chip remove/selection) |
| CSS/SCSS dep | coreui (chip) |
| Responsive | Inline wrap |
| A11y | `.chip-label`, close-button `aria-label` (component baseline) |
| VisaFusion usage | Multi-select of countries/POEs/status filters |

## 6. Form components

### 6.1 Form controls (inputs, textarea, floating labels)
| Field | Value |
|---|---|
| Name | Form Control / Floating Labels |
| Type | Input component |
| Source | `views/forms/form-control.pug` (9); `views/forms/floating-labels.pug` (7) |
| Purpose | Inputs/textarea sizes, states, floating-label fields |
| Dependencies | none |
| JS dependency | none |
| CSS/SCSS dep | bs + coreui (`.form-control`, `.form-floating`) |
| Responsive | `form-control-sm/lg`, full width |
| A11y | `<label class="form-label">` pairing; `aria-describedby` patterns |
| VisaFusion usage | Entry capture forms (passenger data, agent data), auth forms |

### 6.2 Input Group
| Field | Value |
|---|---|
| Name | Input Group |
| Type | Composite input |
| Source | `views/forms/input-group.pug` (11 examples); `login.pug`, `404.pug` |
| Purpose | Prepend/append text, buttons, icons, sizes |
| Dependencies | bundle (buttons inside groups) |
| JS dependency | none required |
| CSS/SCSS dep | bs + coreui |
| Responsive | Wrap on narrow screens |
| A11y | `.input-group-text` labels |
| VisaFusion usage | Search boxes (ref-no lookup), currency/prefixed fields, show-password |

### 6.3 Checks, Radios & Switches
| Field | Value |
|---|---|
| Name | Checks / Radios / Switches |
| Type | Selection control |
| Source | `views/forms/checks-radios.pug` (17 examples) |
| Purpose | Checkboxes, radios, switches, button-style toggles, inline/disabled states |
| Dependencies | none |
| JS dependency | none (except `data-coreui-toggle="buttons"` variants) |
| CSS/SCSS dep | bs + coreui (`.form-check`, `.form-switch`) |
| Responsive | Inline wrap |
| A11y | `<label class="form-check">` wraps input; `autocomplete="off"` |
| VisaFusion usage | Consent attestations, status filters, notification preferences, "remember me" |

### 6.4 Select & Range
| Field | Value |
|---|---|
| Name | Select / Range |
| Type | Selection/slider control |
| Source | `views/forms/select.pug` (5); `views/forms/range.pug` (4) |
| Purpose | Dropdown selects (sizes/multiple), range sliders |
| Dependencies | none |
| JS dependency | none |
| CSS/SCSS dep | bs + coreui |
| Responsive | `form-select-sm/lg` |
| A11y | `<label class="form-label">` pairing |
| VisaFusion usage | Entry type / POE / country dropdowns, threshold sliders in admin |

### 6.5 Validation
| Field | Value |
|---|---|
| Name | Form Validation |
| Type | Validation UX |
| Source | `views/forms/validation.pug` (5 examples) |
| Purpose | `was-validated`, invalid/valid tooltips, server-side states |
| Dependencies | none |
| JS dependency | none (CSS-driven classes) |
| CSS/SCSS dep | bs + coreui (`.is-invalid`, `.is-valid`, `was-validated`) |
| Responsive | N/A |
| A11y | `.invalid-feedback`/`.valid-feedback` text; `aria-describedby` recommended |
| VisaFusion usage | ASP.NET Core validation styling parity on entry/auth forms |

### 6.6 Form Layout
| Field | Value |
|---|---|
| Name | Form Layout |
| Type | Layout pattern |
| Source | `views/forms/layout.pug` (10 examples) |
| Purpose | Grid-based form rows, gutters, horizontal forms |
| Dependencies | none |
| JS dependency | none |
| CSS/SCSS dep | bs grid |
| Responsive | `.row.g-*`, `.col-*` columns |
| A11y | Label pairing |
| VisaFusion usage | Structured entry forms and admin settings forms |

## 7. Data-visualization (chart) components

### 7.1 Charts (Chart.js via @coreui/chartjs)
| Field | Value |
|---|---|
| Name | Charts (line, bar, doughnut, radar, pie, polarArea) |
| Type | Data-viz component |
| Source | `views/charts.pug` (6 examples); `src/js/charts.js`; dashboard `main.js`; `widgets.js` |
| Purpose | Reporting visualizations, sparklines, card charts, brand boxes |
| Dependencies | chart.js, @coreui/chartjs, @coreui/utils |
| JS dependency | `chart.umd.js` + `coreui-chartjs.js` + `@coreui/utils` (loaded in `index.pug` block scripts) |
| CSS/SCSS dep | `coreui-chartjs.css` (view-level) |
| Responsive | `responsive: true`, `maintainAspectRatio: false`, height via wrapper style |
| A11y | Charts are canvas (needs fallback text/data table in VisaFusion) |
| VisaFusion usage | Entry-volume trends, agent activity, ledger summaries in Reporting |

## 8. Icon catalog (not a component but referenced everywhere)

| Field | Value |
|---|---|
| Name | CoreUI Icons (free `cil-*`, brand `cib-*`, flag `cif-*`) |
| Type | Icon library |
| Source | `views/icons/coreui-icons-free.pug` (522 free icons per README), `coreui-icons-brand.pug`, `coreui-icons-flag.pug`; SVGs at `node_modules/@coreui/icons/svg/free|brand|flag` |
| Purpose | UI icons, brand logos, country flags |
| Dependencies | @coreui/icons ^3.1.0 |
| JS dependency | none (SVG inlined at build by `+inlineSvg`) |
| CSS/SCSS dep | none (`.icon`/`.icon-lg`/`.icon-3xl` sizing classes from coreui) |
| Responsive | Vector; size classes |
| A11y | `aria-hidden="true"` decorative; `role="img" aria-label` when alt passed |
| VisaFusion usage | **Country flags (cif-*)** for country/embassy UI; free icons for nav/actions; select only needed files into `wwwroot/icons` |

## 9. Authentication & error pages (layouts, not components)

| Page | Source | Pattern |
|---|---|---|
| Login | `views/authentication/login.pug` | `pages.pug` + centered card; email+password+show/hide tooltip; remember-me; social buttons; register link |
| Register | `views/authentication/register.pug` | `pages.pug` + card form |
| Reset/Change/Password-changed/Check-email | `views/authentication/*.pug` | `pages.pug` variants of auth states |
| 404 / 500 | `views/error-pages/404.pug`, `500.pug` | `pages.pug` + display-3 numeral + message |

**VisaFusion usage**: map 1:1 to existing `/Auth/Login`, `/Auth/Register`,
`/Auth/ChangePassword`, `/Auth/AccessDenied` and ASP.NET Core error handling —
keep the `pages.pug` centered-card layout.

## 10. Coverage summary vs task list

| Requested | Status in template |
|---|---|
| accordions, alerts, badges, breadcrumbs, buttons, dropdowns, modals, pagination, progress, spinners, toasts, tooltips, tables, cards, tabs | Dedicated views + cataloged above |
| forms, input groups, switches, radios, checkboxes | `forms/checks-radios.pug` (switches/radios/checks), `input-group.pug` |
| avatars, lists (list-group), offcanvas | Avatars + list-group cataloged; **offcanvas NOT demonstrated** in any view (component exists in CoreUI lib only) |
| navigation, sidebar, header, footer | Section 1–2 above |
| authentication pages, error pages | Section 9 above |
| dashboards | `index.pug` + `widgets.pug` + `charts.pug` |
| icons | Section 8 (522 free + brands + flags) |
| responsive behavior | Verified per component (Section columns + DESIGN_SYSTEM §6) |
| theme behavior | DESIGN_SYSTEM §3 (light/dark/auto) |

## 11. Provenance

All rows verified this session: file listings via `Get-ChildItem`, example
counts via `Select-String`, behavior/ARIA via `read` of the cited Pug/JS/SCSS
files in the reference copy. Nothing asserted from memory.
