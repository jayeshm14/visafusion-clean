# Implementation Plan: Notifications, Content, Reporting

**Branch**: `008-notifications-content-reporting` | **Date**: 2026-08-18 | **Spec**: [specs/008-notifications-content-reporting/spec.md](spec.md)

**Input**: Feature specification from `/specs/008-notifications-content-reporting/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command; its definition describes the execution workflow.

## Summary

SPEC-0008 delivers Phase 2 item 7 of `library/ExecutionPlan.md`:

- **SMS notification queue** — enqueue + background dispatch, `smshistory` audit continuity (FR-001/003/004/006).
- **Email notification queue** — enqueue + background dispatch, `sentmails` audit continuity (FR-002/003/005/006).
- **Contact-query completion** — finish the SPEC-0007 `POST /api/v1/public/queries` carry-forward: persist to the new `queries` table and enforce the 5/hour per-source rate limit in v1 (FR-007/008; owner Q3:A), plus the office-notification email (FR-008).
- **Holiday/weekly-off management CRUD** — `HolidayAdmin` policy, feeding the SPEC-0006 `HolidayService` rule (FR-011).
- **`dailyUpdate` content CMS** — `AdminPanel` policy with anonymous public read (FR-010).
- **Operational reports** — pending list, today submission/collection/transaction, daily visa fee, daily bill; `emp`/`adm`/`su`, on-screen only (FR-012; owner Q2:A).

v1 runs **enqueue-and-log mode** (owner Q1:C): messages are enqueued and fully audit-logged, with no real vendor send until configuration supplies a provider. The plan completes the SPEC-0003 placeholder infrastructure (`ISmsService`/`IEmailService`, `SmsQueueWorker`/`EmailQueueWorker`) — `ReportWorker` stays a placeholder for Phase 4 (spec §6) — and reuses the delivered SPEC-0006 `HolidayService` rule unchanged.

## Technical Context

**Language/Version**: C# 12 / .NET 8.0 (`net8.0` — verified in `VisaFusion.{Core,Data,Api,Jobs,Web}.csproj`)

**Primary Dependencies**:
- ASP.NET Core 8 (shared framework via `FrameworkReference` — no online NuGet source per SPEC-0003 T007)
- EF Core `Microsoft.EntityFrameworkCore.SqlServer` 8.0.20 (VisaFusion.Data)
- ASP.NET Core Identity (VisaFusion.Identity) + `Microsoft.AspNetCore.Authentication.JwtBearer` 8.0.20
- Serilog 10.0.0 (`Serilog.AspNetCore`, `Serilog.Sinks.File`, `Serilog.Sinks.MSSqlServer`) and OpenTelemetry 1.17.0 (VisaFusion.Web)
- Existing rate-limiter plumbing in `src/VisaFusion.Web/Program.cs` (fixed-window, config-driven; keys `RateLimiting:Queries:PermitLimit`/`:WindowSeconds`)

**Storage**: SQL Server — existing instance, legacy `VisaEntry` preserved read-only, target database `VisaFusion` (GAP-0003 Option A). Tables involved: `smshistory`/`smsQueue`/`sentmails`/`dailyUpdate`/`holidaylist`/`weeklyoff` (existing, unchanged — EF entities `SmsLog`/`SmsQueue`/`EmailLog`/`ContentUpdate`/`Holiday`/`WeeklyOff` from SPEC-0004) + NEW `queries` table (additive, reversible; spec §16) + NEW `emailQueue` table (see research.md Decision D-1 — no legacy email queue exists).

**Testing**: xUnit — `tests/UnitTests`, `tests/IntegrationTests` (EF Core + SQL), `tests/FunctionalTests` (WebApplicationFactory); `scripts/ai-environment-validation/validate-ai-environment.ps1` as environment gate. No online NuGet restore — all packages already in repo cache.

**Target Platform**: Windows Server + IIS (Web host `VisaFusion.Web`); `VisaFusion.Jobs` as a separate background-worker process (SPEC-0003). Workers currently run as placeholders (`SmsQueueWorker`/`EmailQueueWorker`/`ReportWorker` — 30s poll, no behavior).

**Project Type**: Web application (Razor Pages + minimal-API endpoints under `/api/v1`) + background worker host + class libraries (`VisaFusion.Core`, `VisaFusion.Data`, `VisaFusion.Identity`, `VisaFusion.Api`, `VisaFusion.Migration`).

**Performance Goals**: notification enqueue < 1 s (AC-009); report pages < 5 s server response; worker drain keeps up with daily volume (legacy totals: 47,534 `smshistory` / 553,523 `sentmails` rows — modernization_plan §3.4).

**Constraints**: enqueue-and-log mode in v1 (no real vendor send); no schema change to the six legacy tables; `queries` rate limit 5/hour per source enforced in v1 (owner Q3:A); retry 3 attempts exponential backoff, idempotent per message (NFR-005); no string-concatenated SQL (NFR-002); secrets config-only (NFR-004).

**Scale/Scope**: 25-year audit-history continuity; ~700 `updateDDMMYY.asp` snapshots archived (out of scope); 2 notification queues; 6 on-screen reports; 1 new table + 1 new queue table; ~18 API routes; 4 Razor page surfaces (Public/Admin/Reporting).

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Gate | Check | Verdict |
|------|-------|---------|
| I. Specification-first (SDD) | SPEC-0008 exists, 24 sections + Assumptions + Clarifications, all NC markers resolved by owner 2026-08-18 (Q1:C, Q2:A, Q3:A, Q4:A) | PASS |
| II. Legacy as source of truth | Every FR mapped to legacy pages (§8/§24 of spec: `SendSMS*`, `contactsendpre.asp`, `dailyupdate.asp`, §6.8 holiday pages, §6.6 report pages); no invented business features; ambiguous `fn_IsBookableDate` name resolved to SPEC-0006 rule (reused, not re-implemented) | PASS |
| III. Data preservation & integrity | No business table dropped; only NEW additive tables (`queries`, `emailQueue`); six legacy tables unchanged; all changes reversible | PASS |
| IV. Traceability & governance | Spec §24 traceability matrix (FR→legacy→TS); Knowledge Graph update required after implementation; ADR-0001 layout honored | PASS |
| V. Quality & no-assumption | Tests mandatory per FR/AC; the two new tables and the rate-limit default are explicitly justified in research.md, not assumed | PASS |
| VI. Legacy forensic artifacts | No renaming of `Udaan_users`, `udaanuma-dev`, `r&d`, backdoor query parameters (not touched by this feature) | PASS |
| Security standards | No anonymous writes except validated, rate-limited queries (BR-004); credentials config-only (BR-005/NFR-004); no string SQL (NFR-002); `dailyupdate.asp` anonymous write closed (BR-003) | PASS |

No violations → Complexity Tracking table intentionally empty.

## Project Structure

### Documentation (this feature)

```text
specs/008-notifications-content-reporting/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output — design decisions D-1..D-7 (/speckit.plan)
├── data-model.md        # Phase 1 output — entities, queues, audit flow (/speckit.plan)
├── quickstart.md        # Phase 1 output — runnable validation guide (/speckit.plan)
├── contracts/           # Phase 1 output — API + worker contracts (/speckit.plan)
│   ├── notifications-api.md
│   ├── content-api.md
│   └── reports-api.md
├── checklists/
│   └── requirements.md  # 16/16 pass (specify + clarify) + CHK001..038 appended (/speckit.checklist)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created here)
```

### Source Code (repository root)

```text
src/VisaFusion.Core/
└── Application/
    ├── SmsService.cs            # MODIFY: real ISmsService interface (enqueue/drain/history)
    ├── EmailService.cs          # MODIFY: real IEmailService interface (enqueue/drain/history)
    ├── NotificationMessages.cs  # NEW: SmsMessage/EmailMessage/QueueDrainResult records (named to avoid collision with the Api DTOs file)
    └── HolidayService.cs        # UNCHANGED: authoritative rule (SPEC-0006), reused for AC-007 parity
    CoreServiceCollectionExtensions.cs   # MODIFY: remove placeholder ISmsService/IEmailService registrations (implementations move to Data, HolidayService precedent)

