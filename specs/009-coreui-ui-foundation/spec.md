# Feature Specification: Integrate CoreUI as the Canonical VisaFusion UI Foundation

**Identifier**: SPEC-0009
**Title**: Integrate CoreUI as the Canonical VisaFusion UI Foundation
**Status**: Draft
**Created**: 2026-08-19
**Category**: ui
**Input**: User description: "Integrate CoreUI as the canonical VisaFusion UI foundation while preserving the existing role-based native-page architecture."

> This template is the VisaFusion override of the SpecKit `spec-template`.
> It is resolved first by the Spec Kit template stack (`.specify/templates/overrides/`)
> and MUST contain the 24 required sections defined in `library/03_SpecKit_SDD_Framework.md` §4.
> Do not remove or reorder the 24 numbered sections below.

## 1. Identifier

- **SPEC-0009**: Integrate CoreUI as the Canonical VisaFusion UI Foundation

## 2. Title

Integrate CoreUI as the Canonical VisaFusion UI Foundation

## 3. Objective

Adopt the CoreUI Free Bootstrap Admin Template (v5.6.0, commit `d4003cd`,
2026-08-13) as the canonical VisaFusion UI foundation — the single design
system, layout system, component system, navigation presentation, responsive
behavior, and interaction-pattern source for every surface of the modern
VisaFusion application — **while preserving the existing role-based native-page
architecture unchanged in function, role boundaries, authorization semantics,
workflows, and database behavior**.

This specification resolves GAP-002 (`docs/analysis/GAP_REPORT.md` §GAP-002):
the constitution (v1.4.2, Principle IV) mandates CoreUI as the UI design
system, but the shipped UI is a bespoke `vf-*` system (`tokens.css`,
`theme.css`, `bootstrap-icons.css`, `vf-sidebar`/`vf-topnav`) with no CoreUI
assets in `wwwroot/`. This feature makes the shipped UI conform to the
constitution by re-skinning the presentation layer onto CoreUI, and it
explicitly does NOT flatten the role-based native-page architecture into a
generic dashboard (constitution Principle III; `library/Role-Based Native Pages
Architecture Addendum.md` §1–§2).

## 4. Business Context

The legacy Classic ASP VisaEntry application (585 root ASP files, 52-table SQL
Server schema — `@findings/exiting_architecture.md`) is being modernized to
ASP.NET Core under the VisaFusion constitution. The constitution's Principle IV
mandates CoreUI as the UI design reference, and Principle III mandates that the
role-based native-page architecture (roles, permissions, claims, navigation,
menus, submenus, landing pages, dashboards, native pages, workflows, actions,
reports, routing, redirects, authorization boundaries) remains authoritative.

The current state is a contradiction: the implemented UI is a bespoke theme
with no CoreUI assets (GAP-002, HIGH). The business value of this feature is
constitutional compliance plus a consistent, professional, responsive,
accessible, maintainable UI foundation — without any change to what each role
can see, do, or access. The role-based functional architecture is the business
asset; CoreUI is the presentation layer on top of it (constitution Principle V;
Addendum §19).

## 5. Scope

In scope for this work item:

- Adopt CoreUI Free Bootstrap Admin Template v5.6.0 as the canonical UI
  foundation for the VisaFusion Web application (`VisaFusion.Web`).
- Re-skin the application shell (header, sidebar, breadcrumb, page header,
  footer) onto CoreUI layout components, with role-aware rendering driven by a
  centralized role-aware navigation model (Addendum §5–§6, §12–§13).
- Re-skin the existing role-based native pages onto CoreUI components
  (cards, tables, forms, alerts, modals, tabs, dropdowns, badges, progress,
  toasts) per the mapping in `docs/ui/COREUI_VISA_FUSION_MAPPING.md`, preserving
  each page's functional composition (Addendum §8, §13).
- Re-skin authentication pages (Login/Register/ChangePassword/AccessDenied)
  and error pages (404/500) onto the CoreUI standalone `pages` layout
  (`COREUI_DESIGN_SYSTEM.md` §4.2, §9).
- Adopt the CoreUI theme system (light/dark/auto) with the VisaFusion-branded
  token overrides and a renamed persistence key (`COREUI_DESIGN_SYSTEM.md` §3,
  §9).
- Adopt CoreUI accessibility and responsive behavior baselines
  (`COREUI_DESIGN_SYSTEM.md` §6–§7; constitution Principles XVI–XVII).
- Establish the canonical reusable VisaFusion components (one canonical
  implementation each — constitution Principle XIV) for the shell, navigation,
  breadcrumbs, page header, and role-aware components.
- Update the Knowledge Graph and traceability matrix to reflect the CoreUI
  integration (constitution Principle XII–XIII; Addendum §14–§15).
- Resolve GAP-002 by replacing the bespoke `vf-*` presentation with CoreUI
  assets in `wwwroot/` (or by an approved ADR if the owner chooses otherwise —
  see §21 Risks and §6 Out of Scope).

Out of scope is listed in §6.

## 6. Out of Scope

- **No business behavior change**: no change to business rules, workflows,
  validation semantics, or data semantics (constitution Principles II, VII).
- **No authorization change**: no change to the 11-policy authorization
  catalog, the 5 claims, role boundaries, or server-side authorization on any
  protected page or API (constitution Principle XV; Addendum §10).
- **No database change**: no schema change, no data migration, no new tables,
  no dropped tables (constitution Principles VI–VIII). This is a presentation
  feature.
