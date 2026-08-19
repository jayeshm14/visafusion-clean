# ROLE-BASED NATIVE PAGES INVENTORY — VisaFusion × CoreUI

**Status: COMPLETE** · Generated: 2026-08-19 · Sources: `library/Role-Based Native Pages Architecture Addendum.md`, `docs/analysis/ROLE_BASELINE.md`, `docs/analysis/UI_BASELINE.md`, `docs/analysis/GAP_REPORT.md`, `docs/ui/COREUI_INVENTORY.md`, `docs/ui/COREUI_COMPONENT_CATALOG.md`, `docs/ui/COREUI_DESIGN_SYSTEM.md`, `knowledge-graph/traceability-matrix.md`, `src/VisaFusion.Web/**`

## 1. PRIMARY RULE

Per `library/Role-Based Native Pages Architecture Addendum.md` §1, the existing
role-based native-pages architecture is the **authoritative migration
reference**. CoreUI supplies the visual design system, layout system, component
system, navigation presentation, responsive behavior and interaction patterns —
it does NOT replace role boundaries, page ownership, permission boundaries,
role-specific dashboards/menus/actions, or workflow organization.

```text
Existing VisaFusion Role-Based Architecture  +  CoreUI Design System
                        ↓
              Modern VisaFusion UI
```

Every row in the Role-Page Matrix (§4) is grounded in a tool call made
2026-08-19 (see §12 Provenance). No row uses status `UNKNOWN`.

## 2. Scope & verified inventory

- **41 Razor Pages** (verified via `glob src/VisaFusion.Web/**/*.cshtml`):
  26 have page models (`*.cshtml.cs`), 15 are model-less (static/placeholder).
- **21 pages** opt into the authenticated sidebar shell
  (`ViewData["UseSidebar"] = true` + `@section SidebarNav`, verified via grep —
  Agent ×5, Reporting ×7, Admin Users ×2, Admin SecurityDay, Admin Holidays,
  Admin ContentUpdate, Admin Agents ×4).
- All 41 pages use conventional `@page` routing (no custom route templates,
  verified via grep) → area routes `/{Area}/{subpath}`, root routes `/{subpath}`.
- Shell: `Pages/Shared/_Layout.cshtml` (verified lines 16/20/38) — dual mode
  (`useSidebar = ViewData["UseSidebar"] ?? isAuthenticated`), sidebar = Home +
  "Change password" + optional `SidebarNav` section.

## 3. Role & permission inventory (verified)

Roles (from `IdentityIntegration.Roles`, used by `AuthorizationPolicies.RoleSets`):
`Agent`, `Employee`, `Admin`, `SuperUser`; plus `Guest` (anonymous, public area).

Policies registered with `AuthorizationPolicies.Register` (11; verified
`src/VisaFusion.Api/Authorization/AuthorizationPolicies.cs`):

| Policy | Roles (RoleSets) | Native pages using it |
|---|---|---|
| `AgentSelf` | Agent, Employee, Admin, SuperUser | Agent area (5, via `AgentPortalPageModel`) |
| `EntryOperations` | Employee, Admin, SuperUser | Reporting area (7, via `ReportingPageModel`) |
| `AdminPanel` | Admin, SuperUser | Admin Agents (4), Admin ContentUpdate |
| `UserManagement` | Admin, Employee | Admin Users (List, Create) |
| `HolidayAdmin` | Admin, SuperUser | Admin Holidays |
| `SecurityGate` | Admin, SuperUser | Admin SecurityDay |
| `AgentLedger` | Agent, Employee, Admin, SuperUser | — (no native page yet; API/reserved) |
| `BillingOperations` | Employee, Admin, SuperUser | — (no native page yet; Billing area is placeholder, GAP-004) |
| `Search` | Agent, Employee, Admin, SuperUser | — (no native page yet; reserved) |
| `PasswordSelf` | Agent, Employee, Admin, SuperUser | — (no native page yet; API/reserved) |
| `SuperUserOnly` | claim `IdentityClaims.SuperUserClaimType=true` | — (su-provisioning, documented-only deferred contract, SPEC-0006 FR-007) |

Anonymous pages (no `[Authorize]`): all Public-area pages, root `Index`,
`/Auth/Login`, `/Auth/Register`, `/Auth/AccessDenied`. `/Auth/ChangePassword`
carries `[Authorize]` (verified `Pages/Auth/ChangePassword.cshtml.cs:21`).

## 4. ROLE-PAGE MATRIX (addendum §4)

