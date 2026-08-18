# Research — SPEC-0008 Notifications, Content, Reporting

**Branch**: `008-notifications-content-reporting` | **Date**: 2026-08-18 | **Plan**: [plan.md](plan.md)

Phase 0 output of `/speckit.plan`. Resolves the technical unknowns for the notification queues, content CMS, and reporting surfaces against the legacy source of truth and the delivered SPEC-0003..0007 infrastructure. All facts cited below were verified in the codebase this session.

## Scope of Research

| Unknown / choice | Source |
|---|---|
| Email queue backing store (no legacy email queue table exists) | verified: findings `modernization_plan.md` L595 lists `smsQueue` only; no `emailQueue` anywhere in findings/library |
| Queue drain semantics without a queue status column | verified: `SmsQueue.cs` (cellno, refno, agentID, paxname, Message, sentby, sentdate — NO status column); complete_migration_plan §10.6 "legacy smsQueue gate semantics" |
| Dispatch behavior under enqueue-and-log mode (owner Q1:C) | spec §21/Assumptions |
| Rate-limit enforcement values (owner Q3:A) | spec FR-007/AC-001/§17; Program.cs rate-limiter wiring (config keys `RateLimiting:Queries:*`) |
| Holiday/weekly-off CRUD parity check surface (AC-007) | verified: `IHolidayService.IsEmbassyClosedAsync` (Core L27-36) + EF impl (Data) |
| Report data-access pattern (NFR-002) | verified: `VisaEntryDbContext` EF Core; NoStringConcatenatedSqlTests precedent |
| Service placement for the completed SmsService/EmailService | verified: HolidayService precedent (Core interface + Data impl, CoreServiceCollectionExtensions.cs L25-29) |

## Decisions

### D-1 — New `emailQueue` table backs the email notification queue

**Decision**: Add a NEW additive `emailQueue` table (surrogate `Id` bigint identity; `toemail`, `subject`, `body`, `agentsid` int?, `refno` int?, `awb` nvarchar, `sentby`, `sentdate`) as the backing store for the email background worker, mirroring the legacy `smsQueue` shape for `sentmails`.

**Rationale**: FR-002/FR-003/NFR-001 require emails to be enqueued and dispatched through a background worker. The legacy email path is synchronous only (`contactsendpre.asp` → CDO send → INSERT `sentmails`; `emailAgent.asp`; `composeEmail.asp` — no queue table exists). Without a durable queue the worker has nothing to drain and enqueue-and-log mode cannot guarantee the audit trail survives a process restart. The new table is additive and reversible (constitution gate III).

**Alternatives considered**:
- *Synchronous write to `sentmails` only* — violates FR-002/FR-003 (background dispatch) and NFR-001 (no blocking); rejected.
- *Reuse `smsQueue`* — wrong column shape (cellno/message vs toemail/subject/body); would corrupt audit data; rejected.
- *In-memory queue* — loses durability and the 25-year audit guarantee on restart; rejected.

**Flag**: spec §16 lists only the NEW `queries` table; `emailQueue` is a derived design decision required by FR-002. The implementation phase must amend §16 of SPEC-0008 (traceability gate) to register the new table before its migration is applied.

### D-2 — Dispatch provider abstraction with a log-only default (enqueue-and-log mode)

**Decision**: `ISmsService`/`IEmailService` expose `EnqueueAsync` (validates + inserts the queue row, returns immediately) and `DrainNextBatchAsync` (worker-side). The actual vendor send is behind an internal provider interface (`ISmsDispatchProvider`/`IEmailDispatchProvider`) whose v1 default is a **log-only provider**: it records the dispatch attempt and succeeds without contacting any vendor. A real provider (HTTP SMS gateway, SMTP relay) is registered only when configuration supplies vendor settings (owner Q1:C).

**Rationale**: Matches the owner decision exactly: audit continuity works from day one, no vendor dependency, no invented credentials. The provider seam keeps the queue/audit machinery unchanged when the vendor is later configured. Retry/failure behavior (FR-006, NFR-005) is exercised against the provider boundary, so AC-004 is testable without a vendor.

**Alternatives considered**:
- *No provider seam, worker no-ops entirely* — makes AC-004 (retry/failure) untestable; rejected.
- *Wire the legacy `api.messaging4u.com`/`relay.spectranet.com:25` endpoints* — may be defunct, sends plaintext creds (modernization_plan §2.8 finding), blocked by NFR-004; rejected.

### D-3 — Transactional queue drain reproduces the legacy send-once gate semantics

**Decision**: `DrainNextBatchAsync` processes a bounded batch (`Take(n)`) inside a single transaction: read the queue batch → for each row invoke the dispatch provider → write the audit row (`smshistory` for SMS with all 8 fields; `sentmails` for email) → delete the queue row. Commit once per batch. Failed rows are logged with status (`failed`) in the audit table and retried by the worker on the next pass (3 attempts, exponential backoff, idempotent per message — NFR-005). Worker poll interval keeps the drain ahead of daily volume; no request path touches the drain.

**Rationale**: The legacy `smsQueue` has no status/processed column (verified in `SmsQueue.cs`), so the legacy "send-once" gate (complete_migration_plan §10.6) was row-removal based — the queue row disappears once handled. The transactional read→audit→delete reproduces that behavior exactly and gives crash safety: a worker crash before commit leaves the queue row for the next pass, so a message is never sent twice and never lost silently.