- **No flattening of role architecture**: no generic single dashboard
  replacing role-specific landing pages/dashboards; no merging of role-specific
  navigation; no removal of role-specific pages because CoreUI offers a generic
  equivalent (Addendum §2, §7).
- **No new business features**: no new pages, workflows, or functionality
  beyond what the legacy app and existing specs document (constitution
  Principle II).
- **No change to the CoreUI upstream template**: the reference copy in
  `%TEMP%\opencode\coreui-free-bootstrap-admin-template` is read-only; the
  upstream repository is NOT modified (`COREUI_INVENTORY.md` §Scope).
- **No RTL support**: not required by VisaFusion per findings
  (`COREUI_DESIGN_SYSTEM.md` §8).
- **No npm build pipeline**: VisaFusion copies the needed CoreUI dist assets
  into `wwwroot/`; it does not adopt the Pug/Sass build chain
  (`COREUI_INVENTORY.md` §2 package-lock row, §4).
- **No demo-only CoreUI content**: demo-only views, PRO-marketing banners,
  `examples.scss`, demo avatars/backgrounds are excluded
  (`COREUI_INVENTORY.md` §5, §9, §11).
- **GAP-004 placeholder areas** (`Areas/Employee`, `Areas/Billing`,
  `Areas/Notifications` — `docs/analysis/GAP_REPORT.md` §GAP-004): only
  `Areas/Notifications` (status PARTIAL in `COREUI_VISA_FUSION_MAPPING.md` §6)
  is re-skinned in presentation only; `Areas/Employee` and `Areas/Billing`
  (status BLOCKED — no page model, no spec, no policy) are NOT re-skinned
  until their business scope is approved. Missing page models are a separate
  gap and are NOT implemented by this feature.
- **GAP-010 stray page** (`Areas/Public/Pages.Forms.cshtml` — the 41st page
  with no route) is status NOT_REQUIRED (dead file, no discoverable Razor
  route) and is NOT re-skinned; its disposition (delete, or move into
  `Areas/Public/Pages/` with a model) is a separate gap and is NOT decided by
  this feature.

## 7. Stakeholders

- **Guest** (anonymous public visitor) — public site surfaces, contact query,
  login.
- **Agent** (`agt`) — agent landing page, entry submission, entry status,
  search, ledger, password self-service.
- **Employee** (`emp`) — employee landing page, entry operations, search,
  reporting surfaces.
- **Administrator** (`adm`) — admin landing page, user management, holiday
  admin, security gate, billing, reporting.
- **Super User** (`su`) — all `adm` capabilities plus super-user-only
  functions (implies `adm` per FR-008 of the role baseline).
- **System owner / approver** — decides GAP-002 resolution (adopt CoreUI vs.
  amend constitution) if not already decided by this specification.
- **Engineering team** — implements the re-skin, maintains the canonical
  components, keeps the Knowledge Graph synchronized.

Role evidence: `docs/ui/ROLE_PAGE_PERMISSION_MATRIX.md` (5 roles, 11 policies,
5 claims), `docs/ui/ROLE_NAVIGATION_MATRIX.md` (8 navigation groups per §4
centralized target model), `docs/ui/ROLE_WORKFLOW_MATRIX.md` (20 workflows
W1–W20), `docs/ui/ROLE_ROUTE_MATRIX.md` (41 pages, 40 routes, 51 API routes).

## 8. Legacy Mapping

This feature maps to the legacy application's presentation layer and to the
already-modernized VisaFusion UI. Per constitution Principle II, every work item
MUST be mapped to legacy pages using `@findings/modernization_plan.md` §6
(module map) and §13 (legacy pages) before implementation. The authoritative
page-level mapping is `docs/ui/COREUI_VISA_FUSION_MAPPING.md` (41 native pages
with statuses IMPLEMENTED/MAPPED/PARTIAL/BLOCKED/NOT_REQUIRED and their CoreUI
equivalents) and `docs/ui/ROLE_BASED_NATIVE_PAGES_INVENTORY.md`.

Legacy presentation sources (from `@findings/deepanalysis.md` and
`@findings/exiting_architecture.md`): the Classic ASP pages render role-based
menus, tables, forms, and status displays; the modernized VisaFusion UI already
implements the role-based native pages (41 pages, 40 routes) with a bespoke
`vf-*` theme. This feature changes presentation only — the legacy business
behavior behind each page (workflows W1–W20, actions, validation, redirects)
is preserved exactly as implemented and specified in SPEC-0001..SPEC-0008.

## 9. Functional Requirements

- **FR-001**: System MUST adopt CoreUI Free Bootstrap Admin Template v5.6.0
  (commit `d4003cd`) as the canonical UI foundation for all VisaFusion Web
  surfaces — the single source for layouts, visual language, components,
  responsive behavior, navigation presentation, forms, tables, cards, alerts,
  modals, tabs, dropdowns, sidebar, header, footer, icons, spacing, typography,
  and interaction patterns (constitution Principle IV; `COREUI_INVENTORY.md`).
- **FR-002**: System MUST preserve the role-based native-page architecture
  unchanged: roles (Guest/`agt`/`emp`/`adm`/`su`), the 11-policy authorization
  catalog, the 5 claims, the 8-group navigation hierarchy (Public, Account,
  Agent Portal, Reporting, Admin, Employee, Billing, Notifications — per
  `ROLE_NAVIGATION_MATRIX.md` §4 centralized target model), 41 native pages,
  40 page routes, 20 workflows, and role-specific landing pages/dashboards
  (constitution Principle III; Addendum §1–§2, §7;
  `ROLE_PAGE_PERMISSION_MATRIX.md`, `ROLE_NAVIGATION_MATRIX.md`,
  `ROLE_WORKFLOW_MATRIX.md`, `ROLE_ROUTE_MATRIX.md`).