src/VisaFusion.Data/
├── Application/
│   ├── SmsService.cs            # NEW: EF-backed ISmsService impl (smsQueue → smshistory transactional drain)
│   ├── EmailService.cs          # NEW: EF-backed IEmailService impl (emailQueue → sentmails transactional drain)
│   └── HolidayService.cs        # UNCHANGED: read-only mirror of rule data (SPEC-0006)
├── Persistence/
│   ├── Entities/ContactQuery.cs # NEW: `queries` table entity
│   └── Entities/EmailQueue.cs   # NEW: `emailQueue` table entity (research D-1)
│   VisaEntryDbContext.cs        # MODIFY: DbSet<ContactQuery>, DbSet<EmailQueue> + config
└── Migrations/                  # NEW migration: queries + emailQueue (additive, reversible)

src/VisaFusion.Jobs/
├── Program.cs                   # MODIFY: register VisaEntryDbContext + Data-backed services + Serilog
└── Workers/
    ├── SmsQueueWorker.cs        # MODIFY: real drain loop (periodic batch, retry, telemetry)
    ├── EmailQueueWorker.cs      # MODIFY: real drain loop (periodic batch, retry, telemetry)
    └── ReportWorker.cs          # MODIFY: stays a placeholder — Phase-4 report generation out of scope (spec §6)

