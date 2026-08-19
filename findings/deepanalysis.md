# Deep Analysis — Security, RBAC & Database Integrity

**Generated:** 2026-08-06
**Source:** Exhaustive code audit (585 root `.asp` files) + live logins + live SQL queries against `VisaEntry`

---

## 1. Role-Based Access Control Audit

### 1.1 Quantitative summary

| Metric | Count |
|---|---|
| Total `.asp` files in root | 585 |
| Files referencing `session` (any use) | 171 |
| Files referencing `session("priv")` | 117 |
| Files referencing `session("su")` | 11 (only 1 file sets it) |
| Files with **zero** `session` references | 414 |
| Files using weak `session("priv")=""`-only gate (accepts guest) | 82 |
| Files using `priv="" or priv="guest"` gate (blocks guests) | 48 (all `update*.asp` re-themed pages) |
| Files with a genuine role-*denial* check (`priv<>"adm"` → reject) | **0** |

> **Headline finding:** There is **no hard role-based access control anywhere**. The only gate is "is `session("priv")` non-empty?", which passes `guest`, `agt`, `emp`, `adm`, and `su` alike. Every `session("priv")="adm"` comparison is a *display-only* condition (show/hide a button, header, or menu item) — never a redirect or rejection.

### 1.2 Redirect reason codes (`relogin.asp`)

| Code | Meaning |
|---|---|
| `B` | Bad username/password |
| `O` | Office not yet opened by admin (employee gate) |
| `C` | Office closed for day (employee gate) |
| `S` | Session expired |
| `V` | "Please relogin" — session empty (82 Style-A files) |
| `usb` | "Register/login first" — 48 Style-B files + `top*.asp` |

### 1.3 Session-variable mapping on login (`authenticate.asp`)

| DB privilege | `session("priv")` | Notes |
|---|---|---|
| `adm` | `"adm"` | uname, lname, extn=phoneno → `Administrator.asp` |
| `su` | `"adm"` | **su=`"Y"`** → `Administrator.asp` |
| `emp` | `"emp"` | only if `security` open-day row exists; else rsn=O/C → `Employee.asp` |
| `agt` | `"agt"` | agentid only in redirect URL `jn=<agentid>` — never in session |
| `registration` | `"guest"` | hardcoded `jn=253` in redirect |

> `session("userid")` and `session("agentid")` are **never set** in root (only read). This is the root cause of agent ID tampering.

---

## 2. Security Findings (prioritized)

### 2.1 CRITICAL — No role enforcement exists
Only "priv non-empty" gates; guests pass everything. 117 files reference `session("priv")`, 0 do role-denial.

### 2.2 CRITICAL — Self-registration → SU escalation
A guest can POST to `addNewUser.asp` / `editdonetest.asp` with `privilege=su` (field is **not whitelisted**, written lowercased). Chain: register → guest session → create `su` account → login as super user. Passwords stored **plaintext, lowercased**.

### 2.3 CRITICAL — `jn=` fully tamperable (agent data leak)
- `listforagents.asp:37-52` uses `request("jn")` (session fallbacks never set) with no validation against the logged-in agent.
- Changing `?jn=5` → `?jn=6` displays another agent's complete pax/status data.
- `agentStatement.asp:19` — `agent=cint(request("agent"))`, **no session check at all** → any agent's financial ledger readable anonymously.
- `authenticate.asp:84` — agent id exists only in the redirect URL.

### 2.4 HIGH — Unauthenticated DB-write endpoints
Truly anonymous (zero session text, no gated include):

1. `editdoneagent1.asp` — UPDATE `agents` (any agent profile, incl. Active flag)
2. `editdonebyagent1.asp` — UPDATE `agents` + sends email
3. `execute.asp` — mass UPDATE `paxstatus`
4. `editbill.asp` — INSERT (billing)
5. `holidayDeleteSubmit.asp` — DELETE holiday records
6. `holiday_WebEntry.asp` — INSERT/DELETE (web DB)
7. `querieDetail.asp` — INSERT queries
8. `sendawbgo.asp` — INSERT sent-AWB
9. `todayAgentStatusalltemp.asp` — INSERT
10. `openForDay.asp` — INSERT/DELETE `security` (open day)
11. `closeForDay.asp` — UPDATE `security` (close day)
12. `regsub.asp` / `regsubmit.asp` / `regsubdone.asp` — public registration (by design)
13. `insertEntry.asp` — full visa-entry INSERT chain, **anonymous** (references `session("uname")` but never validates it)

