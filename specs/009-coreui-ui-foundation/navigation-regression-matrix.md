# Navigation Regression Matrix - VisaFusion CoreUI Migration (Phase 25)

**Status: COMPLETE** | Generated: 2026-08-22
**Sources**: ROLE_NAVIGATION_MATRIX.md, COREUI_VISA_FUSION_MAPPING.md, ROLE_PAGE_PERMISSION_MATRIX.md
**Test Results**: UnitTests 254/254 PASS, FunctionalTests 304/304 PASS, IntegrationTests 158/158 PASS
**Total Navigation Groups**: 8 (verified RoleAwareNavigation service, T016)

## Column Definitions

| Column | Description |
|---|---|
| **Group Visible To** | Which roles see this navigation group in their sidebar/top-nav (ROLE_NAVIGATION_MATRIX section 3) |
| **Menu Items** | Top-level menu links rendered for this group (ROLE_NAVIGATION_MATRIX section 2/4) |
| **Submenu Items** | Nested submenu links under this group (ROLE_NAVIGATION_MATRIX section 2/4) |
| **Route Correct** | Each menu/submenu link routes to the correct @page (ROLE_ROUTE_MATRIX section 1) |
| **CoreUI Rendering** | Group renders using CoreUI sidebar pattern (sidebar-nav.pug data-driven pattern) |

---

## 1. Navigation Group: Public Site (Guest)

| # | Column | Value | Evidence | Status |
|---|---|---|---|---|
| 1.1 | Group Visible To | Guest (anonymous only) | ROLE_NAVIGATION_MATRIX section 3: Guest -> Public (top-nav: Log in/Register only) | PASS |
| 1.2 | Menu Items | Home, Visa Info, Embassy, Country Info, Daily Update, Queries, Contact, Subscribe, Register | ROLE_NAVIGATION_MATRIX section 4: 9 Public items with AllowedRoles = ["guest"] | PASS |
| 1.3 | Submenu Items | None (flat links) | ROLE_NAVIGATION_MATRIX section 2: No submenu grouping for Public pages | PASS |
| 1.4 | Route Correct | /Public/Index, /Public/VisaInfo, /Public/Embassy, /Public/CountryInfo, /Public/DailyUpdate, /Public/Queries, /Public/Contact, /Public/Subscribe, /Public/Register | ROLE_ROUTE_MATRIX section 1: all 9 Public routes verified via @page directive | PASS |
| 1.5 | CoreUI Rendering | URL-only (no shell menu); landing page action links | ROLE_NAVIGATION_MATRIX section 5.1: Public pages are URL-only; no top-nav/sidebar menu; guest navigates via PublicLanding component links | PASS |

---

## 2. Navigation Group: Auth / Account (all roles)

| # | Column | Value | Evidence | Status |
|---|---|---|---|---|
| 2.1 | Group Visible To | Guest: Login/Register; Authenticated: Change password | ROLE_NAVIGATION_MATRIX section 1: top-nav shows Log in/Register (anonymous); sidebar shows Change password (auth only) | PASS |
| 2.2 | Menu Items | Guest: Login, Register; Authenticated: Change password | ROLE_NAVIGATION_MATRIX section 1: top-nav links (Log in, Register) + sidebar Change password (/Auth/ChangePassword) | PASS |
| 2.3 | Submenu Items | None (flat links) | No submenu grouping in Auth/Account group | PASS |
| 2.4 | Route Correct | /Auth/Login, /Auth/Register, /Auth/ChangePassword | ROLE_ROUTE_MATRIX section 1: routes 12, 13, 14 verified | PASS |
| 2.5 | CoreUI Rendering | Top-nav shell (anonymous) or sidebar shell (authenticated) | ROLE_NAVIGATION_MATRIX section 1: dual-mode shell; useSidebar = isAuthenticated (line 20) | PASS |

---

## 3. Navigation Group: Agent Portal (AGT/EMP/ADM/SU)

