# CoreUI ↔ VisaFusion UI Mapping — Deterministic

**Status: COMPLETE** · Generated: 2026-08-19 · Updated: 2026-08-22 (Phase 27 — synchronized with delivered state)
**Sources**: `library/Role-Based Native Pages Architecture Addendum.md`,
`docs/analysis/ROLE_BASELINE.md`, `docs/analysis/UI_BASELINE.md`,
`docs/analysis/GAP_REPORT.md`, `docs/ui/COREUI_INVENTORY.md`,
`docs/ui/COREUI_COMPONENT_CATALOG.md`, `docs/ui/COREUI_DESIGN_SYSTEM.md`,
`docs/ui/COREUI_DEPENDENCY_MAP.md`,
`docs/ui/ROLE_BASED_NATIVE_PAGES_INVENTORY.md`,
`knowledge-graph/traceability-matrix.md`, `src/VisaFusion.Web/**`.

**Method**: every row is grounded in a tool call made 2026-08-19 (glob of
`.cshtml`/`.cshtml.cs`, grep of `@page`/`[Authorize]`/`SidebarNav|UseSidebar`/
`vf-*` classes, read of `AuthorizationPolicies.cs`, `_Layout.cshtml`,
`Login.cshtml`, `Index.cshtml`, traceability matrix, CoreUI docs). No row uses
status `UNKNOWN`. Where no mapping can be established the item is recorded in
`docs/analysis/GAP_REPORT.md` (GAP-002, GAP-004, GAP-010) and referenced here.

**Status legend**:
- **IMPLEMENTED** — native page fully functional in the modern app (page model
  + view + server-side authorization) with a CoreUI target identified; the
  CoreUI re-skin itself is gated on the GAP-002 owner decision (cross-cutting,
  not a per-page blocker).
- **RE-SKINNED** — native page fully functional in the modern app AND re-skinned
  onto CoreUI presentation (SPEC-0009 Phase 14/15).
- **MAPPED** — artifact exists and its CoreUI equivalent is identified; no
  functional page involved (static assets, shell).
- **PARTIAL** — page exists but is model-less (static/placeholder) or
  unstyled; workflow or model pending.
- **BLOCKED** — mapping cannot be established because the business scope is
  unresolved (GAP-004 placeholder areas without an approved spec).
- **NOT_REQUIRED** — legacy-only artifact with no modern UI counterpart.

**Role abbreviations**: AGT=Agent, EMP=Employee, ADM=Admin, SU=SuperUser,
G=Guest (anonymous). Permission = the `AuthorizationPolicies` policy
(verified `src/VisaFusion.Api/Authorization/AuthorizationPolicies.cs`).

---

## 1. Navigation Group: Public Site (Guest)

