# ROLE × ROUTE MATRIX — VisaFusion

**Status: COMPLETE** · Generated: 2026-08-19
**Sources**: `src/VisaFusion.Web/Program.cs` lines 340–819 (API routes +
policies), `src/VisaFusion.Web/Middleware/LegacyUrlRewriteMiddleware.cs`
(legacy redirects), page `@page` directives (grep), page-model redirects
(grep `RedirectToPage|LocalRedirect`), `docs/ui/ROLE_BASED_NATIVE_PAGES_INVENTORY.md`.

**Method**: every row grounded in a tool call made 2026-08-19. No `UNKNOWN`.

## 1. Page routes (41 pages, verified `@page` + glob)

| Route | Method | Native page | Permission | Roles | Redirect / behavior |
|---|---|---|---|---|---|
| `/` | GET | `Pages/Index.cshtml` | anonymous | all | static welcome (PARTIAL) |
| `/Auth/Login` | GET/POST | `Pages/Auth/Login.cshtml` | anonymous | all | GET: `rsn` reason inline; authenticated → `/Index`. POST: day-gate reject → `/Auth/Login?rsn=O`; success → `LocalRedirect(returnUrl or "/")` |
| `/Auth/Register` | GET/POST | `Pages/Auth/Register.cshtml` | anonymous | all | guest registration |
| `/Auth/ChangePassword` | GET/POST | `Pages/Auth/ChangePassword.cshtml` | `[Authorize]` | all authenticated | success → `/Auth/Login` |
| `/Auth/AccessDenied` | GET | `Pages/Auth/AccessDenied.cshtml` | anonymous | all | 403 surface |
| `/Public/Index` | GET | `Areas/Public/Pages/Index.cshtml` | anonymous | all | static (PARTIAL) |
| `/Public/VisaInfo` | GET | `Areas/Public/Pages/VisaInfo.cshtml` | anonymous | all | static (PARTIAL) |
| `/Public/Embassy` | GET | `Areas/Public/Pages/Embassy.cshtml` | anonymous | all | static (PARTIAL) |
| `/Public/CountryInfo` | GET | `Areas/Public/Pages/CountryInfo.cshtml` | anonymous | all | static (PARTIAL) |
| `/Public/DailyUpdate` | GET | `Areas/Public/Pages/DailyUpdate.cshtml` | anonymous | all | 30-day window (IMPLEMENTED) |
| `/Public/Queries` | GET | `Areas/Public/Pages/Queries.cshtml` | anonymous | all | static form → API (PARTIAL) |
| `/Public/Contact` | GET | `Areas/Public/Pages/Contact.cshtml` | anonymous | all | static (PARTIAL) |
| `/Public/Subscribe` | GET | `Areas/Public/Pages/Subscribe.cshtml` | anonymous | all | static (PARTIAL) |
| `/Public/Register` | GET | `Areas/Public/Pages/Register.cshtml` | anonymous | all | static (PARTIAL) |
| `/Agent/Index` | GET | `Areas/Agent/Pages/Index.cshtml` | `AgentSelf` | agt/emp/adm/su | agent landing |
| `/Agent/Entries` | GET | `Areas/Agent/Pages/Entries.cshtml` | `AgentSelf` | agt/emp/adm/su | own-scoped list |
| `/Agent/Statuses` | GET | `Areas/Agent/Pages/Statuses.cshtml` | `AgentSelf` | agt/emp/adm/su | status timeline |
| `/Agent/Statement` | GET | `Areas/Agent/Pages/Statement.cshtml` | `AgentSelf` | agt/emp/adm/su | ledger |
| `/Agent/Account` | GET/POST | `Areas/Agent/Pages/Account.cshtml` | `AgentSelf` | agt/emp/adm/su | self-edit |
| `/Reporting/Index` | GET | `Areas/Reporting/Pages/Index.cshtml` | `EntryOperations` | emp/adm/su | reports landing |
| `/Reporting/Pending` | GET | `Areas/Reporting/Pages/Pending.cshtml` | `EntryOperations` | emp/adm/su | pending list |
| `/Reporting/TodaySubmission` | GET | `Areas/Reporting/Pages/TodaySubmission.cshtml` | `EntryOperations` | emp/adm/su | today submission |
| `/Reporting/TodayCollection` | GET | `Areas/Reporting/Pages/TodayCollection.cshtml` | `EntryOperations` | emp/adm/su | today collection |
| `/Reporting/TodayTransaction` | GET | `Areas/Reporting/Pages/TodayTransaction.cshtml` | `EntryOperations` | emp/adm/su | today transaction |
| `/Reporting/DailyVisaFee` | GET | `Areas/Reporting/Pages/DailyVisaFee.cshtml` | `EntryOperations` | emp/adm/su | daily visa fee |
| `/Reporting/DailyBill` | GET | `Areas/Reporting/Pages/DailyBill.cshtml` | `EntryOperations` | emp/adm/su | daily bill |
| `/Admin/Index` | GET | `Areas/Admin/Pages/Index.cshtml` | `AdminPanel` | — | placeholder (RE-SKINNED T035/T038) |
| `/Admin/Agents/List` | GET | `Areas/Admin/Pages/Agents/List.cshtml` | `AdminPanel` | adm/su | agent list |
| `/Admin/Agents/Create` | GET/POST | `Areas/Admin/Pages/Agents/Create.cshtml` | `AdminPanel` | adm/su | success → `/Admin/Agents/Detail?id=` |
| `/Admin/Agents/Detail` | GET/POST | `Areas/Admin/Pages/Agents/Detail.cshtml` | `AdminPanel` | adm/su | deactivate/reactivate |
| `/Admin/Agents/Edit` | GET/POST | `Areas/Admin/Pages/Agents/Edit.cshtml` | `AdminPanel` | adm/su | success → `/Admin/Agents/Detail?id=` |
| `/Admin/Users/List` | GET/POST | `Areas/Admin/Pages/Users/List.cshtml` | `UserManagement` | adm/emp | deactivate |
| `/Admin/Users/Create` | GET/POST | `Areas/Admin/Pages/Users/Create.cshtml` | `UserManagement` | adm/emp | success → `/Admin/Users/List` |
| `/Admin/Holidays/Index` | GET/POST | `Areas/Admin/Pages/Holidays/Index.cshtml` | `HolidayAdmin` | adm/su | holiday + weekly-off CRUD |
| `/Admin/ContentUpdate/Index` | GET/POST | `Areas/Admin/Pages/ContentUpdate/Index.cshtml` | `AdminPanel` | adm/su | daily-update CRUD |
| `/Admin/SecurityDay/Index` | GET/POST | `Areas/Admin/Pages/SecurityDay/Index.cshtml` | `SecurityGate` | adm/su | open/close day |
| `/Employee/Index` | GET | `Areas/Employee/Pages/Index.cshtml` | (none) | — | placeholder (BLOCKED, GAP-004) |
| `/Billing/Index` | GET | `Areas/Billing/Pages/Index.cshtml` | (none) | — | placeholder (BLOCKED, GAP-004) |
| `/Notifications/Index` | GET | `Areas/Notifications/Pages/Index.cshtml` | (none) | — | placeholder (PARTIAL, GAP-004) |
| `/Auth/Index` | GET | `Areas/Auth/Pages/Index.cshtml` | (none) | — | placeholder (PARTIAL) |