- **FR-003**: System MUST render the application shell (header, sidebar,
  breadcrumb, page header, footer) from a centralized role-aware navigation
  model — never hard-coded per Razor page (Addendum §5–§6, §12; constitution
  "UI Design System" section).
- **FR-004**: System MUST re-skin every existing role-based native page onto
  CoreUI components per `docs/ui/COREUI_VISA_FUSION_MAPPING.md`, preserving each
  page's functional composition, validation, workflow, and authorization
  (Addendum §8, §13).
- **FR-005**: System MUST re-skin authentication pages
  (Login/Register/ChangePassword/AccessDenied) and error pages (404/500) onto
  the CoreUI standalone `pages` layout (`COREUI_DESIGN_SYSTEM.md` §4.2, §9).
- **FR-006**: System MUST provide the CoreUI theme system (light/dark/auto)
  with VisaFusion-branded design tokens and a VisaFusion-namespaced persistence
  key (`COREUI_DESIGN_SYSTEM.md` §3, §9).
- **FR-007**: System MUST provide one canonical implementation for every
  reusable VisaFusion component proposed in `COREUI_VISA_FUSION_MAPPING.md`
  §1–§7 (`RoleAwareNavigation`, `RoleDashboard`, `DataTable`, `FormCard`,
  `AuthCard`, `ErrorPage`, `InfoPage`, `PublicLanding`, `PublicQueryForm`,
  `ConfirmModal`, `ToastHost`, `DesignTokens`, `ComponentStyles`, `IconSet`) —
  no duplicated per-role components unless the existing architecture justifies
  separate implementations (constitution Principle XIV; Addendum §9).
- **FR-008**: System MUST preserve server-side authorization on every
  protected page and every protected API; UI visibility (hiding a menu item)
  is NOT authorization (constitution Principle XV; Addendum §10).
- **FR-009**: System MUST preserve all role-based routing and redirects:
  login redirects, default landing pages, unauthorized redirects, access-denied
  behavior, role-specific entry points, post-login navigation, workflow
  redirects (Addendum §11; `ROLE_ROUTE_MATRIX.md`).
- **FR-010**: System MUST preserve or improve accessibility on every migrated
  surface: semantic HTML, keyboard accessibility, labels, focus handling, ARIA
  where appropriate, contrast, accessible forms, accessible navigation
  (constitution Principle XVI; `COREUI_DESIGN_SYSTEM.md` §7).
- **FR-011**: System MUST validate desktop, tablet, and mobile behavior for
  every migrated surface (constitution Principle XVII; `COREUI_DESIGN_SYSTEM.md`
  §6).
- **FR-012**: System MUST replace the bespoke `vf-*` presentation assets
  (`tokens.css`, `theme.css`, `bootstrap-icons.css`, `vf-sidebar`/`vf-topnav`)
  with CoreUI assets in `wwwroot/`, resolving GAP-002 (constitution Principle
  IV; `docs/analysis/GAP_REPORT.md` §GAP-002).
- **FR-013**: System MUST update the Knowledge Graph (`knowledge-graph/kg.json`)
  and traceability matrix (`knowledge-graph/traceability-matrix.md`) to model
  the CoreUI integration: CoreUI components, layouts, the role-aware shell,
  and their relationships to native pages, features, and tests (constitution
  Principles XII–XIII; Addendum §14–§15).
- **FR-014**: System MUST keep the CoreUI dependency map and component catalog
  synchronized with the adopted assets (`docs/ui/COREUI_DEPENDENCY_MAP.md`,
  `docs/ui/COREUI_COMPONENT_CATALOG.md`).

## 10. Business Rules

- **BR-001**: CoreUI governs presentation only; it MUST NOT replace VisaFusion
  business architecture (constitution Principle IV–V; Addendum §19).
- **BR-002**: Role-specific native pages remain role-specific unless an
  approved specification explicitly changes them (Addendum §2).
- **BR-003**: UI visibility is not security; hiding a CoreUI navigation item
  does not constitute authorization (constitution Principle XV; Addendum §10).
- **BR-004**: Every business rule (e.g., Canada date-of-birth handling,
  holiday/weekly-off/Sunday entry blocking, the day-open gate) remains
  implemented once in `VisaFusion.Core` and shared by Web UI and API — the
  re-skin MUST NOT duplicate or relocate any business rule (constitution
  Engineering Process & Security Standards).
- **BR-005**: No destructive database operations during UI modernization; the
  only table permitted to be dropped is `dtproperties` (constitution Principle
  VI).
- **BR-006**: The bespoke `vf-*` theme is replaced by CoreUI; the legacy
  forensic artifacts (Udaan_users table name, `udaanuma-dev`/`r&d` folder
  names, the two backdoor query parameters) remain byte-identical and the
  backdoor parameters remain functionally inert (constitution Principle XXIV).

## 11. Non-functional Requirements

- **NFR-001**: The re-skin MUST NOT regress page load behavior or introduce
  client-side blocking beyond the CoreUI baseline; CoreUI assets are served
  from `wwwroot/` (no external CDN dependency) (`COREUI_INVENTORY.md` §2).