Guest-reachable write endpoints (inherit empty-check from includes): `addNewUser.asp` (can create su), `editdonetest.asp` (can set su), `deleteUser.asp` / `deleteSubmit.asp` (can delete any user incl. su), `addembassy.asp`, `addMoreCertificate.asp`, `BulkcollectionSubmit.asp`, `collection*.asp`, `dailyupdate.asp`, `hotelSubmit.asp`, `invoicecreditsubmit.asp`, `invoicesubmit.asp`, `newaddnewagents.asp`, `paymentsubmit.asp`, `SendSMS*.asp`, `newpassword.asp`, `newpasswordforagent.asp`.

### 2.5 HIGH — Open/Close-day flow is not admin-restricted
`open2.asp`/`close.asp` gate only on empty-priv (guest passes); `openForDay.asp`/`closeForDay.asp` are completely anonymous. Any logged-in user (or anonymous) can open/close the working day.

### 2.6 HIGH — SQL injection everywhere
String-concatenated queries from `request(...)` throughout. The only "defense" is `Replace(username1,"'",�)` in `authenticate.asp:22-23` — trivially bypassable. Examples: `listforagents.asp:124` concatenates `request("keywords")` raw into `LIKE '%...%'` and `response.write stmt` prints SQL to the browser; `insertEntry.asp:233` concatenates `request("retrieveremark")` raw.

### 2.7 HIGH — Backdoor in `connection.asp:177-184` (confirmed)
Runs on **every page** that includes `connection.asp`:

```vb
177: application("udaan_users")=request.querystring("udaanappraj123guruadm")
178: if request("udaan12345functiondisplaymarquee")=76 then
179:   response.write con          ' attempts to leak connection object
180: end if
181: response.write(application("udaan_users"))   ' reflected echo = XSS on every page
182: if application("udaan_users")="77" then
183:   con=""                      ' nulls connection = per-request DoS
184: end if
```

- Line 181 = **reflected XSS on every page**.
- Line 183 = **denial of service** (DB calls fail for that request).
- Nothing in the app depends on it. Identical block exists in `connectionold.asp`, `Demo\connection.asp`, `udaanuma-dev\connection.asp`, `r&d\connection.asp`.

### 2.8 MEDIUM — Hardcoded credentials
`sa`/`[REDACTED]` (live, `connection.asp:5`) plus historical prod creds `udaanindia`/`[REDACTED]`, `[REDACTED]`, `[REDACTED]`, `[REDACTED]` (SMS gateway) in plaintext across `connectionweb.asp`, `r&d/*`, `SendSMS*.asp` — with live server IPs.

### 2.9 MEDIUM — User-management gaps
- `newUser.asp` UI dropdown offers adm/emp/agt only, but the POST handler (`addNewUser.asp`) has **no whitelist**.
- `EditUser.asp` gates only on `session("uname")=""` (no priv check) — loads any user by `request("username")`.
- `deleteUser.asp` / `deleteSubmit.asp` can delete ANY account incl. su (guest-reachable).

### 2.10 MEDIUM — Agent profile edit unauthenticated
`editbyagent.asp` (form) gates on empty-priv; downstream `editdoneagent1.asp` / `editdonebyagent1.asp` have **no session check** — anonymous callers can rewrite any agent's profile.

---

## 3. Role → Module Access Matrix (as actually enforced)

| Module | guest | agt | emp | adm | su |
|---|---|---|---|---|---|
| Entry create/edit (`entry.asp`, `makeEntry.asp`, `editentry*.asp`, `insertEntry.asp`) | ✅ | ✅ | ✅ | ✅ | ✅ |
| Agent status list (`listforagents.asp`, `Agent.asp`, `todayAgentStatus*.asp`) | ✅ | ✅ | ✅ | ✅ | ✅ |
| Agent financial ledger (`agentStatement.asp`) | ✅ anonymous | ✅ | ✅ | ✅ | ✅ |
| Billing / collection (`dailybill.asp`, `collection*.asp`, `listbill.asp`) | ✅ | ✅ | ✅ | ✅ | ✅ |
| Search (`searchPax*.asp`, `searchEntry*.asp`, `SearchMyCountry.asp`) | ✅ | ✅ | ✅ | ✅ | ✅ |
| User management (create/delete, incl. su) | ✅ | ✅ | ✅ | ✅ | ✅ |
| Holiday / Weekly off | ✅ | ✅ | ✅ | ✅ | ✅ |
| Open/Close day (`securityHome.asp`, `openForDay.asp`, `closeForDay.asp`) | ✅ anonymous | ✅ | ✅ | ✅ | ✅ |
| Password change (`newpassword.asp`) | ✅ | ✅ | ✅ | ✅ | ✅ |
| `update*.asp` re-themed pages | ❌ | ✅ | ✅ | ✅ | ✅ |
| Admin menu section + su-only UI extras | – | – | – | ✅ | ✅ |

