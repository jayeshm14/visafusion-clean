# Contract: Solution Structure — VisaFusion (SPEC-0003)

**Date**: 2026-08-06 | **Spec**: [SPEC-0003](../spec.md)

## Solution

- Name: `VisaFusion.sln`
- Target framework: .NET 8 (LTS) for all projects (NFR-005)
- Layout: `src/` + `tests/` per ADR-0001 / `library/08` §2

## Projects (migration plan §2, clarification Q1)

| Project | Purpose | Key namespaces (folders) | References |
|---------|---------|--------------------------|------------|
| `VisaFusion.Web` | Razor Pages UI, Areas: Public, Auth, Employee, Agent, Admin, Billing, Reporting, Notifications; cookie auth | `Areas/*`, `Pages` | Core, Data, Identity |
| `VisaFusion.Api` | Web API JSON, `/api/v1`; bearer (JWT) auth | `Controllers`/minimal-API endpoints per area | Core, Data, Identity |
| `VisaFusion.Core` | Domain services: EntryService, StatusService, BillingService, SmsService, EmailService, SecurityGateService, HolidayService | `Domain/`, `Application/` (library/08 layers) | (none — pure domain) |
| `VisaFusion.Data` | EF Core DbContext, entity configurations, migrations | `Persistence/`, `Infrastructure/` (library/08 layers) | Core |
| `VisaFusion.Identity` | ASP.NET Core Identity stores mapping to Udaan_users/agents/registration | Stores, claims | Core, Data |
| `VisaFusion.Jobs` | BackgroundService: SMS queue, email queue, scheduled reports | Workers | Core, Data |

Optional `VisaFusion.Shared` for cross-cutting shared code if needed.

## Test projects (`library/08` §2)

| Project | Scope |
|---------|-------|
| `tests/UnitTests` | Domain/Core unit tests |
| `tests/IntegrationTests` | DbContext, Identity store, service integration |
| `tests/FunctionalTests` | Web + Api end-to-end (hosted single process) |

## Hosting contract

- Web and Api are hosted from **one** ASP.NET Core process (FR-002).
- All requests share `VisaFusion.Core` business-rule enforcement (FR-003).
- Static assets self-hosted, no CDN (migration plan §8.2): `forms/`, `updateimg/`,
  `images/`, `css/`, `js/`, `fonts/`.

## Cross-cutting contracts

- **Logging/metrics/tracing**: Serilog (file + SQL) + OpenTelemetry (NFR-006).
- **Secrets**: appsettings + User Secrets/Key Vault; never in source (NFR-004, §12).
- **SQL**: parameterized only; no string concatenation (NFR-003).

## Traceability

- FR-001 → projects table
- FR-002/FR-003 → hosting contract
- FR-005 → Web Areas
- FR-008 → Jobs project
- AC-001 → verified by quickstart TS-001
