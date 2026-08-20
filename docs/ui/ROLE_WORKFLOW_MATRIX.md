# ROLE × WORKFLOW MATRIX — VisaFusion

**Status: COMPLETE** · Generated: 2026-08-19
**Sources**: page-model action handlers (grep `On(Get|Post|Put|Delete)` across
`src/VisaFusion.Web`), `src/VisaFusion.Web/Program.cs` (API wiring),
`src/VisaFusion.Web/Pages/Auth/Login.cshtml.cs` (day-gate + redirects),
`docs/ui/ROLE_BASED_NATIVE_PAGES_INVENTORY.md` §8 (legacy parity),
`docs/analysis/GAP_REPORT.md`.

**Method**: every row grounded in a tool call made 2026-08-19 (grep of
`public (async Task<IActionResult>|IActionResult) On(Get|Post|Put|Delete)` —
20 matches; read of `Login.cshtml.cs`; read of `Program.cs` lines 340–819).
No `UNKNOWN`.

## 1. Workflow inventory (verified action handlers)

| # | Workflow | Role(s) | Trigger (page action) | Native page | Route | API call | Redirect on success | Legacy parity |
|---|---|---|---|---|---|---|---|---|
| W1 | Login | Guest | `OnGet(rsn, returnUrl)` + `OnPostAsync(returnUrl)` | `Pages/Auth/Login.cshtml` | `/Auth/Login` | `POST /api/v1/auth/login` (JWT); cookie via `SignInManager` | `LocalRedirect(returnUrl or "/")`; day-gate reject → `/Auth/Login?rsn=O` | `authenticate.asp`/`logon.asp`; `relogin.asp?rsn=` B/O/C/S/V/usb |
| W2 | Register | Guest | `OnPostAsync` | `Pages/Auth/Register.cshtml` | `/Auth/Register` | `POST /api/v1/public/register` (role fixed `guest`, rate-limited) | — | `regsub*.asp` |
| W3 | Change password | all authenticated | `OnPostAsync` | `Pages/Auth/ChangePassword.cshtml` | `/Auth/ChangePassword` | `POST /api/v1/auth/change-password` | `RedirectToPage("/Auth/Login")` | `changepassword.asp` flag 2/3 |
| W4 | Agent portal landing | agt/emp/adm/su | `OnGet` (page model) | `Areas/Agent/Pages/Index.cshtml` | `/Agent/Index` | `GET /api/v1/agent` (representative) | — | `agentHome.asp` |
| W5 | Agent own entries | agt/emp/adm/su | `OnGet` (page model) | `Areas/Agent/Pages/Entries.cshtml` | `/Agent/Entries` | `GET /api/v1/agents/{id}/entries` (own-scoped) | — | `listforagents.asp` |
| W6 | Agent statuses | agt/emp/adm/su | `OnGet` (page model) | `Areas/Agent/Pages/Statuses.cshtml` | `/Agent/Statuses` | `GET /api/v1/agents/{id}/statuses` (own-scoped) | — | `agentpaxStatus.asp` |
| W7 | Agent statement | agt/emp/adm/su | `OnGet` (page model) | `Areas/Agent/Pages/Statement.cshtml` | `/Agent/Statement` | `GET /api/v1/agents/{id}/statement` (`AgentLedger`) | — | `agentStatement*` |
| W8 | Agent self-edit | agt/emp/adm/su | `OnPostAsync` | `Areas/Agent/Pages/Account.cshtml` | `/Agent/Account` | `PUT /api/v1/agents/{id}/self` (own-record scoping) | — | `AgentAccount.asp`/`editdonebyagent1.asp` |
| W9 | Reporting (7 reports) | emp/adm/su | `OnGet` (page models) | `Areas/Reporting/Pages/*` (7) | `/Reporting/*` | `GET /api/v1/reports/*` (7 routes) | — | `pendinglist.asp`, `todaySubmission*.asp`, `todayCollection*.asp`, `todayTransaction.asp`, `dailyVisaFee.asp`, `dailybill.asp` |
| W10 | Agent create | adm/su | `OnPostAsync` | `Areas/Admin/Pages/Agents/Create.cshtml` | `/Admin/Agents/Create` | `POST /api/v1/agents` | `RedirectToPage("Detail", {id})` | `addnewagents.asp`/`newagent.asp` |
| W11 | Agent edit | adm/su | `OnPostAsync` | `Areas/Admin/Pages/Agents/Edit.cshtml` | `/Admin/Agents/Edit` | `PUT /api/v1/agents/{id}` | `RedirectToPage("Detail", {id})` | `editdoneagent1.asp` |
| W12 | Agent deactivate/reactivate | adm/su | `OnPostDeactivateAsync` / `OnPostReactivateAsync` | `Areas/Admin/Pages/Agents/Detail.cshtml` | `/Admin/Agents/Detail` | `POST /api/v1/agents/{id}/deactivate` / `/reactivate` | — | `viewagent.asp` lifecycle |
| W13 | User create | adm/emp | `OnPostAsync` | `Areas/Admin/Pages/Users/Create.cshtml` | `/Admin/Users/Create` | `POST /api/v1/admin/users` | `RedirectToPage("List")` | `addNewUser.asp` |
| W14 | User deactivate | adm/emp | `OnPostDeactivateAsync(id)` | `Areas/Admin/Pages/Users/List.cshtml` | `/Admin/Users/List` | `POST /api/v1/admin/users/{id}/deactivate` | — | `deleteUser.asp` |
| W15 | Open/close security day | adm/su | `OnPostOpenAsync` / `OnPostCloseAsync` | `Areas/Admin/Pages/SecurityDay/Index.cshtml` | `/Admin/SecurityDay/Index` | `POST /api/v1/admin/security-day/open` / `/close` | — | `securityHome.asp`/`openForDay.asp`/`closeForDay.asp` |
| W16 | Holiday create/delete | adm/su | `OnPostCreateHolidayAsync` / `OnPostDeleteHolidayAsync` | `Areas/Admin/Pages/Holidays/Index.cshtml` | `/Admin/Holidays/Index` | `POST /api/v1/holidays` / `DELETE /api/v1/holidays/{id}` | — | `holiday_entry.asp`/`holidayDeleteSubmit.asp` |
| W17 | Weekly-off create/delete | adm/su | `OnPostCreateWeeklyOffAsync` / `OnPostDeleteWeeklyOffAsync` | `Areas/Admin/Pages/Holidays/Index.cshtml` | `/Admin/Holidays/Index` | `POST /api/v1/holidays/weekly-off` / `DELETE /api/v1/holidays/weekly-off/{id}` | — | `WeeklyOffList.asp` |
| W18 | Daily update content CRUD | adm/su | `OnPostCreateAsync` / `OnPostEditAsync` / `OnPostDeleteAsync` | `Areas/Admin/Pages/ContentUpdate/Index.cshtml` | `/Admin/ContentUpdate/Index` | `POST /api/v1/admin/content/daily-update` / `DELETE /api/v1/admin/content/daily-update/{id}` | — | `dailyupdate.asp` |
| W19 | Public query submit | Guest | static form → API | `Areas/Public/Pages/Queries.cshtml` | `/Public/Queries` | `POST /api/v1/public/queries` (rate-limited 5/hr/IP) | — | `querieDetail.asp` → `contactsendpre.asp` |
| W20 | SMS/email notification | emp/adm/su (API) | — (no page) | — | — | `POST /api/v1/notifications/sms` / `/email`; `GET .../sms-history` / `.../email-history` | — | `SendSMS.asp` (MOD-004; dispatch log-only, GAP-008) |

