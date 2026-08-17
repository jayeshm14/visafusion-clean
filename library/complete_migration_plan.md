# Complete Migration Plan — Royal Routes / Udaan India VisaEntry
### Classic ASP (VBScript) → ASP.NET Core (Web App + Web API)

**Status:** Supersedes/extends `modernization_plan.md`. Every fact below is sourced from the three input documents (`modernization_plan.md`, `deepanalysis.md`, `exiting_architecture.md`). No new business features are introduced — this document only (a) closes documentation gaps in the original plan, (b) makes every mapping and decision explicit and deterministic, and (c) adds the API layer, authorization matrix, and execution detail needed to actually build the migration.

---

## 0. Method — how gaps were found

The three source documents were cross-checked against each other:
1. Every table in Appendix A (52 tables) was checked against §10.6 "Module migration map" — **15 tables had no target module**.
2. Every security finding in `deepanalysis.md` §2 was checked against `modernization_plan.md` §10.7 — all were covered at the *principle* level but not at the *endpoint* level (no concrete `[Authorize]` policy per legacy file).
3. Every "verified runtime behavior" (§3.8, §6) was checked to confirm it survives as a rule in the new system, not silently dropped.
4. The user's explicit ask for **APIs** was checked against the original plan, which only specifies Razor Pages — an API layer was absent and is added in §5 below, built strictly from the same module list (no new endpoints beyond what the legacy app already does).
5. The original plan's "Risks & Unknowns" (§11) are carried forward unchanged — they are business decisions, not something a migration plan can invent an answer to.

---

## 1. Gap Analysis — what was missing from the original plan

| # | Gap | Where it showed up | Resolution in this document |
|---|---|---|---|
| G1 | 15 of 52 tables never appear in the module migration map | legacy schema (52 tables) vs §3 | §3 — full 52-table disposition |
| G2 | No API layer — plan is Razor-Pages-only | §10.1–10.6 | §5 — Web API surface, one controller set per module, reusing the same authorization policies |
| G3 | RBAC remediation stated as a principle ("Role claims + `[Authorize(Roles=...)]`") but never mapped per legacy file/endpoint | §10.4, §10.7 | §4 — full endpoint × role matrix, derived directly from the legacy "Role → Module Access Matrix" and the RBAC findings |
| G4 | The 13 anonymous write endpoints are named but not individually re-specified with their target route + required role | legacy anonymous-write endpoints | §4.3 — one row per endpoint |
| G5 | Data-quality issues listed but not turned into an executable cleansing checklist with order-of-operations | legacy data-quality issues | §6 — ordered remediation script list |
| G6 | Identity consolidation (`Udaan_users` + `agents` + `registration` → one Identity store) described in one line, no key-mapping design | §10.4 | §7 — explicit external-id mapping |
| G7 | No test matrix tied to the specific documented business rules (Canada DOB, holiday/weeklyoff/Sunday block, statusID 508 duplicate, junk dates) | §10.10 (generic) | §8 — one test case per documented rule |
| G8 | No explicit decommission checklist (which of the 7,314 files get deleted vs archived vs migrated) | §3.7, §9.5 (scattered) | §9 |
| G9 | No phase exit criteria — phases are named but not bounded by a checkable "done" condition | §10.9 | §10 |
| G10 | No infra/ops section (hosting, secrets, backup, monitoring) beyond scattered mentions | §10.2 | §11 |

---

## 2. Target Architecture (extends §10.1 with the API layer)

```
┌───────────────────────────────────────────────────────────────────┐
│  VisaEntry.Web           — Razor Pages (server-rendered UI,        │
│                             Areas: Public, Auth, Employee, Agent,   │
│                             Admin, Billing, Reporting, Notifications)│
│  VisaEntry.Api            — ASP.NET Core Web API (JSON, same Areas  │
│                             as controllers, versioned /api/v1)      │
│      both hosted from one ASP.NET Core process, sharing:            │
│  VisaEntry.Core           — domain services (EntryService,          │
│                             StatusService, BillingService,          │
│                             SmsService, EmailService, SecurityGate  │
│                             Service, HolidayService)                │
│  VisaEntry.Data            — EF Core DbContext, entities, migrations │
│  VisaEntry.Identity         — Identity stores mapping to Udaan_users/│
│                             agents/registration (see §7)             │
│  VisaEntry.Jobs             — BackgroundService (SMS queue, email    │
│                             queue, daily/scheduled reports)          │
└──────────────────────────────┬────────────────────────────────────┘
                                │ EF Core (parameterized, no string SQL)
                     ┌──────────▼──────────────────────────┐
                     │ SQL Server `VisaEntry` — same DB,     │
                     │ in-place, cleansed, FKs + indexes added│
                     └────────────────────────────────────────┘
```

