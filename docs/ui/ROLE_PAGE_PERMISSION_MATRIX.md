# ROLE × PAGE × PERMISSION MATRIX — VisaFusion

**Status: COMPLETE** · Generated: 2026-08-19
**Sources**: `src/VisaFusion.Api/Authorization/AuthorizationPolicies.cs`,
`src/VisaFusion.Api/Authorization/IdentityClaims.cs`,
`src/VisaFusion.Web/Program.cs` (API policy wiring),
`src/VisaFusion.Web/Pages/**`, `src/VisaFusion.Web/Areas/**`,
`docs/ui/ROLE_BASED_NATIVE_PAGES_INVENTORY.md`.

**Method**: every row grounded in a tool call made 2026-08-19 (read of
`IdentityClaims.cs`, `AuthorizationPolicies.cs`, `Program.cs` lines 340–819;
grep of `[Authorize` on page models; glob of all `.cshtml`). No `UNKNOWN`.

## 1. Roles (verified `IdentityIntegration.Roles` + `IdentityClaims.EffectiveRoles`)

| Role | Code | Effective role claims | Notes |
|---|---|---|---|
| Guest | `guest` | none (anonymous) | Public area, login, register, access-denied |
| Agent | `agt` | `role=agt` | `AgentId` claim bound at import (FR-007) |
| Employee | `emp` | `role=emp` | Day-gate applies at login (rsn=O) |
| Admin | `adm` | `role=adm` | |
| SuperUser | `su` | `role=su` + `role=adm` (FR-008 expansion) + `SuperUser=true` | su implies adm |

## 2. Claim contract (verified `IdentityClaims.FromUser`)

| Claim type | Value | Carried by |
|---|---|---|
| `sub` (JwtRegisteredClaimNames.Sub) | username | all authenticated |
| `name` (ClaimTypes.Name) | username | all authenticated |
| `role` (ClaimTypes.Role) | one claim per effective role | all authenticated; su → su+adm |
| `SuperUser` | `"true"` | su only (FR-008) |
| `AgentId` | agent id (invariant int) | agt only, when linked (FR-007) |

## 3. Permission catalog (11 policies, verified `AuthorizationPolicies.cs`)

| Policy | Role set | Pages | APIs |
|---|---|---|---|
| `AgentSelf` | agt, emp, adm, su | Agent area (5) | `/api/v1/agent`, `/api/v1/agents/{id}/entries`, `/statuses`, `/self` |
| `EntryOperations` | emp, adm, su | Reporting area (7) | `/api/v1/employee`, `/api/v1/entries/*`, `/api/v1/notifications/*`, `/api/v1/reports/*` |
| `AdminPanel` | adm, su | Admin Agents (4), Admin ContentUpdate | `/api/v1/admin`, `/api/v1/agents` (CRUD+lifecycle), `/api/v1/admin/content/daily-update` |
| `UserManagement` | adm, emp | Admin Users (List, Create) | `/api/v1/admin/users`, `/api/v1/admin/users/{id}/deactivate` |
| `HolidayAdmin` | adm, su | Admin Holidays | `/api/v1/holidays*` |
| `SecurityGate` | adm, su | Admin SecurityDay | `/api/v1/admin/security-day/*` |
| `AgentLedger` | agt, emp, adm, su | — (no page; API) | `/api/v1/agents/{id}/statement` |
| `BillingOperations` | emp, adm, su | — (Billing placeholder, GAP-004) | `/api/v1/billing` |
| `Search` | agt, emp, adm, su | — (reserved) | — |
| `PasswordSelf` | agt, emp, adm, su | — (reserved; page uses `[Authorize]`) | — |
| `SuperUserOnly` | claim `SuperUser=true` | — (no page) | `/api/v1/admin/superusers` |

## 4. Role → page access matrix

Legend: ✅ accessible · ❌ denied by policy · ⚠️ anonymous (no auth required) ·
⛔ placeholder (no policy attached).