## 2. API routes (verified `Program.cs` lines 340–819)

| Route | Method | Policy | Roles | Notes |
|---|---|---|---|---|
| `/api/v1/health` | GET | — | anonymous | version from shared Core surface |
| `/api/v1/public` | GET | — | anonymous | representative |
| `/api/v1/auth/login` | POST | — | anonymous | JWT login |
| `/api/v1/public/register` | POST | — | anonymous | role fixed `guest`; rate-limited when configured |
| `/api/v1/public/queries` | POST | — | anonymous | rate-limited when configured |
| `/api/v1/auth/logout` | POST | bearer | authenticated | stateless |
| `/api/v1/auth/change-password` | POST | bearer | authenticated | any role |
| `/api/v1/agent` | GET | `AgentSelf` | agt/emp/adm/su | representative |
| `/api/v1/agents/{id}/entries` | GET | `AgentSelf` | agt/emp/adm/su | own-scoped (BR-007/008) |
| `/api/v1/agents/{id}/statuses` | GET | `AgentSelf` | agt/emp/adm/su | own-scoped |
| `/api/v1/agents/{id}/self` | PUT | `AgentSelf` | agt/emp/adm/su | own-record only (FR-020) |
| `/api/v1/agents/{id}/statement` | GET | `AgentLedger` | agt/emp/adm/su | own-scoped |
| `/api/v1/employee` | GET | `EntryOperations` | emp/adm/su | Canada DOB rule |
| `/api/v1/reporting` | GET | roles emp,adm,su | emp/adm/su | representative |
| `/api/v1/notifications` | GET | roles emp,adm,su | emp/adm/su | representative |
| `/api/v1/entries` | POST | `EntryOperations` | emp/adm/su | create |
| `/api/v1/entries/{refno}` | GET | `EntryOperations` | emp/adm/su | read |
| `/api/v1/entries/{refno}` | PUT | `EntryOperations` | emp/adm/su | update |
| `/api/v1/entries/{refno}/status` | POST | `EntryOperations` | emp/adm/su | status change |
| `/api/v1/entries/{refno}/awb` | POST | `EntryOperations` | emp/adm/su | record AWB |
| `/api/v1/notifications/sms` | POST | `EntryOperations` | emp/adm/su | enqueue SMS |
| `/api/v1/notifications/sms-history` | GET | `EntryOperations` | emp/adm/su | SMS history |
| `/api/v1/notifications/email` | POST | `EntryOperations` | emp/adm/su | enqueue email |
| `/api/v1/notifications/email-history` | GET | `EntryOperations` | emp/adm/su | email history |
| `/api/v1/billing/entries` | POST | roles emp,adm,su | emp/adm/su | 501 placeholder |
| `/api/v1/holidays/weekly-off` | POST | `HolidayAdmin` | adm/su | create weekly-off |
| `/api/v1/holidays/weekly-off/{id}` | DELETE | `HolidayAdmin` | adm/su | delete weekly-off |
| `/api/v1/holidays` | POST | `HolidayAdmin` | adm/su | create holiday |
| `/api/v1/holidays/{id}` | DELETE | `HolidayAdmin` | adm/su | delete holiday |
| `/api/v1/reports/agent-status/today` | GET | `EntryOperations` | emp/adm/su | report |
| `/api/v1/reports/pending` | GET | `EntryOperations` | emp/adm/su | report |
| `/api/v1/reports/today-submission` | GET | `EntryOperations` | emp/adm/su | report |
| `/api/v1/reports/today-collection` | GET | `EntryOperations` | emp/adm/su | report |
| `/api/v1/reports/today-transaction` | GET | `EntryOperations` | emp/adm/su | report |
| `/api/v1/reports/daily-visa-fee` | GET | `EntryOperations` | emp/adm/su | report |
| `/api/v1/reports/daily-bill` | GET | `EntryOperations` | emp/adm/su | report |
| `/api/v1/admin/security-day/open` | POST | `SecurityGate` | adm/su | open day |
| `/api/v1/admin/security-day/close` | POST | `SecurityGate` | adm/su | close day |
| `/api/v1/admin/security-day/today` | GET | `SecurityGate` | adm/su | today state |
| `/api/v1/admin/users` | POST | `UserManagement` | adm/emp | create user |
| `/api/v1/admin/superusers` | POST | `SuperUserOnly` | su (claim) | provision su |
| `/api/v1/admin/users/{id}/deactivate` | POST | `UserManagement` | adm/emp | deactivate |
| `/api/v1/admin/content/daily-update` | POST | `AdminPanel` | adm/su | save daily update |
| `/api/v1/admin/content/daily-update/{id}` | DELETE | `AdminPanel` | adm/su | delete daily update |
| `/api/v1/admin` | GET | `AdminPanel` | adm/su | representative |
| `/api/v1/billing` | GET | `BillingOperations` | emp/adm/su | representative |
| `/api/v1/agents` | POST | `AdminPanel` | adm/su | create agent |
| `/api/v1/agents` | GET | `AdminPanel` | adm/su | list agents |
| `/api/v1/agents/{id}` | PUT | `AdminPanel` | adm/su | update agent |
| `/api/v1/agents/{id}/deactivate` | POST | `AdminPanel` | adm/su | deactivate |
| `/api/v1/agents/{id}/reactivate` | POST | `AdminPanel` | adm/su | reactivate |

