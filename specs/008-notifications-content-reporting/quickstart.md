# Quickstart: Validating SPEC-0008 Notifications, Content, Reporting

**Date**: 2026-08-18 | **Spec**: [spec.md](spec.md) | **Contracts**: [contracts/](contracts/) | **Data model**: [data-model.md](data-model.md) | **Research**: [research.md](research.md)

This guide proves the feature works end-to-end. It is a run/validation guide — implementation details live in `tasks.md` (created by `/speckit.tasks`) and the implementation phase.

## Prerequisites

- .NET 8 SDK; `dotnet ef` CLI (10.x) for schema application; SQL Server instance with the `VisaFusion` target database (SPEC-0004/0005/0006 baseline).
- Solution builds: `dotnet build VisaFusion.sln`.
- Baseline suites green before this feature: Unit, Integration, Functional (run them before changes).
- No online NuGet source: all packages already in the local cache (SPEC-0003 T007).

## Setup

```powershell
# 1. Apply the NEW additive schema (queries + emailQueue; research D-1/D-4)
dotnet ef database update --project src/VisaFusion.Data --startup-project src/VisaFusion.Web
#    Expected: EF migration adds the queries and emailQueue tables only;
#    no existing table is altered or dropped (spec §16; reversibility tests cover this).

# 2. Verify the rate-limit keys are present (owner Q3:A)
Select-String -Path src/VisaFusion.Web/appsettings.json -Pattern "RateLimiting"
#    Expected: RateLimiting:Queries { PermitLimit = 5, WindowSeconds = 3600 }

# 3. Run the full test suites
dotnet test tests/UnitTests
dotnet test tests/IntegrationTests
dotnet test tests/FunctionalTests

# 4. Run the hosts
dotnet run --project src/VisaFusion.Web   # Web host (enqueue path + pages)
dotnet run --project src/VisaFusion.Jobs   # Jobs worker host (drain path)
```

## Validation scenarios

### S1 — Contact-query endpoint carry-forward (FR-007/008, AC-001/002)

1. Anonymous `POST /api/v1/public/queries` with a valid body (`name`, `email`, `subject`, `message`) → `201`.
2. Verify a `queries` row exists with `subdate`, `ip_address`, and `status = 'new'` (AC-001; owner Q4:A).
3. Verify the office-notification email was enqueued and logged to `sentmails` with recipient, sender details, and message text (AC-002 — golden-file against the legacy `contactsendpre.asp` template; see spec §23).
4. `POST` a malformed body (bad email / missing field) → `400`.
5. Submit 6 times within an hour from the same source → the 6th returns `429` (rate limit 5/hour enforced, AC-001).

### S2 — SMS queue (FR-001/003/004/006, AC-003/009)

1. As `emp`/`adm`/`su`, `POST /api/v1/notifications/sms` (`mobile`, `message`) → `202` in under 1 second (AC-009).
2. With `VisaFusion.Jobs` running, wait one poll cycle → the `smsQueue` row is gone and an `smshistory` row exists with all eight fields populated (cellno, refno, agentID, paxname, status, message, sentby, sentdate — AC-003).
3. As `agt`/anonymous → `401`/`403` (FR-009).
4. Fail-path: with a dispatch provider that throws, the audit row records `status = failed` and the worker retries (3 attempts, exponential backoff) — never silently swallowed (AC-004).

### S3 — Email queue (FR-002/003/005/006, AC-005/009)

1. As `emp`/`adm`/`su`, `POST /api/v1/notifications/email` (`to`, `subject`, `body`) → `202` in under 1 second (AC-009).
2. After a worker poll → the `emailQueue` row is gone and a `sentmails` row exists with `agentsid`, `date`, `toemail`, `awb` populated (AC-005).
3. Failure path mirrors S2 (AC-004).

### S4 — dailyUpdate CMS (FR-010, AC-006)

1. As `adm`/`su`: create, edit, and delete dated entries via `POST /api/v1/admin/content/daily-update` (with/without `id`) and `DELETE .../{id}` → success; the public page `Areas/Public/Pages/DailyUpdate` reflects the changes anonymously.
2. As `emp`/`agt`/anonymous: the CMS write endpoints return `403` (AC-006; legacy anonymous `dailyupdate.asp` write is closed — BR-003).

### S5 — Holiday/weekly-off CRUD (FR-011, AC-007)

1. As `adm`/`su` via `HolidayAdmin`: `POST /api/v1/holidays` and `POST /api/v1/holidays/weekly-off` → `201`.
2. Duplicate embassy+date or embassy+weekday → `409`; invalid weekday (not 1–7) → `400`.
3. Parity: for a created holiday date, `IHolidayService.IsEmbassyClosedAsync(embassyId, date)` returns `true` immediately (AC-007; rule from SPEC-0006, reused unchanged — BR-002).
4. `DELETE` the records → `204`; the rule returns `false` again.
5. As `emp`/`agt` → `401`/`403`.

### S6 — Operational reports (FR-012, AC-008)

1. As `emp`/`adm`/`su`: open each report surface (pending, today submission, today collection, today transaction, daily visa fee, daily bill) → rows render within 5 seconds; same inputs yield the same ordering (NFR-006).
2. As `agt`/`guest` → `403` (AC-008).
3. Invalid date inputs (`dateFrom` after `dateTo`, non-dates) → `400` before any query executes.
4. Security spot-check: no string-concatenated SQL in the report code path (existing `NoStringConcatenatedSqlTests` guard covers this — AC-008).

### S7 — Secrets and audit continuity (AC-010, BR-001)

1. Search the source tree and logs for the legacy plaintext credentials (`udaanindia`/`[REDACTED]`, relay hostnames) → no matches in source or logs (AC-010, NFR-004).
2. Verify `smshistory`/`sentmails` writes flow through the same tables as legacy — audit continuity (BR-001).

## Expected outcome

All scenarios pass against the verified legacy behaviors (`@findings/modernization_plan.md` §6.6/6.7/6.8/6.9/6.12), with the owner decisions 2026-08-18 honored: enqueue-and-log mode (Q1:C), v1 report set on-screen only (Q2:A), queries rate limit enforced (Q3:A), `queries.status` write-once `new` (Q4:A). No vendor send occurs in v1; the provider seam ([notifications-api.md §5](contracts/notifications-api.md)) is the single place where real dispatch is enabled later by configuration.