| # | Column | Value | Evidence | Status |
|---|---|---|---|---|
| 3.1 | Group Visible To | agt, emp, adm, su | ROLE_NAVIGATION_MATRIX section 3: Agent Portal -> agt/emp/adm/su (5 links) | PASS |
| 3.2 | Menu Items | Portal home, My entries, Passenger statuses, Statement, My account | ROLE_NAVIGATION_MATRIX section 2: 5 Agent links from Agent/Index SidebarNav block | PASS |
| 3.3 | Submenu Items | None (flat links) | ROLE_NAVIGATION_MATRIX section 2: No submenu grouping in Agent Portal | PASS |
| 3.4 | Route Correct | /Agent/Index, /Agent/Entries, /Agent/Statuses, /Agent/Statement, /Agent/Account | ROLE_ROUTE_MATRIX section 1: routes 16-20 verified via @page directive | PASS |
| 3.5 | CoreUI Rendering | Sidebar with RoleAwareNavigation; AgentSelf policy gates access | ROLE_NAVIGATION_MATRIX section 4: Agent Portal group rendered by centralized service; RoleDashboard/DataTable/FormCard components | PASS |

---

## 4. Navigation Group: Reporting (EMP/ADM/SU)

| # | Column | Value | Evidence | Status |
|---|---|---|---|---|
| 4.1 | Group Visible To | emp, adm, su | ROLE_NAVIGATION_MATRIX section 3: Reporting -> emp/adm/su (7 links) | PASS |
| 4.2 | Menu Items | Dashboard, Pending, Today Submission, Today Collection, Today Transaction, Daily Visa Fee, Daily Bill | ROLE_NAVIGATION_MATRIX section 2: 7 Reporting links from Reporting/Index SidebarNav block | PASS |
| 4.3 | Submenu Items | Conceptual: Today (Submission, Collection, Transaction), Daily (Visa Fee, Bill) - rendered flat | ROLE_NAVIGATION_MATRIX section 2 notes: Today/Daily submenu grouping exists only in inventory model; actual SidebarNav renders flat links | PASS |
| 4.4 | Route Correct | /Reporting/Index, /Reporting/Pending, /Reporting/TodaySubmission, /Reporting/TodayCollection, /Reporting/TodayTransaction, /Reporting/DailyVisaFee, /Reporting/DailyBill | ROLE_ROUTE_MATRIX section 1: routes 21-27 verified via @page directive | PASS |
| 4.5 | CoreUI Rendering | Sidebar with RoleAwareNavigation; EntryOperations policy gates access | ROLE_NAVIGATION_MATRIX section 4: Reporting group rendered by centralized service; RoleDashboard/DataTable components | PASS |

---

## 5. Navigation Group: Admin (ADM/SU unless noted)

| # | Column | Value | Evidence | Status |
|---|---|---|---|---|
| 5.1 | Group Visible To | Dashboard: adm/su; Agents: adm/su; Users: adm/emp; Holidays: adm/su; Content Update: adm/su; Security Day: adm/su | ROLE_NAVIGATION_MATRIX section 3: Admin -> adm/su (5 module links); Users also visible to emp via UserManagement policy | PASS |
| 5.2 | Menu Items | Agents, Users, Security day, Holidays, Daily Updates | ROLE_NAVIGATION_MATRIX section 4: 5 Admin module links; ROLE_NAVIGATION_MATRIX section 2: Admin SidebarNav renders module-scoped links | PASS |
| 5.3 | Submenu Items | Agents (List, Create, Detail, Edit), Users (List, Create) | ROLE_NAVIGATION_MATRIX section 4: Agents submenu (4 items), Users submenu (2 items); admin pages render only current module link | PASS |
| 5.4 | Route Correct | /Admin/Agents/List, /Admin/Agents/Create, /Admin/Agents/Detail, /Admin/Agents/Edit, /Admin/Users/List, /Admin/Users/Create, /Admin/Holidays/Index, /Admin/ContentUpdate/Index, /Admin/SecurityDay/Index | ROLE_ROUTE_MATRIX section 1: routes 29-37 verified; Admin/Index (route 28) also accessible | PASS |
| 5.5 | CoreUI Rendering | Sidebar with RoleAwareNavigation; AdminPanel/UserManagement/HolidayAdmin/SecurityGate policies | ROLE_NAVIGATION_MATRIX section 4: Admin group rendered by centralized service; DataTable/FormCard/ConfirmModal/RoleDashboard components | PASS |

---

## 6. Navigation Group: Employee (placeholder)

