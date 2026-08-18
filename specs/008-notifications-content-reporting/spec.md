# Feature Specification: Notifications, Content, Reporting

**Identifier**: SPEC-0008
**Title**: Notifications, Content, Reporting — SMS/email background queues, holiday/weekly-off management, dailyUpdate CMS, operational reports
**Status**: Draft
**Created**: 2026-08-18
**Category**: features
**Input**: User description: "Notifications, content, reporting — 7. SmsService/EmailService/Jobs background queues per §6.7, holiday/weeklyoff/Sunday rule via fn_IsBookableDate, dailyUpdate CMS" (Phase 2, item 7 of `library/ExecutionPlan.md`)

> This template is the VisaFusion override of the SpecKit `spec-template`.
> It is resolved first by the Spec Kit template stack (`.specify/templates/overrides/`)
> and MUST contain the 24 required sections defined in `library/03_SpecKit_SDD_Framework.md` §4.
> Do not remove or reorder the 24 numbered sections below.

## 1. Identifier

- **SPEC-0008**: Notifications, Content, Reporting (Phase 2, item 7 of `library/ExecutionPlan.md`)

## 2. Title

Notifications, Content, Reporting — SMS/email background queues, holiday/weekly-off management, dailyUpdate content CMS, and operational reports

## 3. Objective

Deliver Phase 2, item 7 of `library/ExecutionPlan.md`: (a) the SMS and email notification background queues (`SmsService`/`EmailService`/Jobs) that replace the legacy `SendSMS*.asp` and CDO/OSSMTP email flows; (b) the holiday/weekly-off/Sunday bookable-date surface — management CRUD on `holidaylist`/`weeklyoff` (the rule itself was delivered by SPEC-0006); (c) the `dailyUpdate` content CMS; and (d) the operational reporting surfaces of the legacy §6.6 report pages. Every notification send continues to be written to the legacy `smshistory`/`sentmails` audit tables so the 25-year history stays continuous (`@findings/modernization_plan.md` §7 audit-continuity requirement).

## 4. Business Context

The legacy app sends SMS via `SendSMS.asp`, which POSTs to `http://api.messaging4u.com/india/SendingSMS.aspx` with plaintext credentials over HTTP, and queues messages through `SendSMSToQueue.asp`/`SendSMStoQueue.asp` into the `smsQueue` table, logging sends to `smshistory` (`@findings/modernization_plan.md` §6.7). Email is sent via `CDO.Message`/`CDO.Configuration` over SMTP `relay.spectranet.com:25` in `contactsendpre.asp`, and via the `OSSMTP.dll` COM component in `addNewUser.asp`, logging to `sentmails`/`sentawb` (§6.7). Both vendor channels may be defunct and require owner confirmation (`@library/complete_migration_plan.md` open question 3).

Daily embassy/news content is managed through `dailyupdate.asp` (write) and `viewdailyupdate.asp` (read) against the `dailyUpdate` table, with ~700 `updateDDMMYY.asp` dated snapshots archived as static content (§6.9). Holiday/weekly-off records are managed through `holidayHome.asp`, `holiday_entry.asp`, `holiday_WebEntry.asp`, `holidaySubmit.asp`, `holidayDeleteSubmit.asp`, and `WeeklyOffList.asp` (§6.8). Operational reports live in `dailybill.asp`, `dailyVisaFee.asp`, `todaySubmission*.asp`, `todayCollection*.asp`, `todayTransaction.asp`, `pendinglist.asp`, `urgent.asp`, and `break.asp` (§6.6).

