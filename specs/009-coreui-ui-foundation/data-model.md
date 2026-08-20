# Data Model — SPEC-0009 CoreUI UI Foundation

**Date**: 2026-08-19 | **Spec**: [SPEC-0009](../spec.md) | **Research**: [research.md](research.md)

This feature is presentation-only (spec §16: **no database change**). The
"data model" here is the **UI data model**: the centralized role-aware
navigation model, the canonical component catalog, and the theme token system.
No EF entity, table, column, or stored procedure is created or modified.

## 1. Navigation model (centralized, per `ROLE_NAVIGATION_MATRIX.md` §4)

The `RoleAwareNavigation` service (research D-5) consumes this model. It is
the single source for sidebar/menu/breadcrumb rendering (spec FR-003; Addendum
§5–§6, §12).

### 1.1 Entity: `NavigationGroup`

| Field | Type | Notes |
|---|---|---|
| `Id` | string | Group key: `Public`, `Account`, `AgentPortal`, `Reporting`, `Admin`, `Employee`, `Billing`, `Notifications` (8 groups — clarify 2026-08-19) |
| `Title` | string | Display label |
| `Roles` | string[] | Roles that see the group (Guest/agt/emp/adm/su) |
| `Order` | int | Render order |
| `Menus` | `NavigationMenu[]` | Child menus |

### 1.2 Entity: `NavigationMenu`

| Field | Type | Notes |
|---|---|---|
| `Id` | string | Menu key (e.g. `AgentPortal.Dashboard`) |
| `Label` | string | Link label |
| `Route` | string | Razor page route (e.g. `/Agent/Index`) |
| `Permission` | string? | Policy name or `anonymous`/`[Authorize]` (spec FR-008: UI visibility ≠ authorization) |
| `Roles` | string[] | Roles that see the menu |
| `Submenus` | `NavigationSubmenu[]` | Child submenus (Today, Daily, Agents, Users) |
| `Order` | int | Render order |

### 1.3 Entity: `NavigationSubmenu`

| Field | Type | Notes |
|---|---|---|
| `Id` | string | Submenu key (e.g. `Reporting.Today`) |
| `Label` | string | Group label (Today, Daily, Agents, Users) |
| `Items` | `NavigationMenu[]` | Leaf links |

### 1.4 Group → menu → submenu structure (from `ROLE_NAVIGATION_MATRIX.md` §4)

| Group | Menus | Submenus | Permission | Roles |
|---|---|---|---|---|
| Public | Home, Visa Info, Embassy, Country Info, Daily Update, Queries, Contact, Subscribe, Register | — | anonymous | Guest |
| Account | Login, Register, Change password | — | `[Authorize]` (change pw) | all |
| Agent Portal | Dashboard, My Entries, Statuses, Statement, Account | — | `AgentSelf` | agt/emp/adm/su |
| Reporting | Dashboard, Pending, Today, Daily | Today, Daily | `EntryOperations` | emp/adm/su |
| Admin | Dashboard, Agents, Users, Holidays, Content Update, Security Day | Agents, Users | `AdminPanel`/`UserManagement`/`HolidayAdmin`/`SecurityGate` | adm/su (Users: adm/emp) |
| Employee | Home | — | (none yet) | emp — BLOCKED (GAP-004) |
| Billing | Home | — | (none yet) | emp/adm/su — BLOCKED (GAP-004) |
| Notifications | Home | — | (none yet) | adm/su — PARTIAL |

### 1.5 Breadcrumb model (Addendum §12)

`Role → Module → Feature → Native Page` — derived from the navigation model,
never from URL segments. Rendered by `_Breadcrumb.cshtml`.

## 2. Canonical component catalog (14 components, research D-8)