| Role | Permission | Navigation group | Menu | Submenu | Route | Native page | Feature | Existing component | CoreUI equivalent | Proposed reusable VisaFusion component | Specification | Test | Status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| G | anonymous | Public | Home | — | `/Public/Index` | `Areas/Public/Pages/Index.cshtml` | Public landing (MOD-007) | plain HTML (no `vf-*`) | `views/index.pug` dashboard pattern; Cards `COMPONENT_CATALOG §3.1` | `PublicLanding` | SPEC-0007 | AreaTests, Phase0E2ETests | IMPLEMENTED — _PublicLanding component (T086) |
| G | anonymous | Public | Visa Info | — | `/Public/VisaInfo` | `Areas/Public/Pages/VisaInfo.cshtml` | Visa information | bare HTML (no CSS classes) | Cards §3.1, Accordion/Collapse §5.2, Icons §8 (`cif-*` flags) | `InfoPage` | SPEC-0007 | AreaTests, Phase0E2ETests | IMPLEMENTED — _InfoPage component (T086) |
| G | anonymous | Public | Embassy | — | `/Public/Embassy` | `Areas/Public/Pages/Embassy.cshtml` | Embassy directory | bare HTML (no CSS classes) | Cards §3.1, Tables §3.2, Icons §8 (`cif-*`) | `InfoPage` | SPEC-0007 | AreaTests, Phase0E2ETests | IMPLEMENTED — _InfoPage component (T086) |
| G | anonymous | Public | Country Info | — | `/Public/CountryInfo` | `Areas/Public/Pages/CountryInfo.cshtml` | Country information | bare HTML (no CSS classes) | Cards §3.1, Chip §5.4 | `InfoPage` | SPEC-0007 | AreaTests, Phase0E2ETests | IMPLEMENTED — _InfoPage component (T086) |
| G | anonymous | Public | Daily Update | — | `/Public/DailyUpdate` | `Areas/Public/Pages/DailyUpdate.cshtml` | 30-day daily update (legacy `viewdailyupdate.asp`) | `vf-content`, `vf-card`, `vf-table` | Cards §3.1, Tables §3.2, Pagination §2.3, Badges §3.6 | `DataTable` | SPEC-0008 (content) | ContentCmsTests, ContentUpdateCrudTests | IMPLEMENTED — has page model |
| G | anonymous | Public | Queries | — | `/Public/Queries` | `Areas/Public/Pages/Queries.cshtml` | Public query form → `/api/v1/public/queries` (rate-limited 5/hr/IP) | plain HTML (no `vf-*`) | Form Control §6.1, Input Group §6.2, Select §6.4, Validation §6.5, Buttons §5.1, Alerts §3.5 | `PublicQueryForm` | SPEC-0007 | QueriesEndpointTests, QueriesValidationTests, QueriesPersistenceTests, RateLimitTests | PARTIAL — static page, posts to verified API |
| G | anonymous | Public | Contact | — | `/Public/Contact` | `Areas/Public/Pages/Contact.cshtml` | Contact (legacy `contact.asp`, MOD-007) | bare HTML (no CSS classes) | Form Control §6.1, Validation §6.5, Buttons §5.1 | `InfoPage` | SPEC-0007 | AreaTests, Phase0E2ETests | IMPLEMENTED — _InfoPage component (T086) |
| G | anonymous | Public | Subscribe | — | `/Public/Subscribe` | `Areas/Public/Pages/Subscribe.cshtml` | Newsletter subscription | plain HTML (Bootstrap form classes) | Form Control §6.1, Input Group §6.2, Buttons §5.1 | `FormCard` | SPEC-0007 | AreaTests, Phase0E2ETests | IMPLEMENTED — _FormCard component (T086) |
| G | anonymous | Public | Register | — | `/Public/Register` | `Areas/Public/Pages/Register.cshtml` | Public register (legacy `register.asp`, MOD-007) | plain HTML (no `vf-*`) | `authentication/register.pug` (INVENTORY §10) | `FormCard` | SPEC-0007 | AreaTests, Phase0E2ETests | IMPLEMENTED — _FormCard component (T086) |
| — | — | — | — | — | no route | `Areas/Public/Pages.Forms.cshtml` (stray, outside `Pages/`) | orphan artifact | plain HTML | — | — | — | — | NOT_REQUIRED — dead file; **GAP-010** |
| G | anonymous | Home | Home | — | `/` | `Pages/Index.cshtml` | Welcome/landing (SPEC-0003 FR-002 host) | `PublicLanding` component | `views/blank.pug` scaffold (INVENTORY §10) | `PublicLanding` | SPEC-0003 | AreaTests, Phase0E2ETests | RE-SKINNED (T032) |

## 2. Navigation Group: Auth / Account (all roles)