src/VisaFusion.Api/
├── Endpoints/
│   ├── NotificationsEndpoint.cs # NEW: POST sms/email, GET sms-history/email-history (FR-001..006)
│   ├── HolidaysEndpoint.cs      # NEW: POST/DELETE holidays + weekly-off (FR-011, routes pre-registered)
│   ├── ContentEndpoint.cs       # NEW: daily-update POST/DELETE (FR-010)
│   ├── ReportsEndpoint.cs       # NEW: 6 report GETs (FR-012, agent-status route pre-registered)
│   └── PublicEndpoint.cs        # MODIFY: SubmitQueryAsync persists + enqueues office email; fix stale querieDetail.asp comment
└── Contracts/
    ├── NotificationContracts.cs # NEW: API request/response DTOs
    ├── ContentContracts.cs      # NEW: daily-update DTOs
    └── ReportContracts.cs       # NEW: report row DTOs

src/VisaFusion.Web/
├── Program.cs                   # MODIFY: register Data-backed services (Web composition root, HolidayService precedent);
│                                #         wire queries route → PublicEndpoint.SubmitQueryAsync; add notification/content/
│                                #         holiday/report routes; add RateLimiting:Queries config (Q3:A)
├── appsettings.json             # MODIFY: RateLimiting:Queries { PermitLimit: 5, WindowSeconds: 3600 }
├── appsettings.Development.json # MODIFY: same queries limiter keys (local testability of AC-001)
└── Areas/
    ├── Admin/Pages/
    │   ├── ContentUpdate/Index.cshtml(+cs)   # NEW: dailyUpdate CMS (FR-010, AdminPanel)
    │   └── Holidays/Index.cshtml(+cs)        # NEW: holiday + weekly-off CRUD (FR-011, HolidayAdmin)
    ├── Reporting/Pages/
    │   └── (Pending.cshtml, TodaySubmission.cshtml, TodayCollection.cshtml,
    │        TodayTransaction.cshtml, DailyVisaFee.cshtml, DailyBill.cshtml)(+cs)  # NEW (FR-012)
    └── Public/Pages/
        └── DailyUpdate.cshtml(+cs)           # NEW: anonymous read page (legacy viewdailyupdate.asp)

tests/
├── UnitTests/          # NEW: NotificationValidationTests (SMS + email validation, audit-field completeness),
│                       #      OfficeEmailTemplateTests (golden-file vs contactsendpre.asp), QueriesValidationTests;
│                       #      APPEND: ProductionSecretsGuardTests (AC-010)
├── IntegrationTests/   # NEW: SmsQueueDrainTests (incl. AC-004 failure-injection retry), EmailQueueDrainTests,
│                       #      QueriesPersistenceTests, HolidayCrudParityTests (vs HolidayService),
│                       #      ContentUpdateCrudTests (incl. validation), ReportParameterizedSqlTests,
│                       #      MigrationReversibilityTests; APPEND: AuditTableTests (BR-001)
└── FunctionalTests/    # NEW: NotificationsEndpointTests (RBAC 401/403, AC-003..005/009), QueriesEndpointTests
                        #      (AC-001/002 201/400/429 + RateLimiting:Queries default), HolidayCrudEndpointTests
                        #      (AC-007 + BR-006 weekday numbering), ContentCmsTests (AC-006), ReportEndpointTests (AC-008)
```

**Structure Decision**: Selected the existing 7-project layout (`Core`/`Data`/`Identity`/`Api`/`Jobs`/`Migration`/`Web`). Interfaces stay in `VisaFusion.Core` (single-source business surface, BR-002); EF-backed implementations go in `VisaFusion.Data.Application` following the approved `IHolidayService`/`ISecurityGateService` deviation precedent (CoreServiceCollectionExtensions.cs L25-29, deviation log §1/§5); both composition roots (Web + Jobs) register them. No new projects (keeps the 7-project constraint of the existing deviation log).

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| *(none — all gates pass)* | | |
