# ROLE × NAVIGATION MATRIX — VisaFusion

**Status: COMPLETE** · Generated: 2026-08-19 · Updated: 2026-08-20 (§5.1 decision)
**Sources**: `src/VisaFusion.Web/Pages/Shared/_Layout.cshtml` (shell),
`src/VisaFusion.Web/Services/RoleAwareNavigation.cs` (centralized model),
per-page `@section SidebarNav` blocks (grep + read),
`docs/ui/ROLE_BASED_NATIVE_PAGES_INVENTORY.md` §5 (centralized target model),
`library/Role-Based Native Pages Architecture Addendum.md`.

**Method**: every row grounded in a tool call made 2026-08-19 (read of
`_Layout.cshtml` lines 1–92; grep of `SidebarNav` across all `.cshtml` — 22
matches; read of the `SidebarNav` blocks in Agent/Reporting/Admin pages; grep
of `asp-page=` in the Admin area). No `UNKNOWN`.

## 1. Shell navigation (verified `_Layout.cshtml`)

The shell is dual-mode: `useSidebar = ViewData["UseSidebar"] ?? isAuthenticated`
(line 20). Authenticated pages default to the sidebar shell; anonymous pages
(login, register, public site) default to the top-nav shell.

| Shell | Mode | Rendered links (hard-coded) | Role context |
|---|---|---|---|
| Sidebar (`vf-sidebar`) | authenticated | Home (`/`), Change password (`/Auth/ChangePassword`, auth only) + per-page `@section SidebarNav` | topbar shows `name` + first `role` claim |
| Top-nav (`vf-topnav`) | anonymous | Log in (`/Auth/Login`), Register (`/Auth/Register`) | none |

**Current state**: navigation **is centralized** — the `RoleAwareNavigation`
service (`src/VisaFusion.Web/Services/RoleAwareNavigation.cs`) defines all 8
navigation groups, menus, and submenus. The `_Sidebar.cshtml` partial renders
nav from this service. Per-page `@section SidebarNav` blocks have been removed
(T079). The shell renders the full menu for each role's visible groups.

## 2. Historical per-page navigation (superseded by §4)

> **Note**: This section documents the pre-centralization state (before T079).
> Per-page `@section SidebarNav` blocks have been removed. Navigation is now
> centralized via `RoleAwareNavigation` service (see §4). Retained for
> historical reference only.

| Navigation Group | Menu (link label) | Submenu | Native page | Route | Rendered by |
|---|---|---|---|---|---|
| Agent Portal | Portal home | — | `Areas/Agent/Pages/Index.cshtml` | `/Agent/Index` | Agent Index |
| Agent Portal | My entries | — | `Areas/Agent/Pages/Entries.cshtml` | `/Agent/Entries` | Agent Index |
| Agent Portal | Passenger statuses | — | `Areas/Agent/Pages/Statuses.cshtml` | `/Agent/Statuses` | Agent Index |
| Agent Portal | Statement | — | `Areas/Agent/Pages/Statement.cshtml` | `/Agent/Statement` | Agent Index |
| Agent Portal | My account | — | `Areas/Agent/Pages/Account.cshtml` | `/Agent/Account` | Agent Index |
| Reporting | Reports | — | `Areas/Reporting/Pages/Index.cshtml` | `/Reporting/Index` | Reporting Index |
| Reporting | Pending | — | `Areas/Reporting/Pages/Pending.cshtml` | `/Reporting/Pending` | Reporting Index |
| Reporting | Today Submission | Today | `Areas/Reporting/Pages/TodaySubmission.cshtml` | `/Reporting/TodaySubmission` | Reporting Index |
| Reporting | Today Collection | Today | `Areas/Reporting/Pages/TodayCollection.cshtml` | `/Reporting/TodayCollection` | Reporting Index |
| Reporting | Today Transaction | Today | `Areas/Reporting/Pages/TodayTransaction.cshtml` | `/Reporting/TodayTransaction` | Reporting Index |
| Reporting | Daily Visa Fee | Daily | `Areas/Reporting/Pages/DailyVisaFee.cshtml` | `/Reporting/DailyVisaFee` | Reporting Index |
| Reporting | Daily Bill | Daily | `Areas/Reporting/Pages/DailyBill.cshtml` | `/Reporting/DailyBill` | Reporting Index |
| Admin | Agents | — | `Areas/Admin/Pages/Agents/List.cshtml` | `/Admin/Agents/List` | all 4 Agent pages |
| Admin | Users | — | `Areas/Admin/Pages/Users/List.cshtml` | `/Admin/Users/List` | both User pages |
| Admin | Security day | — | `Areas/Admin/Pages/SecurityDay/Index.cshtml` | `/Admin/SecurityDay/Index` | SecurityDay |
| Admin | Holidays | — | `Areas/Admin/Pages/Holidays/Index.cshtml` | `/Admin/Holidays/Index` | Holidays |
| Admin | Daily Updates | — | `Areas/Admin/Pages/ContentUpdate/Index.cshtml` | `/Admin/ContentUpdate/Index` | ContentUpdate |

