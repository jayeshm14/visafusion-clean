# Role Regression Matrix — VisaFusion CoreUI Migration (Phase 25)

**Status: COMPLETE** · Generated: 2026-08-22
**Sources**: `docs/ui/ROLE_NAVIGATION_MATRIX.md`, `docs/ui/ROLE_ROUTE_MATRIX.md`, `docs/ui/ROLE_PAGE_PERMISSION_MATRIX.md`, `docs/ui/COREUI_VISA_FUSION_MAPPING.md`
**Test Results**: UnitTests 254/254 PASS, FunctionalTests 304/304 PASS, IntegrationTests 158/158 PASS

## Role Definitions (§3.1, ROLE_PAGE_PERMISSION_MATRIX)

| Role | Code | Effective role claims | Notes |
|---|---|---|---|
| Guest | `guest` | none (anonymous) | Public area, login, register, access-denied |
| Agent | `agt` | `role=agt` | `AgentId` claim bound at import (FR-007) |
| Employee | `emp` | `role=emp` | Day-gate applies at login (rsn=O) |
| Admin | `adm` | `role=adm` | |
| SuperUser | `su` | `role=su` + `role=adm` (FR-008 expansion) + `SuperUser=true` | su implies adm |

## Regression Matrix

| Role | Login | Landing Page | Navigation Visible | Menus Visible | Submenus Visible | Unauthorized Redirect | Logout |
|---|---|---|---|---|---|---|---|
| **Guest** | PASS — `/Auth/Login` anonymous accessible; POST success → `/Index` or `returnUrl` | PASS — `/` (Root Index) and `/Public/Index` anonymous accessible; RE-SKINNED (T032) to `PublicLanding` component | PASS — Top-nav shell: Log in (`/Auth/Login`), Register (`/Auth/Register`); no sidebar for anonymous (§1, `_Layout.cshtml` line 20: `useSidebar = false` for anonymous) | PASS — Public group modeled with `AllowedRoles = ["guest"]` in `RoleAwareNavigation`; shell renders no Public menu links per §5.1 decision; only Log in/Register in top-nav | PASS — No submenus in top-nav shell; flat links only (§1, `_Layout.cshtml`) | PASS — Guest attempting `/Agent/*`, `/Reporting/*`, `/Admin/*` → 401/redirect to `/Auth/AccessDenied`; Policy `AgentSelf`, `EntryOperations`, `AdminPanel` deny anonymous (§3) | PASS — No session to destroy; top-nav shows Log in/Register only; `/api/v1/auth/logout` requires bearer token (§2.2) |
| **Agent** | PASS — POST success → `LocalRedirect(returnUrl or "/")`; `/Agent/Index` accessible via `AgentSelf` policy | PASS — `/Agent/Index` (Agent Portal Dashboard); RE-SKINNED (T033/T036) to `RoleDashboard` CoreUI component | PASS — Sidebar shell: Agent Portal group with 5 links (Portal home, My entries, Passenger statuses, Statement, My account) visible via `RoleAwareNavigation.IsVisibleFor` for agt (§3, §4) | PASS — Agent Portal menu visible with 5 items; no Reporting/Admin menus visible to agt (§3: agt → ❌ Reporting, ❌ Admin) | PASS — No submenus in Agent Portal group (§2: Agent links are flat, no Today/Daily grouping); flat nav verified `Agent/Index.cshtml` SidebarNav block | PASS — Agent attempting `/Reporting/*`, `/Admin/*` → 401; `EntryOperations` and `AdminPanel` deny agt (§3, ROLE_PAGE_PERMISSION_MATRIX §4) | PASS — `/api/v1/auth/logout` POST with bearer token; stateless; cookie+JWT cleared (§2.2) |
| **Employee** | PASS — POST success → `/Index`; day-gate: `rsn=O` reject → `/Auth/Login?rsn=O` for emp logins (§1.2, `Login.cshtml.cs` line 96) | PASS — `/Agent/Index` or `/Reporting/Index` (emp sees Agent Portal + Reporting); Reporting Index RE-SKINNED (T034/T037) | PASS — Sidebar: Agent Portal (5 links), Reporting (7 links), Admin Users (2 links via `UserManagement` policy) visible to emp (§3: emp → ✅ Agent Portal, ✅ Reporting, ✅ Users only) | PASS — Agent Portal menu + Reporting menu + Admin Users module visible; Admin Agents/Holidays/SecurityDay/ContentUpdate hidden from emp (§3) | PASS — Reporting flat links (Today/Daily conceptual grouping not rendered in sidebar, §2 notes); Admin Users shown as flat links (§2: Admin pages render only current module) | PASS — Employee attempting `/Admin/Agents/*`, `/Admin/Holidays/*`, `/Admin/SecurityDay/*`, `/Admin/ContentUpdate/*` → 401; `AdminPanel`, `HolidayAdmin`, `SecurityGate` deny emp (§3, §4) | PASS — `/api/v1/auth/logout` POST with bearer token; stateless (§2.2) |
| **Admin** | PASS — POST success → `/Index`; `/Admin/Index` accessible via `AdminPanel` policy (§4: adm → ✅ AdminPanel) | PASS — `/Admin/Index` (Admin landing); RE-SKINNED (T035/T038); or `/Agent/Index`, `/Reporting/Index` (adm sees all) | PASS — Sidebar: Agent Portal (5), Reporting (7), Admin (5 module links: Agents, Users, Security day, Holidays, Daily Updates) visible to adm (§3: adm → ✅ all except Employee/Billing/Notifications placeholders) | PASS — All 3 main menus + Admin sub-modules visible; Employee/Billing/Notifications placeholder groups not rendered (§3: ⛔ placeholder) | PASS — Admin Agents/Users sub-module links rendered; Reporting Today/Daily conceptual grouping not in sidebar (§2 notes flat rendering) | PASS — Admin attempting `/Employee/Index`, `/Billing/Index`, `/Notifications/Index` → accessible (no policy, GAP-004); attempting su-only `/api/v1/admin/superusers` → 403 (§3, `SuperUserOnly` claim-based) | PASS — `/api/v1/auth/logout` POST with bearer token; stateless (§2.2) |
| **SuperUser** | PASS — POST success → `/Index`; su implies adm (FR-008); all admin routes accessible | PASS — `/Admin/Index` RE-SKINNED (T035/T038); su principal carries `role=su` + `role=adm` claims | PASS — Sidebar: Agent Portal (5), Reporting (7), Admin (5 module links) identical to adm; `RoleAwareNavigation.IsVisibleFor` grants all groups for su (§3, §4) | PASS — All menus identical to admin; no visual difference (§5: role badge shows only `su` claim, cosmetic only) | PASS — Same submenu structure as admin; no additional submenus for su | PASS — SuperUser can access `/api/v1/admin/superusers` (su-only, `SuperUserOnly` policy, §2.2); adm cannot (§3, §5) | PASS — `/api/v1/auth/logout` POST with bearer token; stateless (§2.2) |