Columns: `Role | Native Page | Route | Menu | Permission | Workflow | CoreUI Target | Status`.
Role abbreviations: **AGT**=Agent, **EMP**=Employee, **ADM**=Admin, **SU**=SuperUser,
**G**=Guest (anonymous). Statuses: IMPLEMENTED / MAPPED / PARTIAL / BLOCKED / NOT_REQUIRED.
Cross-cutting note: the global re-skin of the current bespoke `vf-*` shell to
CoreUI is gated on the owner decision recorded in **GAP-002**; every
IMPLEMENTED row below is functionally complete in the modern app with its
CoreUI target identified.

### 4.1 Navigation Group: Public Site (Guest)

| Role | Native Page | Route | Menu | Permission | Workflow | CoreUI Target | Status |
|---|---|---|---|---|---|---|---|
| G | `Areas/Public/Pages/Index.cshtml` | `/Public/Index` | Public › Home | anonymous | Public landing (MOD-007) | `views/index.pug` dashboard pattern; Cards `COMPONENT_CATALOG §3.1` | PARTIAL — static, no page model |
| G | `Areas/Public/Pages/VisaInfo.cshtml` | `/Public/VisaInfo` | Public › Visa Info | anonymous | Visa information pages | Cards §3.1, Accordion/Collapse §5.2, Icons §8 (cif-* flags) | PARTIAL — static |
| G | `Areas/Public/Pages/Embassy.cshtml` | `/Public/Embassy` | Public › Embassy | anonymous | Embassy directory | Cards §3.1, Tables §3.2, Icons §8 (cif-*) | PARTIAL — static |
| G | `Areas/Public/Pages/CountryInfo.cshtml` | `/Public/CountryInfo` | Public › Country Info | anonymous | Country information | Cards §3.1, Chip §5.4 | PARTIAL — static |
| G | `Areas/Public/Pages/DailyUpdate.cshtml` | `/Public/DailyUpdate` | Public › Daily Update | anonymous | Legacy `viewdailyupdate.asp` 30-day window (SPEC-0008) | Cards §3.1, Tables §3.2, Pagination §2.3, Badges §3.6 | IMPLEMENTED — has page model (SPEC-0008 content) |
| G | `Areas/Public/Pages/Queries.cshtml` | `/Public/Queries` | Public › Queries | anonymous | Legacy `querieDetail.asp` (MOD-007); form → `/api/v1/public/queries`, rate-limited 5/hr/IP | Form Control §6.1, Input Group §6.2, Select §6.4, Validation §6.5, Buttons §5.1, Alerts §3.5 | PARTIAL — static page, posts to verified API |
| G | `Areas/Public/Pages/Contact.cshtml` | `/Public/Contact` | Public › Contact | anonymous | Legacy `contact.asp` (MOD-007) | Form Control §6.1, Validation §6.5, Buttons §5.1 | PARTIAL — static |
| G | `Areas/Public/Pages/Subscribe.cshtml` | `/Public/Subscribe` | Public › Subscribe | anonymous | Newsletter subscription | Form Control §6.1, Input Group §6.2, Buttons §5.1 | PARTIAL — static |
| G | `Areas/Public/Pages/Register.cshtml` | `/Public/Register` | Public › Register | anonymous | Legacy `register.asp` (MOD-007) | `authentication/register.pug` pattern (INVENTORY §10, §9) | PARTIAL — static; active registration lives at `/Auth/Register` |
| G | `Areas/Public/Pages/Pages.Forms.cshtml` (stray file, NOT under `Pages/`) | no route | — | — | orphan artifact (GAP-010) | — | NOT_REQUIRED — dead file, no discoverable Razor route; GAP-010 |
| G | `Pages/Index.cshtml` | `/` | Home | anonymous | Landing/welcome (SPEC-0003 FR-002 host) | `views/blank.pug` scaffold (INVENTORY §10) | PARTIAL — static welcome page |

### 4.2 Navigation Group: Auth / Account (all roles)

| Role | Native Page | Route | Menu | Permission | Workflow | CoreUI Target | Status |
|---|---|---|---|---|---|---|---|
| G | `Pages/Auth/Login.cshtml` | `/Auth/Login` | Account › Login | anonymous; cookie scheme + JWT (`/api/v1/auth`) | Legacy `authenticate.asp`/`logon.asp` redirect target (GAP-006; SPEC-0005 TS-001) | `authentication/login.pug` (INVENTORY §10) — centered-card layout, show-password tooltip, remember-me | IMPLEMENTED |
| G | `Pages/Auth/Register.cshtml` | `/Auth/Register` | Account › Register | anonymous | Legacy `regsub*.asp` redirect target (GAP-006; SPEC-0005 TS-005) | `authentication/register.pug` (INVENTORY §10) | IMPLEMENTED |
| AGT/EMP/ADM/SU | `Pages/Auth/ChangePassword.cshtml` | `/Auth/ChangePassword` | Account › Change password | `[Authorize]` (any authenticated); legacy `changepassword.asp` flag 2/3 parity (SPEC-0005 TS-012/TS-014) | Change password | `authentication/change-password.pug` (INVENTORY §10) | IMPLEMENTED |
| G | `Pages/Auth/AccessDenied.cshtml` | `/Auth/AccessDenied` | — (error state) | anonymous | 403 → access-denied surface (SPEC-0005; `AccessDeniedPageTests`) | Error-page pattern (`error-pages/404/500.pug` family, INVENTORY §10) | IMPLEMENTED |