| Native page | Route | Guest | Agent | Employee | Admin | SuperUser |
|---|---|---|---|---|---|---|
| Root Index | `/` | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |
| Public Index | `/Public/Index` | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |
| Public VisaInfo | `/Public/VisaInfo` | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |
| Public Embassy | `/Public/Embassy` | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |
| Public CountryInfo | `/Public/CountryInfo` | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |
| Public DailyUpdate | `/Public/DailyUpdate` | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |
| Public Queries | `/Public/Queries` | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |
| Public Contact | `/Public/Contact` | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |
| Public Subscribe | `/Public/Subscribe` | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |
| Public Register | `/Public/Register` | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |
| Auth Login | `/Auth/Login` | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |
| Auth Register | `/Auth/Register` | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |
| Auth AccessDenied | `/Auth/AccessDenied` | ⚠️ | ⚠️ | ⚠️ | ⚠️ | ⚠️ |
| Auth ChangePassword | `/Auth/ChangePassword` | ❌ | ✅ `[Authorize]` | ✅ `[Authorize]` | ✅ `[Authorize]` | ✅ `[Authorize]` |
| Agent Index | `/Agent/Index` | ❌ | ✅ `AgentSelf` | ✅ `AgentSelf` | ✅ `AgentSelf` | ✅ `AgentSelf` |
| Agent Entries | `/Agent/Entries` | ❌ | ✅ `AgentSelf` | ✅ `AgentSelf` | ✅ `AgentSelf` | ✅ `AgentSelf` |
| Agent Statuses | `/Agent/Statuses` | ❌ | ✅ `AgentSelf` | ✅ `AgentSelf` | ✅ `AgentSelf` | ✅ `AgentSelf` |
| Agent Statement | `/Agent/Statement` | ❌ | ✅ `AgentSelf` | ✅ `AgentSelf` | ✅ `AgentSelf` | ✅ `AgentSelf` |
| Agent Account | `/Agent/Account` | ❌ | ✅ `AgentSelf` | ✅ `AgentSelf` | ✅ `AgentSelf` | ✅ `AgentSelf` |
| Reporting Index | `/Reporting/Index` | ❌ | ❌ | ✅ `EntryOperations` | ✅ `EntryOperations` | ✅ `EntryOperations` |
| Reporting Pending | `/Reporting/Pending` | ❌ | ❌ | ✅ `EntryOperations` | ✅ `EntryOperations` | ✅ `EntryOperations` |
| Reporting TodaySubmission | `/Reporting/TodaySubmission` | ❌ | ❌ | ✅ `EntryOperations` | ✅ `EntryOperations` | ✅ `EntryOperations` |
| Reporting TodayCollection | `/Reporting/TodayCollection` | ❌ | ❌ | ✅ `EntryOperations` | ✅ `EntryOperations` | ✅ `EntryOperations` |
| Reporting TodayTransaction | `/Reporting/TodayTransaction` | ❌ | ❌ | ✅ `EntryOperations` | ✅ `EntryOperations` | ✅ `EntryOperations` |
| Reporting DailyVisaFee | `/Reporting/DailyVisaFee` | ❌ | ❌ | ✅ `EntryOperations` | ✅ `EntryOperations` | ✅ `EntryOperations` |
| Reporting DailyBill | `/Reporting/DailyBill` | ❌ | ❌ | ✅ `EntryOperations` | ✅ `EntryOperations` | ✅ `EntryOperations` |
| Admin Index | `/Admin/Index` | ❌ | ❌ | ❌ | ✅ `AdminPanel` | ✅ `AdminPanel` |
| Admin Agents List | `/Admin/Agents/List` | ❌ | ❌ | ❌ | ✅ `AdminPanel` | ✅ `AdminPanel` |
| Admin Agents Create | `/Admin/Agents/Create` | ❌ | ❌ | ❌ | ✅ `AdminPanel` | ✅ `AdminPanel` |
| Admin Agents Detail | `/Admin/Agents/Detail` | ❌ | ❌ | ❌ | ✅ `AdminPanel` | ✅ `AdminPanel` |
| Admin Agents Edit | `/Admin/Agents/Edit` | ❌ | ❌ | ❌ | ✅ `AdminPanel` | ✅ `AdminPanel` |
| Admin Users List | `/Admin/Users/List` | ❌ | ❌ | ✅ `UserManagement` | ✅ `UserManagement` | ✅ `UserManagement` |
| Admin Users Create | `/Admin/Users/Create` | ❌ | ❌ | ✅ `UserManagement` | ✅ `UserManagement` | ✅ `UserManagement` |
| Admin Holidays | `/Admin/Holidays/Index` | ❌ | ❌ | ❌ | ✅ `HolidayAdmin` | ✅ `HolidayAdmin` |
| Admin ContentUpdate | `/Admin/ContentUpdate/Index` | ❌ | ❌ | ❌ | ✅ `AdminPanel` | ✅ `AdminPanel` |
| Admin SecurityDay | `/Admin/SecurityDay/Index` | ❌ | ❌ | ❌ | ✅ `SecurityGate` | ✅ `SecurityGate` |
| Employee Index | `/Employee/Index` | ❌ | ❌ | ⛔ (no policy) | ⛔ (no policy) | ⛔ (no policy) |
| Billing Index | `/Billing/Index` | ❌ | ❌ | ⛔ (no policy) | ⛔ (no policy) | ⛔ (no policy) |
| Notifications Index | `/Notifications/Index` | ❌ | ❌ | ⛔ (no policy) | ⛔ (no policy) | ⛔ (no policy) |

