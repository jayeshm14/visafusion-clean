# Existing Architecture Report — Royal Routes / Udaan Visa System

**Generated:** 2026-08-06
**Source:** Live runtime + code analysis of `G:\Projects\VisaEntry` (Classic ASP / VBScript + SQL Server)

---

## 1. Project Overview

- **Application:** Visa-processing back-office system for **Udaan India Pvt Ltd** (now branded "Royal Routes").
- **Technology:** Classic ASP (VBScript, inline HTML), ADODB → **SQL Server**, IIS.
- **History:** Built ~2001–2009, with an AdminLTE-4 UI modernization attempt in 2026.
- **Scale:** 7,314 files / 200 MB; **2,293 ASP files**; ~700 dated `updateDDMMYY.asp` content snapshots; ~394 `_vti_cnf` (FrontPage) metadata files.

### Codebase Copies (duplicated codebases, only root is live)

| Folder | ASP files | Database | Purpose |
|---|---|---|---|
| Root | 585 (live) | `VisaEntry` | Production app |
| `Demo/` | 548 | `udaandemo` | Demo / isolated copy |
| `udaanuma-dev/` | 38 | `udaanindia` | Dev copy |
| `r&d/` | 726 | `udaanuma` etc. | Research/experiments |
| `r&d/demo/` | — | forks | Client forks (BTI-SITA, mercury-blr, udaan, udaanuma, udaantcook) |

---

## 2. Runtime Architecture (verified live)

```
Browser ── HTTP:8100 ──► IIS Express (Classic ASP / VBScript)
                              │ #include connection.asp (global helper + conn)
                              ▼
                     ADODB ──► SQL Server (default instance, MSSQLSERVER)
                              │  DRIVER={SQL Server};SERVER=.;uid=sa;pwd=sa123;DATABASE=visaentry
                              ▼
                        VisaEntry DB (52 tables, production data)
```

- **App server:** IIS Express on `localhost:8100`; no web framework, no ORM, no build — each `.asp` is self-contained inline VBScript+HTML.
- **Central include:** `connection.asp` (root) holds the global `con` connection and shared helpers (`LoadListBox`, `getDescriptionForID`, `UsrToSysDate`, `getAgentAddress`, `MonthlyHolidayList`, etc.).
- **Two UI generations co-exist:** AdminLTE-4 shell (2026) on login/dashboards/nav + ~2,200 untouched 2001-era pages.

### Verified live status

| Page | Result |
|---|---|
| `http://localhost:8100/Default.asp` | HTTP 200 |
| `http://localhost:8100/logon.asp` | HTTP 200, DB connect OK |
| `http://localhost:8100/update.asp`, `contactus.asp`, `forms.asp` | HTTP 200 |
| Login flow (`authenticate.asp`) | Redirects correctly per role |

---

## 3. Role Architecture (from live logins + `authenticate.asp`)

| Role | DB count | `session("priv")` | Landing page | Session extras |
|---|---|---|---|---|
| **su** (Super User) | 4 | `"adm"` + `su="Y"` | `Administrator.asp` | uname, lname, extn=phoneno |
| **adm** (Admin) | 57 | `"adm"` | `Administrator.asp` | uname, lname, extn |
| **emp** (Employee) | 10 | `"emp"` | `Employee.asp` — only if office day open | uname, lname, extn |
| **agt** (Agent) | 2,294 | `"agt"` | `Agent.asp?jn=<agentid>` | agentid in URL **only, not session** |
| **guest** (self-registered) | 43 (`registration`) | `"guest"` | `default.asp` | uname, name |

- **Verified live:** admin login → `Administrator.asp?uname=satish123`; agent login → `Agent.asp?logon=Y&...&jn=5771`; employee login → blocked `relogin.asp?rsn=O` (office not opened for today).
- **Employee day-gate** (`authenticate.asp:62-79`): `emp` login requires a `security` row for *today* with `closingtime IS NULL`; else `rsn=O` (not opened) or `rsn=C` (closed). Admin opens the day via `securityHome.asp → open2.asp`.

---