- **NFR-002**: The centralized role-aware navigation model MUST be the single
  source for navigation rendering; no Razor page hard-codes its own navigation
  tree (Addendum §5).
- **NFR-003**: Accessibility baseline is WCAG-AA; every migrated surface
  preserves or improves semantic HTML, keyboard accessibility, labels, focus
  handling, ARIA, contrast, accessible forms, and accessible navigation
  (constitution Principle XVI).
- **NFR-004**: Responsive behavior is validated at desktop, tablet, and mobile
  breakpoints for every migrated surface (constitution Principle XVII;
  `COREUI_DESIGN_SYSTEM.md` §6).
- **NFR-005**: The theme system supports light/dark/auto with a
  VisaFusion-namespaced persistence key; the server renders the default (light)
  and `color-modes.js` upgrades to stored/system preference
  (`COREUI_DESIGN_SYSTEM.md` §3).
- **NFR-006**: Browser support follows the CoreUI `.browserslistrc` baseline
  (Chrome/FF ≥60, iOS/Safari ≥12, no IE ≤11) (`COREUI_INVENTORY.md` §2).
- **NFR-007**: No new runtime dependencies beyond the CoreUI assets and their
  documented vendor dependencies (Bootstrap 5.3.x, CoreUI 5.x, SimpleBar,
  Chart.js/@coreui/chartjs where adopted) (`COREUI_DEPENDENCY_MAP.md`).

## 12. Security

- Server-side authorization remains authoritative and unchanged: the 11-policy
  catalog (`AgentSelf`, `EntryOperations`, `AdminPanel`, `UserManagement`,
  `HolidayAdmin`, `SecurityGate`, `AgentLedger`, `BillingOperations`, `Search`,
  `PasswordSelf`, `SuperUserOnly`) and the 5 claims (`sub`, `name`, `role`,
  `SuperUser`, `AgentId`) are preserved exactly (constitution Principle XV;
  `ROLE_PAGE_PERMISSION_MATRIX.md`; `src/VisaFusion.Api/Authorization/`).
- No new anonymous write endpoints are introduced; the only anonymous writes
  remain the two existing validated, rate-limited endpoints: `POST
  /api/v1/public/register` (role fixed `guest`) and `POST
  /api/v1/public/queries` (5/hr/IP) (verified `ROLE_ROUTE_MATRIX.md` §2).
- No plaintext passwords, no query-string identity, no string-concatenated
  SQL; the legacy `connection.asp` backdoor remains removed (constitution
  Engineering Process & Security Standards).
- CoreUI assets are served from `wwwroot/` with no external CDN; no new
  third-party script execution surface beyond the adopted vendor bundles.
- The theme persistence key is namespaced (`visafusion-theme`); no user data
  is stored client-side beyond the theme preference (`COREUI_DESIGN_SYSTEM.md`
  §3).

## 13. Performance

- CoreUI assets are static files served from `wwwroot/`; no build-time
  dependency on npm at deploy time (`COREUI_INVENTORY.md` §2).
- The centralized navigation model renders once per request; no per-page
  navigation recomputation.
- No new database queries are introduced by the re-skin; data access patterns
  are unchanged (presentation-only feature).
- Chart assets (Chart.js/@coreui/chartjs) are loaded only on surfaces that
  render charts: Agent Index, Agent Statement, Reporting Index, DailyVisaFee,
  DailyBill (Charts §7.1 targets in `COREUI_VISA_FUSION_MAPPING.md` §3–§4;
  `COREUI_INVENTORY.md` §6 main.js).
  - **Deferred (2026-08-20, T039)**: chart rendering is NOT yet wired. A
    repo-wide grep for `canvas`/`chart` in `src/VisaFusion.Web/Areas` and
    `src/VisaFusion.Web/Pages` returned zero matches — no existing page exposes
    chart data, and the feature constraint forbids inventing charts. The
    `_RoleDashboard` component renders `<canvas>` containers when `Charts` is
    populated, so the integration point exists; T039 re-opens when a chart data
    source is approved.

## 14. UI Requirements

- Application shell: CoreUI header, sidebar, breadcrumb, page header, footer
  with role-aware rendering (Addendum §6).
- Role-aware navigation: centralized model mapping Role → Permission →
  Navigation Group → Menu → Submenu → Native Page → Feature → Workflow
  (Addendum §5).
- Role-aware breadcrumbs reflecting the actual role-specific navigation
  hierarchy, not URL-segment-derived breadcrumbs (Addendum §12).
- Role-specific landing pages/dashboards re-skinned onto CoreUI cards/tables/
  alerts/charts with existing VisaFusion data (Addendum §7).
- Native pages re-skinned per `docs/ui/COREUI_VISA_FUSION_MAPPING.md` with
  functional composition preserved (Addendum §8, §13).
- Authentication and error pages on the CoreUI standalone `pages` layout
  (`COREUI_DESIGN_SYSTEM.md` §4.2).
- Theme system: light/dark/auto with VisaFusion-branded tokens
  (`COREUI_DESIGN_SYSTEM.md` §3, §9).
- Accessibility and responsive baselines per constitution Principles XVI–XVII
  and `COREUI_DESIGN_SYSTEM.md` §6–§7.
- Notification surfacing via CoreUI toasts and header badge is scoped to the
  Notifications placeholder re-skin (PARTIAL; `ToastHost` per
  `COREUI_VISA_FUSION_MAPPING.md` §6) and to any existing page that already
  surfaces queue/ledger alerts; no new notification surface is introduced
  (`COREUI_DESIGN_SYSTEM.md` §9).

