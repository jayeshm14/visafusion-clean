# Data Model — SPEC-0008 Notifications, Content, Reporting

**Branch**: `008-notifications-content-reporting` | **Date**: 2026-08-18 | **Plan**: [plan.md](plan.md)

Phase 1 output of `/speckit.plan`. Entity definitions, relationships, validation, and state transitions derived from spec §16/§17 and verified entity/column mappings in `src/VisaFusion.Data/Persistence/Entities/*.cs` and `VisaEntryDbContext`.

## Legend

- **NEW** — additive table created by this feature (reversible; no data touched).
- **UNCHANGED** — existing table/entity from SPEC-0004; schema NOT modified (spec §16 "No change").

## Entities

### 1. `ContactQuery` — NEW table `queries`

Contact queries persisted from `POST /api/v1/public/queries` (spec §16; owner Q4:A keeps `status`, no processing surface in v1).

| Column | Type | Required | Notes |
|---|---|---|---|
| `Id` | bigint identity (PK) | yes | Surrogate key |
| `Name` | nvarchar | yes | Validated at the API boundary (spec §17) |
| `Email` | nvarchar | yes | Valid email format |
| `Subject` | nvarchar | yes | Length-limited |
| `Message` | nvarchar | yes | Length-limited |
| `Subdate` | datetime2 | yes | Server timestamp of submission (AC-001) |
| `Status` | nvarchar | yes | Defaults to `new` on insert; never transitions in v1 (owner Q4:A — read-only audit trail) |
| `IpAddress` | nvarchar | yes | Submission source IP (AC-001) |

No legacy table exists (legacy `contactus.asp` → `contactsendpre.asp` was email-only — verified; `querieDetail.asp` is a `visaInfo` upsert, unrelated).

### 2. `EmailQueue` — NEW table `emailQueue` (research.md D-1)

Durable backing store for the email background worker (FR-002/003); mirrors the legacy `smsQueue` shape so the drain logic is uniform.

| Column | Type | Required | Notes |
|---|---|---|---|
| `Id` | bigint identity (PK) | yes | Surrogate key (mirrors `SmsQueue.Id`) |
| `Toemail` | nvarchar | yes | Valid email |
| `Subject` | nvarchar | yes | Length-limited |
| `Body` | nvarchar | yes | Message body |
| `Agentsid` | int | no | FK to `Agent.Id` (legacy `agentsid` convention) |
| `Refno` | int | no | Optional entry reference (mirrors `SmsQueue.Refno`) |
| `Awb` | nvarchar | no | Optional AWB (mirrors `EmailLog.Awb` payload) |
| `Sentby` | nvarchar | no | Actor (mirrors `SmsQueue.Sentby`) |
| `Sentdate` | datetime2 | no | Enqueue timestamp (mirrors `SmsQueue.Sentdate`) |

Flag (from research D-1): spec §16 must be amended during implementation to register this table (traceability gate).

### 3. `SmsLog` — UNCHANGED table `smshistory`

Append-only SMS audit log (FR-004). Verified layout (`SmsLog.cs`): `Id` (surrogate bigint identity), `Cellno`, `Refno` (int?), `AgentId` (int?, FK Agent), `Paxname`, `Status`, `Message`, `Sentby`, `Sentdate` — all eight legacy audit fields. Written by `SmsQueueWorker` drain (research D-3); never updated in place.

### 4. `EmailLog` — UNCHANGED table `sentmails`

Append-only email audit log (FR-005). Verified layout (`EmailLog.cs`): `Id` (legacy numeric identity, values preserved), `Agentsid` (int), `Date` (datetime?), `Toemail`, `Awb`. Written by the email worker drain; also receives the contact-query office-notification email row (FR-008/AC-002).

### 5. `SmsQueue` — UNCHANGED table `smsQueue`

SMS queue backing store (FR-001). Verified layout (`SmsQueue.cs`): `Id` (surrogate), `Cellno`, `Refno`, `AgentId`, `Paxname`, `Message`, `Sentby`, `Sentdate`. **No status column** — the drain's send-once gate is row removal inside a transaction (research D-3; complete_migration_plan §10.6).

### 6. `ContentUpdate` — UNCHANGED table `dailyUpdate`

CMS content (FR-010). Verified layout (`ContentUpdate.cs`): `Id` (surrogate), `Entrydate` (datetime?), `Description` (nvarchar; column max 8,000 chars — spec §17). `adm`/`su` create/edit/delete; anonymous public read.

### 7. `Holiday` — UNCHANGED table `holidaylist`

Embassy holiday dates (FR-011). Verified layout (`Holiday.cs`): `Id` (surrogate), `CountryId` (int? — no target FK, open gap from SPEC-0004; holds the embassy id per `holidayList.asp:131`), `HolidayDate` (datetime?), `Description`. Consumed by `HolidayService.IsEmbassyClosedAsync` (rule reuse, BR-002).

### 8. `WeeklyOff` — UNCHANGED table `weeklyoff`

Embassy weekly-off weekday (FR-011). Verified layout (`WeeklyOff.cs`): `Id` (surrogate), `Embassyid` (int?, FK `Embassy.Id`), `Weekend` (int? — VBScript `Weekday()` numbering, 1=Sunday..7=Saturday, BR-006), `Description`. Consumed by `HolidayService.IsEmbassyClosedAsync`.

## Relationships

```text
Agent (1) ──── (0..*) SmsLog            via SmsLog.AgentId
Agent (1) ──── (0..*) SmsQueue          via SmsQueue.AgentId
Agent (1) ──── (0..*) EmailLog          via EmailLog.Agentsid
Agent (1) ──── (0..*) EmailQueue        via EmailQueue.Agentsid
Embassy (1) ── (0..*) WeeklyOff         via WeeklyOff.Embassyid
Embassy (1) ── (0..*) Holiday           via Holiday.CountryId (documented gap: no FK constraint)
ContactQuery ── (no FK)                 standalone
```

## Validation Rules (spec §17)

| Surface | Rule |
|---|---|
| SMS enqueue | recipient mobile required + valid; message required, length-limited |
| Email enqueue | recipient email required + valid; subject/body required, length-limited |
| Contact query | name/email(subject/message required; email valid; all length-limited; rate limit 5/hour per source — 429 |
| dailyUpdate | date + description required; description ≤ 8,000 chars |
| Holiday | embassy + holiday date required; no duplicate embassy+date (409) |
| Weekly-off | embassy + weekday 1–7 required; no duplicate embassy+weekday (409) |
| Reports | date-range inputs validated; invalid dates rejected before query (400) |

## State Transitions

```text
SMS:  [enqueue] smsQueue row ──worker drain (tx)──▶ [audit] smshistory row (status: sent|failed) + queue row deleted
Email:[enqueue] emailQueue row ──worker drain (tx)──▶ [audit] sentmails row + queue row deleted
Query: POST /api/v1/public/queries ──▶ [persist] queries row (status='new') + [enqueue] office email → sentmails
ContentUpdate: create/edit/delete by adm/su ──▶ [reflect] anonymous public read
Holiday/WeeklyOff: create/delete by adm/su ──▶ [rule] HolidayService sees the row immediately (AC-007 parity)
```

Notes:
- Queue rows never mutate; they are deleted only by the successful drain commit (send-once, research D-3).
- Retry (3 attempts, exponential backoff) is a worker property; each attempt is logged once with its status (NFR-005); a permanently failing row remains visible in the audit log as `failed` and is not silently swallowed (FR-006).
- `queries.status` is write-once (`new`) in v1 (owner Q4:A); an admin query-management module is future work.