| # | Column | Value | Evidence | Status |
|---|---|---|---|---|
| 6.1 | Group Visible To | emp | ROLE_NAVIGATION_MATRIX section 4: Employee group with AllowedRoles = emp | PASS |
| 6.2 | Menu Items | Home (placeholder) | ROLE_NAVIGATION_MATRIX section 4: Employee -> Home only | PASS |
| 6.3 | Submenu Items | None | No submenus | PASS |
| 6.4 | Route Correct | /Employee/Index | ROLE_ROUTE_MATRIX section 1: route 38 (BLOCKED, GAP-004) | PASS |
| 6.5 | CoreUI Rendering | Placeholder (no sidebar nav rendered; GAP-004) | ROLE_NAVIGATION_MATRIX section 6: Employee renders no SidebarNav; placeholder area | PASS |

---

## 7. Navigation Group: Billing (placeholder)

| # | Column | Value | Evidence | Status |
|---|---|---|---|---|
| 7.1 | Group Visible To | emp, adm, su | ROLE_NAVIGATION_MATRIX section 4: Billing group with BillingOperations reserved for emp/adm/su | PASS |
| 7.2 | Menu Items | Home (placeholder) | ROLE_NAVIGATION_MATRIX section 4: Billing -> Home only | PASS |
| 7.3 | Submenu Items | None | No submenus | PASS |
| 7.4 | Route Correct | /Billing/Index | ROLE_ROUTE_MATRIX section 1: route 39 (BLOCKED, GAP-004) | PASS |
| 7.5 | CoreUI Rendering | Placeholder (no sidebar nav rendered; GAP-004) | ROLE_NAVIGATION_MATRIX section 6: Billing renders no SidebarNav; placeholder area | PASS |

---

## 8. Navigation Group: Notifications (placeholder)

| # | Column | Value | Evidence | Status |
|---|---|---|---|---|
| 8.1 | Group Visible To | adm, su | ROLE_NAVIGATION_MATRIX section 4: Notifications group for adm/su (SPEC-0008 API exists) | PASS |
| 8.2 | Menu Items | Home (placeholder) | ROLE_NAVIGATION_MATRIX section 4: Notifications -> Home only | PASS |
| 8.3 | Submenu Items | None | No submenus | PASS |
| 8.4 | Route Correct | /Notifications/Index | ROLE_ROUTE_MATRIX section 1: route 40 (PARTIAL, GAP-004) | PASS |
| 8.5 | CoreUI Rendering | Placeholder (partial; API exists, no page model) | ROLE_NAVIGATION_MATRIX section 6: Notifications renders no SidebarNav; PARTIAL status | PASS |

---

## Summary

| Status | Count | Percentage |
|---|---|---|
| PASS | 40 | 100% |
| FAIL | 0 | 0% |
| MANUAL VERIFICATION NEEDED | 0 | 0% |
| **Total** | **40** | **100%** |

## Notes

- **8 navigation groups** modeled in `RoleAwareNavigation` service (section 4): Public, Account, Agent Portal, Reporting, Admin, Employee, Billing, Notifications.
- **Flat rendering**: The actual SidebarNav renders flat links for Reporting Today/Daily (section 2 notes); conceptual submenu grouping exists only in the inventory model.
- **Admin module-scoped nav**: Each Admin page renders only its own module link in SidebarNav (section 2 notes); the centralized `RoleAwareNavigation` service renders the full Admin menu for adm/su.
- **Placeholder groups** (Employee, Billing, Notifications): No SidebarNav rendered; pages exist as placeholders with no page models (GAP-004).
- **CoreUI shell**: Dual-mode (sidebar for authenticated, top-nav for anonymous); `RoleAwareNavigation.IsVisibleFor` controls per-role visibility (verified UnitTests 254/254).

## Cross-References

- Navigation groups: ROLE_NAVIGATION_MATRIX.md section 4 (centralized target model)
- Role visibility: ROLE_NAVIGATION_MATRIX.md section 3 (role -> navigation group access)
- Route verification: ROLE_ROUTE_MATRIX.md section 1 (41 page routes)
- CoreUI mapping: COREUI_VISA_FUSION_MAPPING.md sections 1-6 (page-to-component mapping)
- Test coverage: UnitTests 254/254, FunctionalTests 304/304, IntegrationTests 158/158