## 5. Role → API access matrix (verified `Program.cs` lines 340–819)

| API route | Method | Guest | Agent | Employee | Admin | SuperUser |
|---|---|---|---|---|---|---|
| `/api/v1/health` | GET | ✅ | ✅ | ✅ | ✅ | ✅ |
| `/api/v1/public` | GET | ✅ | ✅ | ✅ | ✅ | ✅ |
| `/api/v1/auth/login` | POST | ✅ | ✅ | ✅ | ✅ | ✅ |
| `/api/v1/public/register` | POST | ✅ | ✅ | ✅ | ✅ | ✅ |
| `/api/v1/public/queries` | POST | ✅ (rate-limited) | ✅ | ✅ | ✅ | ✅ |
| `/api/v1/auth/logout` | POST | ❌ | ✅ bearer | ✅ bearer | ✅ bearer | ✅ bearer |
| `/api/v1/auth/change-password` | POST | ❌ | ✅ bearer | ✅ bearer | ✅ bearer | ✅ bearer |
| `/api/v1/agent` | GET | ❌ | ✅ `AgentSelf` | ✅ `AgentSelf` | ✅ `AgentSelf` | ✅ `AgentSelf` |
| `/api/v1/agents/{id}/entries` | GET | ❌ | ✅ `AgentSelf` (own only) | ✅ `AgentSelf` | ✅ `AgentSelf` | ✅ `AgentSelf` |
| `/api/v1/agents/{id}/statuses` | GET | ❌ | ✅ `AgentSelf` (own only) | ✅ `AgentSelf` | ✅ `AgentSelf` | ✅ `AgentSelf` |
| `/api/v1/agents/{id}/self` | PUT | ❌ | ✅ `AgentSelf` (own only) | ✅ `AgentSelf` | ✅ `AgentSelf` | ✅ `AgentSelf` |
| `/api/v1/agents/{id}/statement` | GET | ❌ | ✅ `AgentLedger` (own only) | ✅ `AgentLedger` | ✅ `AgentLedger` | ✅ `AgentLedger` |
| `/api/v1/employee` | GET | ❌ | ❌ | ✅ `EntryOperations` | ✅ `EntryOperations` | ✅ `EntryOperations` |
| `/api/v1/reporting` | GET | ❌ | ❌ | ✅ roles emp,adm,su | ✅ roles emp,adm,su | ✅ roles emp,adm,su |
| `/api/v1/notifications` | GET | ❌ | ❌ | ✅ roles emp,adm,su | ✅ roles emp,adm,su | ✅ roles emp,adm,su |
| `/api/v1/entries*` (5 routes) | POST/GET/PUT | ❌ | ❌ | ✅ `EntryOperations` | ✅ `EntryOperations` | ✅ `EntryOperations` |
| `/api/v1/notifications/sms`, `/email`, histories | POST/GET | ❌ | ❌ | ✅ `EntryOperations` | ✅ `EntryOperations` | ✅ `EntryOperations` |
| `/api/v1/reports/*` (7 routes) | GET | ❌ | ❌ | ✅ `EntryOperations` | ✅ `EntryOperations` | ✅ `EntryOperations` |
| `/api/v1/billing/entries` | POST | ❌ | ❌ | ✅ roles emp,adm,su (501) | ✅ roles emp,adm,su (501) | ✅ roles emp,adm,su (501) |
| `/api/v1/admin` | GET | ❌ | ❌ | ❌ | ✅ `AdminPanel` | ✅ `AdminPanel` |
| `/api/v1/agents` (CRUD+lifecycle, 5 routes) | POST/GET/PUT | ❌ | ❌ | ❌ | ✅ `AdminPanel` | ✅ `AdminPanel` |
| `/api/v1/admin/content/daily-update*` | POST/DELETE | ❌ | ❌ | ❌ | ✅ `AdminPanel` | ✅ `AdminPanel` |
| `/api/v1/admin/users` | POST | ❌ | ❌ | ✅ `UserManagement` | ✅ `UserManagement` | ✅ `UserManagement` |
| `/api/v1/admin/users/{id}/deactivate` | POST | ❌ | ❌ | ✅ `UserManagement` | ✅ `UserManagement` | ✅ `UserManagement` |
| `/api/v1/admin/superusers` | POST | ❌ | ❌ | ❌ | ❌ (no `SuperUser` claim) | ✅ `SuperUserOnly` |
| `/api/v1/holidays*` (4 routes) | POST/DELETE | ❌ | ❌ | ❌ | ✅ `HolidayAdmin` | ✅ `HolidayAdmin` |
| `/api/v1/admin/security-day/*` (3 routes) | POST/GET | ❌ | ❌ | ❌ | ✅ `SecurityGate` | ✅ `SecurityGate` |
| `/api/v1/billing` | GET | ❌ | ❌ | ✅ `BillingOperations` | ✅ `BillingOperations` | ✅ `BillingOperations` |

