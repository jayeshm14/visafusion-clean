# Research: Target Architecture (SPEC-0003)

**Date**: 2026-08-06 | **Spec**: [SPEC-0003](../003-target-architecture/spec.md)
**Sources**: `library/complete_migration_plan.md` §2/§10.1/§10.2, `findings/modernization_plan.md`
§3/§6/§10.1-10.4, `adr/ADR-0001.md`, `library/07` (Clean Architecture/DDD), `library/08`
(ASP.NET Core enterprise standards), `library/11` (Testing/Observability), constitution
`.specify/memory/constitution.md` v1.2.0.

All `NEEDS CLARIFICATION` items from the plan's Technical Context were resolved in the
spec's Clarifications section (session 2026-08-06, 5 answers). No unresolved unknowns
remain. This document records the decisions and their rationale.

---

## 1. Solution and Project Layout

- **Decision**: Solution `VisaFusion.sln`; six physical projects named per migration plan
  §2 — `VisaFusion.Web`, `VisaFusion.Api`, `VisaFusion.Core`, `VisaFusion.Data`,
  `VisaFusion.Identity`, `VisaFusion.Jobs` — plus `VisaFusion.Shared` if cross-cutting
  shared code is needed. Test projects: `tests/UnitTests`, `tests/IntegrationTests`,
  `tests/FunctionalTests`.
- **Rationale**: Migration plan §2 defines the six projects explicitly; ADR-0001 and the
  constitution mandate the solution name `VisaFusion` and the `src/`+`tests/` layout from
  `library/08` §2. The `library/08` layers (Domain, Application, Infrastructure,
  Persistence) become namespaces inside Core and Data (clarification Q1).
- **Alternatives considered**:
  - Full `library/08` physical layout (Domain/Application/Infrastructure/Persistence as
    separate projects) — rejected: deviates from the migration plan §2 diagram the user
    explicitly referenced.
  - Hybrid (separate Application project) — rejected: adds project count without
    architectural benefit at scaffolding stage.

## 2. Target Framework

- **Decision**: .NET 8 (LTS).
- **Rationale**: Migration plan §10.2 names ".NET 8 LTS (or 9)"; LTS gives the longest
  maintenance window for a production data-bearing migration; all planned libraries
  (EF Core 8, ASP.NET Core Identity 8, Serilog, OpenTelemetry) have stable .NET 8
  support (clarification Q2).
- **Alternatives considered**: .NET 9 (STS) — rejected for shorter support window; .NET 10
  (LTS) — not yet proven in the plan's library set.

## 3. Single-Process Hosting

- **Decision**: One ASP.NET Core process hosts both `VisaFusion.Web` and `VisaFusion.Api`.
- **Rationale**: Migration plan §2 states "both hosted from one ASP.NET Core process,
  sharing: VisaFusion.Core". A single process guarantees identical business-rule
  enforcement (spec FR-002/FR-003) and simplifies deployment.
- **Alternatives considered**: Separate processes — rejected: would allow rule divergence
  and complicate deployment; the plan explicitly requires one process.

## 4. Authentication Scheme per Entry Point

- **Decision**: Api uses bearer tokens (JWT); Web UI uses cookie authentication; both
  against the same ASP.NET Core Identity store and role/policy matrix (clarification Q3;
  spec FR-010, §12).
- **Rationale**: Standard pattern for a JSON API consumed by non-browser clients (agent
  portal, future mobile); keeps entry-point auth concerns cleanly separated while sharing
  one Identity store and one authorization policy set (migration plan §4 matrix).
- **Alternatives considered**: Shared cookie session — rejected (browser-only coupling);
  bearer-only — rejected (Razor Pages cookie flow is the ASP.NET Core default for
  browser apps).

## 5. Observability

- **Decision**: Serilog structured logging (file + SQL sinks) plus OpenTelemetry tracing
  and metrics (clarification Q4; spec NFR-006).
- **Rationale**: Migration plan §10.2 names Serilog to file + SQL; `library/11` mandates
  structured logging, metrics, and tracing. High-volume history-table operations need
  distributed tracing for performance diagnosis.
- **Alternatives considered**: Built-in ILogger only — rejected (no structured sinks, no
  metrics/tracing); Serilog only — rejected (misses tracing/metrics).

## 6. `/api/v1` Scaffolding Surface

- **Decision**: Health/version endpoint plus one representative read-only endpoint per
  area (clarification Q5; spec FR-004, §15).
- **Rationale**: Proves routing, versioning, bearer-token auth, and shared-Core wiring
  end-to-end without implementing business logic (avoids scope creep into module
  features).
- **Alternatives considered**: Health endpoint only — rejected (does not prove the
  routing/auth/Core chain per area); full API surface — rejected (contradicts §6 Out of
  Scope).

## 7. Razor Pages Areas

- **Decision**: Areas Public, Auth, Employee, Agent, Admin, Billing, Reporting,
  Notifications (spec FR-005, §14).
- **Rationale**: Mirrors the legacy module map (`modernization_plan.md` §6) and migration
  plan §2/§10.3 area list verbatim; no area is invented.
- **Alternatives considered**: Single-area Razor Pages — rejected (would not map to the
  legacy module boundaries and would force rework per module).

## 8. Database Approach

- **Decision**: EF Core 8 (SqlServer) against the existing `VisaEntry` database;
  parameterized queries only; no schema changes in this feature (spec FR-006, §16,
  NFR-003).
- **Rationale**: The live 52-table schema is the source of truth (schema drift confirmed
  in `deepanalysis.md` §4.7 — do not use `database.sql` demo script). Migration plan §10.2
  specifies `Scaffold-DbContext` to bootstrap the model from the live DB.
- **Alternatives considered**: Dapper — rejected (plan names EF Core); `database.sql` as
  baseline — rejected (confirmed drift).

## 9. Jobs

- **Decision**: `VisaFusion.Jobs` hosts BackgroundService(s) for the SMS queue, email
  queue, and scheduled/daily reports (spec FR-008).
- **Rationale**: Migration plan §2/§10.2 define the Jobs project and BackgroundService
  pattern; queues must not block request handling (spec §13).
- **Alternatives considered**: Hangfire — deferred; BackgroundService + Channels suffices
  for the scaffolding; Hangfire reserved for complex job orchestration if reports demand
  it (plan §10.2 note).

## 10. Gate Evaluation

- **Constitution Check (pre-research)**: PASS — all seven principles satisfied (see
  plan.md).
- **Constitution Check (post-design)**: PASS — data model, contracts, and quickstart
  derive from the spec and legacy schema only; no invented behavior, no schema changes,
  no secrets in artifacts.

## Unresolved / Deferred

- Performance latency/throughput targets: deferred to module features (spec performance
  section already covers volume support).
- SMS/SMTP gateway failure modes: deferred to the Notifications module spec.
- Identity store mapping details (Risk #2): deferred to Identity Consolidation feature;
  requires owner sign-off.