| Role | Permission | Navigation group | Menu | Submenu | Route | Native page | Feature | Existing component | CoreUI equivalent | Proposed reusable VisaFusion component | Specification | Test | Status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| G | anonymous | Account | Login | — | `/Auth/Login` | `Pages/Auth/Login.cshtml` | Cookie+JWT login (legacy `authenticate.asp`/`logon.asp` redirect target) | plain HTML form (verified `Login.cshtml`: label+input+button, no `vf-*`) | `authentication/login.pug` (INVENTORY §10) — centered card, show-password tooltip, remember-me | `AuthCard` | SPEC-0005 (TS-001) | AuthLoginTests, WebLoginPageTests | IMPLEMENTED |
| G | anonymous | Account | Register | — | `/Auth/Register` | `Pages/Auth/Register.cshtml` | Guest registration (legacy `regsub*.asp` redirect target) | plain HTML form | `authentication/register.pug` (INVENTORY §10) | `AuthCard` | SPEC-0005 (TS-005) | RegisterPageTests, RegistrationEscalationTests | IMPLEMENTED |
| AGT/EMP/ADM/SU | `[Authorize]` (any authenticated) | Account | Change password | — | `/Auth/ChangePassword` | `Pages/Auth/ChangePassword.cshtml` | Change password (legacy `changepassword.asp` flag 2/3 parity) | plain HTML form | `authentication/change-password.pug` (INVENTORY §10) | `AuthCard` | SPEC-0005 (TS-012, TS-014) | ChangePasswordTests, ChangePasswordPageTests | IMPLEMENTED |
| G | anonymous | Account | — (error state) | — | `/Auth/AccessDenied` | `Pages/Auth/AccessDenied.cshtml` | 403 access-denied surface | plain HTML | Error-page pattern (`error-pages/404/500.pug`, INVENTORY §10) | `ErrorPage` | SPEC-0005 | AccessDeniedPageTests | IMPLEMENTED |
| — | — | Auth | Home | — | `/Auth/Index` | `Areas/Auth/Pages/Index.cshtml` | Auth-area placeholder (no model; SPEC-0003 FR-005) | plain HTML (`h1`+`p`, no `vf-*`) | `views/blank.pug` scaffold (INVENTORY §10) | — | SPEC-0003 | AreaTests | PARTIAL — placeholder, no page model |

## 3. Navigation Group: Agent Portal (AGT/EMP/ADM/SU) — `AgentSelf`

| Role | Permission | Navigation group | Menu | Submenu | Route | Native page | Feature | Existing component | CoreUI equivalent | Proposed reusable VisaFusion component | Specification | Test | Status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| AGT/EMP/ADM/SU | `AgentSelf` (via `AgentPortalPageModel`) | Agent Portal | Dashboard | — | `/Agent/Index` | `Areas/Agent/Pages/Index.cshtml` | Agent landing (legacy `agentHome.asp`) | `RoleDashboard` component | `views/index.pug` KPI cards §3.1, Progress §3.4, Charts §7.1 | `RoleDashboard` | SPEC-0005 FR-003/FR-004 | AgentPortalRbacTests, AgentPortalIntegrationTests, AgentPagesTests, AgentScopingTests, AgentLifecycleTests, AgentRbacTests | RE-SKINNED (T033/T036) |
| AGT/EMP/ADM/SU | `AgentSelf` | Agent Portal | My Entries | — | `/Agent/Entries` | `Areas/Agent/Pages/Entries.cshtml` | Own-entry list (legacy `listforagents.asp`, MOD-001; scoped to own AgentId) | `vf-content`, `vf-alert`, `vf-card`, `vf-form-group/label/control`, `vf-btn vf-btn-primary/secondary`, `vf-table` | Tables §3.2, Pagination §2.3, Badges §3.6, Dropdowns §2.2, Search Button §2.4 | `DataTable` | SPEC-0005 TS-003 + SPEC-0006 FR-008 | EntriesRbacTests, BackdoorAndIsolationTests, AgentPortalIntegrationTests | IMPLEMENTED |
| AGT/EMP/ADM/SU | `AgentSelf` | Agent Portal | Statuses | — | `/Agent/Statuses` | `Areas/Agent/Pages/Statuses.cshtml` | Passenger/entry status (PaxStatus/bighistory lineage) | `vf-content`, `vf-alert`, `vf-card`, `vf-form-group/label/control`, `vf-btn`, `vf-table` | Tabs §2.1, Badges §3.6, Cards §3.1 | `DataTable` | SPEC-0006 FR-005 | StatusChangeTests, StatusChangeIntegrationTests | IMPLEMENTED |
| AGT/EMP/ADM/SU | `AgentSelf` | Agent Portal | Statement | — | `/Agent/Statement` | `Areas/Agent/Pages/Statement.cshtml` | Invoice/ledger statement (legacy `agentStatement*`; FR-001 `invoice` lineage) | `vf-content`, `vf-alert`, `vf-card`, `vf-table`, `vf-numeric` | Tables §3.2, Pagination §2.3, Dropdowns §2.2, Charts §7.1 | `DataTable` | FR-001 (invoice lineage) | ReportSchemaTests, ReportParameterizedSqlTests | IMPLEMENTED |
| AGT/EMP/ADM/SU | `AgentSelf` | Agent Portal | Account | — | `/Agent/Account` | `Areas/Agent/Pages/Account.cshtml` | Agent profile (legacy `AgentAccount.asp`/`editdonebyagent1.asp`) | `vf-content`, `vf-alert vf-alert-danger/success`, `vf-card`, `vf-form-group/label/control` | Form Control §6.1, Form Layout §6.6, Validation §6.5, Buttons §5.1 | `FormCard` | SPEC-0005 FR-003 | AgentPagesTests, AgentRbacTests | IMPLEMENTED |