---

## 4. Database Deep-Dive

### 4.1 Schema integrity
- **0 foreign keys**, **2 primary keys**, **20 identity columns**.
- Relationships are implicit via naming convention (`refno`, `agentid`, `statusID` …), enforced only in app code.
- Schema drift vs `database.sql` (demo script): live DB has extra tables not in the script — `bighistory`, `smshistory`, `sentawb`, `CountryInfo`, `changesbill`, `weeklyoff`, `emailid`, `emaild1`, `hits`, `adcount`, `dtproperties`, `Results`, `smsQueue`, `invno`, `diary`.

### 4.2 Core data volumes

| Table | Rows |
|---|---|
| `bighistory` | 1,430,841 |
| `StatusHistory` | 1,287,261 |
| `sentmails` | 553,523 |
| `PaxStatus` | 359,338 |
| `invoicedetail` | 358,630 |
| `entryDetails` | 312,655 |
| `Mainentry` | 271,724 |
| `invoice` | 271,239 |
| `smshistory` | 47,534 |
| `Ledger` | 26,565 |
| `agents` | 4,218 |
| `Udaan_users` | 2,365 |
| `embassy` | 242 |

### 4.3 Data profile findings
- **Mainentry** spans 2001-12-02 → 2026-04-21; junk dates 1970 / 2207 present.
- **status distribution** (live): 601 Sent = 270,939; 201 Submitted = 337; 101 Dox Received = 212; 401 Pending = 192; others = ~800.
- **`entrytype` is NULL in 100% of Mainentry** — categorization moved to `PaxStatus`/`entryDetails`.
- **Financial:** `PaxStatus` visa-fee sum ≈ ₹87.1 crore (₹871M); total ≈ ₹78.6 crore. `invoice` has 271,239 rows; max `grandtotal` = 4.5×10¹⁴ (bad data); MIN = 0.
- **`invoice` frozen since 2009-01-17** (billing retired 17 yrs before the last Mainentry).
- **`Ledger` is dead:** 26,563 of 26,565 rows have `transdate = NULL`.
- **Orphaned data:** 6,517 `Mainentry` rows reference non-existent agent IDs. `PaxStatus` and `invoice` refno joins are clean (0 orphans).
- **Agent geography (top):** New Delhi 574, Mumbai 472, Bangalore 387, Chennai 365, Hyderabad 198, Kolkata 182, Ahmedabad 130.
- **`country` table empty (0 rows)** — country list actually lives in `embassy` / `CountryInfo`.
- **`registration` (43 rows)** stores plaintext passwords (`pwd` column) used for guest login.

### 4.4 Business taxonomy (live `status` table)

| statusID | Description | | statusID | Description |
|---|---|---|---|---|
| 101 | Dox Received | | 409 | Pending Late |
| 201 | Submitted | | 410 | Pending - Personal Appearance |
| 202 | Received & Submitted | | 411 | Pending - Internal Verification |
| 251 | Re-Submitted | | 501 | Collected |
| 301 | Urgent | | 502 | Under Process |
| 401 | Pending | | 503 | Rejected |
| 402 | Pending - Checklist issued | | 504 | Obtained |
| 403 | Pending - Addl. Docs Reqd. | | 505 | Parallel processing |
| 404 | Pending - Med. Clearance | | 506 | PPT Awaited |
| 405 | Pending - Await Contact | | 507 | DOX Awaited |
| 406 | Pending - Under Process | | 508 | Withdraw / Approval Awaited |
| 407 | Pending - Docs Referred | | 509 | Hold for Payment |
| 408 | Pending - Others | | 601 | Sent |

---

## 5. Recommendations (priority order)

1. **Enforce real RBAC** — central `session("priv")` denial checks on data pages; whitelist `privilege` in `addNewUser.asp`/`editdonetest.asp`; bind `agentid` to session server-side.
2. **Remove the `connection.asp` backdoor block** (lines 177-184).
3. **Move credentials out of source** → ODBC DSN / config + least-privilege SQL login (drop `sa`).
4. **Parameterize all SQL** (SQLi everywhere).
5. **Authenticate the write endpoints** (`editdoneagent1.asp`, `editdonebyagent1.asp`, `openForDay.asp`, `closeForDay.asp`, `insertEntry.asp`, `editbill.asp`, etc.).
6. **Restrict open/close-day** to admins only.
7. **Archive, don't deploy** — root shouldn't ship `r&d/`, `Demo/`, `_vti_*`, `.mdb`, `.zip`, `msoe.dll`.
8. **Use the domain model as the rewrite spec**; retire dead modules (Ledger / invoice) or reconcile them; add FK constraints + data cleanup (orphans, junk dates).