**Alternatives considered**:
- *Add a `processed` column to `smsQueue`* — violates spec §16 "No change" to the six legacy tables; rejected.
- *Two-phase (update flag then send)* — requires a schema change and adds a partial-state window; rejected.

### D-4 — Queries rate limit enforced in v1 via appsettings keys (owner Q3:A)

**Decision**: Add `RateLimiting:Queries:PermitLimit = 5` and `RateLimiting:Queries:WindowSeconds = 3600` to `src/VisaFusion.Web/appsettings.json` and `appsettings.Development.json`. This activates the already-wired conditional limiter (`Program.cs` L251-283, L654-657) so the `queries` route is throttled at 5/hour per source and AC-001's 429 scenario is testable.

**Rationale**: Owner decision Q3:A (2026-08-18) explicitly requires the limit enforced in v1 using the SPEC-0007 FR-011 contract figure. The value is owner-confirmed, not invented (SPEC-0005 §17/R7 requires owner-supplied thresholds — supplied here). The `register` limiter keys remain owner-supplied and are NOT set by this feature.

**Alternatives considered**:
- *Leave config absent* — limiter stays unwired, AC-001's 429 case untestable; contradicts owner Q3:A; rejected.
- *Hard-code 5/hour in Program.cs* — violates the SPEC-0005 config-driven limiter design; rejected.

### D-5 — Holiday/weekly-off CRUD parity asserted against `IHolidayService`, no rule duplication

**Decision**: The CRUD services validate duplicates (embassy+date, embassy+weekday → 409) and AC-007's "immediately honored by the bookable-date rule" is verified by calling `IHolidayService.IsEmbassyClosedAsync` (Core) against the just-created rows in both integration and functional tests. Weekday values use VBScript `Weekday()` numbering 1=Sunday..7=Saturday (BR-006; verified `WeeklyOffList.asp` mapping and `HolidayService.cs` L61).

**Rationale**: BR-002 forbids duplicating the bookable-date rule; `HolidayService` is the single authoritative implementation (SPEC-0006), and the CRUD surface feeds exactly the tables it reads (`holidaylist`/`weeklyoff` — `HolidayService.cs` L52-65). Testing parity through the service is the strongest non-duplicating proof of AC-007.

**Alternatives considered**:
- *Re-implement bookability in the CRUD page* — violates BR-002/constitution single-rule principle; rejected.
- *Direct `fn_IsEmbassyClosed` mirror comparison in tests* — the T-SQL mirror carries TODO-verification flags (HolidayService.cs L30-33); the C# service is authoritative; rejected for test ground truth.

### D-6 — Reports use parameterized EF Core LINQ with server-side date validation

**Decision**: All six report queries (pending list, today submission/collection/transaction, daily visa fee, daily bill) are built with parameterized EF Core LINQ against `VisaEntryDbContext` and projected to DTOs; date-range inputs are validated (rejected as 400) before any query runs. No string-built SQL anywhere (NFR-002).

**Rationale**: EF Core parameterizes LINQ by default, satisfying NFR-002 and the existing `NoStringConcatenatedSqlTests` guard; legacy report pages built SQL by string concatenation (the §6.6 SQLi finding, modernization_plan §2.8) — this closes that surface. Deterministic output for the same date range (NFR-006) comes from stable ORDER BY clauses.

**Alternatives considered**:
- *Dapper + hand-written parameterized SQL* — works but adds a new data-access dependency to the stack; rejected for consistency.
- *Raw `FromSqlRaw`* — risk of reintroducing string-built SQL; rejected.

### D-7 — Completed Sms/Email services follow the `IHolidayService` placement precedent

**Decision**: The `ISmsService`/`IEmailService` interfaces stay in `VisaFusion.Core.Application` (single shared surface); the implementations move to `VisaFusion.Data.Application` (EF-backed), exactly mirroring `IHolidayService`/`ISecurityGateService` (approved deviation, CoreServiceCollectionExtensions.cs L25-29, deviation log §1/§5). The placeholder registrations are removed from `AddVisaFusionCore()`; both composition roots (`VisaFusion.Web/Program.cs` and `VisaFusion.Jobs/Program.cs`) register the Data implementations plus `VisaEntryDbContext`.

**Rationale**: The implementations need `VisaEntryDbContext`, which Core cannot reference (one-way Data → Core). Reusing the established precedent avoids a new architectural pattern and keeps both hosts (Web enqueue path + Jobs drain path) resolving the same service implementations (single behavior, BR-002 spirit).

**Alternatives considered**:
- *Keep implementations in Core with ADO.NET* — bypasses EF entities/audit mapping and the migration pipeline; rejected.
- *New fifth service project* — violates the 7-project deviation constraint; rejected.

## Unresolved Items

- **Vendor confirmation** (SMS gateway / SMTP relay) — intentionally deferred by owner Q1:C; the provider seam (D-2) is the integration point. No code change needed beyond configuration when a vendor is chosen.
- **GAP-0004 identity import** — agent-linked notification addressing and report joins depend on its resolution; existing rows and entities remain usable (nullable FKs).
- **~700 `updateDDMMYY.asp` snapshot archival** — content migration, out of scope (spec §6); does not block the CMS.
