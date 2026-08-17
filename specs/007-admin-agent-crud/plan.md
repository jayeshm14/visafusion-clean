# Implementation Plan: Agent/Admin Management, Security-Day Gate, Public Site, and Professional UI Theme

**Branch**: `007-admin-agent-crud` | **Date**: 2026-08-17 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `/specs/007-admin-agent-crud/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command; its definition describes the execution workflow.

## Summary

SPEC-0007 delivers Phase 3 items 8-9 of `library/ExecutionPlan.md`: (8) agent/admin management — CRUD plus the agent self-service portal — with enforced RBAC, the security-day open/close gate restricted to `adm`/`su`, and public site parity; (9) the professional UI theme replacing AdminLTE with a bespoke Bootstrap 5.3.7 theme, a design-token system, a WCAG-AA baseline, and UTF-8. The work extends the existing VisaFusion solution: minimal-API endpoints under `/api/v1` (VisaFusion.Api), business rules in VisaFusion.Core (single-source per constitution), EF Core persistence (VisaFusion.Data), and Razor Pages areas (VisaFusion.Web). The SPEC-0005 authorization policy catalog and claim contract are reused; one policy contradiction (`UserManagement`) is reconciled per DP-001.

## Technical Context

**Language/Version**: C# 12 / .NET 8.0 (verified: all 7 `.csproj` files declare `net8.0`)

**Primary Dependencies**: ASP.NET Core 8 (Razor Pages + minimal Web API under `/api/v1`), EF Core 8.0.20 (SqlServer), ASP.NET Core Identity 8.0.20, JWT Bearer 8.0.20, Serilog, OpenTelemetry, Bootstrap 5.3.7 (bespoke theme — AdminLTE is NOT used)

**Storage**: SQL Server (existing instance; target database `VisaFusion`; legacy `VisaEntry` preserved read-only)

**Testing**: xUnit — `tests/UnitTests`, `tests/IntegrationTests`, `tests/FunctionalTests` (current baselines: 138/138 unit, 135/135 functional, 52/52 integration)

**Target Platform**: Windows Server / IIS (ASP.NET Core)

**Project Type**: web application (Razor Pages + Web API)

**Performance Goals**: admin/agent pages < 2s server response; public pages < 1s (spec §13)

**Constraints**: WCAG-AA baseline, UTF-8 everywhere, self-hosted static assets (no CDN), no AdminLTE, design tokens as the single visual source, no anonymous write endpoints, claims-based identity (never query string)

**Scale/Scope**: 4,218 agent records, 1,461 security-day rows; ~20 new Razor pages + 17 API endpoints (spec §15, incl. deactivate/reactivate and `?q=` search filters)

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Gate | Status |
|---|---|
| G1 Specification-first | PASS — SPEC-0007 approved (24 sections; 5 clarifications resolved 2026-08-17) |
| G2 Legacy as source of truth | PASS — every capability mapped to legacy pages (spec §8) |
| G3 Data preservation | PASS — deactivate-over-delete (FR-004/FR-023); no data deletion |
| G4 Traceability | PASS — FR→TS matrix (spec §24); knowledge-graph update after each task |
| G5 Security by default | PASS — enforced RBAC, no anonymous writes, claims-based identity |
| G6 Fixed stack | PASS — ASP.NET Core, EF Core, SQL Server, Identity, Bootstrap 5.3.7 bespoke |
| G7 Single-source business rules | PASS — lifecycle/gate rules in VisaFusion.Core |
| G8 No-assumption rule | PASS with decision point — DP-001 documented below |

**Decision Point DP-001 — `UserManagement` policy contradiction**: the existing `AuthorizationPolicies.UserManagement` role set is `adm,su` (`src/VisaFusion.Api/Authorization/AuthorizationPolicies.cs` line 47), but the §4.2 matrix (`library/complete_migration_plan.md` line 150: "adm/emp only, **not** su-creation") and SPEC-0007 §15 (`POST /api/v1/admin/users` — `adm`,`emp`) require `adm,emp`. Resolution: correct the policy to `adm,emp`; `su` still passes via the inherited `adm` role claim (`IdentityClaims.EffectiveRoles`, lines 36-54). No deviation required — the matrix is the source of truth.

## Project Structure

### Documentation (this feature)

```text
specs/007-admin-agent-crud/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
src/
├── VisaFusion.Api/                  # minimal-API endpoints under /api/v1
│   ├── Authorization/               # existing policy catalog (reuse; DP-001 fix)
│   ├── Contracts/                   # request/response DTOs (existing pattern)
│   └── Endpoints/                   # AgentsEndpoint, AdminEndpoint, PublicEndpoint (extend)
├── VisaFusion.Core/                 # business rules (single source, G7)
│   └── Application/                 # AgentService, SecurityDayService, UserManagementService
├── VisaFusion.Data/                 # EF Core persistence
│   └── Persistence/Entities/        # Agent, SecurityDay (existing; deactivation mapping)
├── VisaFusion.Identity/             # Identity integration (existing; agt AgentId link)
└── VisaFusion.Web/                  # Razor Pages
    ├── Areas/Admin/Pages/           # agent CRUD, user management, security-day
    ├── Areas/Agent/Pages/           # self-service portal (entries, statuses, statement, account)
    ├── Areas/Public/Pages/          # public site parity
    ├── Pages/Shared/                # _Layout (sidebar + topbar shell), design tokens
    └── wwwroot/css/                 # tokens.css, theme.css (bespoke; AdminLTE removed)

tests/
├── UnitTests/                       # role-matrix, lifecycle, validation, own-agent scoping
├── IntegrationTests/                # agent CRUD, security-day, public forms, portal
└── FunctionalTests/                 # end-to-end admin/agent/public flows
```

**Structure Decision**: Extend the existing 7-project solution; no new projects. Endpoints follow the existing minimal-API pattern (`Endpoints/*.cs` + `AuthorizationPolicies`); pages follow the existing Razor Pages area pattern (`Areas/*/Pages`). Theme assets live in `VisaFusion.Web/wwwroot`. Tests follow the existing three-suite layout.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

No constitution violations — table intentionally empty. DP-001 is a code-vs-matrix contradiction resolved by correction, not a complexity justification.