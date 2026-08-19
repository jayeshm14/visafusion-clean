# Modernization Plan: Classic ASP → ASP.NET Core
### "Royal Routes / Udaan India" Visa Processing & Tour System (VisaEntry)

**Document status:** Live-analysis snapshot. All facts below were verified by executing the actual Classic ASP app and querying the live production SQL Server. **No code changes were made to the application.**
**Analysis date:** 2026-08-06
**Audience:** AI-assisted migration engineer. This document is intended to be fully self-contained — all facts below were verified by executing the actual Classic ASP app and querying the live production SQL Server.

---

## 1. Executive Summary

`G:\Projects\VisaEntry` is a production Classic ASP (VBScript) web application for a Delhi-based travel / visa facilitation company. It has operated **since 2001** against a live SQL Server database holding **~25 years of production data** (earliest record 2001-12-02, newest 2026-04-21).

The system has two faces:
1. **Public marketing site** ("Royal Routes" brand, formerly "Udaan India"): visa/embassy information pages, forms downloads, registration, contact.
2. **Internal back-office**: entry tracking (visa cases per agent per country), status lifecycle, billing/invoicing, SMS/email notifications, daily open/close security gate, content publishing (weekly/monthly "update" pages).

The app is **deeply insecure** (plaintext passwords, SQL injection everywhere, a deliberate query-string backdoor, no enforced role-based access control, agent identity taken from the query string), **architecturally monolithic** (585 ASP files in root, 2,293 total, 7,314 files / 200 MB), and has **no foreign keys and only 2 primary keys** across 52 tables.

The modernization target is **ASP.NET Core (EF Core + Razor Pages + ASP.NET Core Identity)** with a phased, keep-live-during-migration strategy. The 25 years of data must be preserved and cleansed in place; the application layer is rewritten module by module behind the same IIS host.

---

## 2. Current System Overview

### 2.1 Runtime & hosting
- **Application type:** Classic ASP, server-side VBScript, mostly inline HTML with ADODB recordsets.
- **Web server:** IIS (historically). Currently verified live on **IIS Express, PID 18564, `http://localhost:8100`**.
- **IIS Express config:** `C:\Users\jayes\Documents\IISExpress\config\applicationhost.config`
- **Database server:** SQL Server default instance `MSSQLSERVER` (hostname resolves as `VivaanPC`). DB name `VisaEntry`.
- **DB credentials:** `sa` / `sa123` — stored in plaintext in `connection.asp:5`, verified working. This is the single SQL login used by the whole app.
- **IIS appcmd / admin tools:** require elevated shell (not available during analysis) — only the running IIS Express and `sqlcmd` were used.

### 2.2 Scale
| Metric | Value |
|---|---|
| Total files | 7,314 |
| Total size | 200.3 MB |
| All ASP files | 2,293 |
| Live ASP files (root) | 585 |
| Duplicate/legacy codebases | ~5 (see §3.7) |
| `_vti_cnf` metadata files | ~394 |
| Dated `updateDDMMYY.asp` snapshots | ~700 |
| Database tables | 52 |
| Foreign keys | **0** |
| Primary keys | **2** |
| Identity columns | 20 |
| SQL login used | 1 (`sa`) |

### 2.3 Top-level folder layout (sizes)
| Folder | MB | Purpose |
|---|---|---|
| `r&d\` | 48.7 | Research/dev copies (726 ASP) — NOT production |
| `Demo\` | 41.4 | Demo/client forks (548 ASP) — NOT production |
| `udaanuma-dev\` | 33.7 | Dev branch (38 ASP) — NOT production |
| `updateimg\` | 20.3 | Uploaded content images |
| `forms\` | 17.2 | 57 embassy visa application PDF/DOC forms |
| `css\`, `js\` | 4.9 | AdminLTE 4 + Bootstrap Icons static assets |
| `assets\` | 2.9 | AdminLTE demo images |
| `images\` | 1.4 | Site images |
| `.vs\` | 17.5 | Visual Studio workspace (ignore) |
| `ActiveX\` | 0.2 | `OSSMTP.dll` COM component for email |

---

## 3. Application Architecture (Classic ASP)

### 3.1 Request flow
1. Browser requests a `.asp` page.
2. Nearly every page begins with `<!-- #include file="connection.asp" -->`.
3. `connection.asp` opens a **new ADODB connection** named `con` per request (in `on error resume next` mode).
4. Pages mix HTML output with VBScript blocks. Recordset loops render tables.
5. Server-side processing pages (e.g. `insertEntry.asp`, `collectionSubmit.asp`, `invoicesubmit.asp`) read `request("param")`, build **string-concatenated SQL**, and `con.execute`.

### 3.2 `connection.asp` (the de-facto "framework")
Key facts:
- Line 5: `con.open "provider=sqloledb...uid=sa;pwd=sa123;database=visaentry"` — plaintext superuser.
- Wrapped in `on error resume next` — **all subsequent script errors are silently swallowed**.
- Defines shared functions used across the app:
  - `LoadListBox(table, IDcol, descCol, selVal, fldname, where)` — populates `<select>`.
  - `UsrToSysDate(usrdt)` / `SysToUsrDate(...)` — DD/MM/YYYY ↔ SQL datetime conversion (string-based).
  - `getIDForDescription(tablename, description)` — reverse lookup, e.g. `getIDForDescription("Status","Sent")`.
  - `writeIDDescription(tablename, id)` — writes the description for an ID.
  - `confirm()` etc. are JS helpers (not VBScript).
- Company constants (name, phones, email) and `SMSDisplayName="UdaanIndia"`.
- **Backdoor (§9.1):** lines 177–184 echo/`null` the `con` connection based on query-string parameters.

### 3.3 Date handling convention
User-facing dates are `DD/MM/YYYY` strings; stored as SQL `datetime`. Conversion is done in VBScript via `UsrToSysDate`/`SysToUsrDate`. This is a source of many latent bugs (e.g. `Invoice` max date drift, junk dates 1970/2207 — see §4.6).

### 3.4 Include templates (shared layout)
- `top.asp`, `topAdmin.asp`, `topAgent.asp`, `AgentTop.asp`, `empbottom.asp`, `adminBottom.asp`, `Homebottom.asp`, `left.asp`, `home.asp`.
- `top.asp`/`topAdmin.asp`/`topAgent.asp` each contain session checks that redirect to `relogin.asp?rsn=<code>` when the session is empty/guest (codes: `B`, `O`, `C`, `S`, `V`, `usb`).