## 6. Unresolved role/page/permission relationships

1. **Admin Index (`/Admin/Index`)** — placeholder page; now gated by the
   `AdminPanel` policy (adm/su) via its page model (SPEC-0009 T035/T038). The
   previous no-policy state left the route reachable by any caller; the
   explicit rule closes that gap without changing the 11-policy catalog.
2. **Employee Index (`/Employee/Index`)** — placeholder, no policy, no spec
   (GAP-004). The `Employee` role has no dedicated landing page; its only
   pages are Reporting (via `EntryOperations`) and Admin Users (via
   `UserManagement`).
3. **Billing Index (`/Billing/Index`)** — placeholder, no policy; the
   `BillingOperations` policy exists and gates `/api/v1/billing` and
   `/api/v1/billing/entries` (501 placeholder) but has **no page** (GAP-004).
4. **Notifications Index (`/Notifications/Index`)** — re-skinned with `_InfoPage` component (T078), no policy;
   the notifications API is gated by `EntryOperations` (emp/adm/su) but the
   page has no authorization attribute (GAP-004).
5. **`AgentLedger`** — policy admits agt/emp/adm/su and gates the statement
   API, but the `/Agent/Statement` page is gated by `AgentSelf` (broader).
   The page/API policy mismatch is intentional (page = portal nav, API =
   ledger scope) but undocumented as a decision.
6. **`Search` and `PasswordSelf`** — policies registered with no page and no
   API; reserved contracts only.
7. **`SuperUserOnly`** — claim-based policy with no page; su-provisioning is a
   documented deferred contract (SPEC-0006 FR-007).
8. **Guest vs `guest` role** — the public register API fixes the role to
   `guest` server-side, but no `guest`-role page surface exists beyond the
   anonymous Public area; the `guest` role is not in `IdentityIntegration.Roles`
   page-facing set (verified: roles are Agent/Employee/Admin/SuperUser).
9. **`/Auth/ChangePassword`** — gated by bare `[Authorize]` (any authenticated
   role) while the `PasswordSelf` policy (same role set) is unused; the page
   does not reference the policy.
10. **Day-gate asymmetry** — the login day-gate (`rsn=O`) applies to `emp`
    logins only (verified `Login.cshtml.cs` line 96: `EvaluateAsync(roles, …)`
    with the role set); `agt`/`adm`/`su` logins are not day-gated. This is
    legacy parity but is not expressed in any policy.

## 7. Provenance

Verified 2026-08-19: `read IdentityClaims.cs` (claims + EffectiveRoles),
`read AuthorizationPolicies.cs` (11 policies + RoleSets), `read Program.cs`
lines 340–819 (every API route + its `RequireAuthorization` policy),
`read Login.cshtml.cs` (day-gate + redirects), `grep [Authorize` on page
models, `glob` all `.cshtml`. Nothing asserted from memory.