## 4. Navigation Group: Reporting (EMP/ADM/SU) — `EntryOperations`

| Role | Permission | Navigation group | Menu | Submenu | Route | Native page | Feature | Existing component | CoreUI equivalent | Proposed reusable VisaFusion component | Specification | Test | Status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| EMP/ADM/SU | `EntryOperations` (via `ReportingPageModel`) | Reporting | Dashboard | — | `/Reporting/Index` | `Areas/Reporting/Pages/Index.cshtml` | Reporting landing (MOD-005) | `RoleDashboard` component | `views/index.pug` + `views/widgets.pug`; Cards §3.1, Charts §7.1 | `RoleDashboard` | SPEC-0008 (reporting) | ReportEndpointTests, ReportSchemaTests, ReportParameterizedSqlTests | RE-SKINNED (T034/T037) |
| EMP/ADM/SU | `EntryOperations` | Reporting | Pending | — | `/Reporting/Pending` | `Areas/Reporting/Pages/Pending.cshtml` | Pending list (legacy `pendinglist.asp`) | `vf-content`, `vf-btn vf-btn-primary`, `vf-alert vf-alert-danger`, `vf-table` | Tables §3.2, Pagination §2.3, Badges §3.6 | `DataTable` | SPEC-0008 (reporting) | ReportEndpointTests, ReportSchemaTests | IMPLEMENTED |
| EMP/ADM/SU | `EntryOperations` | Reporting | Today | Submission | `/Reporting/TodaySubmission` | `Areas/Reporting/Pages/TodaySubmission.cshtml` | Today's submissions (legacy `todaySubmission*.asp`) | `vf-content`, `vf-btn vf-btn-primary`, `vf-alert vf-alert-danger`, `vf-table` | Tables §3.2, Cards §3.1, Badges §3.6 | `DataTable` | SPEC-0008 (reporting) | ReportEndpointTests, ReportSchemaTests | IMPLEMENTED |
| EMP/ADM/SU | `EntryOperations` | Reporting | Today | Collection | `/Reporting/TodayCollection` | `Areas/Reporting/Pages/TodayCollection.cshtml` | Today's collections (legacy `todayCollection*.asp`) | `vf-content`, `vf-btn vf-btn-primary`, `vf-alert vf-alert-danger`, `vf-table` | Tables §3.2, Cards §3.1, Badges §3.6 | `DataTable` | SPEC-0008 (reporting) | ReportEndpointTests, ReportSchemaTests | IMPLEMENTED |
| EMP/ADM/SU | `EntryOperations` | Reporting | Today | Transaction | `/Reporting/TodayTransaction` | `Areas/Reporting/Pages/TodayTransaction.cshtml` | Today's transactions (legacy `todayTransaction.asp`) | `vf-content`, `vf-btn vf-btn-primary`, `vf-alert vf-alert-danger`, `vf-table` | Tables §3.2, Cards §3.1, Badges §3.6 | `DataTable` | SPEC-0008 (reporting) | ReportEndpointTests, ReportSchemaTests | IMPLEMENTED |
| EMP/ADM/SU | `EntryOperations` | Reporting | Daily | Visa Fee | `/Reporting/DailyVisaFee` | `Areas/Reporting/Pages/DailyVisaFee.cshtml` | Daily visa fee (legacy `dailyVisaFee.asp`) | `vf-content`, `vf-btn vf-btn-primary`, `vf-alert vf-alert-danger`, `vf-table` | Tables §3.2, Cards §3.1, Charts §7.1 | `DataTable` | SPEC-0008 (reporting) | ReportEndpointTests, ReportSchemaTests | IMPLEMENTED |
| EMP/ADM/SU | `EntryOperations` | Reporting | Daily | Bill | `/Reporting/DailyBill` | `Areas/Reporting/Pages/DailyBill.cshtml` | Daily bill (legacy `dailybill.asp`) | `vf-content`, `vf-btn vf-btn-primary`, `vf-alert vf-alert-danger`, `vf-table` | Tables §3.2, Cards §3.1, Charts §7.1 | `DataTable` | SPEC-0008 (reporting) | ReportEndpointTests, ReportSchemaTests | IMPLEMENTED |