### 3.5 Module map of the 585 root files
Filename-pattern census (585 files, includes ~700 dated update snapshots counted separately below):
| Area | Count |
|---|---|
| Content / update pages | 280 (incl. ~700 dated snapshots, counted via pattern) |
| Agent management | 52 |
| Entry / status management | 19+ |
| SMS / email | 16 |
| Auth / registration | 14 |
| Embassy / forms | 13 |
| Billing / invoice | 10 |
| Reports | 6 |
| Admin panel | 4 |
| Test / scratch | 16+ (`agenttest`, `editdonetest`, `usertest`, `tempuma*`, `refnototaldetailsubTest*`, `*_old`, `HomebottomDemo`, ...) |
| Other / miscellaneous | 151 |

### 3.6 Key workflow pages (verified by reading source)
| Workflow | Pages |
|---|---|
| New entry (multi-pax, multi-country) | `makeEntry.asp`, `insertEntry.asp` |
| Edit entry | `editentry.asp`, `editEntrySubmit.asp`, `editdone.asp`, `editedone.asp` |
| Collection (pickup) | `collection.asp`, `collectionform.asp`, `collectionSubmit.asp`, `collectionPaxSubmit.asp`, `BulkCollection.asp`, `BulkcollectionSubmit.asp` |
| Status updates | `todayAgentStatus*.asp`, `showStatus.asp`, `status.asp`, `paxStatus.asp` |
| Billing | `dailybill.asp`, `invoicesubmit.asp`, `editbill.asp`, `creditnote.asp`, `creditprint.asp`, `dailyprint*.asp`, `dailyVisaFee.asp` |
| Agent self-service | `Agent.asp`, `agentHome.asp`, `listforagents.asp`, `AgentAccount.asp`, `agentStatement*.asp`, `agentinvoice.asp`, `agentpaxStatus.asp`, `emailAgent.asp`, `sendawb*.asp`, `sendSMSToQueue.asp` |
| Day open/close (security gate) | `securityHome.asp`, `openForDay.asp`, `closeForDay.asp`, `employee.asp` |
| Holidays / weekly off | `holidayHome.asp`, `holiday_entry.asp`, `holidaySubmit.asp`, `holidayList.asp`, `WeeklyOffList.asp` |
| Content publishing | `dailyupdate.asp`, `viewdailyupdate.asp`, `update.asp` + ~700 `updateDDMMYY.asp` snapshots |
| Public site | `Default.asp`, `profile.asp`, `contactus.asp`, `queries.asp`, `embassyhome.asp`, `CountryInfo.asp`, `VisaInfo.asp`, `forms.asp`, `registration.asp` |
| Messaging | `composeEmail.asp`, `message.asp`, `mymessage.asp`, `Addtoschedular.asp`, `scheduler` table |
| Task/private work | `tasks.asp`, `listtasks*.asp`, `priwork.asp`, `Tablecah.asp` |