## 15. API Contracts

- No new API endpoints and no changes to existing API contracts. All 51 API
  routes in `docs/ui/ROLE_ROUTE_MATRIX.md` §2 remain unchanged in route,
  method, policy, request, and response.
- The re-skin consumes the existing APIs exactly as the current pages do;
  no API contract is modified by this feature.
- Any new client-side interaction (e.g., theme switching) is local to the
  browser and does not introduce API calls.

## 16. Database Changes

- **No change.** No tables, columns, indexes, or stored procedures are
  created, modified, or dropped by this feature (constitution Principles
  VI–VIII). The only table ever permitted to be dropped is `dtproperties`, and
  this feature does not drop it.
- The 52-table legacy schema and the `VisaFusion` target database are
  untouched; data semantics are unchanged (constitution Principle VII).

## 17. Validation Rules

- All existing validation rules (client and server) are preserved exactly;
  the re-skin changes presentation of validation messages only, using CoreUI
  form-validation patterns (`COREUI_DESIGN_SYSTEM.md` §9 form validation UX).
- No new validation rules are introduced; no existing validation rule is
  relaxed or removed.
- Form validation UX aligns with ASP.NET Core validation output rendered in
  CoreUI styles.

## 18. Error Handling

- Error pages (404/500) are re-skinned onto the CoreUI standalone `pages`
  layout (`COREUI_DESIGN_SYSTEM.md` §4.2, §9).
- Access-denied behavior and unauthorized redirects are preserved exactly
  (Addendum §11; `ROLE_ROUTE_MATRIX.md`).
- Client-side error presentation (validation summaries, alerts) uses CoreUI
  alert/validation components; error semantics are unchanged.

## 19. Audit Requirements

- The Knowledge Graph (`knowledge-graph/kg.json`) and traceability matrix
  (`knowledge-graph/traceability-matrix.md`) are updated to record the CoreUI
  integration: CoreUI component nodes, layout nodes, the role-aware shell, and
  their edges to native pages, features, and tests (constitution Principles
  XII–XIII; Addendum §14–§15).
- The decision to adopt CoreUI (resolving GAP-002) is recorded as an ADR under
  `/adr` (constitution Principle XIII; `library/00` §5 ADR-0006 precedent for
  constitution amendments).
- Documentation is updated: `docs/ui/*` (mapping, matrices, inventory,
  catalog, dependency map, design system) reflect the adopted state
  (constitution Principle XIX).

## 20. Acceptance Criteria

- **AC-001**: All VisaFusion Web surfaces render with CoreUI assets served
  from `wwwroot/`; no bespoke `vf-*` presentation assets remain in use
  (GAP-002 resolved; FR-012).
- **AC-002**: The role-based native-page architecture is preserved: all 41
  native pages, 40 routes, 5 roles, 11 policies, 5 claims, the 8 navigation
  groups of the centralized target model, and 20 workflows remain present and
  unchanged in function (FR-002; verified against `ROLE_*_MATRIX.md` docs).
- **AC-003**: No role-specific landing page/dashboard is replaced by a generic
  dashboard; each role's landing page is re-skinned with its existing data
  (FR-002; Addendum §7).
- **AC-004**: The application shell renders from the centralized role-aware
  navigation model; no Razor page hard-codes its own navigation tree (FR-003;
  Addendum §5–§6).
- **AC-005**: Every native page in `docs/ui/COREUI_VISA_FUSION_MAPPING.md` is
  re-skinned per its mapped CoreUI components with functional composition
  preserved (FR-004; Addendum §8).
- **AC-006**: Authentication and error pages use the CoreUI standalone `pages`
  layout (FR-005).
- **AC-007**: Theme switching (light/dark/auto) works with the
  VisaFusion-namespaced persistence key and server-rendered default (FR-006;
  NFR-005).
- **AC-008**: Every reusable VisaFusion component has exactly one canonical
  implementation (FR-007; constitution Principle XIV).
- **AC-009**: Server-side authorization is unchanged: every protected page and
  API retains its policy; hiding a menu item never grants or denies access
  (FR-008; Addendum §10).
- **AC-010**: Role-based routing and redirects (login, landing, unauthorized,
  access-denied, post-login, workflow) behave exactly as before the re-skin
  (FR-009; Addendum §11).
- **AC-011**: Accessibility is preserved or improved on every migrated surface
  (WCAG-AA baseline) (FR-010; NFR-003).
- **AC-012**: Responsive behavior is validated at desktop, tablet, and mobile
  for every migrated surface (FR-011; NFR-004).
- **AC-013**: The Knowledge Graph and traceability matrix model the CoreUI
  integration with full provenance (FR-013; Addendum §14–§15).
- **AC-014**: No database change: schema, data, and stored procedures are
  byte-identical before and after the re-skin (FR-016/§16; constitution
  Principles VI–VIII).
- **AC-015**: No business rule, validation rule, or workflow changed; the
  SPEC-0001..0008 test suites pass unchanged (BR-004; §17).
- **AC-016**: Role-based visual validation is performed for every role
  (Guest/`agt`/`emp`/`adm`/`su`), not only the administrator account (Addendum
  §17).
- **AC-017**: The role architecture preservation gate (Addendum §18) passes:
  every role, permission, native page, navigation item, landing page, workflow,
  protected route, and protected API identified and preserved; role-aware
  navigation and breadcrumbs implemented; role-based tests implemented;
  Knowledge Graph updated; SpecKit updated; traceability complete.