## 5. Navigation Group: Admin (ADM/SU unless noted)

| Role | Permission | Navigation group | Menu | Submenu | Route | Native page | Feature | Existing component | CoreUI equivalent | Proposed reusable VisaFusion component | Specification | Test | Status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| ADM/SU | `AdminPanel` | Admin | Dashboard | — | `/Admin/Index` | `Areas/Admin/Pages/Index.cshtml` | Admin landing (no model) | `RoleDashboard` component | `views/index.pug`; Cards §3.1, Progress §3.4 | `RoleDashboard` | — | AreaTests | RE-SKINNED (T035/T038) |
| ADM/SU | `AdminPanel` | Admin | Agents | List | `/Admin/Agents/List` | `Areas/Admin/Pages/Agents/List.cshtml` | Agent list (legacy `viewagent.asp`/`topAgent.asp`, MOD-002) | `vf-content`, `vf-card`, `vf-form-group/label/control`, `vf-btn`, `vf-table`, `vf-badge vf-badge-success/danger` | Tables §3.2, Pagination §2.3, Search Button §2.4, Dropdowns §2.2, Badges §3.6 | `DataTable` | SPEC-0007 (admin agents) | AgentPagesTests, AgentCrudIntegrationTests, AgentPortalRbacTests, AgentScopingTests | IMPLEMENTED |
| ADM/SU | `AdminPanel` | Admin | Agents | Create | `/Admin/Agents/Create` | `Areas/Admin/Pages/Agents/Create.cshtml` | Agent create (legacy `addnewagents.asp`/`newagent.asp`) | `vf-content`, `vf-card`, `vf-form-group/label/control`, `vf-btn` | Form Control §6.1, Form Layout §6.6, Select §6.4, Validation §6.5 | `FormCard` | SPEC-0007 (admin agents) | AgentPagesTests, AgentCrudIntegrationTests | IMPLEMENTED |
| ADM/SU | `AdminPanel` | Admin | Agents | Detail | `/Admin/Agents/Detail` | `Areas/Admin/Pages/Agents/Detail.cshtml` | Agent detail (legacy `viewagent.asp`) | `vf-content`, `vf-card`, `vf-table` | Cards §3.1, Tables §3.2, Avatar §1.5 | `DataTable` | SPEC-0007 (admin agents) | AgentPagesTests, AgentCrudIntegrationTests | IMPLEMENTED |
| ADM/SU | `AdminPanel` | Admin | Agents | Edit | `/Admin/Agents/Edit` | `Areas/Admin/Pages/Agents/Edit.cshtml` | Agent edit (legacy `editdoneagent1.asp`) | `vf-content`, `vf-card`, `vf-form-group/label/control`, `vf-btn` | Form Control §6.1, Form Layout §6.6, Select §6.4, Validation §6.5 | `FormCard` | SPEC-0007 (admin agents) | AgentPagesTests, AgentCrudIntegrationTests | IMPLEMENTED |
| ADM/EMP | `UserManagement` | Admin | Users | List | `/Admin/Users/List` | `Areas/Admin/Pages/Users/List.cshtml` | User list (legacy `addNewUser.asp`/`deleteUser.asp`/`editdonetest.asp`) | `vf-content`, `vf-alert vf-alert-success/danger`, `vf-btn`, `vf-card`, `vf-table`, `vf-badge` | Tables §3.2, Pagination §2.3, Avatar §1.5, Badges §3.6 | `DataTable` | SPEC-0005 FR-017 | UserPagesTests, AdminUserManagementTests, UserManagementTests, UserManagementIntegrationTests | IMPLEMENTED |
| ADM/EMP | `UserManagement` | Admin | Users | Create | `/Admin/Users/Create` | `Areas/Admin/Pages/Users/Create.cshtml` | User provisioning | `vf-content`, `vf-card`, `vf-form-group/label/control`, `vf-form-control` (select), `vf-btn` | Form Control §6.1, Form Layout §6.6, Select §6.4, Checks/Radios/Switches §6.3, Validation §6.5 | `FormCard` | SPEC-0005 FR-017 | UserPagesTests, AdminUserManagementTests, UserManagementTests | IMPLEMENTED |
| ADM/SU | `HolidayAdmin` | Admin | Holidays | — | `/Admin/Holidays/Index` | `Areas/Admin/Pages/Holidays/Index.cshtml` | Holiday/weekly-off CRUD (legacy `holiday_entry.asp`/`holidayDeleteSubmit.asp`/`WeeklyOffList.asp`; bookable-date rule) | `vf-content`, `vf-alert`, `vf-card`, `vf-btn`, `vf-table` | Tables §3.2, Modals §4.1 (confirm delete), Form Control §6.1, Validation §6.5 | `DataTable` + `ConfirmModal` | SPEC-0006 FR-006 | HolidayServiceTests, HolidayCrudParityTests, HolidayCrudEndpointTests, EmbassyClosedTests | IMPLEMENTED |
| ADM/SU | `AdminPanel` | Admin | Content Update | — | `/Admin/ContentUpdate/Index` | `Areas/Admin/Pages/ContentUpdate/Index.cshtml` | Daily update content (legacy `dailyupdate.asp`) | `vf-content`, `vf-alert vf-alert-success/danger`, `vf-card`, `vf-btn`, `vf-table` | Form Control §6.1, Form Layout §6.6, Validation §6.5, Toasts §4.2 | `FormCard` | SPEC-0008 (content) | ContentCmsTests, ContentUpdateCrudTests | IMPLEMENTED |
| ADM/SU | `SecurityGate` | Admin | Security Day | — | `/Admin/SecurityDay/Index` | `Areas/Admin/Pages/SecurityDay/Index.cshtml` | Open/close day (legacy `securityHome.asp`/`openForDay.asp`/`closeForDay.asp`; day-gate `rsn=` states) | `vf-content`, `vf-alert`, `vf-card`, `vf-btn vf-btn-primary` | Cards §3.1 (state), Buttons §5.1, Alerts §3.5, Badges §3.6 | `RoleDashboard` | SPEC-0005 FR-010/FR-016/FR-018 | SecurityDayPagesTests, SecurityDayTests, SecurityDayIntegrationTests, SecurityGateServiceTests, SecurityGateIntegrationTests, WebLoginPageTests | IMPLEMENTED |