## 3. Legacy URL redirects (verified `LegacyUrlRewriteMiddleware.cs`)

| Legacy URL | Modern target | Status | Notes |
|---|---|---|---|
| `Default.asp` | `/` | 301 permanent | case-insensitive match |
| `authenticate.asp`, `logon.asp` | `/Auth/Login` | 301 permanent | |
| `regsub*.asp` (regsub, regsubmit, regsubdone) | `/Auth/Register` | 301 permanent | prefix match |
| any other `*.asp` | — | 404 | NFR-005: no silent forwarding |

## 4. Unresolved route relationships

1. **`/Admin/Index`** — now gated by the `AdminPanel` policy (adm/su) via its
   page model (SPEC-0009 T035/T038); the previous no-policy state left the
   route reachable by any caller. Resolved.
2. **`/Employee/Index`, `/Billing/Index`, `/Notifications/Index`** — no
   policy, no model (GAP-004); reachable by any authenticated user.
3. **`/Auth/Index`** — placeholder with no policy; reachable by anyone.
4. **`/Public/Register` vs `/Auth/Register`** — two register routes; the
   Public one is static (PARTIAL), the Auth one is functional. The legacy
   `regsub*.asp` redirect targets `/Auth/Register`; the Public route is
   orphaned in the nav (no links).
5. **`/api/v1/billing/entries`** — 501 placeholder gated by inline roles
   emp,adm,su while `/api/v1/billing` uses the `BillingOperations` policy;
   two different authorization mechanisms for the same module (GAP-004).
6. **`/api/v1/reporting` and `/api/v1/notifications`** — gated by inline
   `Roles = "emp,adm,su"` (verified Program.cs lines 388–399) while the
   functional routes in the same modules use the `EntryOperations` policy;
   the representative stubs and the real routes diverge in authorization
   mechanism (same role set, different enforcement).
7. **`/Auth/ChangePassword` redirect** — success redirects to `/Auth/Login`
   (verified line 54), which then redirects authenticated users to `/Index`;
   the double hop is legacy parity but undocumented as a decision.
8. **`rsn=C` never produced** — the login page renders a reason for `rsn=C`
   (day closed) but the day-gate only ever emits `rsn=O` (verified
   `Login.cshtml.cs` line 99); `rsn=C` is dead UI (legacy parity).

## 5. Provenance

Verified 2026-08-19: `read Program.cs` lines 340–819 (all API routes +
policies), `read LegacyUrlRewriteMiddleware.cs` (legacy redirects), `grep
RedirectToPage|LocalRedirect` (27 matches across page models), `grep @page`
(routes), `glob` (page files). Nothing asserted from memory.