## 21. Risks

- **GAP-002 owner decision**: if the owner chooses to amend the constitution
  instead of adopting CoreUI, this specification's FR-001/FR-012 are void and
  the feature must be re-scoped. Mitigation: this specification is the
  adoption decision; an ADR records it (constitution Principle XIII).
- **Regression of role behavior during re-skin**: risk of accidentally
  changing navigation, redirects, or page composition. Mitigation: role-based
  test matrix (Addendum §16), role-based visual validation for every role
  (Addendum §17), preservation gate (Addendum §18), and the existing
  SPEC-0001..0008 test suites as regression net (AC-015).
- **Authorization weakened by UI hiding**: risk of treating hidden menu items
  as security. Mitigation: constitution Principle XV and Addendum §10 are
  explicit; AC-009 verifies server-side authorization unchanged.
- **GAP-004 placeholder areas mistaken for implemented**: `Areas/Employee`,
  `Areas/Billing`, `Areas/Notifications` have no page models. Mitigation: this
  feature re-skins presentation only; the missing models remain a separate gap
  (§6).
- **GAP-010 stray page**: `Areas/Public/Pages.Forms.cshtml` has no route.
  Mitigation: presentation-only re-skin; routing disposition remains a separate
  gap (§6).
- **CoreUI asset bloat**: copying the full template could bloat `wwwroot/`.
  Mitigation: copy only needed assets per `COREUI_INVENTORY.md` §11 and the
  dependency map; demo-only content excluded (§6).
- **Theme persistence key collision**: the CoreUI default key
  (`coreui-free-bootstrap-admin-template-theme`) must be renamed to
  `visafusion-theme` (FR-006; `COREUI_DESIGN_SYSTEM.md` §3).

## 22. Dependencies

- **Constitution v1.4.2** — Principles III, IV, V, VI, VII, VIII, XII, XIII,
  XIV, XV, XVI, XVII, XIX, XXII, XXIII; UI Design System section.
- **`library/Role-Based Native Pages Architecture Addendum.md`** — the
  governing rules for preserving the role architecture (all 19 sections).
- **`docs/ui/COREUI_VISA_FUSION_MAPPING.md`** — the 41-page mapping with
  statuses and CoreUI equivalents (the implementation contract for FR-004).
- **`docs/ui/ROLE_PAGE_PERMISSION_MATRIX.md`**, **`ROLE_NAVIGATION_MATRIX.md`**,
  **`ROLE_WORKFLOW_MATRIX.md`**, **`ROLE_ROUTE_MATRIX.md`**,
  **`ROLE_BASED_NATIVE_PAGES_INVENTORY.md`** — role architecture evidence.
- **`docs/ui/COREUI_INVENTORY.md`**, **`COREUI_COMPONENT_CATALOG.md`**,
  **`COREUI_DESIGN_SYSTEM.md`**, **`COREUI_DEPENDENCY_MAP.md`** — CoreUI
  evidence (v5.6.0, commit `d4003cd`).
- **`docs/analysis/GAP_REPORT.md`** — GAP-002 (resolved by this feature),
  GAP-004, GAP-010 (presentation-only handling).
- **`knowledge-graph/kg.json`** (v2.0: 465 nodes, 1,032 edges) and
  **`knowledge-graph/traceability-matrix.md`** — to be updated (FR-013).
- **SPEC-0001..SPEC-0008** — the implemented role-based pages, APIs, and tests
  that this feature re-skins without changing behavior.
- **`src/VisaFusion.Web`** — the Razor Pages application whose layouts and
  pages are re-skinned.
- **`src/VisaFusion.Api/Authorization/`** — the 11-policy catalog and 5 claims
  that must remain unchanged.

## 23. Test Scenarios

- **TS-001 (unit)**: centralized role-aware navigation model returns the
  correct menu/submenu set per role (Guest/`agt`/`emp`/`adm`/`su`) matching
  `ROLE_NAVIGATION_MATRIX.md`.
- **TS-002 (unit)**: canonical component rendering (shell, breadcrumb, page
  header) produces CoreUI markup with role-aware content.
- **TS-003 (integration)**: every protected page and API retains its policy;
  authorization tests from SPEC-0005 pass unchanged (AC-009).
- **TS-004 (integration)**: role-based routing and redirects (login, landing,
  unauthorized, access-denied, post-login, workflow) behave as before
  (AC-010).
- **TS-005 (API)**: all 51 API routes respond identically before and after the
  re-skin (route, method, policy, status) (AC-009; §15).
- **TS-006 (UI)**: every native page in `COREUI_VISA_FUSION_MAPPING.md`
  renders with its mapped CoreUI components and preserved functional
  composition (AC-005).
- **TS-007 (UI)**: theme switching light/dark/auto persists under the
  `visafusion-theme` key and survives reload (AC-007).
- **TS-008 (UI)**: responsive validation at desktop/tablet/mobile for every
  migrated surface (AC-012).
- **TS-009 (UI)**: accessibility checks (semantic HTML, keyboard, labels,
  focus, ARIA, contrast) on every migrated surface (AC-011).
- **TS-010 (regression)**: SPEC-0001..0008 test suites pass unchanged
  (AC-015).
- **TS-011 (role-based)**: role-based test matrix per Addendum §16 — for each
  role: login, landing page, navigation, menus, submenu, page access,
  unauthorized access, actions, forms, validation, APIs, reports, logout
  (AC-016).
