# UI Contract: Application Shell, Navigation, and Components (SPEC-0009)

**Date**: 2026-08-19 | **Spec**: [SPEC-0009](../spec.md) | **Data model**: [data-model.md](../data-model.md)

This contract defines the presentation-layer contract between the CoreUI
shell, the centralized navigation model, and the 41 native pages. It is a UI
contract (not an API contract) — no HTTP endpoint is created or changed
(spec §15).

## 1. Shell contract

### 1.1 Layout selection (preserved from `_Layout.cshtml` line 20)

```
useSidebar = ViewData["UseSidebar"] ?? isAuthenticated
```

| Mode | Layout | Surfaces |
|---|---|---|
| `useSidebar == true` | CoreUI sidebar shell (`_Layout.cshtml` + `_Header`/`_Sidebar`/`_Breadcrumb`/`_PageHeader`/`_Footer`) | 21 authenticated sidebar pages (Agent ×5, Reporting ×7, Admin ×9) |
| `useSidebar == false` | CoreUI standalone `pages` layout (`_AuthLayout.cshtml`) | Auth (Login/Register/ChangePassword/AccessDenied), Public area (9), root Index, error pages |

### 1.2 Shell composition (Addendum §6)

```text
VisaFusion Shell
├── Header            → _Header.cshtml (toggler, theme dropdown, avatar menu)
├── Role Context      → current principal → RoleAwareNavigation
├── Role-Aware Sidebar → _Sidebar.cshtml (brand, nav, unfoldable toggler)
├── Breadcrumb        → _Breadcrumb.cshtml (role → module → feature → page)
├── Page Header       → _PageHeader.cshtml
├── Native Role Page  → unchanged functional composition
└── Footer            → _Footer.cshtml (VisaFusion branding)
```

### 1.3 Asset contract (every page)

```html
<!-- head -->
<link rel="stylesheet" href="~/lib/coreui/css/coreui.css" />
<link rel="stylesheet" href="~/css/vf-coreui.css" />
<script src="~/js/config.js"></script>
<script src="~/js/color-modes.js"></script>
<!-- body end -->
<script src="~/lib/coreui/js/coreui.bundle.min.js"></script>
<script src="~/lib/simplebar/js/simplebar.min.js"></script>
```

Chart surfaces (Agent Index, Agent Statement, Reporting Index, DailyVisaFee,
DailyBill) additionally load `lib/chartjs/*` + `js/main.js` (spec §13).

## 2. Navigation contract

`RoleAwareNavigation` (service) exposes:

| Member | Signature | Contract |
|---|---|---|
| `GetGroups(ClaimsPrincipal)` | `IReadOnlyList<NavigationGroup>` | Groups visible to the principal's effective roles, ordered |
| `GetBreadcrumb(ClaimsPrincipal, string route)` | `IReadOnlyList<BreadcrumbItem>` | Role → Module → Feature → Page chain for the current route |
| `GetLandingRoute(ClaimsPrincipal)` | `string` | Role-specific landing page (login redirect / post-login nav) |

Rules:
- Menu visibility is **usability only** — never authorization (constitution
  Principle XV; Addendum §10). Every protected page retains its server-side
  `[Authorize(Policy=…)]`.
- No Razor page hard-codes its own navigation tree (Addendum §5; spec FR-003).
- The 8 groups and their menus/submenus are defined in
  `ROLE_NAVIGATION_MATRIX.md` §4 (data-model §1.4).

## 3. Component contract (14 canonical partials)

| Partial | Signature (model) | Renders | Contract |
|---|---|---|---|
| `_RoleDashboard` | `RoleDashboardModel` (title, kpis, alerts, charts) | CoreUI cards/progress/charts | Role landing data unchanged |
| `_DataTable` | `DataTableModel` (columns, rows, page, total, actions) | CoreUI table + pagination + badges | Row actions preserve existing handlers |
| `_FormCard` | `FormCardModel` (title, form html) | CoreUI card + form layout | Validation messages render CoreUI `.is-invalid`/`.invalid-feedback` |
| `_AuthCard` | `AuthCardModel` (title, form html) | Centered card (pages layout) | Auth behavior unchanged |
| `_ErrorPage` | `ErrorPageModel` (code, message) | 404/500/access-denied surface | Error semantics unchanged |
| `_InfoPage` | `InfoPageModel` (title, content) | Cards/accordion/icons | Static content unchanged |
| `_PublicLanding` | `PublicLandingModel` | Landing scaffold | Static welcome unchanged |
| `_PublicQueryForm` | `PublicQueryFormModel` | Form + validation + alerts | Posts to `/api/v1/public/queries` unchanged |
| `_ConfirmModal` | `ConfirmModalModel` (id, message, form action) | CoreUI modal | Confirm-delete semantics unchanged |
| `_ToastHost` | `ToastHostModel` | Toast container | Notifications placeholder only (PARTIAL) |
| `_DesignTokens` | — | `--cui-*` overrides | Rebrand tokens |
| `_ComponentStyles` | — | vf-* → CoreUI mapping | Only `vf-skip-link` retained |
| `_IconSet` | — | `cil-*`/`cif-*` SVGs | Replaces bootstrap-icons.css |

## 4. Page re-skin contract

Every page in `COREUI_VISA_FUSION_MAPPING.md` with status IMPLEMENTED or
PARTIAL is re-skinned per its mapped CoreUI equivalents and proposed
component. BLOCKED (Employee, Billing) and NOT_REQUIRED (stray Forms page)
rows are untouched (spec §6). Page models (`.cshtml.cs`) are not modified
except where a page must pass a component model to a partial.

## 5. Non-goals

- No API contract change (all 51 routes unchanged — spec §15).
- No database change (spec §16).
- No business rule change (spec §6; BR-004).