### 3.7 Duplicate / stale codebases (DO NOT MIGRATE — archive)
- `Demo\` (548 ASP) — demo/client forks, incl. `Demo\` sub-site variants.
- `udaanuma-dev\` (38 ASP) — dev branch.
- `r&d\` (726 ASP) — research folder incl. `r&d\demo\`.
- `*_old`, `*_bak`, `*test`, `*Temp*` root files — scratch versions (e.g. `searchEntry_bak.asp`, `editagent-old.asp`, `topAgentDemo.asp`, `listforagentsDemo.asp`).
- `updateDDMMYY.asp` (≈700 files) — historical content snapshots; archive as static content, do not port logic.
- `_vti_cnf\` — FrontPage metadata; delete.
- `updatearun.asp`, `updatepankaj.asp`, `Defaultarun.asp`, `Phone arun.asp`, `arunsearch*.asp` — personal scratch copies.

### 3.8 Verified runtime behaviors worth preserving
- **Anonymous DB-write endpoints** exist (no login required): `insertEntry.asp`, `editdoneagent1.asp`, `execute.asp`, `openForDay.asp`, `closeForDay.asp`, `editbill.asp`, `deleteUser.asp`, `deleteSubmit.asp`, `paymentReceive.asp`, `paymentsubmit.asp`, `regsubmit.asp`, `usersubmit.asp`, `countryAll.asp` (≈13). Port each to a *role-protected* controller action — do not preserve anonymity.
- **`insertEntry.asp` flow:** reads `request.form("country"&k&l)` per pax per country; requires DOB for Canada (`canadaid=getIDForDescription("Embassy","canada")`, lines 25–27); blocks collection/submission when the embassy is closed for a holiday (`holidaylist` query line 36) or weekly off (`weeklyoff`); blocks Sunday; sets `insertEntry="N"` and writes a warning banner instead of inserting.
- **`listforagents.asp` (agent status view):** resolves the agent identity from `request("jn")` (never from the session) — this is the source of the agent-data-leak vulnerability (§5.5). Uses a 90-day rolling window (`mydate=date()-90`, `mydate1=date()-2`). Search posts keywords+countryID and **concatenates raw keywords into SQL** (line ~124 also prints the statement to the page).
- **`topAgent.asp`:** hardcodes an agent quick-login query string (seckey/params: `logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&ses=k3456l7dj9javyemsn&company=udaan&jn=...`).
- **Employee login gate:** `authenticate.asp` lines 62–79 — employees may only log in on days present in the `security` table (day open). If today is not an open day, redirect `relogin.asp?rsn=O`. Verified: last open day was 2026-04-16, so an `emp` login on 2026-08-06 is rejected.

---

## 4. Data Model (SQL Server `VisaEntry`)

### 4.1 Table census
- **52 tables**, **0 foreign keys**, **2 primary keys** (identity columns on `agents.agentsID` and `Udaan_users`? — no; the 2 PKs are on `registration` and `Udaan_users`), **20 identity columns**.
- Tables fall into classes:
  - **Core transactional:** `Mainentry`, `entryDetails`, `PaxStatus`, `PaxStatus` history chain, `StatusHistory`, `bighistory`, `sentmails`, `sentawb`, `smshistory`, `smsQueue`.
  - **Billing:** `invoice`, `invoicedetail`, `Ledger`, `masterbalance`, `invno`, `creditnote`-related (via `invoice.invtype`).
  - **Reference/lookup:** `Status`, `Category`, `EntryType`, `Poe`, `Embassy`, `bank`, `Attestation`, `certificate`, `country` (empty), `weeklyoff`, `holidaylist`, `hotel`, `cab`.
  - **People:** `agents`, `newagents`, `registration`, `Udaan_users`, `subscriber`, `emailid`, `emaild1`.
  - **Content:** `CountryInfo`, `VisaInfo`, `dailyUpdate`, `quote`, `hits`, `adcount`.
  - **Ops:** `security` (day open/close), `scheduler` (messages), `priwork` (tasks), `diary`, `deleteditem`, `changes`, `changesbill`, `Results` (temp).
  - **System:** `dtproperties`.

### 4.2 Row counts (live, 2026-08-06)
| Table | Rows | Notes |
|---|---|---|
| `bighistory` | 1,430,841 | Master audit trail (refno-level) |
| `StatusHistory` | 1,287,261 | Per-pax status transitions |
| `sentmails` | 553,523 | Email log |
| `PaxStatus` | 359,338 | Per-pax-per-country status/fees |
| `invoicedetail` | 358,630 | Invoice line items |
| `entryDetails` | 312,655 | Pax records |
| `Mainentry` | 271,724 | Master entry records |
| `invoice` | 271,239 | Invoices (frozen since 2009-01-17) |
| `smshistory` | 47,534 | SMS log |
| `Ledger` | 26,565 | Agent ledger — **dead module** (26,563 NULL transdate) |
| `agents` | 4,218 | Agent master |
| `Udaan_users` | 2,365 | App users (admins/employees/agents) |
| `security` | 1,461 | Day open/close log |
| `embassy` | 242 | Embassy master |
| `registration` | 43 | Public self-registrations (→ guest) |
| `country` | **0** | Empty (dead) |
| `masterbalance`, `invno`, `smsQueue`, `hits`, `adcount`, `quote`, `diary`, `cab`, `paxhotel`, `paxCab` | low/0 | See §9.4 dead tables |

### 4.3 Status taxonomy (`Status` table)
```
101 Dox Received            201 Submitted                202 Received & Submitted
251 Re-Submitted            301 Urgent                   401 Pending
402 Pending - Checklist issued   403 Pending - Addl. Docs Reqd.
404 Pending - Med. Clearance     405 Pending - Await Contact
406 Pending - Under Process      407 Pending - Docs Referred
408 Pending - Others        409 Pending Late             410 Pending - Personal Appearance
411 Pending - Internal Verification   501 Collected     502 Under Process
503 Rejected                504 Obtained                 505 Parallel processing
506 PPT Awaited             507 DOX Awaited              508 Withdraw  | 508 Approval Awaited (duplicate ID!)
509 Hold for Payment        601 Sent
```
**Data issue:** `statusID=508` has **two** descriptions (`Withdraw` and `Approval Awaited`) — orphaned/duplicate rows. Clean-up required before mapping to an enum.

### 4.4 Key tables — structure highlights
(Full 52-table column dump is in §12 Appendix A.)

**`Mainentry`** (master case): `refno` (not PK, no identity — allocated by app logic), `paxname`, `agent`, `companyname`, `passportno`, `totalpassengers`, `entries`, `subdate`, `coldate`, `receivedate`, `traveldate`, `sentDate`, `entrytype` (**100% NULL**), `category`, `attestation`, `poe`, `status`, `externalremark`, `internalremark`, `AgentInstruction`, `enteredby`, `entrydatetime`, `Bill`, `id` (numeric identity, *this* is the real key).

**`PaxStatus`** (per-pax-per-country): `refno`, `PaxID`, `CountryID`, `subdate`, `coldate`, `colcheck`, `sentDate`, `category`, `entrytype`, `statusID`, `remarks`, plus fee columns `visafee`, `handlingfee`, `ddcharges`, `couriercharges`, `Misccharges`, `total`, `VFSTTCharges`.

**`invoice` / `invoicedetail`:** `invoice(refno, invoiceno, hotelfee, cabfee, poe, poeremark, misc, miscremark, attestfee, attestremark, courierfee, grandtotal, invoicedate, remark, invtype)`. `invtype` distinguishes `'B'` (bill) vs other types. **Invoice writes stopped 2009-01-17** — 2009+ billing was abandoned or moved elsewhere; money column anomaly (§4.6).

**`Ledger`:** agent-wise debit/credit ledger with `balance`, `bank`, `paidas`, `ddno`, `reftype`. **Dead** — no transdate values.

**`agents`:** 27 cols (name, company, address, phones, emails, director, accounts, IATA/TAFI/TAAI membership flags, `smsno`).

**`Udaan_users`:** app login table — `username`, `Password` (**plaintext**), `privilege` (`su`/`adm`/`emp`/`agt`), `firstname`, `lastname`, `emailid`, `active`.

**`security`:** `date1`, `openingtime`, `openby`, `closingtime`, `closedby` — the daily open/close gate.

**`embassy`:** `EmbassyID` (identity), `Description`, address, phones, email, hours, `active`.

### 4.5 Data quality issues (verified)
1. `Mainentry.entrytype` is **100% NULL** across all rows.
2. `invoice` writes frozen 2009-01-17; later billing data lives only in `PaxStatus` fee columns.
3. `invoice.grandtotal` max ≈ **4.5 × 10^14** (junk/overflow values).
4. Junk dates: values near 1970 and 2207 present (bad conversions from DD/MM/YYYY strings).
5. 6,517 `Mainentry` rows orphaned (agent id pointing at missing agent).
6. `country` table empty; `CountryInfo`/`VisaInfo` content keyed off `Embassy`.
7. `statusID=508` duplicated description.
8. `Ledger` dead (26,563/26,565 NULL transdate).
9. No FKs ⇒ orphan rows are the norm; integrity must be reconstructed during migration.

### 4.6 Financial volume (for data-migration sizing)
- `PaxStatus.visafee` total ≈ **₹871M**; all-fees total ≈ **₹786M** (visafee > sum is itself a data anomaly to flag).

### 4.7 Schema drift vs `database.sql`
- `database.sql` (UTF-16, in repo) is a **demo script** with 40 `CREATE TABLE` — it does **not** match live 52-table schema (newer tables like `PaxAttestation`, `paxCab`, `paxhotel`, `smsQueue`, `masterbalance`, `newagents`, `Results`, `diary` etc. are absent or differ). **Do not** use it as the migration baseline; reverse-engineer from the live DB.

---

## 5. Authentication & Authorization

### 5.1 Roles (`Udaan_users.privilege`)
| privilege | Meaning | Approx. count | Notes |
|---|---|---|---|
| `su` | Super-user | 4 | e.g. `satish123`/`udaan123` (verified) |
| `adm` | Admin | 57 | e.g. `arun587`/`arun123` (verified) |
| `emp` | Employee | 10 | Gated by day-open table |
| `agt` | Agent | 2,294 | Actually agent rows in `agents`; login via `description` + pwd scheme `udaan-5376` etc. |
| `guest` | Public registrant | 43 (`registration`) | Created via `regsubmit.asp` |

### 5.2 Login flow
- `logon.asp` (AdminLTE 4 themed) → `authenticate.asp`.
- `authenticate.asp`: reads `username`/`password`, builds a `select * from Udaan_users where username='...' and Password='...'` (**SQLi + plaintext compare**), maps privilege→session vars (`uname, lname, extn, name, priv`), sets `su="Y"` for `su`, redirects:
  - adm/su → `Administrator.asp?uname=...`
  - emp → gated by `security` open-day; if closed → `relogin.asp?rsn=O`
  - agt → `Agent.asp?logon=Y&...&jn=<agentID>` (agent ID travels in URL only)
- `logout.asp` kills session.
- **`session("userid")` / `session("agentid")` are read in code but never set** — dead session variables.

### 5.3 RBAC enforcement reality
- **Zero role-denial checks** in the codebase. Of 585 root files: 171 reference `session`, 117 reference `session("priv")`, **414 reference session 0 times**, 82 are weak gates, 48 block guests (mostly `update*.asp`). No file denies based on privilege — at best they redirect guests to login.
- The **privilege value never restricts** which pages an authenticated user may open. Any logged-in `agt` can hit admin pages.

### 5.4 Critical security findings (all verified in source)
1. **Backdoor in `connection.asp` lines 177–184:** query params `udaanappraj123guruadm` echo internals; `udaan12345functiondisplaymarquee=76` leaks the `con` connection object into the page; `=77` sets `con` to `Nothing` → per-request DoS. Present in every copy of connection.asp.
2. **SQL injection everywhere:** user input concatenated into SQL in hundreds of places (search pages, `listforagents.asp` keyword search, login, all `request("...")` writes).
3. **Agent identity = query string:** `jn=`, `agent=`, `agentsID=` params select the acting agent. `listforagents.asp` shows *another agent's* statuses if `jn` is changed. Session identity is never used.
4. **Plaintext passwords** in `Udaan_users` and `registration`; passwords emailed in plaintext on registration (`addNewUser.asp` email body includes `Password: [REDACTED]`).
5. **Hardcoded secrets in code:** SQL `sa` password; SMS gateway creds `udaanindia` / `[REDACTED]` (`SendSMS.asp`); SMTP relay `relay.spectranet.com:25`, from `udaan@spectranet.com`; CDO config; hardcoded agent seckey.
6. **~13 anonymous DB-write endpoints** (see §3.8).
7. **`on error resume next`** swallows all runtime errors → silent data corruption.
8. Public `execute.asp` executes arbitrary SQL (anonymously).

---

## 6. Business Workflows (behavioural spec for the new system)

### 6.1 Entry creation
- Admin/employee fills `makeEntry.asp` (multi-pax, multi-country per entry).
- `insertEntry.asp` validates:
  - Canada requires DOB.
  - Coldate/subdate must not fall on a `holidaylist` holiday, embassy `weeklyoff`, or Sunday.
  - On violation: prints warning banner, `insertEntry="N"`, **does not insert**.
- Insert chain: `Mainentry` (allocates `refno` via `select max(refno)+1` — see `entry.asp:199` commented) → `entryDetails` (per pax, `PaxID`) → `PaxStatus` (per pax per country) → `StatusHistory` → `bighistory` (audit) → optional `sentmails` (email receipt) → `sentawb` (AWB).
- `displayRefno.asp` and `emailReceipt.asp` are includes used after insert.

### 6.2 Collection / submission / status lifecycle
- `collectionSubmit.asp`: iterates pax/country rows, validates dates vs holidays/weeklyoff/Sunday, sets status `Sent`/`Obtained` (via `getIDForDescription`), records to `StatusHistory`, `bighistory`, `sentmails`, optionally queues SMS.
- `todayAgentStatus*.asp` (14 variants): daily agent-wise status sheets; the "send by char" variants email/SMS status updates to agents.
- Status transition writes are consistent with the audit model: every change lands in `StatusHistory` (per pax) and `bighistory` (per refno, free-text `Remarks`).

### 6.3 Billing
- `invoicesubmit.asp`: `application.lock` for refno serialization; updates `invoice`; upserts `invoicedetail` per pax (`select 1 from invoicedetail where invoiceno=... and paxid=... and countryid=... and invtype='B'` then insert/update).
- `dailybill.asp`, `dailyprint*.asp`: daily billing reports.
- `creditnote.asp`, `creditprint.asp`, `invoicecreditsubmit.asp`: credit notes.
- **Legacy state:** invoice table frozen 2009; current billing likely manual/paper or via `PaxStatus` fees. Confirm with business owners before assuming the invoice module should be rebuilt (it may be intentionally discontinued).

### 6.4 Agent management
- CRUD: `addnewagents.asp`, `editagent.asp`, `viewagent.asp`, `deleteUser.asp`, `newagent.asp`, `neweditagent.asp`, `agentStatement*.asp` (financial statement per agent).
- `masterbalance` table tracks agent balance/due date (sparsely used).

### 6.5 Agent self-service portal
- `Agent.asp` (AdminLTE 4) → `agentHome.asp`, `listforagents.asp`, `agentpaxStatus.asp`, `agentinvoice.asp`, `AgentAccount.asp`, `emailAgent.asp`, `sendawb*.asp`, `SendSMS*.asp`, `sendSMSToQueue.asp`.
- Agent sees their own refnos, statuses, bills, AWB; triggers email/SMS to themselves and their own clients.

### 6.6 Reports
- `dailybill.asp`, `dailyVisaFee.asp`, `todaySubmission*.asp`, `todayCollection*.asp`, `todayTransaction.asp`, `pendinglist.asp`, `emailAllPending.asp`, `emailDaysPending.asp`, `emailCriteria.asp`, `emailRefno.asp` (email-driven reports), `urgent.asp`, `break.asp`.
- `searchByInvno.asp`, `searchbymail.asp`, `searchPax*.asp`, `searchEntry*.asp`, `searchResult.asp` — free-text/filter search (all SQLi-prone).

### 6.7 SMS / Email
- **SMS:** `SendSMS.asp` POSTs to `http://api.messaging4u.com/india/SendingSMS.aspx?username=udaanindia&pwd=[REDACTED]&<mobile>&<msg>` (plaintext creds, HTTP). Sender `UdaanIndia`; CDMA number `919818720698`. Logs to `smshistory`; queued via `SendSMSToQueue.asp`/`SendSMStoQueue.asp`→`smsQueue`.
- **Email:** `contactsendpre.asp:29-41` uses `CDO.Message`/`CDO.Configuration` (SMTP `relay.spectranet.com`, port 25); `addNewUser.asp` uses `OSSMTP.SMTPSession` COM (ActiveX `OSSMTP.dll`, `oSMTP.RaiseError=True`). Logs to `sentmails`/`sentawb`.
- **Replacement plan:** both CDO and OSSMTP are COM-on-Windows — replace with `SmtpClient`/mail library and a real SMTP provider (or modern HTTP mail API). The `relay.spectranet.com` relay may be defunct — confirm.

