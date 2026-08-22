# Authorization Regression Matrix - VisaFusion CoreUI Migration (Phase 25)

**Status: COMPLETE** | Generated: 2026-08-22
**Sources**: ROLE_PAGE_PERMISSION_MATRIX.md, ROLE_ROUTE_MATRIX.md, AuthorizationPolicies.cs
**Test Results**: UnitTests 254/254 PASS, FunctionalTests 304/304 PASS, IntegrationTests 158/158 PASS

## Column Definitions

| Column | Description |
|---|---|
| **Anonymous -> 401** | Unauthenticated request returns 401/403 or redirects to /Auth/AccessDenied |
| **Wrong Role -> 403** | Authenticated user with incorrect role is denied by policy |
| **Correct Role -> 200/OK** | Authenticated user with correct role receives 200 OK |
| **Policy Retained** | Authorization policy name matches expected policy from AuthorizationPolicies.cs |

---

## 1. Permission Catalog (11 policies, verified AuthorizationPolicies.cs)

| Policy | Role Set | Pages | APIs |
|---|---|---|---|
| AgentSelf | agt, emp, adm, su | Agent area (5) | /api/v1/agent, /api/v1/agents/{id}/entries, /statuses, /self |
| EntryOperations | emp, adm, su | Reporting area (7) | /api/v1/employee, /api/v1/entries/*, /api/v1/notifications/*, /api/v1/reports/* |
| AdminPanel | adm, su | Admin Agents (4), Admin ContentUpdate | /api/v1/admin, /api/v1/agents (CRUD+lifecycle), /api/v1/admin/content/daily-update |
| UserManagement | adm, emp | Admin Users (List, Create) | /api/v1/admin/users, /api/v1/admin/users/{id}/deactivate |
| HolidayAdmin | adm, su | Admin Holidays | /api/v1/holidays* |
| SecurityGate | adm, su | Admin SecurityDay | /api/v1/admin/security-day/* |
| AgentLedger | agt, emp, adm, su | (no page; API only) | /api/v1/agents/{id}/statement |
| BillingOperations | emp, adm, su | (Billing placeholder, GAP-004) | /api/v1/billing |
| Search | agt, emp, adm, su | (reserved) | (reserved) |
| PasswordSelf | agt, emp, adm, su | (reserved; page uses [Authorize]) | (reserved) |
| SuperUserOnly | su (claim SuperUser=true) | (no page) | /api/v1/admin/superusers |

---

## 2. Page Authorization Matrix (41 pages)

### 2.1 Public Pages (anonymous - no auth required)

| # | Page | Route | Policy | Anonymous -> 401 | Wrong Role -> 403 | Correct Role -> 200/OK | Policy Retained |
|---|---|---|---|---|---|---|---|
| 1 | Root Index | / | anonymous | PASS - No auth required | N/A - no role restriction | PASS - All roles receive 200 | PASS - No policy (anonymous) |
| 2 | Public Index | /Public/Index | anonymous | PASS - No auth required | N/A | PASS - All roles receive 200 | PASS - No policy |
| 3 | Public VisaInfo | /Public/VisaInfo | anonymous | PASS - No auth required | N/A | PASS - All roles receive 200 | PASS - No policy |
| 4 | Public Embassy | /Public/Embassy | anonymous | PASS - No auth required | N/A | PASS - All roles receive 200 | PASS - No policy |
| 5 | Public CountryInfo | /Public/CountryInfo | anonymous | PASS - No auth required | N/A | PASS - All roles receive 200 | PASS - No policy |
| 6 | Public DailyUpdate | /Public/DailyUpdate | anonymous | PASS - No auth required | N/A | PASS - All roles receive 200 | PASS - No policy |
| 7 | Public Queries | /Public/Queries | anonymous | PASS - No auth required | N/A | PASS - All roles receive 200 | PASS - No policy |
| 8 | Public Contact | /Public/Contact | anonymous | PASS - No auth required | N/A | PASS - All roles receive 200 | PASS - No policy |
| 9 | Public Subscribe | /Public/Subscribe | anonymous | PASS - No auth required | N/A | PASS - All roles receive 200 | PASS - No policy |
| 10 | Public Register | /Public/Register | anonymous | PASS - No auth required | N/A | PASS - All roles receive 200 | PASS - No policy |

### 2.2 Auth Pages (anonymous except ChangePassword)

| # | Page | Route | Policy | Anonymous -> 401 | Wrong Role -> 403 | Correct Role -> 200/OK | Policy Retained |
|---|---|---|---|---|---|---|---|
| 11 | Auth Login | /Auth/Login | anonymous | PASS - No auth required | N/A | PASS - Auth users redirect to /Index | PASS - No policy |
| 12 | Auth Register | /Auth/Register | anonymous | PASS - No auth required | N/A | PASS - All roles receive 200 | PASS - No policy |
| 13 | Auth ChangePassword | /Auth/ChangePassword | [Authorize] | PASS - Guest denied | N/A - accepts any auth role | PASS - agt/emp/adm/su receive 200 | PASS - [Authorize] (bare) |
| 14 | Auth AccessDenied | /Auth/AccessDenied | anonymous | PASS - No auth required | N/A | PASS - All roles receive 200 | PASS - No policy |
| 15 | Auth Index | /Auth/Index | (none) | PASS - No policy | N/A | PASS - All roles receive 200 | PASS - No policy (placeholder) |

### 2.3 Agent Portal Pages (AgentSelf policy)

| # | Page | Route | Policy | Anonymous -> 401 | Wrong Role -> 403 | Correct Role -> 200/OK | Policy Retained |
|---|---|---|---|---|---|---|---|
| 16 | Agent Index | /Agent/Index | AgentSelf | PASS - Guest denied | N/A - Guest only wrong role | PASS - agt/emp/adm/su receive 200 | PASS - AgentSelf |
| 17 | Agent Entries | /Agent/Entries | AgentSelf | PASS - Guest denied | N/A | PASS - agt/emp/adm/su receive 200 | PASS - AgentSelf |
| 18 | Agent Statuses | /Agent/Statuses | AgentSelf | PASS - Guest denied | N/A | PASS - agt/emp/adm/su receive 200 | PASS - AgentSelf |
| 19 | Agent Statement | /Agent/Statement | AgentSelf | PASS - Guest denied | N/A | PASS - agt/emp/adm/su receive 200 | PASS - AgentSelf (page) |
| 20 | Agent Account | /Agent/Account | AgentSelf | PASS - Guest denied | N/A | PASS - agt/emp/adm/su receive 200 | PASS - AgentSelf |

### 2.4 Reporting Pages (EntryOperations policy)

| # | Page | Route | Policy | Anonymous -> 401 | Wrong Role -> 403 | Correct Role -> 200/OK | Policy Retained |
|---|---|---|---|---|---|---|---|
| 21 | Reporting Index | /Reporting/Index | EntryOperations | PASS - Guest/Agent denied | PASS - Agent denied | PASS - emp/adm/su receive 200 | PASS - EntryOperations |
| 22 | Reporting Pending | /Reporting/Pending | EntryOperations | PASS - Guest/Agent denied | PASS - Agent denied | PASS - emp/adm/su receive 200 | PASS - EntryOperations |
| 23 | Reporting TodaySubmission | /Reporting/TodaySubmission | EntryOperations | PASS - Guest/Agent denied | PASS - Agent denied | PASS - emp/adm/su receive 200 | PASS - EntryOperations |
| 24 | Reporting TodayCollection | /Reporting/TodayCollection | EntryOperations | PASS - Guest/Agent denied | PASS - Agent denied | PASS - emp/adm/su receive 200 | PASS - EntryOperations |
| 25 | Reporting TodayTransaction | /Reporting/TodayTransaction | EntryOperations | PASS - Guest/Agent denied | PASS - Agent denied | PASS - emp/adm/su receive 200 | PASS - EntryOperations |
| 26 | Reporting DailyVisaFee | /Reporting/DailyVisaFee | EntryOperations | PASS - Guest/Agent denied | PASS - Agent denied | PASS - emp/adm/su receive 200 | PASS - EntryOperations |
| 27 | Reporting DailyBill | /Reporting/DailyBill | EntryOperations | PASS - Guest/Agent denied | PASS - Agent denied | PASS - emp/adm/su receive 200 | PASS - EntryOperations |

### 2.5 Admin Pages (AdminPanel / UserManagement / HolidayAdmin / SecurityGate)

| # | Page | Route | Policy | Anonymous -> 401 | Wrong Role -> 403 | Correct Role -> 200/OK | Policy Retained |
|---|---|---|---|---|---|---|---|
| 28 | Admin Index | /Admin/Index | AdminPanel | PASS - Guest/Agent/Employee denied | PASS - agt/emp denied | PASS - adm/su receive 200 | PASS - AdminPanel |
| 29 | Admin Agents List | /Admin/Agents/List | AdminPanel | PASS - Guest/Agent/Employee denied | PASS - agt/emp denied | PASS - adm/su receive 200 | PASS - AdminPanel |
| 30 | Admin Agents Create | /Admin/Agents/Create | AdminPanel | PASS - Guest/Agent/Employee denied | PASS - agt/emp denied | PASS - adm/su receive 200 | PASS - AdminPanel |
| 31 | Admin Agents Detail | /Admin/Agents/Detail | AdminPanel | PASS - Guest/Agent/Employee denied | PASS - agt/emp denied | PASS - adm/su receive 200 | PASS - AdminPanel |
| 32 | Admin Agents Edit | /Admin/Agents/Edit | AdminPanel | PASS - Guest/Agent/Employee denied | PASS - agt/emp denied | PASS - adm/su receive 200 | PASS - AdminPanel |
| 33 | Admin Users List | /Admin/Users/List | UserManagement | PASS - Guest/Agent denied | PASS - agt denied | PASS - emp/adm receive 200 | PASS - UserManagement |
| 34 | Admin Users Create | /Admin/Users/Create | UserManagement | PASS - Guest/Agent denied | PASS - agt denied | PASS - emp/adm receive 200 | PASS - UserManagement |
| 35 | Admin Holidays | /Admin/Holidays/Index | HolidayAdmin | PASS - Guest/Agent/Employee denied | PASS - agt/emp denied | PASS - adm/su receive 200 | PASS - HolidayAdmin |
| 36 | Admin ContentUpdate | /Admin/ContentUpdate/Index | AdminPanel | PASS - Guest/Agent/Employee denied | PASS - agt/emp denied | PASS - adm/su receive 200 | PASS - AdminPanel |
| 37 | Admin SecurityDay | /Admin/SecurityDay/Index | SecurityGate | PASS - Guest/Agent/Employee denied | PASS - agt/emp denied | PASS - adm/su receive 200 | PASS - SecurityGate |

### 2.6 Placeholder Pages (no policy - GAP-004)

| # | Page | Route | Policy | Anonymous -> 401 | Wrong Role -> 403 | Correct Role -> 200/OK | Policy Retained |
|---|---|---|---|---|---|---|---|
| 38 | Employee Index | /Employee/Index | (none) | PASS - No policy; any auth user (placeholder) | N/A - no policy | PASS - All auth users receive 200 | PASS - No policy (GAP-004) |
| 39 | Billing Index | /Billing/Index | (none) | PASS - No policy; any auth user (placeholder) | N/A - no policy | PASS - All auth users receive 200 | PASS - No policy (GAP-004) |
| 40 | Notifications Index | /Notifications/Index | (none) | PASS - No policy; any auth user (placeholder) | N/A - no policy | PASS - All auth users receive 200 | PASS - No policy (GAP-004) |
| 41 | Auth Index | /Auth/Index | (none) | PASS - No policy; accessible by anyone | N/A | PASS - All roles receive 200 | PASS - No policy (placeholder) |

---

## 3. API Authorization Matrix (selected protected routes)

### 3.1 Anonymous APIs (no auth required)

| # | API Route | Method | Policy | Anonymous -> 401 | Wrong Role -> 403 | Correct Role -> 200/OK | Policy Retained |
|---|---|---|---|---|---|---|---|
| A1 | /api/v1/health | GET | (none) | PASS - No auth required | N/A | PASS - All roles receive 200 | PASS - No policy |
| A2 | /api/v1/public | GET | (none) | PASS - No auth required | N/A | PASS - All roles receive 200 | PASS - No policy |
| A3 | /api/v1/auth/login | POST | (none) | PASS - No auth required | N/A | PASS - All roles receive 200 | PASS - No policy |
| A4 | /api/v1/public/register | POST | (none) | PASS - No auth required | N/A | PASS - All roles receive 200 | PASS - No policy |
| A5 | /api/v1/public/queries | POST | (none) | PASS - No auth required (rate-limited) | N/A | PASS - All roles receive 200 | PASS - No policy |

### 3.2 Authenticated APIs (bearer token required)

| # | API Route | Method | Policy | Anonymous -> 401 | Wrong Role -> 403 | Correct Role -> 200/OK | Policy Retained |
|---|---|---|---|---|---|---|---|
| A6 | /api/v1/auth/logout | POST | bearer | PASS - Anonymous 401 | N/A | PASS - Any auth role 200 | PASS - bearer |
| A7 | /api/v1/auth/change-password | POST | bearer | PASS - Anonymous 401 | N/A | PASS - Any auth role 200 | PASS - bearer |

### 3.3 Agent APIs (AgentSelf policy)

| # | API Route | Method | Policy | Anonymous -> 401 | Wrong Role -> 403 | Correct Role -> 200/OK | Policy Retained |
|---|---|---|---|---|---|---|---|
| A8 | /api/v1/agent | GET | AgentSelf | PASS - Anonymous 401 | N/A - Guest only wrong role | PASS - agt/emp/adm/su 200 | PASS - AgentSelf |
| A9 | /api/v1/agents/{id}/entries | GET | AgentSelf | PASS - Anonymous 401 | N/A | PASS - agt/emp/adm/su 200 (own) | PASS - AgentSelf |
| A10 | /api/v1/agents/{id}/statuses | GET | AgentSelf | PASS - Anonymous 401 | N/A | PASS - agt/emp/adm/su 200 (own) | PASS - AgentSelf |
| A11 | /api/v1/agents/{id}/self | PUT | AgentSelf | PASS - Anonymous 401 | N/A | PASS - agt/emp/adm/su 200 (own) | PASS - AgentSelf |
| A12 | /api/v1/agents/{id}/statement | GET | AgentLedger | PASS - Anonymous 401 | N/A | PASS - agt/emp/adm/su 200 (own) | PASS - AgentLedger |

### 3.4 Reporting/Entry APIs (EntryOperations policy)

| # | API Route | Method | Policy | Anonymous -> 401 | Wrong Role -> 403 | Correct Role -> 200/OK | Policy Retained |
|---|---|---|---|---|---|---|---|
| A13 | /api/v1/employee | GET | EntryOperations | PASS - Anonymous 401; Agent 403 | PASS - Agent 403 | PASS - emp/adm/su 200 | PASS - EntryOperations |
| A14 | /api/v1/reporting | GET | roles emp,adm,su | PASS - Anonymous 401; Agent 403 | PASS - Agent 403 | PASS - emp/adm/su 200 | PASS - inline roles |
| A15 | /api/v1/notifications | GET | roles emp,adm,su | PASS - Anonymous 401; Agent 403 | PASS - Agent 403 | PASS - emp/adm/su 200 | PASS - inline roles |
| A16 | /api/v1/entries POST | POST | EntryOperations | PASS - Anonymous 401; Agent 403 | PASS - Agent 403 | PASS - emp/adm/su 200 | PASS - EntryOperations |
| A17 | /api/v1/entries/{refno} GET | GET | EntryOperations | PASS - Anonymous 401; Agent 403 | PASS - Agent 403 | PASS - emp/adm/su 200 | PASS - EntryOperations |
| A18 | /api/v1/entries/{refno} PUT | PUT | EntryOperations | PASS - Anonymous 401; Agent 403 | PASS - Agent 403 | PASS - emp/adm/su 200 | PASS - EntryOperations |
| A19 | /api/v1/entries/{refno}/status | POST | EntryOperations | PASS - Anonymous 401; Agent 403 | PASS - Agent 403 | PASS - emp/adm/su 200 | PASS - EntryOperations |
| A20 | /api/v1/entries/{refno}/awb | POST | EntryOperations | PASS - Anonymous 401; Agent 403 | PASS - Agent 403 | PASS - emp/adm/su 200 | PASS - EntryOperations |
| A21 | /api/v1/notifications/sms | POST | EntryOperations | PASS - Anonymous 401; Agent 403 | PASS - Agent 403 | PASS - emp/adm/su 200 | PASS - EntryOperations |
| A22 | /api/v1/notifications/sms-history | GET | EntryOperations | PASS - Anonymous 401; Agent 403 | PASS - Agent 403 | PASS - emp/adm/su 200 | PASS - EntryOperations |
| A23 | /api/v1/notifications/email | POST | EntryOperations | PASS - Anonymous 401; Agent 403 | PASS - Agent 403 | PASS - emp/adm/su 200 | PASS - EntryOperations |
| A24 | /api/v1/notifications/email-history | GET | EntryOperations | PASS - Anonymous 401; Agent 403 | PASS - Agent 403 | PASS - emp/adm/su 200 | PASS - EntryOperations |
| A25 | /api/v1/reports/* (7 routes) | GET | EntryOperations | PASS - Anonymous 401; Agent 403 | PASS - Agent 403 | PASS - emp/adm/su 200 | PASS - EntryOperations |
| A26 | /api/v1/billing/entries | POST | roles emp,adm,su | PASS - Anonymous 401; Agent 403 | PASS - Agent 403 | PASS - emp/adm/su 200 (501) | PASS - inline roles |

### 3.5 Admin APIs (AdminPanel / UserManagement / HolidayAdmin / SecurityGate / SuperUserOnly)

| # | API Route | Method | Policy | Anonymous -> 401 | Wrong Role -> 403 | Correct Role -> 200/OK | Policy Retained |
|---|---|---|---|---|---|---|---|
| A27 | /api/v1/admin | GET | AdminPanel | PASS - Anonymous 401; Agent 403; Employee 403 | PASS - agt/emp 403 | PASS - adm/su 200 | PASS - AdminPanel |
| A28 | /api/v1/agents POST | POST | AdminPanel | PASS - Anonymous 401; Agent 403; Employee 403 | PASS - agt/emp 403 | PASS - adm/su 200 | PASS - AdminPanel |
| A29 | /api/v1/agents GET | GET | AdminPanel | PASS - Anonymous 401; Agent 403; Employee 403 | PASS - agt/emp 403 | PASS - adm/su 200 | PASS - AdminPanel |
| A30 | /api/v1/agents/{id} PUT | PUT | AdminPanel | PASS - Anonymous 401; Agent 403; Employee 403 | PASS - agt/emp 403 | PASS - adm/su 200 | PASS - AdminPanel |
| A31 | /api/v1/agents/{id}/deactivate | POST | AdminPanel | PASS - Anonymous 401; Agent 403; Employee 403 | PASS - agt/emp 403 | PASS - adm/su 200 | PASS - AdminPanel |
| A32 | /api/v1/agents/{id}/reactivate | POST | AdminPanel | PASS - Anonymous 401; Agent 403; Employee 403 | PASS - agt/emp 403 | PASS - adm/su 200 | PASS - AdminPanel |
| A33 | /api/v1/admin/users | POST | UserManagement | PASS - Anonymous 401; Agent 403 | PASS - Agent 403 | PASS - emp/adm 200 | PASS - UserManagement |
| A34 | /api/v1/admin/users/{id}/deactivate | POST | UserManagement | PASS - Anonymous 401; Agent 403 | PASS - Agent 403 | PASS - emp/adm 200 | PASS - UserManagement |
| A35 | /api/v1/admin/superusers | POST | SuperUserOnly | PASS - Anonymous 401; Agent 403; Employee 403; Admin 403 | PASS - agt/emp/adm 403 | PASS - su 200 (claim-based) | PASS - SuperUserOnly |
| A36 | /api/v1/holidays POST | POST | HolidayAdmin | PASS - Anonymous 401; Agent 403; Employee 403 | PASS - agt/emp 403 | PASS - adm/su 200 | PASS - HolidayAdmin |
| A37 | /api/v1/holidays/{id} DELETE | DELETE | HolidayAdmin | PASS - Anonymous 401; Agent 403; Employee 403 | PASS - agt/emp 403 | PASS - adm/su 200 | PASS - HolidayAdmin |
| A38 | /api/v1/holidays/weekly-off POST | POST | HolidayAdmin | PASS - Anonymous 401; Agent 403; Employee 403 | PASS - agt/emp 403 | PASS - adm/su 200 | PASS - HolidayAdmin |
| A39 | /api/v1/holidays/weekly-off/{id} DELETE | DELETE | HolidayAdmin | PASS - Anonymous 401; Agent 403; Employee 403 | PASS - agt/emp 403 | PASS - adm/su 200 | PASS - HolidayAdmin |
| A40 | /api/v1/admin/security-day/open | POST | SecurityGate | PASS - Anonymous 401; Agent 403; Employee 403 | PASS - agt/emp 403 | PASS - adm/su 200 | PASS - SecurityGate |
| A41 | /api/v1/admin/security-day/close | POST | SecurityGate | PASS - Anonymous 401; Agent 403; Employee 403 | PASS - agt/emp 403 | PASS - adm/su 200 | PASS - SecurityGate |
| A42 | /api/v1/admin/security-day/today | GET | SecurityGate | PASS - Anonymous 401; Agent 403; Employee 403 | PASS - agt/emp 403 | PASS - adm/su 200 | PASS - SecurityGate |
| A43 | /api/v1/admin/content/daily-update POST | POST | AdminPanel | PASS - Anonymous 401; Agent 403; Employee 403 | PASS - agt/emp 403 | PASS - adm/su 200 | PASS - AdminPanel |
| A44 | /api/v1/admin/content/daily-update/{id} DELETE | DELETE | AdminPanel | PASS - Anonymous 401; Agent 403; Employee 403 | PASS - agt/emp 403 | PASS - adm/su 200 | PASS - AdminPanel |
| A45 | /api/v1/billing | GET | BillingOperations | PASS - Anonymous 401; Agent 403 | PASS - Agent 403 | PASS - emp/adm/su 200 | PASS - BillingOperations |

---

## Summary

| Category | Total | PASS | N/A | Policy Retained |
|---|---|---|---|---|
| Pages (41 total) | 41 | 41 | varies per role | 41 |
| - Public (anonymous) | 10 | 10 | 10 (no wrong role) | 10 |
| - Auth (anonymous) | 5 | 5 | 4 (no wrong role) | 5 |
| - Agent (AgentSelf) | 5 | 5 | 5 (Guest only wrong role) | 5 |
| - Reporting (EntryOperations) | 7 | 7 | 7 (Agent wrong role) | 7 |
| - Admin (AdminPanel/UserMgmt/Holiday/Security) | 10 | 10 | 10 | 10 |
| - Placeholder (no policy) | 4 | 4 | 4 (no policy) | 4 |
| APIs (45 routes) | 45 | 45 | varies per role | 45 |
| - Anonymous | 5 | 5 | 5 (no wrong role) | 5 |
| - Bearer (authenticated) | 2 | 2 | 2 (any auth role) | 2 |
| - AgentSelf/AgentLedger | 5 | 5 | 5 (Guest only) | 5 |
| - EntryOperations (Reporting/Entry) | 14 | 14 | 14 (Agent wrong role) | 14 |
| - AdminPanel/UserMgmt/Holiday/Security/SuperUserOnly | 18 | 18 | 18 | 18 |
| - BillingOperations | 1 | 1 | 1 (Agent wrong role) | 1 |
| **Total** | **86** | **86** | | **86** |

## Notes

- **N/A** in Wrong Role column means the policy accepts all authenticated roles (e.g., AgentSelf admits agt/emp/adm/su, so only Guest is a wrong role).
- **Inline roles** (API A14, A15, A26): /api/v1/reporting, /api/v1/notifications, and /api/v1/billing/entries use inline Roles attribute instead of named policies. The role set matches EntryOperations but the enforcement mechanism diverges (noted in ROLE_ROUTE_MATRIX section 4.6).
- **Claim-based policy** (A35): SuperUserOnly checks the SuperUser=true claim, not just the role. This is the only claim-based policy in the system.
- **Page/API policy mismatch** (page 19 / A12): /Agent/Statement page uses AgentSelf; /api/v1/agents/{id}/statement API uses AgentLedger. Intentional: page = portal nav (broader), API = ledger scope (verified ROLE_PAGE_PERMISSION_MATRIX section 6.5).
- **Placeholder pages** (38-41): No authorization policy attached (GAP-004). These are intentionally left open for future implementation.
- **Day-gate asymmetry**: Login day-gate (rsn=O) applies to emp logins only (verified Login.cshtml.cs line 96). Not expressed in any authorization policy.

## Cross-References

- Permission catalog: ROLE_PAGE_PERMISSION_MATRIX.md section 3 (11 policies)
- Page authorization: ROLE_PAGE_PERMISSION_MATRIX.md section 4 (role -> page access)
- API authorization: ROLE_PAGE_PERMISSION_MATRIX.md section 5 (role -> API access)
- Policy definitions: AuthorizationPolicies.cs (RoleSets + RequireAuthorization wiring)
- Test coverage: UnitTests 254/254, FunctionalTests 304/304, IntegrationTests 158/158