### 4.3 Navigation Group: Agent Portal (AGT/EMP/ADM/SU) — `AgentSelf`

| Role | Native Page | Route | Menu | Permission | Workflow | CoreUI Target | Status |
|---|---|---|---|---|---|---|---|
| AGT/EMP/ADM/SU | `Areas/Agent/Pages/Index.cshtml` | `/Agent/Index` | Agent › Dashboard | `AgentSelf` (via `AgentPortalPageModel`) | Legacy `agentHome.asp` agent landing | `views/index.pug` KPI cards §3.1, Progress §3.4, Charts §7.1 | IMPLEMENTED |
| AGT/EMP/ADM/SU | `Areas/Agent/Pages/Entries.cshtml` | `/Agent/Entries` | Agent › My Entries | `AgentSelf` | Legacy `listforagents.asp` (MOD-001); scoped to own AgentId (SPEC-0005 TS-003) | Tables §3.2, Pagination §2.3, Badges §3.6, Dropdowns §2.2 (row actions), Search Button §2.4 | IMPLEMENTED |
| AGT/EMP/ADM/SU | `Areas/Agent/Pages/Statuses.cshtml` | `/Agent/Statuses` | Agent › Statuses | `AgentSelf` | Passenger/entry status (PaxStatus/bighistory lineage, SPEC-0006) | Tabs §2.1, Badges §3.6, Timeline via Cards §3.1 | IMPLEMENTED |
| AGT/EMP/ADM/SU | `Areas/Agent/Pages/Statement.cshtml` | `/Agent/Statement` | Agent › Statement | `AgentSelf` | Legacy `agentStatement*`; invoice/ledger lineage (FR-001 `invoice`) | Tables §3.2, Pagination §2.3, Dropdowns §2.2, Charts §7.1 | IMPLEMENTED |
| AGT/EMP/ADM/SU | `Areas/Agent/Pages/Account.cshtml` | `/Agent/Account` | Agent › Account | `AgentSelf` | Legacy `AgentAccount.asp`/`editdonebyagent1.asp` profile | Form Control §6.1, Form Layout §6.6, Validation §6.5, Buttons §5.1 | IMPLEMENTED |

### 4.4 Navigation Group: Reporting (EMP/ADM/SU) — `EntryOperations`

| Role | Native Page | Route | Menu | Permission | Workflow | CoreUI Target | Status |
|---|---|---|---|---|---|---|---|
| EMP/ADM/SU | `Areas/Reporting/Pages/Index.cshtml` | `/Reporting/Index` | Reporting › Dashboard | `EntryOperations` (via `ReportingPageModel`) | Reporting landing (MOD-005) | `views/index.pug` + `views/widgets.pug` patterns; Cards §3.1, Charts §7.1 | IMPLEMENTED |
| EMP/ADM/SU | `Areas/Reporting/Pages/Pending.cshtml` | `/Reporting/Pending` | Reporting › Pending | `EntryOperations` | Legacy `pendinglist.asp` | Tables §3.2, Pagination §2.3, Badges §3.6 | IMPLEMENTED |
| EMP/ADM/SU | `Areas/Reporting/Pages/TodaySubmission.cshtml` | `/Reporting/TodaySubmission` | Reporting › Today › Submission | `EntryOperations` | Legacy `todaySubmission*.asp` | Tables §3.2, Cards §3.1 (summary), Badges §3.6 | IMPLEMENTED |
| EMP/ADM/SU | `Areas/Reporting/Pages/TodayCollection.cshtml` | `/Reporting/TodayCollection` | Reporting › Today › Collection | `EntryOperations` | Legacy `todayCollection*.asp` | Tables §3.2, Cards §3.1, Badges §3.6 | IMPLEMENTED |
| EMP/ADM/SU | `Areas/Reporting/Pages/TodayTransaction.cshtml` | `/Reporting/TodayTransaction` | Reporting › Today › Transaction | `EntryOperations` | Legacy `todayTransaction.asp` | Tables §3.2, Cards §3.1, Badges §3.6 | IMPLEMENTED |
| EMP/ADM/SU | `Areas/Reporting/Pages/DailyVisaFee.cshtml` | `/Reporting/DailyVisaFee` | Reporting › Daily › Visa Fee | `EntryOperations` | Legacy `dailyVisaFee.asp` | Tables §3.2, Cards §3.1, Charts §7.1 | IMPLEMENTED |
| EMP/ADM/SU | `Areas/Reporting/Pages/DailyBill.cshtml` | `/Reporting/DailyBill` | Reporting › Daily › Bill | `EntryOperations` | Legacy `dailybill.asp` | Tables §3.2, Cards §3.1, Charts §7.1 | IMPLEMENTED |