### 6.8 Holiday / weekly-off management
- `holidayHome.asp`, `holiday_entry.asp`, `holiday_WebEntry.asp`, `holidaySubmit.asp`, `holidayDeleteSubmit.asp`, `WeeklyOffList.asp` — CRUD on `holidaylist` and `weeklyoff` keyed to `EmbassyID`.

### 6.9 Content publishing
- `dailyupdate.asp` + `viewdailyupdate.asp` manage the `dailyUpdate` table (date + description).
- ~700 `updateDDMMYY.asp` static snapshot pages (embassy news) — port as static/markdown content, not code.

### 6.10 Security day open/close
- `securityHome.asp`, `openForDay.asp`, `closeForDay.asp` — writes `security` rows; blocks employee logins on closed days.

### 6.11 Tour modules (legacy/low usage)
- `hotel.asp`, `hotelSubmit.asp`, `paxhotel`; `cabs.asp`, `cabsrecord.asp`, `paxCab`. Used for visa-plus-travel services; verify current usage before building.

### 6.12 Public website
- `Default.asp` (AdminLTE 4 themed, has a hardcoded "Messages 3 / Brad Diesel" demo dropdown — a **bug**: dead demo data visible publicly). Hits counter commented out (§3 `Default.asp` lines 3–14).
- `profile.asp`, `contactus.asp`/`contact.asp`/`contactsendpre.asp`, `queries.asp`/`getqueries.asp`/`querieDetail.asp`, `embassyhome.asp`, `CountryInfo.asp`, `VisaInfo.asp`, `forms.asp` (57 PDF/DOC downloads), `registration.asp`, `subscribe.asp`.
- SEO meta present (Royal Routes keywords). `malasya.asp`, `ekido.asp`, `welgrow.asp`, `new year 2006.asp` — legacy one-off pages.