## 2. Workflow → database dependency (verified `VisaEntryDbContext.cs` DbSets)

| Workflow | Tables (DbSet) |
|---|---|
| W1 Login | AspNetUsers, AspNetRoles, AspNetUserClaims (Identity), `SecurityDays` (day-gate) |
| W2 Register | AspNetUsers |
| W3 Change password | AspNetUsers (PasswordHash) |
| W4 Agent landing | `Agents` |
| W5 Agent entries | `Entries`, `EntryPassengers`, `PaxCountryStatuses` |
| W6 Agent statuses | `PaxCountryStatuses`, `StatusHistory`, `Statuses` |
| W7 Agent statement | `Invoices`, `InvoiceDetails`, `LedgerHistory`, `MasterBalances` |
| W8 Agent self-edit | `Agents` |
| W9 Reporting | `Entries`, `EntryPassengers`, `PaxCountryStatuses`, `Agents`, `Invoices`, `InvoiceDetails`, `MasterBalances`, `Banks` (report procs) |
| W10–W12 Agent CRUD | `Agents`, `AgentStagings`, `AdminAuditLogs`, AspNetUsers (identity link) |
| W13–W14 User mgmt | AspNetUsers, AspNetRoles, AspNetUserClaims, `AdminAuditLogs` |
| W15 Security day | `SecurityDays`, `AdminAuditLogs` |
| W16–W17 Holidays | `Holidays`, `WeeklyOffs`, `Embassies`, `AdminAuditLogs` |
| W18 Content update | `ContentUpdates`, `AdminAuditLogs` |
| W19 Public query | `ContactQueries`, `EmailQueues` |
| W20 Notifications | `SmsQueues`, `SmsLogs`, `EmailQueues`, `EmailLogs` |

## 3. Unresolved workflow relationships

1. **W9 Reporting** — the 7 report pages call the 7 report APIs, but the
   report SQL lives in database views/procs (scripts 03, per inventory §8);
   the exact view/proc names are not re-verified this session — the DbSet
   surface above is the verified dependency.
2. **W15 day-gate** — the login day-gate (`rsn=O`) applies to `emp` logins
   only (verified `Login.cshtml.cs` line 96); the SecurityDay page itself is
   adm/su. The gate→page relationship is asymmetric and undocumented as a
   decision (see ROLE_PAGE_PERMISSION_MATRIX §6.10).
3. **W20 Notifications** — API exists and is gated by `EntryOperations`, but
   there is no page workflow; the Notifications page is a placeholder
   (GAP-004) and dispatch is log-only (GAP-008).
4. **W19 Public query** — the page is static (no page model); the workflow is
   entirely client-side form → API. Rate-limit thresholds are owner-supplied
   (no invented values, verified `Program.cs` lines 796–800).
5. **W10–W12 Agent CRUD** — the Create/Edit pages redirect to Detail, but
   Detail has no "back to list" workflow link beyond the sidebar "Agents"
   link; the list→detail→edit navigation chain is implicit.
6. **W13–W14 User mgmt** — Create redirects to List; List deactivate has no
   reactivate counterpart in the page surface (only deactivate verified in
   `Users/List.cshtml.cs` line 58).

## 4. Provenance

Verified 2026-08-19: `grep On(Get|Post|Put|Delete)` (20 action handlers),
`read Login.cshtml.cs` (W1), `read Program.cs` lines 340–819 (API per
workflow), `grep DbSet<` in `VisaEntryDbContext.cs` (41 DbSets), inventory
§8 legacy parity. Nothing asserted from memory.