# Feature Specification: Target Architecture

**Identifier**: SPEC-0003
**Title**: Target Architecture
**Status**: Draft
**Created**: 2026-08-06
**Category**: epics (cross-cutting solution architecture; "epics" is the closest allowed category)
**Input**: User description: "refer complete_mugration_plan.md and implement project architecture as per 2. Target Architecture (extends §10.1 with the API layer)"

> This template is the VisaFusion override of the SpecKit `spec-template`.
> It is resolved first by the Spec Kit template stack (`.specify/templates/overrides/`)
> and MUST contain the 24 required sections defined in `library/03_SpecKit_SDD_Framework.md` §4.
> Do not remove or reorder the 24 numbered sections below.

## 1. Identifier

- **SPEC-0003**: Target Architecture

## 2. Title

Target Architecture — VisaFusion solution skeleton (Web + API + Core + Data + Identity + Jobs)

## 3. Objective

Establish the target project architecture for the VisaFusion modernization exactly as
defined in `library/complete_migration_plan.md` §2 (Target Architecture, which extends
`findings/modernization_plan.md` §10.1 with the API layer). This feature scaffolds the
solution structure and cross-cutting concerns so that every subsequent module feature
(entry, status, billing, notifications, reporting, identity) builds on a consistent,
already-decided foundation. It does not implement any business module.

## 4. Business Context

The legacy Classic ASP application is browser-only, IIS-hosted, with business validation
inlined per page and applied inconsistently. The target architecture keeps the browser
back-office experience (Razor Pages) while adding a JSON API surface for the agent portal
and future clients. Both entry points share one domain-services core so business rules
(Canada DOB, holiday/weeklyoff/Sunday block, day-open gate) are enforced identically
regardless of how a request arrives. This is not a new feature — it is the same module
surface from `modernization_plan.md` §3–§6 exposed a second way, per the explicit request
for APIs.

## 5. Scope

- Create the `VisaFusion` solution with the six projects named in
  `complete_migration_plan.md` §2: Web (Razor Pages), Api (Web API, versioned `/api/v1`),
  Core (domain services), Data (EF Core DbContext/entities/migrations), Identity (Identity
  stores), Jobs (BackgroundService for SMS/email queues and scheduled reports).
- Host Web and Api from a single ASP.NET Core process sharing `VisaFusion.Core`.
- Define the Areas mirroring the legacy module map: Public, Auth, Employee, Agent, Admin,
  Billing, Reporting, Notifications.
- Wire EF Core against the existing SQL Server `VisaEntry` database (in-place, cleansed,
  FKs + indexes added later per the Data Remediation feature).
- Project layout: the six §2 names ARE the physical projects. The `library/08` §2 layers
  (Domain, Application, Infrastructure, Persistence) are realized as folders/namespaces
  inside Core (Domain, Application) and Data (Persistence, Infrastructure), per the
  clarification recorded below.

## 6. Out of Scope

- Any business module implementation (entry creation, status update, billing, etc.) —
  these are separate feature specs.
- Data cleansing / remediation (the `statusID=508` duplicate, junk dates, `grandtotal`
  overflow, orphaned `Mainentry` rows, dead-table drops) — separate Data Remediation
  feature.
- Identity store implementation details (mapping `Udaan_users`/`agents`/`registration`) —
  covered by the Identity Consolidation feature; this spec only establishes the Identity
  project and its integration point.
- API endpoint contracts for each module — defined per-module in later specs; this spec
  establishes the `/api/v1` versioning and controller/area scaffolding only.
- UI page design and styling.

## 7. Stakeholders

- Back-office users (Employee, Admin, Agent) who use the browser UI.
- External/integration clients (agent portal, future mobile) who consume the JSON API.
- Development team who build module features on this foundation.
- Database administrator / data engineer responsible for the `VisaEntry` database.

## 8. Legacy Mapping

Mapped to the legacy module map in `@findings/modernization_plan.md` §6 and the target
architecture in `library/complete_migration_plan.md` §2:

| Target project | Legacy module / pages | Knowledge Graph node |
|----------------|------------------------|----------------------|
| Web (Razor Pages) | All back-office pages (browser UI) | MOD-001..MOD-006 |
| Api (`/api/v1`) | Same module surface, exposed as JSON | MOD-001..MOD-006 |
| Core | Domain services (EntryService, StatusService, BillingService, SmsService, EmailService, SecurityGateService, HolidayService) | MOD-001..MOD-006 |
| Data | EF Core DbContext over the 52-table `VisaEntry` schema | TBL-* |
| Identity | `Udaan_users`, `agents`, `registration` (see §7 of migration plan) | MOD-006 |
| Jobs | SMS/email queues, scheduled reports | MOD-004, MOD-005 |