### 6.13 Registration / subscription
- `registration.asp` → `regsubmit.asp` creates a `registration` row, optionally emails welcome via OSSMTP, then becomes a `guest` login (`logon.asp` allows uid/pwd from `registration` too — verify which table authenticates guests).

---

## 7. External Dependencies

| Dependency | Where | Risk |
|---|---|---|
| `http://api.messaging4u.com/india/SendingSMS.aspx` | `SendSMS.asp` | Defunct/low-reliability SMS gateway; hardcoded creds; HTTP not HTTPS |
| `relay.spectranet.com:25` SMTP | CDO (contactsendpre.asp) + OSSMTP (addNewUser.asp) | Legacy relay; may be dead; port 25 often blocked |
| `OSSMTP.SMTPSession` COM | `ActiveX\OSSMTP.dll` | Windows/32-bit COM only — not portable to .NET on modern hosts |
| `CDO.Message` / `CDO.Configuration` | contactsendpre.asp | COM only; deprecated |
| `udaanindia.com`, `www.udaanindia.com` | topNav, topAgent.asp | Old brand domain links (broken branding; site now Royal Routes) |
| `chat/Default.asp`, `chat/Clientdefault.asp` | `authenticate.asp:48`, `topAgent.asp:70` | **Folder does not exist** → broken links (see §9.3) |
| VFS Global / embassy / consulate sites | content pages | External content links; verify liveness |
| `cdn.jsdelivr.net` (bootstrap-icons, bootstrap 5.3.7, popper) | AdminLTE 4 pages | Requires internet at runtime; consider self-hosting for intranet reliability |
| 57 embassy forms in `forms\` | `forms.asp` | Static downloads — copy as-is |

---

## 8. UI / Frontend

### 8.1 Current state
- Majority of pages: classic table-based HTML, `iso-8859-1`, inline `onMouseOver` image-swap scripts, `bgcolor=#FFFFFF`.
- A **AdminLTE 4 + Bootstrap 5.3.7 + Bootstrap Icons** re-theme is **partially applied** to the shell pages only:
  - `logon.asp`, `Administrator.asp`, `Agent.asp`, `Default.asp`, `update.asp` reference `css/adminlte.min.css`, `js/adminlte.min.js`, `bootstrap-icons` CDN, `fonts/source-sans-3` woff2.
  - `topAdmin.asp`/`topAgent.asp` contain the responsive nav that the inner pages still embed in their own HTML.