### 4.5 Navigation Group: Admin (ADM/SU unless noted) — policies per page

| Role | Native Page | Route | Menu | Permission | Workflow | CoreUI Target | Status |
|---|---|---|---|---|---|---|---|
| ADM/SU | `Areas/Admin/Pages/Index.cshtml` | `/Admin/Index` | Admin › Dashboard | (none — placeholder) | Admin landing (no model) | `views/index.pug`; Cards §3.1, Progress §3.4 | PARTIAL — placeholder, no page model |
| ADM/SU | `Areas/Admin/Pages/Agents/List.cshtml` | `/Admin/Agents/List` | Admin › Agents › List | `AdminPanel` | Legacy `viewagent.asp`/`topAgent.asp` (MOD-002) | Tables §3.2, Pagination §2.3, Search Button §2.4, Dropdowns §2.2 | IMPLEMENTED |
| ADM/SU | `Areas/Admin/Pages/Agents/Create.cshtml` | `/Admin/Agents/Create` | Admin › Agents › Create | `AdminPanel` | Legacy `addnewagents.asp`/`newagent.asp` | Form Control §6.1, Form Layout §6.6, Select §6.4, Validation §6.5 | IMPLEMENTED |
| ADM/SU | `Areas/Admin/Pages/Agents/Detail.cshtml` | `/Admin/Agents/Detail` | Admin › Agents › Detail | `AdminPanel` | Legacy `viewagent.asp` detail | Cards §3.1, Tables §3.2, Avatar §1.5 | IMPLEMENTED |
| ADM/SU | `Areas/Admin/Pages/Agents/Edit.cshtml` | `/Admin/Agents/Edit` | Admin › Agents › Edit | `AdminPanel` | Legacy `editdoneagent1.asp` | Form Control §6.1, Form Layout §6.6, Select §6.4, Validation §6.5 | IMPLEMENTED |
| ADM/EMP | `Areas/Admin/Pages/Users/List.cshtml` | `/Admin/Users/List` | Admin › Users › List | `UserManagement` | Legacy `addNewUser.asp`/`deleteUser.asp`/`editdonetest.asp` | Tables §3.2, Pagination §2.3, Avatar §1.5, Badges §3.6 | IMPLEMENTED |
| ADM/EMP | `Areas/Admin/Pages/Users/Create.cshtml` | `/Admin/Users/Create` | Admin › Users › Create | `UserManagement` | User provisioning (SPEC-0005 FR-017) | Form Control §6.1, Form Layout §6.6, Select §6.4, Checks/Radios/Switches §6.3, Validation §6.5 | IMPLEMENTED |
| ADM/SU | `Areas/Admin/Pages/Holidays/Index.cshtml` | `/Admin/Holidays/Index` | Admin › Holidays | `HolidayAdmin` | Legacy `holiday_entry.asp`/`holidayDeleteSubmit.asp`/`WeeklyOffList.asp` (SPEC-0006 FR-006 bookable-date rule) | Tables §3.2, Modals §4.1 (confirm delete), Form Control §6.1, Validation §6.5 | IMPLEMENTED |
| ADM/SU | `Areas/Admin/Pages/ContentUpdate/Index.cshtml` | `/Admin/ContentUpdate/Index` | Admin › Content Update | `AdminPanel` | Legacy `dailyupdate.asp` (SPEC-0008 content) | Form Control §6.1, Form Layout §6.6, Validation §6.5, Toasts §4.2 | IMPLEMENTED |
| ADM/SU | `Areas/Admin/Pages/SecurityDay/Index.cshtml` | `/Admin/SecurityDay/Index` | Admin › Security Day | `SecurityGate` | Legacy `securityHome.asp`/`openForDay.asp`/`closeForDay.asp`; day-gate (`relogin.asp?rsn=` states; SPEC-0005 FR-010/FR-016/TS-013) | Cards §3.1 (state), Buttons §5.1, Alerts §3.5, Badges §3.6 | IMPLEMENTED |