Notes (verified):
- The Reporting "Today"/"Daily" submenu grouping exists only in the inventory
  model (§4); the **actual** `SidebarNav` renders flat links (verified
  `Reporting/Index.cshtml` lines 8–16).
- The Admin `SidebarNav` renders only the current module's link (e.g. Agents
  pages render only "Agents"), not the full Admin menu (verified `asp-page=`
  grep: 9 matches, one per Admin page).
- The Public area pages (9) have **no nav links** in either shell — they are
  URL-reachable only (top-nav shows only Log in/Register).
- The placeholder areas (Employee, Billing, Notifications) render no
  `SidebarNav` (no `UseSidebar`).

## 3. Role → navigation group access

| Role | Public (top-nav) | Account | Agent Portal | Reporting | Admin | Employee | Billing | Notifications |
|---|---|---|---|---|---|---|---|---|
| Guest | ✅ (Log in/Register only) | ✅ Login/Register | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Agent | ✅ | ✅ Change password | ✅ (5 links) | ❌ | ❌ | ❌ | ❌ | ❌ |
| Employee | ✅ | ✅ Change password | ✅ (5 links) | ✅ (7 links) | ✅ Users (2 links) | ⛔ placeholder | ❌ | ❌ |
| Admin | ✅ | ✅ Change password | ✅ (5 links) | ✅ (7 links) | ✅ (5 module links) | ⛔ placeholder | ⛔ placeholder | ⛔ placeholder |
| SuperUser | ✅ | ✅ Change password | ✅ (5 links) | ✅ (7 links) | ✅ (5 module links) | ⛔ placeholder | ⛔ placeholder | ⛔ placeholder |

## 4. Centralized target model (addendum §5 — implemented 2026-08-20)

One `RoleAwareNavigation` service consuming this matrix; renders CoreUI
`sidebar-nav.pug` data-driven pattern (`nav` array: `item`/`title`/`group`/
`divider`). Do NOT hard-code per-page nav. Implemented in
`src/VisaFusion.Web/Services/RoleAwareNavigation.cs` (T016); the per-page
`@section SidebarNav` blocks were removed (T079) and the shell renders the
service's groups via `_Sidebar` (T081).