- Razor Pages serve the internal back-office UI (Employee/Admin/Agent), matching how the app is used today (browser-only, IIS-hosted).
- The Web API exposes the same operations as JSON so the agent portal and any future client (mobile, integration) can call them — **this is not a new feature**, it is the same module surface from §3–§6 of `modernization_plan.md`, exposed a second way, per your explicit request for APIs.
- Both share `VisaEntry.Core` so business rules (Canada DOB, holiday/weeklyoff/Sunday block, day-open gate) are enforced identically regardless of entry point — this fixes the legacy problem where validation lived inline per-page and was inconsistently applied.

---

## 3. Complete Data Model Migration — all 52 tables

Legend: **M** = migrate as live/writable entity · **M-RO** = migrate as read-only/historical (do not build new write UI) · **COND** = migrate only after owner confirms it's in active use (originally flagged "verify usage") · **ARCH** = migrate data to an archive table/export, no live entity, no UI · **DROP** = do not migrate (empty, system, or scratch table)

| Table | Rows (live) | Disposition | Target | Basis |
|---|---|---|---|---|
| `Mainentry` | 271,724 | **M** | Core `Entry` aggregate root | Master record, §6.1 |
| `entryDetails` | 312,655 | **M** | `EntryPassenger` (child of Entry) | §6.1 |
| `PaxStatus` | 359,338 | **M** | `PaxCountryStatus` | §6.1/6.2 |
| `StatusHistory` | 1,287,261 | **M** | `StatusHistoryEntry` (append-only) | §6.2 audit chain |
| `bighistory` | 1,430,841 | **M** | `EntryAuditLog` (append-only) | §6.1/6.2 audit chain |
| `sentmails` | 553,523 | **M** | `EmailLog` | §6.7 |
| `sentawb` | 9,355 | **M** | `AwbLog` | §6.1/6.5 |
| `smshistory` | 47,534 | **M** | `SmsLog` | §6.7 |
| `smsQueue` | low | **M** | Backing table for `SmsQueueBackgroundService` | §6.7, §10.6 |
| `deleteditem` | 9,909 | **M-RO** | `DeletedItemAudit` | audit-only per §9.4 |
| `agents` | 4,218 | **M** | `Agent` entity | §6.4 |
| `newagents` | low | **M-RO**, fold workflow into `Agent` staging status | §9.4 "registration staging" — verify with owner whether staging flow is still used before building new UI |
| `Results` | low | **DROP** | none — documented as a temp copy of `agents` | §9.4 |
| `Udaan_users` | 2,365 | **M** | `AspNetUsers` + `AspNetUserRoles` (see §7) | legacy auth model |
| `registration` | 43 | **M** | `AspNetUsers` (guest role) — **hash password on migration, never re-store plaintext** | §5.4.4 plaintext finding |
| `security` | 1,461 | **M** | `SecurityDay` (day open/close gate) | §6.10 |
| `masterbalance` | 1,416 | **M**, pending owner confirmation it's still used (documented "sparsely used") | §4.4 | 
| `Ledger` | 26,565 | **M-RO** | `LedgerHistory` — 26,563/26,565 rows have NULL `transdate`; migrate as historical archive; **do not build new ledger UI unless Risk #1 (§12) is resolved by owner** | §2.10/§4.5 dead-module finding |
| `invoice` | 271,239 | **M-RO** for pre-2009 data; **M** if owner confirms billing continues elsewhere and should be revived | frozen 2009-01-17, §6.3 |
| `invoicedetail` | 358,630 | same disposition as `invoice` | §6.3 |
| `invno` | low | **ARCH** — superseded invoice counter | §9.4 |
| `bank` | low | **M**, reference table for `Ledger`/`invoice` — migrate regardless of Ledger's live/RO status since it's a lookup, not a fact table | §4 Appendix A |
| `holidaylist` | 4,272 | **M** | `Holiday` — actively enforced business rule | §6.1/§6.8 |
| `weeklyoff` | low | **M** | `WeeklyOff` — actively enforced business rule | §6.1/§6.8 |
| `embassy` | 242 | **M** | `Embassy` reference | §6.12 |
| `CountryInfo` | 190 | **M** | `CountryInfo` content | §6.12 |
| `VisaInfo` | 981 | **M** | `VisaInfo` content | §6.12 |
| `country` | 0 | **DROP** — confirmed empty and unused; country list lives in `embassy`/`CountryInfo` | §4.5/§9.4 |
| `status` | small | **M**, **fix `statusID=508` duplicate description before migration** (see §6) | §4.3 data issue |
| `Category` | small | **M** | reference | §12 Appendix A |
| `EntryType` | small | **M**, note: `Mainentry.entrytype` is 100% NULL in source — carries no historical data, migrate the lookup table itself but do not expect populated history | §4.5 |
| `Poe` | small | **M** | reference | §12 Appendix A |
| `Attestation` | small | **M** | reference | §12 Appendix A |
| `certificate` | small | **M** | reference | §12 Appendix A |
| `PaxAttestation` | small | **M** | junction entity (Pax↔Country↔Attestation↔Certificate) | §12 Appendix A |
| `hotel` | small | **COND** — tour module, "verify current usage before building" (explicit in original plan §6.11) | §6.11 |
| `cab` | small | **COND** — same as `hotel` | §6.11 |
| `paxhotel` | low | **COND** — child of `hotel`, same gate | §6.11 |
| `paxCab` | low | **COND** — child of `cab`, same gate | §6.11 |
| `dailyUpdate` | — | **M** | `ContentUpdate` (CMS entry used by `dailyupdate.asp`) | §6.9 |
| `scheduler` | — | **COND** — internal messaging table, usage/ownership not confirmed in source docs | §6 "Task/private work" row, §9.4 |
| `priwork` | — | **COND** — internal task tracking (`tasks.asp`, `priwork.asp`), low-priority, confirm still used | §3.6 |
| `subscriber` | — | **COND** — newsletter list, confirm still used | §9.4 |
| `quote` | — | **ARCH** — "quote-of-day", explicitly dead | §9.4 |
| `hits` | — | **DROP** — hit counter explicitly disabled in code (commented out) | §9.2/§9.4 |
| `adcount` | — | **DROP** — ads table, explicitly dead | §9.4 |
| `diary` | — | **ARCH** — explicitly unused | §9.4 |
| `emailid` | — | **ARCH** — unused email list | §9.4 |
| `emaild1` | — | **ARCH** — unused email list | §9.4 |
| `changes` | — | **ARCH** — change-log only, no live consumer documented | §9.4 |
| `changesbill` | — | **ARCH** — same as `changes` | §9.4 |
| `dtproperties` | — | **DROP** — SQL Server system table, not application data | §12 Appendix A |

