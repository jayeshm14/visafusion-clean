# Implementation Plan: Target Architecture

**Branch**: `003-target-architecture` | **Date**: 2026-08-06 | **Spec**: [SPEC-0003](../003-target-architecture/spec.md)

**Input**: Feature specification from `/specs/003-target-architecture/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command; its definition describes the execution workflow.

## Summary

Establish the VisaFusion solution skeleton exactly as defined in
`library/complete_migration_plan.md` §2 (Target Architecture, extending
`findings/modernization_plan.md` §10.1 with the API layer). Six physical projects
(`VisaFusion.Web`, `VisaFusion.Api`, `VisaFusion.Core`, `VisaFusion.Data`,
`VisaFusion.Identity`, `VisaFusion.Jobs`) hosted from a single ASP.NET Core process,
sharing one Core so business rules are enforced identically via Web UI and `/api/v1` JSON
API. No business module is implemented; the feature delivers the buildable, runnable,
deployable foundation every module feature builds on.

## Technical Context

**Language/Version**: C# on .NET 8 (LTS) — clarified 2026-08-06 (spec NFR-005; migration
plan §10.2 named ".NET 8 LTS (or 9)").

**Primary Dependencies**: ASP.NET Core 8 (Razor Pages + Web API in one process), EF Core 8
(SqlServer), ASP.NET Core Identity, Serilog (file + SQL sinks), OpenTelemetry
(tracing/metrics), xUnit for tests.

**Storage**: SQL Server `VisaEntry` (existing 52-table database, in-place; no schema
changes in this feature — remediation is the Data Remediation feature).

**Testing**: xUnit (UnitTests, IntegrationTests, FunctionalTests per `library/08` §2);
validation scenarios in quickstart.md (TS-001..TS-005 from spec §23).

**Target Platform**: Windows Server / IIS (in-process) per migration plan §10.1; runs
locally on IIS Express / Kestrel with only SQL Server required (NFR-001).

**Project Type**: Web application (Razor Pages back-office + JSON Web API), monolith
process, clean-architecture layering.

**Performance Goals**: Support high-volume history tables (`StatusHistory` 1.3M,
`bighistory` 1.4M rows) via the indexes defined in the Data Remediation feature; background
queues (SMS/email) must not block request handling (spec §13).

**Constraints**: Parameterized queries only (no string-concatenated SQL); secrets in
configuration (appsettings + User Secrets/Key Vault), never in source; no plaintext
passwords; backdoor query parameters inert (spec §12).

**Scale/Scope**: Solution scaffolding only — 6 projects, 8 Razor Pages Areas, `/api/v1`
health + one representative endpoint per area. No business module implementation.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

**Pre-Phase-0 evaluation (PASS):**

| Constitution principle | Status | Evidence |
|------------------------|--------|----------|
| I. Specification-First (SDD) | PASS | SPEC-0003 approved via `/speckit.specify`; 24 sections complete |
| II. Legacy as Source of Truth | PASS | Architecture maps to `modernization_plan.md` §6 module map and §10.1; no behavior invented (§8 Legacy Mapping) |
| III. Data Preservation & Integrity | PASS | No schema changes; no business table dropped (BR-003; §16) |
| IV. Traceability & Governance | PASS | FR→§→AC traceability matrix in spec §24; ADR-0001 cited; KG update required after tasks |
| V. Quality, Delivery & No-Assumption Rule | PASS | AC-001..AC-007 testable; NFR-001/AC-007 keep repo buildable/deployable; clarifications resolved in spec |
| Security by default | PASS | §12: no plaintext, no query-string identity, no anonymous writes, backdoor inert, secrets in config |
| Fixed execution order | PASS | Intake → Spec → Clarify → Plan → (Tasks/Implement/Test/Validate/Release) |

**Post-Phase-1 evaluation: see re-check below.**

## Project Structure

### Documentation (this feature)

```text
specs/003-target-architecture/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
├── checklists/          # Spec quality checklist (16/16 passing)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
VisaFusion.sln
src/
├── VisaFusion.Web/          # SINGLE HOST process (Razor Pages UI + Web API controllers)
│   │                        #   Areas: Public, Auth, Employee, Agent, Admin, Billing,
│   │                        #   Reporting, Notifications; cookie auth for UI + JWT for /api/v1
│   ├── Areas/               #   Eight Razor Pages Areas
│   └── Program.cs           #   Single Program.cs: Razor Pages + Api controllers + auth
├── VisaFusion.Api/          # Class Library: /api/v1 controllers/endpoints (hosted by Web)
├── VisaFusion.Core/         # Domain services (EntryService, StatusService, BillingService,
│   │                        #   SmsService, EmailService, SecurityGateService, HolidayService)
│   ├── Domain/              #   [library/08 layer] Entities, Value Objects, Domain Events
│   └── Application/         #   [library/08 layer] Use Cases, Commands, Queries, Validation, DTOs
├── VisaFusion.Data/         # EF Core DbContext, entities, migrations
│   ├── Persistence/         #   [library/08 layer] DbContext, entity configurations
│   └── Infrastructure/      #   [library/08 layer] repository implementations, infrastructure
├── VisaFusion.Identity/     # ASP.NET Core Identity stores mapping to Udaan_users/agents/registration
└── VisaFusion.Jobs/         # SEPARATE Worker process: BackgroundService SMS queue, email queue,
                            #   scheduled reports (own Program.cs)
tests/
├── UnitTests/
├── IntegrationTests/
└── FunctionalTests/
```

**Structure Decision**: Six physical projects named per migration plan §2 (Web, Api, Core,
Data, Identity, Jobs) with the `VisaFusion` solution prefix per ADR-0001/constitution.
`library/08` §2 layers (Domain, Application, Infrastructure, Persistence) are realized as
folders/namespaces inside Core and Data (clarification Q1, 2026-08-06). Test projects per
`library/08` §2 (UnitTests, IntegrationTests, FunctionalTests). All projects target
.NET 8 LTS.

**Hosting Decision (resolved during analysis)**: FR-002 (single process) is realized by
making `VisaFusion.Web` the single host — its `Program.cs` configures both Razor Pages and
the `/api/v1` Web API controllers (from `VisaFusion.Api`, a class library) plus both cookie
and JWT bearer authentication. `VisaFusion.Api` has no `Program.cs`. `VisaFusion.Jobs` is a
separate Worker process with its own `Program.cs` (background queues must not block request
handling, spec §13).

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

No constitution violations detected; no complexity justification required. The six-project
structure is mandated by migration plan §2 and the clarification, not a discretionary
choice.

---

## Phase 0: Research — see `research.md`

## Phase 1: Design & Contracts — see `data-model.md`, `contracts/`, `quickstart.md`

## Constitution Check — Post-Phase-1 re-check (PASS)

| Constitution principle | Status | Evidence |
|------------------------|--------|----------|
| I. Specification-First (SDD) | PASS | Spec unchanged; plan artifacts derive from spec only |
| II. Legacy as Source of Truth | PASS | Data model maps to legacy 52-table schema (§8); no new entities invented |
| III. Data Preservation & Integrity | PASS | data-model.md: no schema changes, no business table drops |
| IV. Traceability & Governance | PASS | Contracts/quickstart map to FR/AC; KG update queued for implementation |
| V. Quality, Delivery & No-Assumption Rule | PASS | quickstart TS-001..TS-005 prove AC-001..AC-007; all clarifications resolved |
| Security by default | PASS | Contracts specify bearer/cookie auth schemes; no secrets in artifacts |
| Fixed execution order | PASS | Next: `/speckit.tasks` → implement → test → validate → release |