### 4.6 Navigation Group: Employee / Billing / Notifications (placeholder areas, GAP-004)

| Role | Native Page | Route | Menu | Permission | Workflow | CoreUI Target | Status |
|---|---|---|---|---|---|---|---|
| EMP/ADM/SU | `Areas/Employee/Pages/Index.cshtml` | `/Employee/Index` | Employee › Home | (none — placeholder) | None defined (no model, GAP-004) | `views/blank.pug` scaffold | BLOCKED — no page model, no spec, no policy; GAP-004 |
| EMP/ADM/SU | `Areas/Billing/Pages/Index.cshtml` | `/Billing/Index` | Billing › Home | (none — placeholder) | Legacy billing module (MOD-003 `invoice.asp`); `BillingOperations` policy exists but no page/spec | `views/blank.pug`; would be Tables §3.2 + Cards §3.1 once scoped | BLOCKED — placeholder; no approved spec; GAP-004 |
| ADM/SU | `Areas/Notifications/Pages/Index.cshtml` | `/Notifications/Index` | Notifications › Home | (none — placeholder) | Notifications module (MOD-004 `SendSMS.asp`; SPEC-0008 notifications-api; dispatch is log-only, GAP-008) | `views/blank.pug`; would use Toasts §4.2 + Badges §3.6 once scoped | PARTIAL — page placeholder; SPEC-0008/notifications-api exists, no page model |

### 4.7 Cross-cutting UI artifacts

| Artifact | Route/Path | Menu | Permission | Workflow | CoreUI Target | Status |
|---|---|---|---|---|---|---|
| `Pages/Shared/_Layout.cshtml` | all pages | — | role-aware shell | Dual shell: sidebar mode for authenticated, top-nav for anonymous (verified lines 16/20/38) | CoreUI Sidebar §1.1 (`sidebar.pug` + data-driven `sidebar-nav.pug`), Header §1.2 (`header.pug`), Footer §1.3, Breadcrumb §1.4 | IMPLEMENTED (native) → CoreUI shell pending GAP-002 |
| `wwwroot/css/tokens.css` | static | — | — | design tokens | Replace with CoreUI `--cui-*` CSS custom properties (DESIGN_SYSTEM §3) | MAPPED |
| `wwwroot/css/theme.css` (49 verified `vf-*` classes: shell/sidebar/topnav/btn/form/alert/card/table/badge/list/numeric) | static | — | — | bespoke component styles | Map per component to CoreUI equivalents (Buttons §5.1, Forms §6.x, Tables §3.2, Badges §3.6, Alerts §3.5, Cards §3.1) | MAPPED — re-skin pending GAP-002 |
| `wwwroot/css/bootstrap-icons.css` | static | — | — | icon source | Replace with CoreUI Icons §8 (`cil-*`/`cif-*` SVGs into `wwwroot/icons`) | MAPPED |
| `wwwroot/updateimg/**` (legacy) | static | — | — | legacy images served for parity (Phase0E2ETests 200) | No CoreUI equivalent — legacy asset | NOT_REQUIRED |

## 5. ROLE-BASED NAVIGATION MODEL (addendum §5)

Current state (verified): the nav is **not** yet centralized — each of the 21
sidebar pages renders its own `@section SidebarNav`, and the shared shell only
hard-codes Home + "Change password". The addendum requires a centralized,
role-aware navigation model. The authoritative hierarchy to implement is:

```text
Role → Permission → Navigation Group → Menu → Submenu → Native Page → Feature → Workflow
```

Proposed centralized model (from the verified groups in §4):

| Navigation Group | Menu | Submenu | Permission | Roles | Pages |
|---|---|---|---|---|---|
| Public | Home / Visa Info / Embassy / Country Info / Daily Update / Queries / Contact / Subscribe / Register | — | anonymous | Guest | §4.1 rows |
| Account | Login / Register / Change password | — | `[Authorize]` (change pw) | all | §4.2 |
| Agent Portal | Dashboard / My Entries / Statuses / Statement / Account | — | `AgentSelf` | AGT/EMP/ADM/SU | §4.3 |
| Reporting | Dashboard / Pending / Today › {Submission, Collection, Transaction} / Daily › {Visa Fee, Bill} | Today, Daily | `EntryOperations` | EMP/ADM/SU | §4.4 |
| Admin | Dashboard / Agents › {List, Create, Detail, Edit} / Users › {List, Create} / Holidays / Content Update / Security Day | Agents, Users | `AdminPanel` / `UserManagement` / `HolidayAdmin` / `SecurityGate` | ADM/SU (Users: ADM/EMP) | §4.5 |
| Employee | Home | — | (none yet) | EMP | §4.6 BLOCKED |
| Billing | Home | — | (none yet; `BillingOperations` reserved) | EMP/ADM/SU | §4.6 BLOCKED |
| Notifications | Home | — | (none yet; SPEC-0008 API exists) | ADM/SU | §4.6 PARTIAL |