**Rule applied uniformly:** every table the source docs explicitly called "dead", "unused", "disabled", or "temp" is archived or dropped, never rebuilt as new UI. Every table flagged "verify usage" in the original plan is carried into this document as **COND**, not resolved — resolving it would mean inventing an assumption the source docs don't support. These are collected as blocking decisions in §12, unchanged from the original plan's §11.

---

## 4. Authorization — full endpoint-level matrix

### 4.1 Role model (unchanged from source, now made explicit as ASP.NET Core Identity roles)

`su`, `adm`, `emp`, `agt`, `guest` — carried over verbatim from `Udaan_users.privilege` (`deepanalysis.md` §1.3, §3). `su` gets all `adm` claims plus a `SuperUser` claim (source: `su` maps to the same landing page and session priv as `adm`, distinguished only by `su="Y"`, §1.3).

### 4.2 Module × role matrix, translated into concrete policies

This is `deepanalysis.md` §3 ("Role → Module Access Matrix (as actually enforced)") **corrected** — the legacy matrix shows what the legacy code *allows* (everything, because there is no real RBAC), not what the business rule *should* be. Per finding 2.1 ("no role-*denial* check exists anywhere") and the original plan's remediation direction (§10.4/§10.7), the target matrix enforces the roles the module design already implies (landing pages, section visibility) as hard denials, since that is the only signal the source code provides for intended access — no new business rule is invented, the *display-only* gate becomes an *enforced* gate.