No new business behavior is introduced; the architecture only reorganizes the existing
module surface.

## 9. Functional Requirements

- **FR-001**: The solution MUST contain the six projects defined in
  `complete_migration_plan.md` §2 (Web, Api, Core, Data, Identity, Jobs).
- **FR-002**: The Web and Api projects MUST be hosted from a single ASP.NET Core process.
  (Resolution: `VisaFusion.Web` is the single host; `VisaFusion.Api` is a class library of
  `/api/v1` controllers/endpoints hosted by Web — no own `Program.cs`. `VisaFusion.Jobs`
  runs as a separate Worker process so background queues do not block request handling,
  per §13.)
- **FR-003**: The Web and Api projects MUST share the Core project so business rules are
  enforced identically regardless of entry point.
- **FR-004**: The Api project MUST expose a versioned JSON surface under `/api/v1`
  containing a health/version endpoint plus one representative endpoint per area, proving
  routing, versioning, auth, and shared-Core wiring end-to-end (clarified 2026-08-06).
- **FR-005**: The Web project MUST define Razor Pages Areas mirroring the legacy module
  map (Public, Auth, Employee, Agent, Admin, Billing, Reporting, Notifications).
- **FR-006**: The Data project MUST provide an EF Core DbContext over the existing
  `VisaEntry` database with parameterized queries only (no string-concatenated SQL).
- **FR-007**: The Identity project MUST integrate ASP.NET Core Identity with the legacy
  identity sources (Udaan_users, agents, registration) per the migration plan §7.
- **FR-008**: The Jobs project MUST host BackgroundService(s) for the SMS queue, email
  queue, and scheduled/daily reports.
- **FR-009**: The solution MUST be buildable and deployable after every task.
- **FR-010**: The Api MUST authenticate requests with bearer tokens (JWT); the Web UI MUST
  use cookie-based authentication (clarified 2026-08-06).

## 10. Business Rules

- **BR-001**: Business rules are enforced in Core and are identical for Web and Api entry
  points (fixes the legacy inline-per-page inconsistency).
- **BR-002**: The API is not a new feature; it exposes the same module surface as the Web
  UI.
- **BR-003**: No business table is dropped; only `dtproperties` may be removed (per
  constitution Principle III).

## 11. Non-functional Requirements

- **NFR-001**: The solution MUST build with a single command and run locally with no
  external services beyond SQL Server.
- **NFR-002**: The architecture MUST support the full 52-table schema and the high-volume
  history tables (`StatusHistory` 1.3M, `bighistory` 1.4M rows).
- **NFR-003**: All data access MUST be parameterized; no string-concatenated SQL.
- **NFR-004**: Secrets MUST NOT be stored in source; they live in configuration
  (appsettings + User Secrets / Key Vault).
- **NFR-005**: The solution MUST target .NET 8 (LTS) (clarified 2026-08-06).
- **NFR-006**: The solution MUST provide structured logging (Serilog) to file and SQL, plus
  OpenTelemetry tracing and metrics (clarified 2026-08-06).
- **NFR-007**: When the `VisaEntry` database is unreachable at startup or during a request,
  the solution MUST fail fast with a clear, logged error (no silent fallback, no
  swallowed exceptions); Web UI and Api return a standardized 500 response (added
  2026-08-07, checklist CHK033).
- **NFR-008**: Scalability limits (horizontal/vertical) are explicitly deferred: this
  feature establishes a single-process monolith host; scaling strategy is decided in a
  later feature once module load characteristics are known (added 2026-08-07, checklist
  CHK040).

## 12. Security

- No plaintext passwords; passwords are hashed on migration (never re-stored plaintext).
- No query-string identity; agent identity is derived from the authenticated principal,
  never from a URL parameter.
- No anonymous write endpoints.
- The legacy `connection.asp` backdoor and its query parameters MUST have no effect in the
  new solution.
- Secrets (connection string, SMS/SMTP creds) move out of source into configuration.
- Authentication schemes per entry point (clarified 2026-08-06): the Api uses bearer tokens
  (JWT); the Web UI uses cookie authentication. Both authenticate against the same
  ASP.NET Core Identity store and enforce the same role/policy matrix (§4 of the migration
  plan).