- **TS-012 (visual)**: role-based visual validation per Addendum §17 for every
  role, not only administrator (AC-016).
- **TS-013 (database)**: schema and data byte-identical before/after the
  re-skin (AC-014).
- **TS-014 (KG)**: Knowledge Graph validation passes with the CoreUI
  integration nodes/edges and full provenance (AC-013).

## 24. Traceability Matrix

| Requirement | Architecture | Domain | Database | API | UI | Test | Migration |
|-------------|--------------|--------|----------|-----|----|------|-----------|
| FR-001      | Addendum §19; constitution IV | — | — | — | COREUI_INVENTORY.md | TS-006 | — |
| FR-002      | Addendum §1–§2, §7; constitution III | ROLE_*_MATRIX.md | — | ROLE_ROUTE_MATRIX.md | ROLE_BASED_NATIVE_PAGES_INVENTORY.md | TS-011 | — |
| FR-003      | Addendum §5–§6, §12 | ROLE_NAVIGATION_MATRIX.md | — | — | shell components | TS-001 | — |
| FR-004      | Addendum §8, §13 | — | — | — | COREUI_VISA_FUSION_MAPPING.md | TS-006 | — |
| FR-005      | COREUI_DESIGN_SYSTEM.md §4.2 | — | — | — | auth/error pages | TS-006 | — |
| FR-006      | COREUI_DESIGN_SYSTEM.md §3 | — | — | — | theme system | TS-007 | — |
| FR-007      | constitution XIV; Addendum §9 | — | — | — | canonical components | TS-002 | — |
| FR-008      | constitution XV; Addendum §10 | ROLE_PAGE_PERMISSION_MATRIX.md | — | AuthorizationPolicies.cs | — | TS-003, TS-005 | — |
| FR-009      | Addendum §11 | ROLE_ROUTE_MATRIX.md | — | ROLE_ROUTE_MATRIX.md | — | TS-004 | — |
| FR-010      | constitution XVI | — | — | — | COREUI_DESIGN_SYSTEM.md §7 | TS-009 | — |
| FR-011      | constitution XVII | — | — | — | COREUI_DESIGN_SYSTEM.md §6 | TS-008 | — |
| FR-012      | constitution IV | — | — | — | wwwroot assets | TS-006 | GAP-002 |
| FR-013      | constitution XII–XIII; Addendum §14–§15 | — | — | — | — | TS-014 | kg.json |
| FR-014      | — | — | — | — | COREUI_DEPENDENCY_MAP.md | — | — |
| BR-001      | constitution IV–V; Addendum §19 | — | — | — | — | TS-010 | — |
| BR-002      | Addendum §2 | — | — | — | — | TS-010 | — |
| BR-003      | constitution XV; Addendum §10 | — | — | — | — | TS-010 | — |
| BR-004      | constitution Engineering Standards | — | — | — | — | TS-010 | — |
| BR-005      | constitution VI | — | — | — | — | TS-010 | — |
| BR-006      | constitution XXIV | — | — | — | — | TS-010 | — |
| NFR-001     | COREUI_INVENTORY.md §2 | — | — | — | COREUI_DESIGN_SYSTEM.md | TS-008 | — |
| NFR-002     | Addendum §5 | — | — | — | COREUI_DESIGN_SYSTEM.md | TS-008 | — |
| NFR-003     | constitution XVI | — | — | — | COREUI_DESIGN_SYSTEM.md §7 | TS-009 | — |
| NFR-004     | constitution XVII | — | — | — | COREUI_DESIGN_SYSTEM.md §6 | TS-008 | — |
| NFR-005     | COREUI_DESIGN_SYSTEM.md §3 | — | — | — | COREUI_DESIGN_SYSTEM.md | TS-007 | — |
| NFR-006     | COREUI_INVENTORY.md §2 | — | — | — | COREUI_DESIGN_SYSTEM.md | TS-008 | — |
| NFR-007     | COREUI_DEPENDENCY_MAP.md | — | — | — | COREUI_DESIGN_SYSTEM.md | TS-008 | — |
| AC-001      | constitution IV; GAP-002 | — | — | — | wwwroot assets | TS-006 | — |
| AC-002      | constitution III; Addendum §1–§2, §7 | ROLE_*_MATRIX.md | — | ROLE_ROUTE_MATRIX.md | ROLE_BASED_NATIVE_PAGES_INVENTORY.md | TS-011 | — |
| AC-003      | Addendum §7 | — | — | — | role landings | TS-011 | — |
| AC-004      | Addendum §5–§6 | ROLE_NAVIGATION_MATRIX.md | — | — | shell components | TS-001 | — |
| AC-005      | Addendum §8, §13 | — | — | — | COREUI_VISA_FUSION_MAPPING.md | TS-006 | — |
| AC-006      | COREUI_DESIGN_SYSTEM.md §4.2 | — | — | — | auth/error pages | TS-006 | — |
| AC-007      | COREUI_DESIGN_SYSTEM.md §3 | — | — | — | theme system | TS-007 | — |
| AC-008      | constitution XIV; Addendum §9 | — | — | — | canonical components | TS-002 | — |
| AC-009      | constitution XV; Addendum §10 | ROLE_PAGE_PERMISSION_MATRIX.md | — | AuthorizationPolicies.cs | — | TS-003, TS-005 | — |
| AC-010      | Addendum §11 | ROLE_ROUTE_MATRIX.md | — | ROLE_ROUTE_MATRIX.md | — | TS-004 | — |
| AC-011      | constitution XVI | — | — | — | COREUI_DESIGN_SYSTEM.md §7 | TS-009 | — |
| AC-012      | constitution XVII | — | — | — | COREUI_DESIGN_SYSTEM.md §6 | TS-008 | — |
| AC-013      | constitution XII–XIII; Addendum §14–§15 | — | — | — | — | TS-014 | kg.json |
| AC-014      | constitution VI–VIII | — | 52 tables | — | — | TS-013 | — |
| AC-015      | constitution II; SPEC-0001..0008 | — | — | — | — | TS-010 | — |
| AC-016      | Addendum §16–§17 | ROLE_*_MATRIX.md | — | — | all pages | TS-011, TS-012 | — |
| AC-017      | Addendum §18 | — | — | — | — | TS-010..TS-014 | — |