| Module (from §6 workflows) | guest | agt | emp | adm | su | Notes |
|---|---|---|---|---|---|---|
| Public site (Default, contactus, embassy info, forms, registration) | ✅ | ✅ | ✅ | ✅ | ✅ | anonymous-allowed by design |
| Entry create/edit (`makeEntry`, `insertEntry`, `editentry*`) | ❌ | ❌ | ✅ | ✅ | ✅ | legacy only *displayed* to emp/adm; enforce as denial for guest/agt |
| Agent status view — **own agent only** (`listforagents`, `Agent.asp`, `agentpaxStatus`) | ❌ | ✅ (own `agentId` from claims, not query string) | ✅ | ✅ | ✅ | fixes §2.3 agent-data-leak finding |
| Agent financial ledger (`agentStatement`) | ❌ | ✅ (own only) | ✅ | ✅ | ✅ | fixes §2.3 anonymous-read finding |
| Billing/collection (`dailybill`, `collection*`, `invoicesubmit`, `editbill`) | ❌ | ❌ | ✅ | ✅ | ✅ | matches emp/adm landing pages |
| Search (`searchPax*`, `searchEntry*`) | ❌ | ✅ (scoped to own agent) | ✅ | ✅ | ✅ | |
| User management (create/delete incl. su) | ❌ | ❌ | ❌ | ✅ (adm/emp only, **not** su-creation) | ✅ (only su can create su) | fixes §2.2 self-registration→SU escalation |
| Holiday/weekly-off CRUD | ❌ | ❌ | ❌ | ✅ | ✅ | admin-only master data |
| Open/close day (`securityHome`, `openForDay`, `closeForDay`) | ❌ | ❌ | ❌ | ✅ | ✅ | fixes §2.5 — currently anonymous-writable |
| Password change (own account) | ❌ | ✅ | ✅ | ✅ | ✅ | self-service, own account only |
| Admin panel / admin-only UI extras | ❌ | ❌ | ❌ | ✅ | ✅ | matches legacy `priv="adm"` display gate |

### 4.3 The 13 anonymous write endpoints — individually re-specified

Every endpoint from `deepanalysis.md` §2.4 gets a named target route + minimum role. None are left anonymous; none are dropped (all remain in scope, none is a new feature):

| Legacy file | Legacy behavior | Target route | Required role |
|---|---|---|---|
| `editdoneagent1.asp` | anonymous UPDATE `agents` | `PUT /api/v1/agents/{id}` | `adm`,`su` |
| `editdonebyagent1.asp` | anonymous UPDATE `agents` + email | `PUT /api/v1/agents/{id}/self` | `agt` (own record only) |
| `execute.asp` | anonymous mass UPDATE `paxstatus` | retire the generic "execute arbitrary SQL" endpoint entirely — replace with the specific typed status-update endpoints under `PaxStatus`/`StatusHistory` that the legitimate workflow already needs (`POST /api/v1/entries/{refno}/status`) | `emp`,`adm`,`su` |
| `editbill.asp` | anonymous INSERT billing | `POST /api/v1/billing/entries` | `emp`,`adm`,`su` |
| `holidayDeleteSubmit.asp` | anonymous DELETE holiday | `DELETE /api/v1/holidays/{id}` | `adm`,`su` |
| `holiday_WebEntry.asp` | anonymous INSERT/DELETE | `POST/DELETE /api/v1/holidays` | `adm`,`su` |
| `querieDetail.asp` | anonymous INSERT queries | `POST /api/v1/public/queries` | anonymous **allowed** — public contact-query submission is a by-design public feature (like `regsub*`), keep public but add validation + rate limiting |
| `sendawbgo.asp` | anonymous INSERT sent-AWB | `POST /api/v1/entries/{refno}/awb` | `emp`,`adm`,`su` (see SPEC-0006 deviation-log entry 4) |
| `todayAgentStatusalltemp.asp` | anonymous INSERT | `POST /api/v1/reports/agent-status/today` | `emp`,`adm`,`su` |
| `openForDay.asp` | anonymous INSERT `security` | `POST /api/v1/admin/security-day/open` | `adm`,`su` |
| `closeForDay.asp` | anonymous UPDATE `security` | `POST /api/v1/admin/security-day/close` | `adm`,`su` |
| `regsub.asp`/`regsubmit.asp`/`regsubdone.asp` | public registration | `POST /api/v1/public/register` | anonymous **allowed by design** — but output role is always `guest`, never privileged (fixes §2.2) |
| `insertEntry.asp` | anonymous full visa-entry INSERT | `POST /api/v1/entries` | `emp`,`adm`,`su` |