## 13. Performance

- The architecture MUST support the high-volume history tables with the indexes defined in
  the Data Remediation feature (`StatusHistory(PaxID, Date)`, `bighistory(refno)`,
  `sentmails(agentsid, date)`, etc.).
- Background queues (SMS/email) MUST not block request handling.

## 14. UI Requirements

- Razor Pages Areas mirror the legacy module map (Public, Auth, Employee, Agent, Admin,
  Billing, Reporting, Notifications).
- Static assets (forms/, updateimg/, images/, css/, js/, fonts/) are self-hosted (no CDN)
  per the migration plan §8.2.

## 15. API Contracts

- Base path `/api/v1` with versioning established in this feature.
- Scaffolding surface (clarified 2026-08-06): a health/version endpoint plus one
  representative endpoint per area (e.g., a read-only list per area) to prove routing,
  versioning, bearer-token auth, and shared-Core wiring end-to-end.
- Per-module endpoints are defined in the module specs; this feature only establishes the
  versioned routing and controller/area scaffolding.

## 16. Database Changes

- No schema changes in this feature (architecture scaffolding only).
- The Data project references the existing `VisaEntry` database; schema remediation
  (cleansing, FKs, indexes, dead-table drops) is the Data Remediation feature.

## 17. Validation Rules

- All query input is validated and parameterized; no raw string SQL.
- Business validation lives in Core and is shared by Web and Api.

## 18. Error Handling

- Standardized error handling for both Web and Api entry points.
- No swallowed exceptions (`on error resume next` behavior is not carried forward).
- Recovery/rollback: startup and migration failures MUST fail fast with a clear, logged
  error and a non-zero exit; no partial-start state is left running. This feature performs
  no schema changes, so no data rollback is required here — rollback/recovery for schema
  changes is owned by the Data Remediation feature (added 2026-08-07, checklist CHK029).

## 19. Audit Requirements

- The architecture MUST support append-only audit/history tables (`StatusHistory`,
  `bighistory`, `sentmails`, `smshistory`) as read/write entities.
- Traceability: every module feature maps to the Knowledge Graph and traceability matrix.

## 20. Acceptance Criteria

- **AC-001**: The `VisaFusion` solution builds with all §2 projects present.
- **AC-002**: The single process serves both the Web UI and the `/api/v1` surface,
  including a health/version endpoint and one representative endpoint per area.
- **AC-003**: A representative business rule (e.g., Canada DOB requirement) is enforced
  identically when invoked via Web and via Api.
- **AC-004**: No plaintext password or hardcoded credential exists in the solution.
- **AC-005**: No string-concatenated SQL exists in the solution.
- **AC-006**: The `connection.asp` backdoor query parameters have no effect.
- **AC-007**: The solution builds and runs with no configuration beyond SQL Server.

## 21. Risks

- **R1**: Scope creep into module implementation — mitigated by strict Out of Scope.
- **R2**: High-volume history tables degrade performance — mitigated by indexes defined in
  the Data Remediation feature and parameterized queries.