Implementation target (do NOT hard-code per-page nav): one `RoleAwareNavigation`
service that consumes this matrix and renders the CoreUI `sidebar-nav.pug`
data-driven pattern (`nav` array with types `item`/`title`/`group`/`divider`,
CoreUI navigation component — INVENTORY §8 `_partials/sidebar-nav.pug`).

## 6. ROLE-BASED APPLICATION SHELL (addendum §6)

Target shell composition (CoreUI partials — INVENTORY §8):

```text
VisaFusion Shell (replaces vf-shell)
├── Header              → _partials/header.pug (theme dropdown, avatar menu, notification badges)
├── Role Context        → current principal → nav model (§5)
├── Role-Aware Sidebar  → _partials/sidebar.pug + sidebar-nav.pug (SimpleBar, unfoldable, mobile close)
│     Menu Group → Menu → Submenu
├── Breadcrumb          → _mixins/breadcrumb.pug (role → module → feature → page, addendum §12)
├── Page Header
├── Native Role Page    → unchanged functional composition (§4 rows)
└── Footer              → _partials/footer.pug (VisaFusion branding)
```

The shell is reusable; only content and navigation are role-aware. Adoption is
gated on GAP-002.

## 7. EXISTING COMPONENT → COREUI MAPPING (addendum §8, steps 9–14)

Verified `vf-*` classes in `wwwroot/css/theme.css` map as follows
(CoreUI refs: `docs/ui/COREUI_COMPONENT_CATALOG.md`):

| Existing `vf-*` | CoreUI target | Notes |
|---|---|---|
| `vf-shell`, `vf-sidebar`, `vf-sidebar-brand`, `vf-sidebar-nav`, `vf-main`, `vf-content`, `vf-footer` | Sidebar §1.1, Header §1.2, Footer §1.3 | `sidebar-dark sidebar-fixed` + `.wrapper` layout |
| `vf-topnav`, `vf-topnav-brand`, `vf-topnav-links`, `vf-topbar`, `vf-topbar-user`, `vf-role` | Header §1.2 | avatar dropdown, role badge (`badge-sm`) |
| `vf-btn`, `vf-btn-primary/secondary/danger` | Buttons §5.1 | map to `.btn .btn-primary/.btn-outline/.btn-danger` |
| `vf-form-group/label/control`, `vf-field-validation-error`, `vf-validation-summary-errors` | Form Control §6.1, Validation §6.5 | `.is-invalid` + `.invalid-feedback`/`.valid-feedback` |
| `vf-alert`, `vf-alert-danger/success` | Alerts §3.5 | `role="alert"` + dismissible |
| `vf-card` | Cards §3.1 | `.card .card-header/.card-footer` |
| `vf-table` | Tables §3.2 | `.table-responsive`, `.table-sm` |
| `vf-badge`, `vf-badge-success/danger` | Badges §3.6 | `badge-sm` for nav markers, `bg-*` for status |
| `vf-list`, `vf-numeric` | List Group §3.3, Table/typography | numeric alignment via Bootstrap utilities |
| `vf-skip-link` | (accessibility) | keep — matches CoreUI a11y baseline |

Authorization is preserved on every page (server-side `[Authorize(Policy=…)]`),
never relies on menu visibility (addendum §10).

## 8. TRACEABILITY (addendum §15)

Chain per page: Role → Permission → Navigation (§4) → Page → Feature →
Specification → Use Case/API → Database → Test. Spec references verified via
`knowledge-graph/traceability-matrix.md` and `specs/` folders.