**Name resolution (bookable-date rule)**: the input description names `fn_IsBookableDate`, which is the retired name from `library/ExecutionPlan.md`. Per `specs/006-core-entry-workflow/checklists/database.md` CHK051 and Gap Report GR-0002, the name was retired in favor of the owner-confirmed split: the authoritative rule is `VisaFusion.Core`/`VisaFusion.Data` `HolidayService` (C#), with `fn_IsEmbassyClosed` (owner-supplied script 02) as the read-only reporting/BI mirror. Both were delivered by SPEC-0006. This feature does NOT re-implement the rule; it delivers the management CRUD that feeds the rule's calendar tables and reuses the delivered rule wherever notification/content/report behavior depends on date bookability.

## 5. Scope

- SMS notification queue: enqueue, background dispatch, `smshistory` audit logging, send/history API (legacy `SendSMS.asp`, `SendSMSManually.asp`, `SendSMSToQueue.asp`/`SendSMStoQueue.asp`/`sendSMSToQueue.asp`, §6.7)
- Email notification queue: enqueue, background dispatch, `sentmails`/`sentawb` audit logging, send/history API (legacy `contactsendpre.asp`, `emailAgent.asp`, `composeEmail.asp`, §6.7)
- Contact-query → office email: complete the SPEC-0007 `POST /api/v1/public/queries` carry-forward (persistence to a new `queries` table + rate limiting) and dispatch the office notification email that is the legacy behavior of `contactus.asp` → `contactsendpre.asp` (§6.12; no legacy DB persistence — the email IS the legacy behavior)
- `dailyUpdate` content CMS for `adm`/`su` with anonymous public read (legacy `dailyupdate.asp` write / `viewdailyupdate.asp` read, §6.9)
- Holiday/weekly-off management CRUD for `adm`/`su` via the `HolidayAdmin` policy (legacy §6.8 pages) — feeds `holidaylist`/`weeklyoff`, which `HolidayService`/`fn_IsEmbassyClosed` (SPEC-0006) consume
- Operational reports for `emp`/`adm`/`su` (legacy §6.6 pages): pending list, today submission, today collection, today transaction, daily visa fee, daily bill (owner decision 2026-08-18, Q2: A — no report email dispatch in v1)
- Complete the placeholder infrastructure from SPEC-0003 (`ISmsService`/`IEmailService`, `SmsQueueWorker`/`EmailQueueWorker`) with the real behavior defined in this spec (`ReportWorker` stays a placeholder — see §6 Out of Scope)
- Map all work to legacy pages per `@findings/modernization_plan.md` §6 and §13

## 6. Out of Scope

- The bookable-date rule implementation (delivered by SPEC-0006: `HolidayService` C# + `fn_IsEmbassyClosed` script 02) — reused, not re-implemented
- Entry workflow, status lifecycle, billing (SPEC-0006 module)
- Agent/admin CRUD, security-day gate, public site parity, theme (SPEC-0007 module)
- Internal in-app messaging (`composeEmail.asp` to in-app mailboxes, `message.asp`, `mymessage.asp`, `Addtoschedular.asp`/`scheduler` table) — separate messaging module, not part of §6.7 external SMS/email notifications
- The ~700 `updateDDMMYY.asp` static snapshot pages — content migration/archival, not code (`@findings/modernization_plan.md` §3.7)
- Tour modules (`hotel`, `cabs`, `paxhotel`, `paxCab`)
- Data cleansing and normalization (Phase 4)
- Search pages (`searchPax*`, `searchEntry*`, `searchResult.asp`) — agent-scoped search delivered in SPEC-0007; free-text search is Phase 4 reporting follow-up
- Report dispatch by email (`emailAllPending.asp`, `emailDaysPending.asp`, `emailCriteria.asp`, `emailRefno.asp`) — deferred per owner decision 2026-08-18 (Q2: A); v1 ships on-screen reports only
- `ReportWorker` real implementation / Phase-4 report generation (`src/VisaFusion.Jobs/Workers/ReportWorker.cs`) — remains a placeholder; report generation is a Phase 4 follow-up

## 7. Stakeholders

- Agents (`agt`) — recipients of status/appointment SMS and email notifications; their contact details (`agents.smsno`, `agents.emailid` — verified column names, modernization_plan §3.4 L528-531) feed notification addressing
- Employees (`emp`) — operate the daily reports and dispatch notifications
- System administrators (`adm`) and super users (`su`) — manage the `dailyUpdate` content, the holiday/weekly-off calendar, and notification operations
- Public visitors — submit contact queries (legacy `contactus.asp` flow) and read daily updates (`viewdailyupdate.asp`)
- Operations — confirm the SMS gateway and SMTP relay vendors and supply credentials
- Migration team — audit-log continuity (`smshistory`/`sentmails`) during cutover

## 8. Legacy Mapping

| Target capability | Legacy pages | Source |
|---|---|---|
| SMS notification queue | `SendSMS.asp`, `SendSMSManually.asp`, `SendSMSToQueue.asp`, `SendSMStoQueue.asp`, `sendSMSToQueue.asp` (→ `smsQueue` → `smshistory`) | modernization_plan §6.7 |
| Email notification queue | `contactsendpre.asp` (CDO, `relay.spectranet.com:25`), `emailAgent.asp`, `composeEmail.asp`, `addNewUser.asp` (OSSMTP COM) (→ `sentmails`/`sentawb`) | modernization_plan §6.7 |
| Contact-query → office email | `contactus.asp` form → `contactsendpre.asp` (CDO email to office; **no DB persistence in legacy**) → `contactsend.asp` | modernization_plan §6.12 |
| Content CMS | `dailyupdate.asp` (write), `viewdailyupdate.asp` (read), `update.asp`; ~700 `updateDDMMYY.asp` snapshots archived as static content | modernization_plan §6.9 |
| Holiday/weekly-off management | `holidayHome.asp`, `holiday_entry.asp`, `holiday_WebEntry.asp`, `holidaySubmit.asp`, `holidayDeleteSubmit.asp`, `WeeklyOffList.asp` (→ `holidaylist`, `weeklyoff`) | modernization_plan §6.8 |
| Operational reports | `pendinglist.asp`, `todaySubmission*.asp`, `todayCollection*.asp`, `todayTransaction.asp`, `dailyVisaFee.asp`, `dailybill.asp`, `urgent.asp`, `break.asp` | modernization_plan §6.6 |
| Report dispatch by email | `emailAllPending.asp`, `emailDaysPending.asp`, `emailCriteria.asp`, `emailRefno.asp` | modernization_plan §6.6 |

## 9. Functional Requirements

- **FR-001**: System MUST enqueue an SMS message (recipient mobile, message, optional refno/agentID context) and dispatch it through the background SMS worker, logging every send to the SMS history audit table (legacy `SendSMSToQueue.asp` → `smsQueue` → `smshistory`, §6.7)
- **FR-002**: System MUST enqueue an email message (recipient, subject, body, optional refno/agentID context) and dispatch it through the background email worker, logging every send to the email history audit table (legacy `contactsendpre.asp`/`emailAgent.asp` → `sentmails`, §6.7)
- **FR-003**: System MUST run SMS and email dispatch as background workers that never block request handling (Jobs worker host from SPEC-0003; see NFR-001)
- **FR-004**: System MUST record every SMS send with the full audit field set — cellno, refno, agentID, paxname, status, message, sentby, sentdate (legacy `smshistory` layout; audit continuity)
- **FR-005**: System MUST record every email send with the full audit field set — agentsid, date, toemail, awb (legacy `sentmails` layout; audit continuity)
- **FR-006**: System MUST handle a failed SMS/email dispatch with structured, visible failure logging and retry; failures MUST NOT be silently swallowed (no `on error resume next` behavior)
- **FR-007**: System MUST complete the SPEC-0007 contact-query endpoint `POST /api/v1/public/queries` carry-forward: persist validated queries to a new `queries` table and rate-limit them at 5/hour per source, **enforced in v1** (SPEC-0007 FR-011; owner decision 2026-08-18; wired via SPEC-0005 §17/R7)
- **FR-008**: System MUST dispatch the office notification email for a persisted contact query, preserving the legacy `contactus.asp` → `contactsendpre.asp` behavior (email to the office with sender details and message text)
- **FR-009**: System MUST protect all notification send and history-read endpoints with role authorization (`emp`/`adm`/`su`, per the SPEC-0005 T031 precedent for reporting/notifications)
- **FR-010**: System MUST provide a `dailyUpdate` CMS where `adm`/`su` can create, edit, and delete dated daily-update entries (date + description), with public read access remaining anonymous (legacy `dailyupdate.asp` write / `viewdailyupdate.asp` read)
- **FR-011**: System MUST provide holiday/weekly-off management CRUD for `adm`/`su` via the `HolidayAdmin` policy — create/delete embassy holiday dates and embassy weekly-off weekday records (legacy §6.8 pages), feeding the calendar tables consumed by the SPEC-0006 bookable-date rule
- **FR-012**: System MUST provide operational reports (pending list, today submission, today collection, today transaction, daily visa fee, daily bill) for `emp`/`adm`/`su`, generated from parameterized data access only (legacy §6.6 pages)

## 10. Business Rules

- **BR-001**: Notification channels MUST keep writing `smshistory`/`sentmails`/`sentawb` so the 25-year audit history stays continuous (`@findings/modernization_plan.md` §7 audit-continuity)
- **BR-002**: The bookable-date rule is implemented once — `HolidayService` (C#, authoritative) + `fn_IsEmbassyClosed` (read-only mirror), both delivered by SPEC-0006 — and MUST NOT be duplicated by any notification/content/report surface
- **BR-003**: `dailyUpdate` writes are `adm`/`su` only; the legacy anonymous `dailyupdate.asp` write endpoint moves behind role authorization (fixes the §2.8 finding; `@library/complete_migration_plan.md` §4.3 anonymous-write list)
- **BR-004**: Notification send endpoints are never anonymous; the only anonymous write is the validated, rate-limited public query submission (constitution security standards; SPEC-0005 §12)
- **BR-005**: SMS/SMTP credentials are never stored in source; they live in configuration (User Secrets / Key Vault) per SPEC-0005 NFR-004
- **BR-006**: Holiday weekly-off weekday values use the legacy VBScript `Weekday()` numbering (1=Sunday .. 7=Saturday), matching `WeeklyOffList.asp` and `HolidayService` (verified column mapping in `VisaEntryDbContext.ConfigureWeeklyOff`)

## 11. Non-functional Requirements

- **NFR-001**: SMS/email dispatch MUST NOT block the request lifecycle — enqueue returns immediately and dispatch happens on the background worker (SPEC-0003 Jobs host)
- **NFR-002**: All data access MUST be parameterized; no string-concatenated SQL (SPEC-0005 NFR-003; fixes the §6.6 report SQLi finding)
- **NFR-003**: All notification sends and failures MUST emit structured logs (Serilog) and counters (OpenTelemetry), extending the existing observability setup (SPEC-0005 NFR-006)
- **NFR-004**: Secrets (SMS gateway, SMTP) MUST NOT be stored in source (SPEC-0005 NFR-004; fixes the plaintext `udaanindia`/`rajan1604` SMS creds finding, modernization_plan §2.8)
- **NFR-005**: Notification dispatch MUST be retryable and idempotent per message — a retried message is dispatched once per attempt and logged once per attempt with its status (no duplicate silent sends)
- **NFR-006**: Report generation MUST be repeatable and deterministic for the same input date range

## 12. Security

- Notification send/history endpoints gated by role authorization (`emp`/`adm`/`su`) — 401/403, never anonymous (BR-004, FR-009)
- `dailyUpdate` CMS gated by the `AdminPanel` policy (`adm`/`su`) — the legacy anonymous `dailyupdate.asp` write endpoint is closed (BR-003)
- Holiday/weekly-off CRUD gated by the `HolidayAdmin` policy (`adm`/`su`) — 11-policy catalog from SPEC-0005 §5 (not §12); policy constants verified in `src/VisaFusion.Api/Authorization/AuthorizationPolicies.cs`
- Public query submission remains the only anonymous write — validated, rate-limited at 5/hour per source (enforced in v1; owner decision 2026-08-18; SPEC-0005 §17/R7; SPEC-0007 FR-011), and never accepts privileged data
- No query-string identity; recipient and scoping data resolve server-side
- SMS/SMTP credentials from configuration only (User Secrets / Key Vault); no credentials in source or logs
- Report queries parameterized; no SQL injection surface (NFR-002)

## 13. Performance

- Notification enqueue returns a response in under 1 second; dispatch happens asynchronously on the worker (NFR-001)
- The queue worker processes messages without delaying request handling; worker drain rate keeps up with the daily send volume (legacy peak well under the 47,534-row `smshistory` / 553,523-row `sentmails` totals, modernization_plan §3.4)
- Report pages render in under 5 seconds server response for the legacy data volumes (`pendinglist`, today sheets)
- No full extra round trips on the public daily-update read page

## 14. UI Requirements

- Admin content CMS page (Area `Admin`): list/create/edit/delete of `dailyUpdate` entries (date + description text) — `AdminPanel` policy
- Admin holiday/weekly-off pages (Area `Admin`): holiday CRUD and weekly-off weekday CRUD per embassy — `HolidayAdmin` policy
- Reporting pages (Area `Reporting`): pending list, today submission/collection/transaction, daily visa fee, daily bill — `emp`/`adm`/`su`
- Public daily-update read page: anonymous, renders the current and recent dated entries (legacy `viewdailyupdate.asp`)
- All surfaces use the SPEC-0007 bespoke Bootstrap 5.3.7 theme (AdminLTE NOT used per constitution), UTF-8, WCAG-AA baseline
- Empty states explicit (no rows → friendly message, never a blank table header)

## 15. API Contracts

Per `@library/complete_migration_plan.md` §5 (Notifications module) and §4.3 (route families), under the versioned `/api/v1` base path:

- `POST /api/v1/notifications/sms` — `emp`,`adm`,`su` (enqueue SMS; legacy `SendSMS*`; body: mobile, message, optional refno/agentId)
- `POST /api/v1/notifications/email` — `emp`,`adm`,`su` (enqueue email; legacy `emailAgent`/`composeEmail`; body: to, subject, body, optional refno/agentId)
- `GET /api/v1/notifications/sms-history` — `emp`,`adm`,`su` (audit read; legacy `smshistory`)
- `GET /api/v1/notifications/email-history` — `emp`,`adm`,`su` (audit read; legacy `sentmails`)
- `POST /api/v1/public/queries` — anonymous, validated, rate-limited (SPEC-0007 carry-forward: persist to `queries` + office email; legacy `contactus.asp`→`contactsendpre.asp`)
- `POST /api/v1/holidays` — `HolidayAdmin` (create holiday; legacy `holidaySubmit.asp`; route pre-registered in SPEC-0005 T030)
- `DELETE /api/v1/holidays/{id}` — `HolidayAdmin` (delete holiday; legacy `holidayDeleteSubmit.asp`; route pre-registered in SPEC-0005 T030)
- `POST /api/v1/holidays/weekly-off` — `HolidayAdmin` (create weekly-off weekday per embassy; legacy `WeeklyOffList.asp`; follows the pre-registered `/api/v1/holidays` route family)
- `DELETE /api/v1/holidays/weekly-off/{id}` — `HolidayAdmin` (delete weekly-off; legacy `WeeklyOffList.asp`)
- `POST /api/v1/admin/content/daily-update` — `AdminPanel` (create/update dailyUpdate entry; legacy `dailyupdate.asp`)
- `DELETE /api/v1/admin/content/daily-update/{id}` — `AdminPanel` (delete dailyUpdate entry)
- `GET /api/v1/reports/agent-status/today` — `emp`,`adm`,`su` (route pre-registered in SPEC-0005 T030)
- `GET /api/v1/reports/pending` — `emp`,`adm`,`su` (legacy `pendinglist.asp`)
- `GET /api/v1/reports/today-submission` — `emp`,`adm`,`su` (legacy `todaySubmission*.asp`)
- `GET /api/v1/reports/today-collection` — `emp`,`adm`,`su` (legacy `todayCollection*.asp`)
- `GET /api/v1/reports/today-transaction` — `emp`,`adm`,`su` (legacy `todayTransaction.asp`)
- `GET /api/v1/reports/daily-visa-fee` — `emp`,`adm`,`su` (legacy `dailyVisaFee.asp`)
- `GET /api/v1/reports/daily-bill` — `emp`,`adm`,`su` (legacy `dailybill.asp`)

All report endpoints render on-screen HTML; report dispatch by email is deferred per owner decision 2026-08-18 (Q2: A) and will reuse `POST /api/v1/notifications/email` when enabled.

## 16. Database Changes

- **NEW `queries` table** (additive, reversible): contact queries persisted from `POST /api/v1/public/queries` — `id` (identity), `name`, `email`, `subject`, `message`, `subdate`, `status` (defaults to `new` on insert; no processing surface in v1 — owner decision 2026-08-18), `ip_address`. No legacy table exists for this (legacy `contactus.asp`→`contactsendpre.asp` sent email only, no INSERT — verified this session); the legacy `querieDetail.asp` is a `visaInfo` content upsert and is NOT related to contact queries
- **NEW `emailQueue` table** (additive, reversible): durable email notification queue — `id` (identity), `toemail`, `subject`, `body`, `agentsid`, `refno`, `awb`, `sentby`, `sentdate`. No legacy email queue exists (legacy email was synchronous CDO/OSSMTP per §6.7) — research D-1; drained transactionally to `sentmails` (research D-3)
- **No change** to `smshistory` (existing: cellno, refno, agentID, paxname, status, message, sentby, sentdate — EF entity `SmsLog` from SPEC-0004), `sentmails` (existing: id, agentsid, date, toemail, awb — EF entity `EmailLog`), `smsQueue` (existing: cellno, refno, agentID, paxname, Message, sentby, sentdate — EF entity `SmsQueue` with surrogate Id), `dailyUpdate` (existing: entrydate, Description nvarchar(8000)), `holidaylist` (countryID, holiday, description), `weeklyoff` (embassyid, weekend, description)
- All changes reversible; no data deletion; no business tables dropped

## 17. Validation Rules

- SMS enqueue: recipient mobile required and valid; message required with length limit
- Email enqueue: recipient email required and valid; subject and body required with length limits
- Contact query: name, email (valid), subject, message all required with length limits (SPEC-0007 contract `public-api.md` §1); rate limit 5/hour per source (SPEC-0007 FR-011) **enforced in v1** (owner decision 2026-08-18), wired via SPEC-0005 §17/R7
- dailyUpdate: date and description required; description within the 8,000-character column limit
- Holiday: embassy and holiday date required; no duplicate embassy+date
- Weekly-off: embassy and weekday (1–7, VBScript numbering per BR-006) required; no duplicate embassy+weekday
- Reports: date-range inputs validated; invalid dates rejected before query execution

**Date bookability edge cases** (semantics delivered by SPEC-0006 `HolidayService`/`fn_IsEmbassyClosed`, reused unchanged — no re-implementation):
- A date that is both an embassy holiday and a weekly-off day → not bookable (most restrictive rule wins; `HolidayService` short-circuits on the first match)
- Null or invalid date input → rejected by input validation before the rule is invoked
- Embassy not found in the calendar tables → treated as bookable (no matching holiday/weekly-off row = no restriction)

## 18. Error Handling

- Standardized problem-details responses: 400 validation, 401/403 authorization, 404 not found, 409 duplicate (holiday/weekly-off), 429 rate-limited (queries)
- Dispatch failures are logged with structured details and retried; the failure is visible in the SMS/email history status field and in observability counters — never silently swallowed (FR-006)
- No stack traces or connection details leaked to clients
- Queue worker faults are isolated to the worker; a worker crash does not fail request handling

## 19. Audit Requirements

- Every SMS send: `smshistory` row with cellno, refno, agentID, paxname, status, message, sentby, sentdate (FR-004)
- Every email send: `sentmails` row with agentsid, date, toemail, awb (FR-005)
- Holiday/weekly-off create/delete: actor, target embassy, date/weekday, action
- dailyUpdate create/edit/delete: actor, entrydate, action
- Contact query: persisted row with timestamp, IP, and status defaulting to `new` (no processing surface in v1 — owner decision 2026-08-18); office-notification email logged to `sentmails`
- All authorization denials on notification/content/report routes logged per SPEC-0005 NFR-006 (subject, endpoint, outcome; no password material)

## 20. Acceptance Criteria

- **AC-001**: A valid contact query POST returns 201 and persists a row in `queries` with timestamp and IP; a malformed body returns 400; a rate-limited source (6th submission within an hour) returns 429
- **AC-002**: A persisted contact query triggers the office notification email, logged to `sentmails` with recipient, sender details, and message text (legacy `contactsendpre.asp` behavior)
- **AC-003**: Enqueuing an SMS creates a dispatch that results in an `smshistory` row with all eight audit fields populated
- **AC-004**: A failed SMS/email dispatch is retried and logged with its failure status — never silently swallowed
- **AC-005**: Enqueuing an email results in a `sentmails` row with agentsid, date, toemail, awb populated
- **AC-006**: The `dailyUpdate` CMS is accessible to `adm`/`su` only; non-admin roles receive 403; the public read page stays anonymous and reflects CMS changes
- **AC-007**: Holiday/weekly-off CRUD is accessible via the `HolidayAdmin` policy (`adm`/`su`) only; created records are immediately honored by the bookable-date rule (parity with `HolidayService`/`fn_IsEmbassyClosed`, SPEC-0006)
- **AC-008**: Operational reports render for `emp`/`adm`/`su`; `agt`/`guest` receive 403; all report queries are parameterized (no SQLi)
- **AC-009**: Notification enqueue returns in under 1 second and does not block request handling
- **AC-010**: No SMS/SMTP credentials appear in source code or logs

## 21. Risks

- SMS gateway / SMTP relay vendors — `api.messaging4u.com` and `relay.spectranet.com` may be defunct (complete_migration_plan open question 3; modernization_plan §6.7/§13); **RESOLVED 2026-08-18 (Q1: C)** — v1 runs enqueue-and-log mode with no real send; real dispatch is enabled by configuration once a vendor is confirmed
- Report scope — the legacy §6.6 list is broad; **RESOLVED 2026-08-18 (Q2: A)** — v1 ships pending list + today submission/collection/transaction + daily visa fee + daily bill with no email dispatch; remaining reports and email dispatch deferred
- GAP-0004 (identity import blocked) — agent-linked notification addressing and report joins depend on its resolution
- `dailyUpdate` content migration (~700 snapshot pages) — archival scope, not code; must not block the CMS
- Legacy `smsQueue` gate semantics (complete_migration_plan §10.6) — the queue worker must reproduce the send-once logging behavior without the legacy gate
- Retry semantics are new behavior (legacy had none) — kept idempotent per message (NFR-005) to avoid duplicate sends

## 22. Dependencies

- SPEC-0003 — Jobs worker host, placeholder `ISmsService`/`IEmailService`/`SmsQueueWorker`/`EmailQueueWorker` (T052/T054) — completed by this feature; `ReportWorker` stays a placeholder (§6)
- SPEC-0004 — EF entities `SmsLog`, `EmailLog`, `SmsQueue` with verified legacy column mappings
- SPEC-0005 — identity/RBAC, 11-policy catalog (§5), §17/R7 rate limiting, §4.3 route registrations (`POST /api/v1/holidays`, `DELETE /api/v1/holidays/{id}`, `POST /api/v1/reports/agent-status/today` as 501)
- SPEC-0006 — `HolidayService` (C# authoritative rule) + `fn_IsEmbassyClosed` (read-only mirror), entries/statuses data for reports; name resolution GR-0002/CHK051 (retired `fn_IsBookableDate`)
- SPEC-0007 — public site, `POST /api/v1/public/queries` placeholder endpoint, bespoke theme; carry-forward T032/T034 (persistence, rate limiting, integration tests)
- GAP-0004 resolution — identity import for agent-linked notification addressing

## 23. Test Scenarios

- Unit: notification validation rules, `smshistory`/`sentmails` audit-field completeness, weekly-off weekday numbering (BR-006), dailyUpdate/holiday/weekly-off validation
- Integration: queue worker drains `smsQueue` and writes `smshistory` with all audit fields; email enqueue writes `sentmails`; endpoint contracts (send, history, holiday CRUD, content CMS, reports); queries persistence + office-email dispatch; bookable-date rule parity after holiday/weekly-off CRUD changes (against `HolidayService`/`fn_IsEmbassyClosed`)
- Functional: end-to-end contact query → persist → office email (enqueued+logged); CMS create/edit/delete reflected on the public view; report render
- API: 201/400/429 on queries; 403 on notification/content/holiday/report routes for unauthorized roles; 409 on duplicate holiday/weekly-off
- Security: no credentials in source or logs; no SQLi on report endpoints (parameterized-only assertion)
- Golden-file: email payload structure for the contact-query notification compared against the legacy `contactsendpre.asp` message template (sender details + message text)

## 24. Traceability Matrix

| Requirement | Legacy source | Test |
|---|---|---|
| FR-001, FR-003, FR-004 | §6.7 `SendSMS*`, `SendSMSToQueue.asp`, `smsQueue`/`smshistory` | TS-001..003 |
| FR-002, FR-003, FR-005 | §6.7 `contactsendpre.asp`, `emailAgent.asp`, `composeEmail.asp`, `sentmails` | TS-004..006 |
| FR-006 | §6.7 (structured failure — modernization decision) | TS-007 |
| FR-007, FR-008 | §6.12 `contactus.asp` → `contactsendpre.asp`; SPEC-0007 contract | TS-008..010 |
| FR-009 | SPEC-0005 T031 precedent (emp/adm/su) | TS-011 |
| FR-010 | §6.9 `dailyupdate.asp`/`viewdailyupdate.asp` | TS-012 |
| FR-011 | §6.8 `holidayHome.asp`, `holidaySubmit.asp`, `WeeklyOffList.asp`; SPEC-0006 rule | TS-013 |
| FR-012 | §6.6 `pendinglist.asp`, `todaySubmission*`, `todayCollection*`, `todayTransaction.asp`, `dailyVisaFee.asp`, `dailybill.asp` | TS-014 |

## Assumptions

- Notification channels run in **enqueue-and-log mode for v1** (owner decision 2026-08-18, Q1: C): SMS/email messages are enqueued and fully audit-logged (`smshistory`/`sentmails`), but no real send occurs until a vendor is configured; dispatch is enabled by configuration only
- The Jobs worker host and empty Core service interfaces exist from SPEC-0003 (T052/T054); this feature completes them with real behavior — they are placeholders, not production services
- The bookable-date rule is delivered (SPEC-0006: `HolidayService` + `fn_IsEmbassyClosed`); the input's `fn_IsBookableDate` name is retired per GR-0002/CHK051 and is NOT re-implemented
- The `queries` table is a NEW table — no legacy table exists (legacy contact queries were email-only via `contactsendpre.asp`); persistence is a documented modernization decision from SPEC-0007, and the office email is the preserved legacy behavior
- The `emailQueue` table is a NEW queue table (research D-1) — the legacy app had no email queue; enqueued emails are drained transactionally to `sentmails` (research D-3)
- The `queries.status` field defaults to `new` on insert and has no processing surface in v1 (owner decision 2026-08-18); an admin query-management module (list/process) is future work
- `smshistory`, `sentmails`, `smsQueue`, `dailyUpdate`, `holidaylist`, `weeklyoff` exist (SPEC-0004) with the verified column layouts and are unchanged
- The ~700 `updateDDMMYY.asp` snapshots are archived as static content; the CMS writes the `dailyUpdate` table in the same date + description pattern (no rich text in v1)
- Contact-query rate limit is 5/hour per source per SPEC-0007 FR-011 and is **enforced in v1** (owner decision 2026-08-18), wired via SPEC-0005 §17/R7
- Notification dispatch retry (3 attempts, exponential backoff) is a reliability property of the queue worker — legacy `SendSMS.asp` had no retry; kept idempotent per message
- Report v1 set (owner decision 2026-08-18, Q2: A): pending list + today submission/collection/transaction + daily visa fee + daily bill; no report email dispatch in v1

## Clarifications

### Session 2026-08-18

- Q: The input description references `fn_IsBookableDate` (ExecutionPlan item 7) — the name was retired by SPEC-0006 CHK051/GR-0002. → A: The bookable-date rule is already delivered as `HolidayService` (C#, authoritative) + `fn_IsEmbassyClosed` (read-only mirror); this feature reuses it and delivers the §6.8 management CRUD, not a new function.
- Q: Does the legacy contact-query flow persist anything? → A: No — `contactus.asp` → `contactsendpre.asp` sends an email to the office (verified in source); there is no legacy `queries` table. The `queries` persistence is a new SPEC-0007 decision; the email dispatch is the preserved legacy behavior.
- Q: `querieDetail.asp` — is it related to contact queries? → A: No — verified in source: it upserts the `visaInfo` table (countryID/categoryID/information) and is visa-content editing, not contact-query handling.
- Q1: Which SMS gateway / SMTP relay vendors should production-ready dispatch use? → A: **Option C (2026-08-18)** — enqueue-and-log mode for v1; no real send until a vendor is confirmed and configured (Risks §21; Assumptions)
- Q2: Which reports ship in v1, and is report-dispatch-by-email in scope? → A: **Option A (2026-08-18)** — pending list + today submission/collection/transaction + daily visa fee + daily bill, on-screen only; no report email dispatch in v1 (FR-012; Risks §21; Assumptions)
- Q3: Should the contact-query rate limit be actively enforced in v1? → A: **Option A (2026-08-18)** — enforce 5/hour per source in v1; threshold configured, AC-001 429 scenario testable (FR-007; §12; §17; AC-001; Assumptions)
- Q4: What happens to the `queries.status` field in v1 given no management surface is in scope? → A: **Option A (2026-08-18)** — keep the field, default `new` on insert, no processing surface in v1 (read-only audit trail) (§16; §19; Assumptions)