## Assumptions

- The owner decision for GAP-002 is **adopt CoreUI** (re-skin), consistent
  with constitution Principle IV; this specification is that decision and an
  ADR records it. If the owner instead amends the constitution, FR-001/FR-012
  are void and this spec must be re-scoped (§21).
- The CoreUI reference copy (`%TEMP%\opencode\coreui-free-bootstrap-admin-template`,
  v5.6.0, commit `d4003cd`) is the exact adopted version; version pins come
  from `COREUI_DEPENDENCY_MAP.md`.
- The 41-page mapping in `docs/ui/COREUI_VISA_FUSION_MAPPING.md` is the
  authoritative page-level implementation contract; statuses
  (IMPLEMENTED/MAPPED/PARTIAL/BLOCKED/NOT_REQUIRED) are honored — pages marked
  BLOCKED are not re-skinned until their blocker is resolved.
- GAP-004 placeholder areas: only Notifications (PARTIAL) is re-skinned in
  presentation only; Employee and Billing (BLOCKED) are not re-skinned until
  their business scope is approved. The GAP-010 stray page (NOT_REQUIRED) is
  not re-skinned. Functional gaps are separate work items (§6).
- The 23 unresolved role/page/permission relationships noted in the role
  analysis are open decisions, not facts; this feature does not resolve them
  and does not encode them as requirements.
- No new business features are introduced; the feature set remains bounded by
  `@findings/modernization_plan.md`, `@findings/deepanalysis.md`, and
  `@findings/exiting_architecture.md` (constitution Principle II).

## Clarifications

### Session 2026-08-19

- Q: Does this feature implement the GAP-004 placeholder areas (Employee,
  Billing, Notifications) or the GAP-010 stray Forms page? → A: No — this
  feature re-skins presentation only. The missing page models (GAP-004) and
  the stray-page routing disposition (GAP-010) are separate gaps and are
  explicitly out of scope (§6).
- Q: Is the GAP-002 owner decision (adopt CoreUI vs. amend constitution)
  already made? → A: This specification is the adoption decision, consistent
  with constitution Principle IV; an ADR records it. If the owner decides
  otherwise, FR-001/FR-012 are void and the spec is re-scoped (§21).
- Q: Are any API contracts or database objects changed by this feature? → A:
  No. All 51 API routes and the entire database schema/data are unchanged
  (§15, §16, AC-009, AC-014).
- Q: How many navigation groups does the centralized target model define? → A:
  8 (Public, Account, Agent Portal, Reporting, Admin, Employee, Billing,
  Notifications) per `ROLE_NAVIGATION_MATRIX.md` §4 and
  `ROLE_BASED_NATIVE_PAGES_INVENTORY.md` §5. The earlier "10 groups, 24 menus,
  9 submenus" figures were KG node counts, not the matrix; corrected in FR-002,
  §7, AC-002.
- Q: Are the GAP-004 placeholder areas all re-skinned? → A: No — only
  Notifications (PARTIAL) is re-skinned presentation-only; Employee and Billing
  (BLOCKED, no page model/spec/policy) are not re-skinned until their business
  scope is approved (per `COREUI_VISA_FUSION_MAPPING.md` §6). Corrected in §6
  and Assumptions.
- Q: Is the GAP-010 stray Forms page re-skinned? → A: No — it is NOT_REQUIRED
  (dead file, no discoverable Razor route); disposition (delete or move with a
  model) is a separate gap. Corrected in §6 and Assumptions.
- Q: Is the public query endpoint the only anonymous write? → A: No — there
  are two anonymous writes: `POST /api/v1/public/register` (role fixed
  `guest`) and `POST /api/v1/public/queries` (5/hr/IP), both validated and
  rate-limited (verified `ROLE_ROUTE_MATRIX.md` §2). Corrected in §12.
- Q: Which surfaces render charts? → A: Agent Index, Agent Statement,
  Reporting Index, DailyVisaFee, DailyBill (Charts §7.1 targets in
  `COREUI_VISA_FUSION_MAPPING.md` §3–§4). Corrected in §13.
- Q: What are the canonical reusable VisaFusion components? → A: The 14
  components proposed in `COREUI_VISA_FUSION_MAPPING.md` §1–§7
  (`RoleAwareNavigation`, `RoleDashboard`, `DataTable`, `FormCard`, `AuthCard`,
  `ErrorPage`, `InfoPage`, `PublicLanding`, `PublicQueryForm`, `ConfirmModal`,
  `ToastHost`, `DesignTokens`, `ComponentStyles`, `IconSet`). Corrected in
  FR-007.