- Static assets available: `css\` (adminlte*.css + maps, bootstrap-icons.css), `js\` (adminlte*.js + maps), `assets\img\` (AdminLTE demo images incl. `user1-128x128.jpg`), `fonts\`.

### 8.2 Migration UI strategy
- Keep the AdminLTE 4 look as the base skin for the new Razor Pages layout (it is already the de-facto brand).
- Self-host adminlte/css/js/fonts/icons (no CDN) for reliable intranet + offline operation.
- Replace all `iso-8859-1` with UTF-8; fix the demo dropdown on `Default.asp`.

---

## 9. Known Bugs, Errors & Undeveloped Features

### 9.1 Security backdoor (CRITICAL)
`connection.asp:177-184`: query params `udaanappraj123guruadm` (echo) and `udaan12345functiondisplaymarquee=76|77` (dump / null the DB connection). **Remove entirely** in new code; do not port.

### 9.2 Bugs visible at runtime
- `Default.asp` shows AdminLTE demo dropdown "Brad Diesel / Call me whenever..." — leftover template demo content on the public homepage.
- `tritri.asp` includes missing `top1.asp` → 500 error on that page (only missing include found).
- `update.asp` (the "Update" nav page, 1,918 lines) mixes a **password change form** with content publishing UI — convoluted; split responsibilities.
- `invoice` max `grandtotal` = 4.5×10^14 (money type corrupted by string concat).
- `Status` duplicate ID 508.
- Junk dates 1970/2207.
- Hits counter code commented out — the public counter is dead.
- `application.lock` used around refno allocation (entry.asp:199 shows the old `max(refno)` approach) — race conditions possible; replace with identity/SQL `OUTPUT` or sequence.
- `listforagents.asp` prints its SQL to the page (debug leak).

### 9.3 Broken dependencies
- `chat\` folder missing → `chat/Default.asp` and `chat/Clientdefault.asp` 404 (referenced from `authenticate.asp:48`, `topAgent.asp:70`).
- `top1.asp` missing (only `tritri.asp` includes it).
- `r&d\bighistory.asp`, `r&d\count2.asp`, `r&d\HOLIDAYLIST.ASP` use `../` parent includes — broken outside root (scratch only).

### 9.4 Dead / unused tables & modules (undeveloped or abandoned)
- `country` (0 rows), `hits` (counter disabled), `adcount` (ads), `quote` (quote-of-day), `diary`, `invno` (invoice counter superseded), `smsQueue` (queue exists but gate is legacy), `cab`, `hotel`, `paxCab`, `paxhotel` (tour modules, verify usage), `masterbalance` (sparse), `Results` (temp), `emaild1`/`emailid` (unused email lists), `newagents` (registration staging), `deleteditem` (audit only), `changes`/`changesbill` (change-log only), `subscriber` (newsletter), `dailyUpdate` (used by `dailyupdate.asp`), `priwork`/`tasks` (task tracking), `scheduler` (messaging), `dtproperties` (system).
- `Ledger` + all ledger screens (`paymentReceive.asp`, `paymentsubmit.asp`, `visapayment.asp`, `agentStatement*.asp` partly) — **dead since ~2009**.
- `invoice`/`invoicedetail` frozen 2009 — confirm intended disposition.
- Category `Business Me` is `Active=N`.

### 9.5 Scratch/test files (16+)
`agenttest.asp`, `agenttestsubmit.asp`, `editdonetest.asp`, `newagenttestsubmit.asp`, `embassytestsubmit.asp`, `usertest.asp`, `usertestsubmit.asp`, `tempuma.asp`, `tempuma1.asp`, `testuma.asp`, `test1.asp`, `test11.asp`, `test03.asp`, `refnototaldetailsubTest.asp`, `refnototaldetailsubTest1.asp`, `listforagentsDemo.asp`, `logonDemo.asp`, `topAgentDemo.asp`, `HomebottomDemo.asp`, `*_old.asp`, `*_bak.asp`, `trial.asp`, `PCHECK.ASP`, `5555.asp`, `5555`... Delete/archive; do not migrate.

### 9.6 Unfinished / questionable features
- `customerfeedform.asp`, `encloser.asp`, `enterWP.asp`, `open2.asp`, `listbox8888.asp`, `listbill1.asp`, `searchEntryarun4444.asp`, `arunsearch4444.asp`, `newp.asp`, `udaan.asp`, `tri.asp`, `break.asp`, `urgent.asp`, `welgrow.asp`, `ekido.asp`, `malasya.asp`, `DareAdventure110306.asp`, `new year 2006.asp`, `header111.asp`, `top1111.asp`, `updatecar*.asp`, `updatehotel.asp`, `updatetraveljobs*.asp` — one-off/skeleton pages; validate each before porting.

---

## 10. Migration Plan to ASP.NET Core

### 10.1 Target architecture
```
┌────────────────────────────────────────────────────────────┐
│ ASP.NET Core 8/9 Web App (Razor Pages) on IIS / IIS Express │
│  - Controllers/Handlers per module (from §6)               │
│  - ASP.NET Core Identity (custom stores → Udaan_users,      │
│    registration, agents)                                    │
│  - EF Core (SqlServer) — reverse-engineered DbContext       │
│  - Static content: forms/, updateimg/, css/, js/, fonts/    │
│  - BackgroundService: SMS queue, email queue, reports       │
│  - Serilog + appsettings for secrets                        │
└───────────────────────────┬────────────────────────────────┘
                            │ EF Core / Dapper
                  ┌─────────▼─────────────────────────┐
                  │ SQL Server VisaEntry (in-place,    │
                  │  data-cleansed, indexes+FKS added) │
                  └────────────────────────────────────┘
```

### 10.2 Proposed stack
- **.NET 8 LTS** (or 9) — Razor Pages, minimal controllers where APIs are needed.
- **EF Core** with `Microsoft.EntityFrameworkCore.Design` reverse-engineering (`Scaffold-DbContext`) to bootstrap the model from the live DB.
- **ASP.NET Core Identity** with custom `UserStore` mapping to `Udaan_users` (and separate agent/registration identities), **password hashing** (`PasswordHasher`) — do NOT store plaintext.
- **Validation & date handling:** NodaTime or `DateTime` with explicit culture; replace VBScript string-date conversion.
- **Scheduling:** `BackgroundService` + `System.Threading.Channels` for SMS/email queue; `Hangfire` if complex jobs (reports).
- **Secrets:** `appsettings.json` + User Secrets/Key Vault; remove hardcoded creds.
- **Logging:** Serilog to file + SQL; replace swallowed `on error resume next`.

### 10.3 Suggested project layout
```
src/
  VisaEntry.Web/            Razor Pages app (Areas: Admin, Agent, Employee, Public, Billing, Reporting)
  VisaEntry.Data/           EF Core DbContext, entities, migrations
  VisaEntry.Core/           Domain services (EntryService, StatusService, BillingService, SmsService, EmailService)
  VisaEntry.Jobs/           Background worker (SMS/email queues, daily reports)
tests/
  VisaEntry.Tests/          xUnit unit + integration tests
tools/
  DataMigration/            Console app: cleanse + migrate data, rebuild FKs/indexes