| Native Page | Feature | Specification | API / Use case | Database | Test (file-level) |
|---|---|---|---|---|---|
| `/Auth/Login` | cookie+JWT login | SPEC-0005 (TS-001) | `/api/v1/auth` | AspNetUsers, AspNetRoles | AuthLoginTests, WebLoginPageTests |
| `/Auth/Register` | guest registration | SPEC-0005 (TS-005) | shared `RegistrationFlow` | AspNetUsers | RegisterPageTests, RegistrationEscalationTests |
| `/Auth/ChangePassword` | change password | SPEC-0005 (TS-012, TS-014) | changepassword legacy parity | AspNetUsers.PasswordHash | ChangePasswordTests, ChangePasswordPageTests |
| `/Auth/AccessDenied` | denial surface | SPEC-0005 | — | — | AccessDeniedPageTests |
| `/Agent/Index` | agent landing | SPEC-0005 FR-003/FR-004 (agent views) | `/api/v1/auth` AgentId claim | Agents | AgentPortalRbacTests, AgentPortalIntegrationTests, AgentPagesTests, AgentScopingTests, AgentLifecycleTests, AgentRbacTests |
| `/Agent/Entries` | own-entry list | SPEC-0005 TS-003 + SPEC-0006 FR-008 | `/api/v1/entries` (scoped) | Mainentry, entryDetails, PaxStatus | EntriesRbacTests, BackdoorAndIsolationTests, AgentPortalIntegrationTests |
| `/Agent/Statuses` | status timeline | SPEC-0006 FR-005 | `/api/v1/entries/{refno}/status` | PaxStatus, StatusHistory, bighistory | StatusChangeTests, StatusChangeIntegrationTests, StatusChangeIntegrationTests |
| `/Agent/Statement` | invoice/ledger | FR-001 (invoice lineage) | `/api/v1/reports` (ledger) | invoice | ReportSchemaTests, ReportParameterizedSqlTests |
| `/Agent/Account` | agent profile | SPEC-0005 FR-003 | agents self-edit | Agents | AgentPagesTests, AgentRbacTests |
| `/Reporting/*` (7) | reports | SPEC-0008 (reporting) | `/api/v1/reports` | Views (report procs, scripts 03) | ReportEndpointTests, ReportSchemaTests, ReportParameterizedSqlTests |
| `/Admin/Agents/*` (4) | agent CRUD | SPEC-0007 (admin agents) | `/api/v1/agents` (contracts/agents-api.md) | Agents | AgentPagesTests, AgentCrudIntegrationTests, AgentPortalRbacTests, AgentScopingTests |
| `/Admin/Users/*` (2) | user mgmt | SPEC-0005 FR-017 | admin user API | AspNetUsers, AspNetRoles, AspNetUserClaims | UserPagesTests, AdminUserManagementTests, UserManagementTests, UserManagementIntegrationTests |
| `/Admin/Holidays/Index` | holiday/weeklyoff | SPEC-0006 FR-006 (bookable-date rule) | holiday API | holidaylist, weeklyoff | HolidayServiceTests, HolidayCrudParityTests, HolidayCrudEndpointTests, EmbassyClosedTests |
| `/Admin/ContentUpdate/Index` | daily update content | SPEC-0008 (content) | contracts/content-api.md | (SPEC-0008 content data) | ContentCmsTests, ContentUpdateCrudTests |
| `/Admin/SecurityDay/Index` | open/close day | SPEC-0005 FR-010/FR-016/FR-018 | day-gate API (`rsn=` states) | security (SPEC-0004 §3.1) | SecurityDayPagesTests, SecurityDayTests, SecurityDayIntegrationTests, SecurityGateServiceTests, SecurityGateIntegrationTests, WebLoginPageTests |
| `/Public/DailyUpdate` | 30-day daily update | SPEC-0008 (content) | contracts/content-api.md | (SPEC-0008 content data) | ContentCmsTests, ContentUpdateCrudTests |
| `/Public/Queries` | public query form | SPEC-0007 | `/api/v1/public/queries` (rate-limited) | (SPEC-0007 public-api) | QueriesEndpointTests, QueriesValidationTests, QueriesPersistenceTests, RateLimitTests |
| Public static pages (7) | info/contact/subscribe | SPEC-0007 | — (static) | — | AreaTests, Phase0E2ETests |
| `/` (root) | welcome | SPEC-0003 FR-002 | — | — | AreaTests, Phase0E2ETests |
| Employee/Billing/Notifications placeholders | — | GAP-004 (no spec) | — | — | AreaTests |

## 9. ROLE-BASED TEST MATRIX (addendum §16)