| Navigation Group | Menu | Submenu | Permission | Roles | Pages |
|---|---|---|---|---|---|
| Public | Home / Visa Info / Embassy / Country Info / Daily Update / Queries / Contact / Subscribe / Register | — | anonymous | Guest | §2 Public rows |
| Account | Login / Register / Change password | — | `[Authorize]` (change pw) | all | `/Auth/*` |
| Agent Portal | Dashboard / My Entries / Statuses / Statement / Account | — | `AgentSelf` | agt/emp/adm/su | `/Agent/*` |
| Reporting | Dashboard / Pending / Today › {Submission, Collection, Transaction} / Daily › {Visa Fee, Bill} | Today, Daily | `EntryOperations` | emp/adm/su | `/Reporting/*` |
| Admin | Dashboard / Agents › {List, Create, Detail, Edit} / Users › {List, Create} / Holidays / Content Update / Security Day | Agents, Users | `AdminPanel` / `UserManagement` / `HolidayAdmin` / `SecurityGate` | adm/su (Users: adm/emp) | `/Admin/*` |
| Employee | Home | — | (none yet) | emp | `/Employee/Index` BLOCKED |
| Billing | Home | — | (none yet; `BillingOperations` reserved) | emp/adm/su | `/Billing/Index` BLOCKED |
| Notifications | Home | — | (none yet; SPEC-0008 API exists) | adm/su | `/Notifications/Index` PARTIAL |

## 5. Unresolved navigation relationships

1. **Public pages are unreachable from the shell** — the 9 Public pages have
   no nav links in either shell; only Log in/Register are rendered. The
   centralized model must decide whether Public pages get a top-nav menu or
   remain URL-only (owner decision). **RESOLVED 2026-08-20 — see §5.1.**
2. **Admin nav is module-scoped, not role-scoped** — each Admin page renders
   only its own module link; an Admin user cannot navigate between Agents,
   Users, Holidays, Security Day, and Content Update from the sidebar. The
   centralized model must render the full Admin menu for adm/su.
3. **Employee has no dedicated nav group** — the Employee role sees Agent
   Portal + Reporting + Admin Users links but no Employee group; the
   `/Employee/Index` placeholder is unreachable from any nav (GAP-004).
4. **Billing/Notifications groups are unreachable** — placeholder pages with
   no nav links (GAP-004).
5. **Role badge shows only the first role claim** — `_Layout.cshtml` line 22
   reads `FindFirstValue(ClaimTypes.Role)`; a su principal (su+adm) displays
   only `su`. Cosmetic, but the centralized nav must decide the display rule.
6. **Submenu grouping is conceptual only** — Reporting "Today"/"Daily" and
   Admin "Agents"/"Users" submenus exist in the target model but not in the
   rendered nav; the centralized service must introduce them.

### 5.1 Decision — Public pages are URL-only (guest group, no shell menu)

**Decision (2026-08-20, SPEC-0009 T084):** the 9 Public pages remain
**URL-only reachable** — they are NOT rendered as a menu in either shell
(top-nav or sidebar). The `RoleAwareNavigation` service models them as the
`public` group with `AllowedRoles = ["guest"]` (visible only to anonymous
users; every authenticated role is redirected to its own portal), but the
shell renders no Public menu links. Rationale:

- Legacy parity: the legacy public pages were reached by direct URL from
  external links/emails, not from an in-app menu; the top-nav shows only
  Log in/Register (verified `_Layout.cshtml`).
- Guest surface: anonymous users land on `/` (PublicLanding component) and
  navigate the public pages via the landing page's action links, not a shell
  menu.
- Authenticated users: the Public group is hidden from the sidebar for every
  authenticated role (verified `RoleAwareNavigation.IsVisibleFor` — guest
  visibility applies only when the principal has no role claims; covered by
  `tests/UnitTests/RoleAwareNavigationTests.Public_Group_Is_Visible_Only_To_Anonymous_Users`).

Consequences: no top-nav Public menu is added; the `public` group exists in
the nav model for guest landing/route-matrix completeness only; the
`ROLE_ROUTE_MATRIX` and `ROLE_PAGE_PERMISSION_MATRIX` keep the Public rows
(anonymous access).

## 6. Provenance

Verified 2026-08-19: `read _Layout.cshtml` (shell, lines 1–92), `grep
SidebarNav` (22 matches: 1 shell + 21 pages), `read Agent/Index.cshtml`,
`Reporting/Index.cshtml`, `Admin/Agents/List.cshtml` (SidebarNav blocks),
`grep asp-page=` in Admin area (9 nav links). Nothing asserted from memory.