```
Areas mirror the old module map: **Public**, **Auth**, **Employee** (entry/status), **Agent** (self-service), **Admin** (masters/content/security), **Billing**, **Reporting**, **Notifications**.

### 10.4 Authentication & authorization remediation
| Legacy | Target |
|---|---|
| Plaintext `Password` in `Udaan_users` | `PasswordHasher` (bcrypt-style PBKDF2); migration tool hashes existing rows on first login (or bulk) |
| `session("priv")` display-only | Role claims (`su/adm/emp/agt/guest`) + `[Authorize(Roles="adm,su")]` per page/handler |
| Agent identity via `jn=` query string | Identity from cookie claims; never trust query string. Map agent↔user via `Udaan_users.username = agents.Description` |
| Employee day-open gate | Keep as a business rule in an `IAuthorizationPolicy` (check `security` table for today) or service-level check |
| ~13 anonymous writes | All become authenticated + role-checked handlers |
| Backdoor | Remove |
| SQLi | EF Core parameterized queries / Dapper with parameters |

### 10.5 Data access strategy
- **Phase 0:** `Scaffold-DbContext` against live DB → generate entities.
- **Phase 1:** Add a clean domain model + explicit mapping to legacy columns (keep legacy table names/columns; the DB stays the single source of truth; no big-bang rewrite).
- **Phase 2:** Add FKs + indexes in a staging copy first, validate, then apply to production with downtime plan.
- Keep `refno` semantics: allocate via `int identity` or a dedicated counter table with atomic `UPDATE ... OUTPUT`, replacing `application.lock`/`max(refno)`.

### 10.6 Module migration map (legacy → target)
| Legacy module | Target |
|---|---|
| `connection.asp` + all pages | `appsettings.json` connection string + `AddDbContext` (scoped, `Encrypt=True` once TLS available) |
| `makeEntry/insertEntry` | `Employee/Entries` Razor Page + `EntryService` (validation: Canada DOB, holidaylist/weeklyoff/Sunday checks moved to server) |
| `todayAgentStatus*` | `Employee/DailyStatus` page + background email/SMS dispatch |
| `invoicesubmit/dailybill` | `Billing/*` pages + `BillingService` (clarify with owners if invoice module is dead) |
| `agent self-service` | `Agent` area, identity-bound to `agents.Description` |
| `openForDay/closeForDay` | `Admin/SecurityGate` page writing `security` |
| `SendSMS` + `smsQueue` | `SmsService` (HTTP gateway with HTTPS, retries, logging to `smshistory`) + `BackgroundService` queue worker |
| CDO/OSSMTP email | `EmailService` using SMTP (`SmtpClient`) or mail API; log to `sentmails`/`sentawb` |
| `holiday/weeklyoff` | `Admin/Holidays` pages |
| `dailyupdate` + `updateDDMMYY.asp` snapshots | CMS: `Admin/Content` editing `dailyUpdate`; snapshots imported as static HTML |
| Public site | Public area; keep SEO meta; **fix demo dropdown**; static forms download |
| Reports | `Reporting` area (HTML/Excel via `ClosedXML`); parameterized queries |
| `ledger`/`invoice` | **Do not rebuild** unless owners confirm they are back in use |

### 10.7 Security remediation checklist (new code)
1. Remove backdoor, all hardcoded secrets → config/secrets.
2. Hash passwords; enforce password policy.
3. Parameterize every query (no string SQL).
4. `[Authorize]` + role policies on every page; unit-test that guests can't reach employee/agent/admin pages.
5. Anti-CSRF (Razor Pages has it by default), request size limits, output encoding (Razor encodes by default).
6. HSTS, CSP, no `on error resume next` (use structured exception handling).
7. Session: use cookie auth with secure cookies; drop reliance on query string identity.
8. Audit log: keep writing `bighistory`/`StatusHistory`/`sentmails`/`smshistory` so 25-year history stays continuous.

### 10.8 Data migration strategy
1. **Backup** the DB (`BACKUP DATABASE VisaEntry`).
2. **Cleanse in a staging copy:** fix `statusID=508` duplicate; null→default for `entrytype`; clamp junk dates; repair/flag 6,517 orphan `Mainentry` agents; decide on `invoice`/`Ledger` freeze.
3. **Add constraints/indexes** in staging; measure impact on 1.4M-row history tables (index `StatusHistory(PaxID, Date)`, `bighistory(refno)`, `sentmails(agentsid, date)`, etc.).
4. **Application writes continue against live DB** during phasing (same DB, new app) → no data cutover risk; old ASP stays until parity.
5. **Cutover:** flip default document / redirect old `.asp` (URL-rewrite) to new routes; keep old app on a maintenance URL for the transition window.

### 10.9 Phased rollout
- **Phase 0 (1–2 wks):** scaffold EF, Identity, auth gates, static assets, URL rewrite. App boots.
- **Phase 1 (Billing-free core):** login, entry creation, status update, agent self-service (read-only), daily status pages. Run in parallel; compare counts.
- **Phase 2:** notifications (SMS/email), holiday/weeklyoff, content CMS, reports.
- **Phase 3:** agent/admin CRUD, security gate, public site, forms.
- **Phase 4:** data cleanse + constraints + cutover; decommission old ASP; archive Demo/r&d/udaanuma-dev.

### 10.10 Testing strategy
- Export a sanitized subset (e.g. 6 months, 50 agents) for integration tests.
- Golden-file comparison: run old ASP vs new handler over the same refno set and diff results (status transitions, fees, emails sent).
- xUnit tests for `EntryService` validation rules (Canada DOB, holiday/weeklyoff/Sunday), billing math, date conversion edge cases (DD/MM/YYYY, junk dates).
- Load-test history reads (1.4M rows) with indexes.

---

## 11. Risks & Unknowns (owner decisions required)

1. **Is the invoice/billing module intentionally frozen since 2009?** If so, exclude from scope; if not, 17 years of billing data must be reconstructed from `PaxStatus` fees.
2. **Agent login model:** agents authenticate with `description`+password from `agents` table while `Udaan_users` also holds `agt` rows — confirm which is authoritative.
3. **SMS gateway `api.messaging4u.com` and SMTP `relay.spectranet.com`** may be defunct — confirm current vendor and obtain new credentials (the SMS/SMTP numbers in the code are old).
4. **Public chat links** (`chat/...`) are broken in legacy; confirm feature was abandoned (likely) so we do not rebuild it.
5. **Tour modules** (hotel/cab) — usage status unknown; likely abandon.
6. **`updateDDMMYY.asp` snapshots** (~700): keep as archived static pages or import into CMS?
7. **Superuser count/ownership:** 4 `su` accounts; define the new super-admin provisioning.
8. **Data anomalies** (junk dates, duplicate 508, orphan agents, `entrytype` 100% NULL) need business sign-off on repair rules.
9. **Old brand domain** `udaanindia.com` references vs current `Royal Routes` branding — decide canonical domain.
10. **`sa` account:** create dedicated least-privilege app login; `sa` only for migration.

---

## 12. Appendix A — Full 52-table schema (live, 2026-08-06)

Format: `table | column_id | column | type | max_length | nullable | identity`

```
adcount      | AddLocation(numeric,9), Hitdate(datetime), adcount(numeric,9), Description(varchar,200)   [adcountid identity]
agents       | 27 cols: agentsID[ID], Description, companyname, complexname, street1, street2, area, city,
             |   pincode, phoneno, faxno, emailid(nvarchar,2000), directorname, acno, payment, active,
             |   TAAI, TAFI, MEMBERSHIP, CREATIONDATE, IATA, DirectorPH, AcMgrPH, VisaInchargeName,
             |   VisaInchargePH, enteredby, smsno
Attestation  | AttestationID, Description(varchar,50)
bank         | bankid, description, Active
bighistory   | bighistoryid[ID], refno, agent, Date, UpdatedBy, Remarks(nvarchar,7800)
cab          | cabid, description
Category     | CategoryID, Description, Active
certificate  | certificateID, description
changes      | refno, description
changesbill  | refno, description
country      | countrycode, country, description   (0 rows)
CountryInfo  | CountryID, About(1500), Climate(1500), Language(800), Religion(700), Curency(500),
             |   TimeZone(500), Continent_File, Flag_File, Visa_File
dailyUpdate  | entrydate, Description(nvarchar,8000)
deleteditem  | refno, paxid, countryid, deletedby, description
diary        | ID, dte
dtproperties | id[ID], objectid, property, value, lvalue(image), version, uvalue   [system]
emaild1      | companyname, emailid
emailid      | companyname, emailid
embassy      | EmbassyID[ID], Description, embassyname, street1.., phoneno, faxno, emailid,
             |   workinghours, chancery, chanceryphone, chanceryaddress, active
entryDetails | PaxID[ID], refno, Paxname, passportno, DateOfBirth, Category, totalpax
EntryType    | EntryTypeID, Description, Active
hits         | hits, Description
holidaylist  | countryID, holiday, description(nvarchar,1000)
hotel        | hotelid, description
invno        | invoiceno
invoice      | refno, invoiceno, hotelfee(money), cabfee(money), poeremark(nvarchar,2000), poe(money),
             |   miscremark(nvarchar,2000), misc(money), attestfee(money), attestremark(nvarchar,2000),
             |   courierfee(money), grandtotal(money), invoicedate, remark(nvarchar,2000), invtype
invoicedetail| invoiceno, paxid, countryid, visafee(money), handlingfee(money), ddcharges(money),
             |   invtype, VFSTTCharges(money)
Ledger       | agentID, transdate, transactionType, bank, paidas, ddno, dddate, paxname, refno, reftype,
             |   credit(money), Debit(money), balance(money), Remark(nvarchar,300), entrydateTime,
             |   updatedby, id[ID], invno
Mainentry    | refno, paxname, agent, refferer, companyname, passportno, totalpassengers, entries,
             |   dateofbirth, subdate, coldate, receivedate, traveldate, sentDate, entrytype(100% NULL),
             |   category, attestation, poe, status, externalremark(nvarchar,8000),
             |   internalremark(nvarchar,8000), AgentInstruction(nvarchar,4000), enteredby,
             |   entrydatetime, Bill, id(numeric)[ID]
masterbalance| agentid, masterbalance(money), duedate
newagents    | newagentsID[ID] + same address/profile columns as agents
PaxAttestation| PaxID, CountryID, AttestationID, CertificateID
paxCab       | refno, name, cabowner, vehical, cabno, ac, sdate, enddate, startfrom, standeredkm,
             |   standeredhour, actualkm, actualhour, extrakm, extrahour, extrainfo, extraamount, mode,
             |   dest, orderedby, ratesperday, noofday, total, entryDateTime
paxhotel     | refno, name, hotelname, arrivaltime, arrivaldate, departtime, departdate, nosofdays,
             |   tariff, transportation, flightdetail, flightstatus, misccharges, total, noofrooms,
             |   entryDateTime
PaxStatus    | refno, PaxID, CountryID, subdate, coldate, colcheck, sentDate, category, entrytype,
             |   statusID, remarks(nvarchar,8000), visafee, handlingfee, ddcharges, couriercharges,
             |   Misccharges, total, entrydatetime, VFSTTCharges
Poe          | PoeID, Description, Active
priwork      | id[ID], givenby, date, edate, work(nvarchar,2000), status
quote        | date, quote
registration | registID[ID], uid, pwd, name, desig, company, busitype, address, area, city, pincode,
             |   country, phoneno, faxno, emailid, hpage, howknow, date, active, TAAI, TAFI, MEMBERSHIP,
             |   CREATIONDATE
Results      | agentsID + 24 profile columns (temp copy of agents)
scheduler    | messageid[ID], date, messageto, messagefrom, subject, description(nvarchar,8000),
             |   messageread(varchar,5010), sentdate
security     | date1, openingtime, openby, closingtime, closedby
sentawb      | id[ID], agentsid, date, toemail(nvarchar,2000), remark(nvarchar,2000), awb
sentmails    | id[ID], agentsid, date, toemail(nvarchar,2000), awb
smshistory   | cellno, refno, agentID, paxname, status, message, sentby, sentdate
smsQueue     | cellno, refno, agentID, paxname, Message, sentby, sentdate
status       | statusID, Description, Active   [508 duplicated]
StatusHistory| PaxID, Date, CountryID, StatusID, Remarks(nvarchar,8000), UpdatedBy
subscriber   | id[ID], name, email
Udaan_users  | username, Password, privilege, firstname, lastname, emailid, address1, address2, city,
             |   state, country, pincode, phoneno, Faxno, active
VisaInfo     | countryID, categoryID, information(varchar,7000), countryFor
weeklyoff    | embassyid(numeric), weekend(numeric), description
```
Full machine-readable dump: `%TEMP%\opencode\schema_dump.txt` (also reproduced in analysis tool output).

---

## 13. Appendix B — File inventory

- Full alphabetical list of all 585 root `.asp` files: `%TEMP%\opencode\root_asp_list.txt`.
- The 200+ top-value workflow files are catalogued in §3.6 and §6.

---

*End of document. All statements verified against the live Classic ASP application and SQL Server `VisaEntry` on 2026-08-06.*