## 4. Navigation by Role

### Admin / SU sidebar (`topAdmin.asp`)
Dashboard, E-mails, Agents, Embassy, Users, Visa Info (Visa Information / Daily Visa Posts), Billing & Finance (Bills / Collections / Credit Notes / Financial Alerts), Advanced Search, Security, Contact — plus **ADMINISTRATION section (Admin Panel, Holidays)** shown only when `priv="adm"`.

### Agent sidebar (`topAgent.asp`)
Visa Tracking (submitted / collected / pending / sent views), Holidays, Visa Information, Visa Forms, and ACCOUNT (Change Password, Edit Info, Queries, Logout).

> Note: `topAgent.asp:12-18` resolves agentID from `jn=` query string before falling back to (never-set) session vars.

---

## 5. Database Architecture

### Schema integrity
- **52 tables**, **0 foreign keys**, **2 primary keys**, **20 identity columns**.
- Relationships are implicit by naming convention (`refno`, `agentid`, `statusID`) — enforced only in application code.

### Table inventory (live row counts)

| Table | Rows | Role in app |
|---|---|---|
| `bighistory` | 1,430,841 | Full remark/change audit log |
| `StatusHistory` | 1,287,261 | Per-pax status timeline |
| `sentmails` | 553,523 | AWB/email dispatch log |
| `PaxStatus` | 359,338 | Per pax-country status + fees |
| `invoicedetail` | 358,630 | Invoice line items |
| `entryDetails` | 312,655 | Passenger/passport records |
| **`Mainentry`** | **271,724** | **Master visa-entry record** |
| `invoice` | 271,239 | Invoices (frozen 2009) |
| `smshistory` | 47,534 | SMS log |
| `Ledger` | 26,565 | Agent accounting (unused) |
| `deleteditem` | 9,909 | Deleted items log |
| `sentawb` | 9,355 | AWB records |
| `holidaylist` | 4,272 | Embassy holidays |
| `agents` | 4,218 | Travel agents |
| `Udaan_users` | 2,365 | System logins |
| `security` | 1,461 | Open/close-day records |
| `embassy` | 242 | Embassies |
| `CountryInfo` | 190 | Country info |
| `masterbalance` | 1,416 | Agent balances |
| `VisaInfo` | 981 | Visa info content |
| `registration` | 43 | Self-registered users |
| Others | 0–27 | Lookups / unused |

### Core workflow (Mainentry)
```
refno → entryDetails (pax) → PaxStatus (per country) → StatusHistory (timeline)
subdate → coldate → receivedate → sentDate → traveldate
```
- Mainentry spans **2001-12 → 2026-04 (25 years)**.

### Business taxonomy (real codes)
- `status`: 101 Dox Received, 201 Submitted, 301 Urgent, 401 Pending, 501 Collected, 601 Sent, 503 Rejected …
- `category`: Ppt Renewal, Student, Work, Business, Official, Attestation …
- `entrytype`: Multiple / Single / Double
- `poe`: POE / ECNR
- `attestation`: MEA / ME / Notary / AOA

### Financial data
- `PaxStatus` visa-fee sum ≈ **₹87.1 crore** (₹871M); total ≈ ₹78.6 crore.
- `invoice` 271,239 records.

### Data-quality / lifecycle signals
- **Billing retired:** `invoice` freezes at **2009-01-17**; `Mainentry` continues to 2026.
- **`Ledger` dead:** 26,563/26,565 rows have `transdate = NULL` — accounting module never operational.
- 6,517 `Mainentry` rows reference non-existent agent IDs; junk dates (1970/2207); one invoice `grandtotal` = 4.5×10¹⁴.
- Empty tables: `country` (0 rows — country list lives in `embassy`), `invno`, `diary`, `cab`, `adcount`.

---

## 6. Summary

The system is fully operational at **http://localhost:8100** with 25 years of production data. Its domain model (visa workflow, status pipeline, agent network) is sound and well-populated, but it carries a large legacy burden: duplicated codebases, retired modules (billing/ledger), no referential integrity, and a two-generation UI split.