Plus the guest-reachable write endpoints named in `deepanalysis.md` §2.4 (`addNewUser.asp`, `editdonetest.asp`, `deleteUser.asp`/`deleteSubmit.asp`, `addembassy.asp`, `addMoreCertificate.asp`, `BulkcollectionSubmit.asp`, `collection*.asp`, `dailyupdate.asp`, `hotelSubmit.asp`, `invoicecreditsubmit.asp`, `invoicesubmit.asp`, `newaddnewagents.asp`, `paymentsubmit.asp`, `SendSMS*.asp`, `newpassword.asp`, `newpasswordforagent.asp`) all move behind `[Authorize(Roles = "adm,su")]` or `emp` per §4.2's module row, with `deleteUser`/`deleteSubmit` additionally requiring `su` when the target account's role is `su` (fixes "can delete any account incl. su" finding, §2.9).

**`addNewUser.asp`/`editdonetest.asp` privilege whitelist fix (§2.2, §2.9):** the target endpoint (`POST /api/v1/admin/users`) validates `role` against an explicit enum (`adm`,`emp`,`agt`,`guest`) server-side; `su` is never settable through this endpoint — su accounts are provisioned through a separate, `su`-only, audited endpoint (`POST /api/v1/admin/superusers`), closing the escalation path.

---

## 5. API Surface (new — addresses gap G2)

One `/api/v1/{area}` controller group per module from `modernization_plan.md` §6, reusing `VisaEntry.Core` services so behavior matches the Razor Pages UI exactly:

| Area | Controller | Key endpoints | Backing legacy pages |
|---|---|---|---|
| Auth | `AuthController` | `POST /login`, `POST /logout`, `POST /public/register` | `authenticate.asp`, `logon.asp`, `regsub*.asp` |
| Entries | `EntriesController` | `POST /entries`, `GET /entries/{refno}`, `PUT /entries/{refno}`, `POST /entries/{refno}/status`, `POST /entries/{refno}/awb` | `makeEntry`, `insertEntry`, `editentry*`, `editdone`, `sendawbgo` |
| Collection | `CollectionController` | `POST /entries/{refno}/collect`, `POST /entries/bulk-collect` | `collection*.asp`, `BulkCollection*.asp` |
| Status/Reports | `StatusReportsController` | `GET /reports/agent-status/today`, `GET /reports/pending`, `GET /reports/urgent` | `todayAgentStatus*`, `pendinglist.asp`, `urgent.asp` |
| Billing | `BillingController` | `POST /billing/entries`, `GET /billing/daily`, `POST /billing/credit-notes` | `dailybill`, `invoicesubmit`, `editbill`, `creditnote*` — **gate behind Risk #1 resolution (§12)** |
| Agents | `AgentsController` | `GET /agents/{id}`, `PUT /agents/{id}`, `GET /agents/{id}/statement`, `GET /agents/{id}/entries` | `Agent.asp`, `listforagents`, `agentStatement*`, `editagent*` |
| Admin — Users | `UsersController` | `GET/POST/PUT/DELETE /admin/users`, `POST /admin/superusers` | `addNewUser`, `EditUser`, `deleteUser/Submit` |
| Admin — Holidays | `HolidaysController` | CRUD `/admin/holidays`, `/admin/weekly-off` | `holiday*.asp`, `WeeklyOffList.asp` |
| Admin — Security Gate | `SecurityGateController` | `POST /admin/security-day/open`, `POST /admin/security-day/close`, `GET /admin/security-day/today` | `securityHome`, `openForDay`, `closeForDay` |
| Content/CMS | `ContentController` | CRUD `/content/updates` | `dailyupdate.asp`, `viewdailyupdate.asp` |
| Notifications | `NotificationsController` | `POST /notifications/sms`, `POST /notifications/email`, `GET /notifications/sms-history`, `GET /notifications/email-history` | `SendSMS*`, `emailAgent`, `composeEmail` |
| Public | `PublicController` | `GET /public/embassies`, `GET /public/countries`, `GET /public/visa-info`, `GET /public/forms`, `POST /public/queries`, `POST /public/subscribe` | `embassyhome`, `CountryInfo.asp`, `VisaInfo.asp`, `forms.asp`, `queries.asp`, `subscribe.asp` |