- **R3**: Identity mapping ambiguity (Risk #2 in migration plan §12) — carried forward,
  not resolved here; requires owner sign-off before the Identity feature.
- **R4**: Data-quality defects (orphans, junk dates, `grandtotal` overflow) block FK
  enforcement — handled by the Data Remediation feature, not this one.

## 22. Dependencies

- `library/complete_migration_plan.md` §2 (Target Architecture) and §10.1 (original).
- `@findings/modernization_plan.md` §3 (application architecture), §6 (module map).
- `ADR-0001` (Target Architecture and Specs Layout).
- `library/08` (ASP.NET Core enterprise standards), `library/07` (Clean Architecture/DDD).
- Data Remediation feature (SPEC-0004, pending) for schema cleansing and FK/index work.

## 23. Test Scenarios

- **TS-001**: Solution builds cleanly (all projects).
- **TS-002**: App boots; Web UI and `/api/v1` both respond.
- **TS-003**: A shared business rule returns the same result via Web and Api.
- **TS-004**: Security scan finds no plaintext credentials and no string-concatenated SQL.
- **TS-005**: Backdoor query parameters are inert.

## 24. Traceability Matrix

| Requirement | Architecture | Domain | Database | API | UI | Test | Migration |
|-------------|--------------|--------|----------|-----|----|------|-----------|
| FR-001      | ADR-0001, §2 | Core    |          |     |    | TS-001 | —         |
| FR-002      | §2           | —       | —        | —   | Web | TS-002 | —         |
| FR-003      | §2           | Core    | —        | Api | Web | TS-003 | —         |
| FR-004      | §2           | —       | —        | /api/v1 | — | TS-002 | —         |
| FR-005      | §2           | —       | —        | —   | Areas | TS-002 | —         |
| FR-006      | §2           | Data    | VisaEntry | —  | —   | TS-004 | —         |
| FR-007      | §2, §7       | Identity| Udaan_users, agents, registration | — | — | TS-002 | §7        |
| FR-008      | §2           | Jobs    | —        | —   | —   | TS-002 | —         |
| FR-009      | —            | —       | —        | —   | —   | TS-001 | —         |
| FR-010      | §2, §12      | Identity| —        | Api | Web | TS-002 | §7        |
| NFR-007     | §18          | —       | VisaEntry | Api | Web | TS-002 | —         |
| NFR-008     | §13          | —       | —        | —   | —   | —      | —         |

## Assumptions

- The solution name is **VisaFusion** (per constitution and ADR-0001).
- The six §2 project names (Web, Api, Core, Data, Identity, Jobs) are the physical
  projects; `library/08` layers (Domain, Application, Infrastructure, Persistence) are
  folders/namespaces inside Core and Data (clarified 2026-08-06).
- The solution targets .NET 8 (LTS) (clarified 2026-08-06).
- The Api authenticates with bearer tokens (JWT); the Web UI uses cookies (clarified
  2026-08-06).
- Observability is Serilog (file + SQL) plus OpenTelemetry tracing/metrics (clarified
  2026-08-06).
- The `/api/v1` scaffolding surface is a health/version endpoint plus one representative
  endpoint per area (clarified 2026-08-06).
- The existing `VisaEntry` SQL Server database is the single source of truth; no schema
  changes in this feature.
- Business rules are centralized in Core; this is the intended fix for legacy
  inline-per-page validation inconsistency.
- The API surface is not a new feature; it mirrors the existing module surface.
- Single-process hosting (FR-002) is realized with `VisaFusion.Web` as the one host
  (Razor Pages + `/api/v1` controllers); `VisaFusion.Api` is a class library; `VisaFusion.Jobs`
  is a separate Worker process (resolved during `/speckit.analyze`, 2026-08-07).

## Clarifications

### Session 2026-08-06

- Q: Should this feature include the Data Remediation schema work (cleansing, FK, indexes,
  dead-table drops)? → A: No. The user described the data remediation work in a separate
  `/speckit.specify` request ("Feature 1: Foundation & Data Remediation"). This feature is
  architecture scaffolding only; the Data Remediation feature (SPEC-0004, pending) owns
  the cleansing sequence and dead-table drops. The migration plan §2 diagram lists
  "cleansed, FKs + indexes added" as the target state of the database that this
  architecture connects to, not as work performed here.
- Q: How should the project layout reconcile the migration plan §2 project names (Web, Api,
  Core, Data, Identity, Jobs) with the `library/08` §2 structure (Domain, Application,
  Infrastructure, Persistence, Identity, Api, Web, Shared)? → A: Option A — the six §2
  names are the physical projects; `library/08` layers (Domain, Application,
  Infrastructure, Persistence) are folders/namespaces inside Core and Data.
- Q: Which .NET target framework should the solution use (migration plan §10.2 leaves it
  open: ".NET 8 LTS (or 9)")? → A: Option A — .NET 8 (LTS), per the plan's stated
  preference and longest support window.
- Q: How should the Api (`/api/v1`) authenticate requests? → A: Option A — bearer tokens
  (JWT) for the Api; cookie-based authentication for the Web UI; both against the same
  Identity store and role/policy matrix.
- Q: What observability should this feature establish (logging, metrics, tracing)? → A:
  Option A — Serilog structured logging (file + SQL) plus OpenTelemetry tracing/metrics,
  per migration plan §10.2 and `library/11`.
- Q: What should the `/api/v1` surface contain in this scaffolding feature? → A: Option A —
  a health/version endpoint plus one representative endpoint per area, proving routing,
  versioning, bearer-token auth, and shared-Core wiring end-to-end.