| Component | Partial | CoreUI equivalent | Consumed by (mapping doc) | Status |
|---|---|---|---|---|
| RoleAwareNavigation | `_Sidebar.cshtml` + service | `sidebar-nav.pug` data-driven nav | all authenticated pages | IMPLEMENTED (T016) |
| RoleDashboard | `_RoleDashboard.cshtml` | `views/index.pug` KPI cards, Progress §3.4, Charts §7.1 | Agent Index, Reporting Index, Admin Index, SecurityDay | IMPLEMENTED (T024b) |
| DataTable | `_DataTable.cshtml` | Tables §3.2, Pagination §2.3, Badges §3.6, Dropdowns §2.2 | Agent Entries/Statuses/Statement, Reporting ×7, Admin Agents/Users/Holidays, Public DailyUpdate | IMPLEMENTED (T024) |
| FormCard | `_FormCard.cshtml` | Form Control §6.1, Form Layout §6.6, Validation §6.5 | Agent Account, Admin Agents Create/Edit, Users Create, ContentUpdate, Public Queries/Contact/Subscribe | IMPLEMENTED (T024) |
| AuthCard | `_AuthCard.cshtml` | `authentication/*.pug` centered card | Auth Login/Register/ChangePassword, Public Register | IMPLEMENTED (T024) |
| ErrorPage | `_ErrorPage.cshtml` | `error-pages/404/500.pug` | Auth AccessDenied, 404/500 | IMPLEMENTED (T024) |
| InfoPage | `_InfoPage.cshtml` | Cards §3.1, Accordion §5.2, Icons §8 | Public VisaInfo/Embassy/CountryInfo/Contact/Subscribe | IMPLEMENTED (T024) |
| PublicLanding | `_PublicLanding.cshtml` | `views/index.pug` / `views/blank.pug` | Public Index, root Index | IMPLEMENTED (T024) |
| PublicQueryForm | `_PublicQueryForm.cshtml` | Form Control §6.1, Validation §6.5, Alerts §3.5 | Public Queries | IMPLEMENTED (T024) |
| ConfirmModal | `_ConfirmModal.cshtml` | Modals §4.1 | Admin Holidays (delete confirm) | IMPLEMENTED (T024) |
| ToastHost | `_ToastHost.cshtml` | Toasts §4.2 | Notifications placeholder (PARTIAL) | IMPLEMENTED (T024) |
| DesignTokens | `wwwroot/css/vf-coreui.css` (T005) | `--cui-*` tokens | all pages (head) | IMPLEMENTED (T005) |
| ComponentStyles | `wwwroot/css/vf-component-styles.css` (T025) | vf-* → CoreUI class mapping | all pages (head) | IMPLEMENTED (T025) |
| IconSet | `wwwroot/icons/**` (T002) | `cil-*`/`cif-*` SVGs | all pages | IMPLEMENTED (T002) |

## 3. Theme token system (research D-7)

| Token | Value (VisaFusion rebrand) | Source |
|---|---|---|
| `--cui-primary` | VisaFusion brand color | `COREUI_DESIGN_SYSTEM.md` §2.1 |
| `--cui-secondary` | secondary | §2.1 |
| `--cui-success` / `--cui-danger` / `--cui-warning` / `--cui-info` | status colors | §2.1 |
| `--cui-body-color` / `--cui-body-bg` / `--cui-tertiary-bg` | text/background | §2.1 |
| `--cui-border-color` | borders | §2.1 |
| `--cui-sidebar-bg` | sidebar | §2.1 |

Theme state: `data-coreui-theme` ∈ {`light`, `dark`, `auto`} on `<html>`;
persistence key `visafusion-theme` (localStorage); server default `light`
(spec FR-006/NFR-005).

## 4. State transitions

- **Shell mode**: `useSidebar = ViewData["UseSidebar"] ?? isAuthenticated`
  (preserved from `_Layout.cshtml` line 20) — anonymous → top-nav/pages layout;
  authenticated → sidebar shell. No behavior change (spec FR-009).
- **Theme**: `light` ⇄ `dark` via dropdown; `auto` follows
  `prefers-color-scheme`; persisted on change; restored on load
  (`COREUI_DESIGN_SYSTEM.md` §3).

## 5. Validation rules

- Navigation model: every menu route must resolve to an existing Razor page
  route (41 pages / 40 routes — `ROLE_ROUTE_MATRIX.md` §1); no orphan nav item
  (Addendum §15).
- Component contract: every partial renders CoreUI markup with the mapped
  classes; no `vf-*` class remains in use except `vf-skip-link` (mapping doc
  §7).
- No database validation applies (no schema change).