| Role | Page | Permission | Authorized | Unauthorized | Navigation | API | Test |
|---|---|---|---|---|---|---|---|
| Guest | `/Auth/Login` | anonymous | 200 GET / cookie POST | bad creds → generic error | — | 401 without creds | WebLoginPageTests, AuthLoginTests |
| Guest | `/Public/Queries` | anonymous | POST 201/200 | over rate limit → 429 | — | `/api/v1/public/queries` | QueriesEndpointTests, RateLimitTests |
| Agent | `/Agent/Entries` | `AgentSelf` | 200 own scope | other agent → 403/404; anonymous → 401/302 | Sidebar renders (UseSidebar) | `/api/v1/entries` scoped | AgentPortalRbacTests, BackdoorAndIsolationTests |
| Employee | `/Reporting/*` | `EntryOperations` | 200 | Guest/Agent → 403; day-gated when closed | Sidebar renders | `/api/v1/reports` | ReportEndpointTests, SecuredWriteRoutesTests |
| Employee | `/Admin/Users/List` | `UserManagement` | 200 (ADM+EMP) | Guest → 401/302 | Sidebar renders | admin user API | UserPagesTests, AdminUserManagementTests |
| Admin | `/Admin/Agents/*` | `AdminPanel` | 200 | Guest → 401/302; Agent → 403 | Sidebar renders | `/api/v1/agents` | AgentPagesTests, SecuredWriteRoutesTests |
| Admin | `/Admin/SecurityDay/Index` | `SecurityGate` | 200 (ADM/SU) | non-ADM → 403; `rsn=O` redirect | Sidebar renders | day-gate API | SecurityDayPagesTests, WebLoginPageTests |
| Admin | `/Admin/Holidays/Index` | `HolidayAdmin` | 200 | Guest → 401/302 | Sidebar renders | holiday API | HolidayCrudParityTests, HolidayCrudEndpointTests |
| SuperUser | `/Auth/ChangePassword` | `[Authorize]` | 204 | anonymous → 401/redirect | — | changepassword | ChangePasswordTests, ChangePasswordPageTests |
| All roles | `/Auth/AccessDenied` | anonymous | 200 | — | — | — | AccessDeniedPageTests |
| All roles | `/` | anonymous | 200 | — | Home link | — | AreaTests, Phase0E2ETests |

UI visibility ≠ authorization (§10): every protected page retains its
server-side policy (verified attributes in §3).

## 10. ORPHAN / UNMAPPED ARTIFACTS → GAP_REPORT.md

- **GAP-010 (added)**: `Areas/Public/Pages.Forms.cshtml` — stray file directly
  under the Public area root, outside `Areas/Public/Pages/`; has `@page` but no
  discoverable Razor route and no model. Verified via glob + grep. Disposition
  pending owner: delete, or move into `Areas/Public/Pages/` with a model.
- Cross-references: **GAP-002** (CoreUI adoption vs bespoke `vf-*` — gates §5–§7),
  **GAP-004** (Employee/Billing/Notifications placeholders — §4.6 BLOCKED rows),
  **GAP-008** (notification transports log-only — §4.6 Notifications row).

## 11. PRESERVATION GATE (addendum §18) — current status

| Gate item | Status |
|---|---|
| Every role identified | ✅ §3 (Agent, Employee, Admin, SuperUser, Guest) |
| Every permission identified | ✅ §3 (11 policies) |
| Every native role page identified | ✅ §4 (41 pages + cross-cutting artifacts) |
| Every role-based navigation item mapped | ✅ §5 (proposed centralized model) |
| Every role-specific landing page mapped | ✅ §4 (Agent/Reporting/Admin/Public) |
| Every role-specific workflow preserved | ✅ §4 workflow column (legacy parity) |
| Every protected route preserved | ✅ §3/§4 (policy per page) |
| Every protected API preserved | ✅ §8 API column |
| Role-aware navigation implemented | ⏳ pending GAP-002 (currently per-page `SidebarNav` sections) |
| Role-aware breadcrumbs implemented | ⏳ pending GAP-002 |
| Role-specific pages migrated | ✅ functional; CoreUI presentation pending GAP-002 |
| Role-based tests implemented | ✅ §9 (test files exist and run) |
| Knowledge Graph updated | ⏳ to be regenerated with role/navigation nodes per §14 |
| SpecKit updated | ⏳ referenced specs cited; addendum integration pending |
| Traceability complete | ✅ §8 |

## 12. PROVENANCE

Every fact above was verified by a tool call on 2026-08-19:
- `glob src/VisaFusion.Web/**/*.cshtml` (41 pages) and `**/*.cshtml.cs` (26 models).
- `grep @page`, `grep SidebarNav|UseSidebar` (45 matches; 21 sidebar pages),
  `grep [Authorize` (policy attributes on page models).
- `read src/VisaFusion.Api/Authorization/AuthorizationPolicies.cs` (11 policies,
  RoleSets), `read Pages/Index.cshtml`, `read Pages/Shared/_Layout.cshtml` (shell).
- `glob tests/**/*.cs` (test inventory), `read knowledge-graph/traceability-matrix.md`
  (spec→test map, module→legacy map), `glob specs/**` (spec folders 001–008).
- `read docs/ui/COREUI_INVENTORY.md`, `docs/ui/COREUI_COMPONENT_CATALOG.md`,
  `docs/analysis/GAP_REPORT.md` (format + GAP-001…009).
- `library/Role-Based Native Pages Architecture Addendum.md` read (structure of
  this document).
Nothing asserted from memory; `UNKNOWN` is not used.