## 6. Navigation Group: Employee / Billing / Notifications (placeholder areas, GAP-004)

| Role | Permission | Navigation group | Menu | Submenu | Route | Native page | Feature | Existing component | CoreUI equivalent | Proposed reusable VisaFusion component | Specification | Test | Status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| EMP/ADM/SU | (none — placeholder) | Employee | Home | — | `/Employee/Index` | `Areas/Employee/Pages/Index.cshtml` | None defined (no model) | plain HTML | `views/blank.pug` scaffold | — | — | AreaTests | BLOCKED — no page model, no spec, no policy; **GAP-004** |
| EMP/ADM/SU | (none — placeholder; `BillingOperations` reserved) | Billing | Home | — | `/Billing/Index` | `Areas/Billing/Pages/Index.cshtml` | Legacy billing (MOD-003 `invoice.asp`); no approved spec | plain HTML | `views/blank.pug`; would be Tables §3.2 + Cards §3.1 once scoped | — | — | AreaTests | BLOCKED — placeholder; **GAP-004** |
| ADM/SU | (none — placeholder) | Notifications | Home | — | `/Notifications/Index` | `Areas/Notifications/Pages/Index.cshtml` | Notifications (MOD-004 `SendSMS.asp`; SPEC-0008 notifications-api; dispatch log-only, GAP-008) | `_InfoPage` component (T078) | `views/blank.pug`; would use Toasts §4.2 + Badges §3.6 once scoped | `ToastHost` (not implemented) | SPEC-0008 (notifications) | NotificationsEndpointTests, AreaTests | PARTIAL — re-skinned with `_InfoPage`; API exists, no page model |