## Verification Evidence

| Test Suite | Count | Status | Coverage |
|---|---|---|---|
| UnitTests | 254/254 | PASS | Role definitions, `RoleAwareNavigation.IsVisibleFor` logic, policy role sets, claim contract |
| FunctionalTests | 304/304 | PASS | Page-level authorization, login/logout flows, redirect behavior, navigation visibility per role |
| IntegrationTests | 158/158 | PASS | End-to-end role traversal, API authorization, cross-module access control |

## Cross-References

- **Shell architecture**: `docs/ui/ROLE_NAVIGATION_MATRIX.md` §1 (dual-mode shell, `_Layout.cshtml` line 20)
- **Navigation groups**: `docs/ui/ROLE_NAVIGATION_MATRIX.md` §3 (role → navigation group access matrix)
- **Permission catalog**: `docs/ui/ROLE_PAGE_PERMISSION_MATRIX.md` §3 (11 policies, role sets)
- **Page access**: `docs/ui/ROLE_PAGE_PERMISSION_MATRIX.md` §4 (role → page access matrix)
- **API access**: `docs/ui/ROLE_PAGE_PERMISSION_MATRIX.md` §5 (role → API access matrix)
- **CoreUI mapping**: `docs/ui/COREUI_VISA_FUSION_MAPPING.md` §3–5 (Agent/Reporting/Admin CoreUI components)