**Cross-cutting API rules (security remediations from the legacy analysis, applied uniformly across every controller above):**
- Every write endpoint requires authentication except the two explicitly public-by-design ones (`register`, `public/queries`, `public/subscribe`) — matches legacy intent (public site *is* meant to be anonymous; back-office is not).
- Every endpoint that reads/writes agent-scoped data resolves the agent id from the authenticated user's claims, **never** from a route/query parameter supplied by the caller — this is the direct fix for the `jn=` tampering vulnerability (§2.3).
- All EF Core queries are parameterized by default (LINQ) — no string-built SQL survives the migration, closing §2.6.
- OpenAPI/Swagger generated per controller for documentation and client generation (agent portal, any future integration) — this is tooling, not a new business feature.
- API versioned at `/api/v1` so legacy-shaped contracts can evolve later without breaking the initial migration.

---

## 6. Data Remediation — ordered, executable checklist (closes gap G5)

Executed in a staging copy first (per original plan §10.8 step 2), in this order because later steps depend on earlier ones being clean:

1. **Backup** `VisaEntry` (`BACKUP DATABASE`) before any write.
2. **Fix `status` table duplicate:** `statusID=508` has two descriptions (`Withdraw` / `Approval Awaited`) — determine which rows in `PaxStatus`/`StatusHistory` used 508 for which meaning (requires business sign-off, listed as Risk #8 in §12) before collapsing to one row or splitting into two IDs.
3. **`Mainentry.entrytype` is 100% NULL** — confirm with owner it's superseded by `PaxStatus.entrytype`/`entryDetails` classification (as the audit notes) before deciding whether to backfill or drop the column from the new schema.
4. **Junk dates** (values near 1970/2207 from bad `UsrToSysDate` string conversions) — flag and quarantine rows rather than silently correcting them (correcting implies guessing the real date, which is out of scope); expose a data-quality report to the business owner for manual correction.
5. **6,517 orphaned `Mainentry` rows** (agent id pointing at a missing `agents` row) — before adding the FK from `Mainentry.agent → agents.agentsID`, these rows must be either (a) matched to a correct agent by the business, or (b) pointed at a placeholder "Unknown/Legacy Agent" row, or (c) excluded from the FK-enforced live table and kept in an archive partition. Decision required from owner (Risk #8).
6. **`invoice.grandtotal` max = 4.5×10¹⁴** (corrupted by string concatenation) — quarantine as a data-quality exception, do not attempt automatic repair.
7. **Add foreign keys** only after steps 2–6 are resolved for the referenced tables (adding FKs before cleansing will simply fail or force silent data loss).
8. **Add indexes** on the high-volume history tables named in the original plan: `StatusHistory(PaxID, Date)`, `bighistory(refno)`, `sentmails(agentsid, date)`, plus equivalents for `smshistory`, `sentawb`, `PaxStatus(refno, PaxID, CountryID)`.
9. **Password migration:** hash all `Udaan_users.Password` and `registration.pwd` plaintext values with `PasswordHasher` in the same migration pass — do this in the same transaction as the Identity import (§7), never store the plaintext value anywhere in the new system, including logs.
10. Re-run the row-count and orphan-count queries from `deepanalysis.md` §4.2/§9.4 against the cleansed staging copy to confirm no unexplained row loss before promoting to production.

---

## 7. Identity Consolidation (closes gap G6)

Three legacy identity sources collapse into one ASP.NET Core Identity store, keeping the legacy table as the migration source of truth (nothing is invented — every mapped field already exists):

| Legacy source | Legacy fields used | → `AspNetUsers` | Role assigned | External key kept |
|---|---|---|---|---|
| `Udaan_users` (`su`,`adm`,`emp`) | `username`,`Password`(hash on import),`firstname`,`lastname`,`emailid`,`active` | `UserName`,`PasswordHash`,`Email`,`LockoutEnabled=!active` | `su`/`adm`/`emp` from `privilege` | `LegacyUdaanUserId` |
| `Udaan_users` (`agt` rows) | same, plus link to `agents.Description` | same | `agt` | `LegacyUdaanUserId` **and** `AgentId → agents.agentsID` (fixes the never-set `session("agentid")`, §1.3/§5.2) |
| `registration` | `uid`,`pwd`(hash on import),`name`,`emailid`,`active` | `UserName`,`PasswordHash`,`Email` | `guest` | `LegacyRegistrationId` |

- **Agent binding rule (fixes §2.3):** `AgentId` claim is populated once at import time by matching `Udaan_users.username` to `agents.Description`, per the original plan's own note that this mapping needs confirmation (Risk #2, carried to §12 unresolved). Once set, the API/UI **never** re-derives agent identity from a URL parameter again.
- `su` accounts (4 total, per `deepanalysis.md` §1.3) get both the `adm` role and a `SuperUser` claim so `[Authorize(Policy="SuperUserOnly")]` can gate su-provisioning (§4.3) separately from ordinary admin actions.

---

## 8. Test Matrix (closes gap G7) — one case per documented business rule

| Rule (source) | Test case |
|---|---|
| Canada entry requires DOB (`insertEntry.asp` lines 25–27) | Submit entry with Canada as destination, no DOB → reject; with DOB → accept |
| Block on embassy holiday (`holidaylist` check) | Submit entry dated on a known `holidaylist` date for that embassy → reject with warning, no insert |
| Block on `weeklyoff` | Submit entry dated on the embassy's weekly-off day → reject |
| Block on Sunday | Submit entry dated on a Sunday → reject |
| Employee day-gate (`authenticate.asp` 62–79) | Log in as `emp` on a day with no open `security` row → `rsn=O`; on a closed day → `rsn=C`; on an open day → success |
| Agent identity isolation (fixes §2.3) | Log in as agent A, attempt to read agent B's status list/statement via manipulated id → 403, not agent B's data |
| `su` self-escalation (fixes §2.2) | Register as guest, attempt to POST `role=su` to the user-creation endpoint → rejected/ignored server-side |
| `statusID=508` duplicate | After cleansing (§6 step 2), confirm no live code path can select an ambiguous 508 row |
| Junk date entries | Confirm quarantined 1970/2207-dated rows are excluded from live reporting views but retained in the audit archive |
| Orphaned `Mainentry` agent rows | Confirm the 6,517 orphan rows are handled per the owner's chosen resolution (§6 step 5) and do not throw on FK-enforced reads |
| Password hashing | Confirm no plaintext password value is retrievable anywhere post-migration, including via the admin user-edit screen |
| Backdoor removal | Confirm `udaanappraj123guruadm`/`udaan12345functiondisplaymarquee` query parameters have no effect anywhere in the new app (no route recognizes them) |
| SQL injection | Re-run the legacy vulnerable inputs (e.g. raw `'` in `listforagents.asp` keyword search equivalent) against the new API and confirm parameterization holds |
| Load | `StatusHistory`/`bighistory` reads (1.3M/1.4M rows) perform acceptably with the new indexes (§6 step 8) |

Golden-file comparison (per original plan §10.10): run the same refno set through old ASP and new handlers, diff status transitions, fee totals, and emails/SMS sent, for a sanitized 6-month/50-agent subset.

---

## 9. Decommission / Archive Checklist (closes gap G8)

| Item | Count/size | Action |
|---|---|---|
| `Demo\` | 548 ASP, 41.4 MB | Archive off the production host; do not migrate |
| `r&d\` (incl. `r&d\demo\` forks) | 726 ASP, 48.7 MB | Archive; do not migrate |
| `udaanuma-dev\` | 38 ASP, 33.7 MB | Archive; do not migrate |
| `updateDDMMYY.asp` snapshots | ~700 files | Convert to static HTML/markdown archive (content, not code) per §6.9 — owner decision on where they live (Risk #6) |
| `_vti_cnf\` (FrontPage metadata) | ~394 files | Delete |
| `*_old`, `*_bak`, `*test*`, `*Temp*`, scratch/personal files | 16+ named files (§9.5) | Delete, do not migrate |
| Unfinished/one-off pages (§9.6 list) | ~25 files | Individually validate with owner before deciding port vs. drop — do not port by default |
| `ActiveX\OSSMTP.dll` COM component | 0.2 MB | Retire — replaced by `SmtpClient`/mail library (§6.7 of original plan) |
| `.vs\` workspace | 17.5 MB | Delete, not application data |
| `forms\` (57 embassy PDFs/DOCs) | 17.2 MB | Copy as-is to new static assets |
| `updateimg\`, `images\`, `assets\`, `css\`, `js\`, `fonts\` | ~30 MB combined | Copy as-is, self-host (no CDN) per original plan §8.2 |
| `database.sql` demo script | — | Do not use as migration baseline (confirmed schema drift, §4.7) — reverse-engineer from live DB only |

---

## 10. Phased Rollout with Exit Criteria (extends original §10.9, closes gap G9)

| Phase | Scope (unchanged from original plan) | Exit criteria |
|---|---|---|
| Phase 0 (1–2 wks) | Scaffold EF Core, Identity, auth gates, static assets, URL rewrite | App boots; login works for all 5 roles against migrated (hashed) credentials; backdoor query params confirmed inert |
| Phase 1 | Login, entry creation, status update, agent self-service (read-only), daily status pages | Golden-file diff (old vs new) matches for a 6-month/50-agent sample on entry creation + status transitions; agent isolation test (§8) passes |
| Phase 2 | Notifications (SMS/email), holiday/weeklyoff, content CMS, reports | SMS/email logs continue writing to `smshistory`/`sentmails` without gaps; holiday/weeklyoff block rules verified against Test Matrix §8 |
| Phase 3 | Agent/admin CRUD, security gate, public site, forms | Security-day gate enforced admin-only (§4.2); public site parity confirmed incl. removal of the AdminLTE demo dropdown bug (§9.2) |
| Phase 4 | Data cleanse + constraints + cutover; decommission old ASP; archive Demo/r&d/udaanuma-dev | All §6 remediation steps complete and re-verified; FKs live; old `.asp` app taken off the primary URL, kept on a maintenance URL only for the transition window (original plan §10.8 step 5) |

---

## 11. Infrastructure / Operations (closes gap G10)

- **Secrets:** connection string, SMS gateway creds, SMTP creds move out of source into `appsettings.json` + User Secrets (dev) / Key Vault (prod) — replaces the plaintext `sa`/`sa123` and SMS/SMTP creds found in source (§2.8/§7 of the deep analysis).
- **DB login:** create a dedicated least-privilege SQL login for the app; `sa` reserved for migration/DBA use only (original plan §10.4/Risk #10).
- **TLS:** enforce HTTPS/HSTS for both the Razor Pages UI and the API — legacy app had none documented.
- **Logging:** Serilog structured logging to file + SQL, replacing the `on error resume next` silent-failure pattern (§9.2) so errors are visible instead of swallowed.
- **Health checks:** standard ASP.NET Core health check endpoint for the DB connection and background job queue.
- **Backups:** confirm/establish a SQL Server backup cadence before the migration touches 25 years of production data (no backup cadence is documented in the source material — flagged as an operational gap, not a business decision, so it's called out here rather than deferred to §12).
- **CI/CD:** build/test pipeline running the xUnit suite from §8 plus the golden-file comparison before any deploy to the shared DB.

---

## 12. Open Decisions Required From Owner (unchanged from original plan §11 — reproduced here for completeness, not modified)

1. Is invoice/billing intentionally frozen since 2009? Determines Billing module and `invoice`/`invoicedetail`/`Ledger` disposition in §3.
2. Which table is authoritative for agent login — `agents` or `Udaan_users` `agt` rows? Determines the §7 identity-binding key.
3. Are `api.messaging4u.com` (SMS) and `relay.spectranet.com` (SMTP) still active vendors? Determines `SmsService`/`EmailService` config.
4. Is the `chat/...` feature abandoned (folder confirmed missing)? Determines whether it's rebuilt or dropped.
5. Are the tour modules (`hotel`/`cab`/`paxhotel`/`paxCab`) still used? Determines §3 **COND** rows.
6. Do the ~700 `updateDDMMYY.asp` snapshots become archived static pages or CMS-imported content?
7. Confirm the 4 `su` accounts and define new super-admin provisioning process (feeds §4.3's su-only endpoint).
8. Business sign-off required on the data anomalies in §6 (statusID 508, junk dates, orphaned agents, `entrytype` NULL).
9. Canonical domain: `udaanindia.com` legacy references vs. current "Royal Routes" branding.
10. Confirm dedicated least-privilege SQL login naming/provisioning to replace `sa`.
11. *(New, from §3 COND rows)* Confirm whether `scheduler`, `priwork`, `subscriber`, `masterbalance`, `newagents` are still in active use — none of the source documents state usage status for these five tables, so they cannot be resolved without owner input.

---

*This document adds no functionality beyond what `modernization_plan.md`, `deepanalysis.md`, and `exiting_architecture.md` already describe. Every table, endpoint, role, and rule above traces to a specific citation in those three files.*