## 7. Cross-cutting artifacts

| Role | Permission | Navigation group | Menu | Submenu | Route | Native page | Feature | Existing component | CoreUI equivalent | Proposed reusable VisaFusion component | Specification | Test | Status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| all | role-aware shell | — | — | — | all pages | `Pages/Shared/_Layout.cshtml` | Dual shell: sidebar (authenticated) / top-nav (anonymous) | `vf-shell`, `vf-main`, `vf-content`, `vf-skip-link` (structural) | CoreUI Sidebar §1.1, Header §1.2, Footer §1.3, Breadcrumb §1.4 | `RoleAwareNavigation` (centralized, per addendum §5/§6) | — | AreaTests, Phase0E2ETests, CoreUIShellTests, CoreUIVisualTests | IMPLEMENTED — CoreUI shell (re-skin complete 2026-08-20, ADR-0006) |
| — | — | — | — | — | static | `wwwroot/css/tokens.css` | design tokens | `--vf-*` custom properties | CoreUI `--cui-*` tokens (DESIGN_SYSTEM §2) | `DesignTokens` | — | — | RESOLVED — deleted (T077); `--cui-*` tokens now in `wwwroot/css/vf-component-styles.css` |
| — | — | — | — | — | static | `wwwroot/css/theme.css` | bespoke component styles (49 verified `vf-*` classes) | `vf-btn`, `vf-form-*`, `vf-alert`, `vf-card`, `vf-table`, `vf-badge`, `vf-list`, `vf-numeric` | Buttons §5.1, Forms §6.x, Alerts §3.5, Cards §3.1, Tables §3.2, Badges §3.6, List Group §3.3 | `ComponentStyles` | — | — | RESOLVED — deleted (T077); classes mapped to CoreUI equivalents (re-skin T078) |
| — | — | — | — | — | static | `wwwroot/icons/cil/free-symbol-defs.svg` | icon source | CoreUI `cui-*`/`cif-*` SVGs | CoreUI Icons §8 (`cui-*` SVGs via `free-symbol-defs.svg`) | `IconSet` | — | — | IMPLEMENTED (T053: bootstrap-icons.css removed; icons rendered via `<use href>` pattern) |
| — | — | — | — | — | static | `wwwroot/updateimg/**` (legacy) | legacy images served for parity | — | No CoreUI equivalent — legacy asset | — | — | Phase0E2ETests (200) | NOT_REQUIRED |

## 8. Unmapped items → GAP_REPORT.md

- **GAP-002** — CoreUI adoption vs bespoke `vf-*` shell: gates every MAPPED row
  and the cross-cutting re-skin. Owner decision required. **RESOLVED 2026-08-20**
  — ADR-0006 ratifies CoreUI as the design reference; the re-skin is complete
  (SPEC-0009 T076–T085).
- **GAP-004** — Employee/Billing/Notifications placeholder areas: BLOCKED rows
  in §6; no page models, no approved specs.
- **GAP-010** — stray `Areas/Public/Pages.Forms.cshtml`: NOT_REQUIRED row in §1;
  disposition pending owner (delete or move into `Pages/` with a model).

## 9. Provenance

All rows verified 2026-08-19 by tool call: `glob` (41 pages, 26 page models),
`grep` (`@page` routes; `[Authorize` policies; `SidebarNav|UseSidebar` 45
matches / 21 sidebar pages; `vf-*` per-page usage in Reporting, Agent, Admin
Users/Agents/Holidays/SecurityDay/ContentUpdate, Public DailyUpdate),
`read` (`AuthorizationPolicies.cs` RoleSets, `_Layout.cshtml`, `Login.cshtml`,
`Index.cshtml`, traceability-matrix, CoreUI docs, GAP_REPORT). Nothing asserted
from memory; `UNKNOWN` is not used.

## 10. Phase 10 — Reusable Component Library (SPEC-0009)

Implemented 2026-08-20. The 14 canonical VisaFusion components now exist as
reusable partials/models in `src/VisaFusion.Web/Components/` layered on CoreUI
classes and the `--cui-*` design tokens. Page re-skinning onto these components
(Phases 11–21 per SPEC-0009 plan.md) is **complete** (T078, 2026-08-20).

| Component | Artifact(s) | CoreUI equivalent | Status |
|---|---|---|---|
| `RoleAwareNavigation` | `Services/RoleAwareNavigation.cs` (T016) | Sidebar §1.1, Header §1.2 | IMPLEMENTED |
| `RoleDashboard` | `_RoleDashboard.cshtml` + `RoleDashboardModel.cs` | Cards §3.1, Progress §3.4, Charts §7.1, Tables §3.2 | IMPLEMENTED |
| `DataTable` | `_DataTable.cshtml` + `DataTableModel.cs` | Tables §3.2, Pagination §2.3, Badges §3.6, Dropdowns §2.2 | IMPLEMENTED |
| `FormCard` | `_FormCard.cshtml` + `FormCardModel.cs` | Cards §3.1, Forms §6.x, Validation §6.5 | IMPLEMENTED |
| `AuthCard` | `_AuthCard.cshtml` + `AuthCardModel.cs` | Cards §3.1, Forms §6.x, Validation §6.5 | IMPLEMENTED |
| `ErrorPage` | `_ErrorPage.cshtml` + `ErrorPageModel.cs` | Cards §3.1, Buttons §5.1 | IMPLEMENTED |
| `InfoPage` | `_InfoPage.cshtml` + `InfoPageModel.cs` | Cards §3.1, Accordion §5.2, Tables §3.2 | IMPLEMENTED |
| `PublicLanding` | `_PublicLanding.cshtml` + `PublicLandingModel.cs` | Cards §3.1, Progress §3.4, Buttons §5.1 | IMPLEMENTED |
| `PublicQueryForm` | `_PublicQueryForm.cshtml` + `PublicQueryFormModel.cs` | Cards §3.1, Forms §6.x, Validation §6.5 | IMPLEMENTED |
| `ConfirmModal` | `_ConfirmModal.cshtml` + `ConfirmModalModel.cs` | Modals §4.1, Buttons §5.1 | IMPLEMENTED |
| `ToastHost` | `_ToastHost.cshtml` + `ToastHostModel.cs` | Toasts §4.2, Buttons §5.1 | IMPLEMENTED |
| `DesignTokens` | `wwwroot/css/vf-coreui.css` (T005) | `--cui-*` tokens (DESIGN_SYSTEM §2) | IMPLEMENTED |
| `ComponentStyles` | `wwwroot/css/vf-component-styles.css` (T025) | token-only component styles | IMPLEMENTED |
| `IconSet` | `wwwroot/icons/**` (T002) | CoreUI Icons §8 (`cil-*`/`cif-*`) | IMPLEMENTED |

**Evaluate-list disposition (user directive, 2026-08-20)**: buttons, cards,
alerts, badges, forms, inputs, input groups, select, checkbox, radio, switch,
tables, pagination, modal, dropdown, accordion, progress, toast — covered by the
14 canonical components above. Tabs, offcanvas, spinner, tooltip — **NOT
required** by any existing VisaFusion page (T006b tooltip audit: 0 matches);
breadcrumb → `_Breadcrumb.cshtml` (Phase 8), page header → `_PageHeader.cshtml`
(Phase 3), empty state → DataTable empty-message row, validation state →
`.is-invalid`/`.invalid-feedback` in FormCard/AuthCard/PublicQueryForm.

**Tests**: `tests/IntegrationTests/CoreUIComponentTests.cs` (TS-009) — 14
checks: all 10 partials + models exist, no duplicate partial names repo-wide,
component stylesheet is token-only, each partial renders its wrapper class.
KG: `PARTIAL-*` nodes + `VFC-* → PARTIAL-* implements`, `PARTIAL-* → CUI-* uses`,
`PARTIAL-* → TEST-CoreUIComponent tested_by` edges added 2026-08-20.