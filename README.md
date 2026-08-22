# VisaFusion

Modernization of the legacy Classic ASP VisaEntry application to a
production-grade ASP.NET Core platform (VisaFusion), governed by a
deterministic, AI-native engineering environment.

**Constitution**: `.specify/memory/constitution.md` (v1.4.1) — the governing
rules for every engineering activity.

## Repository Layout

| Path | Purpose |
|------|---------|
| `findings/` | Live-verified legacy analysis (architecture, deep analysis, modernization plan) |
| `library/` | Engineering standards (SpecKit, DDD, ASP.NET Core, GitHub, testing, DevSecOps) |
| `specs/` | Feature specifications (`specs/NNN-<short-name>/`) produced by `/speckit.specify` |
| `adr/` | Architecture Decision Records |
| `knowledge-graph/` | Materialized knowledge graph (`kg.json` + `traceability-matrix.md`) |
| `scripts/` | PowerShell tooling (validation, SpecKit helpers) |
| `tests/` | Automated tests (Pester) |
| `reports/` | Version-controlled generated artifacts (e.g., validation reports) |
| `.github/workflows/` | CI/CD gates |

## AI Environment Validation

The repository includes a repeatable validation workflow (SPEC-0001, ADR-0002)
that confirms the 12 documented engineering integrations (GraphRAG, MCP, ADRs,
C4, DDD, Event Storming, Docs-as-Code, Backstage, OpenTelemetry, CodeQL,
Dependabot, NDepend) are consistent with the authoritative docs in `findings/`
and `library/`.

### Run on demand

```powershell
& ./scripts/ai-environment-validation/validate-ai-environment.ps1 `
  -SourceDirs @('findings', 'library') `
  -OutputDir 'reports/ai-environment-validation'
```

- Writes `reports/ai-environment-validation/report.md` (traceability matrix +
  Gap Report) and `summary.json` (machine-readable, schema v1).
- Exit code `0` when all 12 integrations are `validated`; non-zero otherwise
  (blocks the CI gate).

### Verify with tests

```powershell
Invoke-Pester ./tests/ai-environment-validation/validate-ai-environment.Tests.ps1
```

### CI gate

`.github/workflows/ai-environment-validation.yml` runs the validation on every
change to `findings/**` or `library/**` and blocks merge on failure.

See `specs/001-ai-environment-validation/quickstart.md` for the full guide.
- `library/03_SpecKit_SDD_Framework.md` — Specification-Driven Development
- `library/12_VisaFusion_Legacy_Modernization_Playbook.md` — migration methodology
- `library/complete_migration_plan.md` — overall migration plan

## VisaFusion Solution (SPEC-0003 Target Architecture)

The ASP.NET Core solution lives under `src/` (six projects) with tests under
`tests/`. See `specs/003-target-architecture/` for the full specification,
plan, contracts, and task list.

## UI Architecture (SPEC-0009 CoreUI)

The UI uses **CoreUI v5.6.0** as the design reference (ADR-0006, GAP-002
resolved). Key architecture:

- **Shell**: Dual-mode layout (`_Layout.cshtml`) — sidebar for authenticated
  users, top-nav for anonymous. Navigation centralized via `RoleAwareNavigation`
  service (8 groups, 24 menus, 9 submenus).
- **Components**: 14 reusable VisaFusion components (`src/VisaFusion.Web/Components/`)
  derived from CoreUI primitives — `_AuthCard`, `_DataTable`, `_FormCard`,
  `_InfoPage`, `_PublicLanding`, `_PublicQueryForm`, `_RoleDashboard`,
  `_ConfirmModal`, `_ErrorPage`, `_ToastHost`, `_RoleAwareNavigation`,
  `_DesignTokens`, `_ComponentStyles`, `_IconSet`.
- **Design tokens**: `--cui-*` CoreUI tokens via `vf-coreui.css`; custom
  `--vf-*` tokens for component-specific styling via `vf-component-styles.css`.
- **Icons**: CoreUI free icon set (`cil-*`/`cif-*`) via SVG symbol sprite.
- **Roles**: 5 roles (Guest, agt, emp, adm, su) with 11 authorization policies.
  Each role sees a different navigation group and page set.

See `docs/ui/` for the full mapping, matrices, and inventory.


## Documentation Index

- `library/01_System_Role_and_Principles.md` — mission, principles, Definition of Done
- `library/02_OpenCode_Operating_System.md` — fixed execution order
| Project | Purpose |
|---------|---------|
| `src/VisaFusion.Web` | Single host (FR-002): Razor Pages UI + `/api/v1` controllers; Serilog + OpenTelemetry (NFR-006) |
| `src/VisaFusion.Api` | `/api/v1` controllers (class library; no own `Program.cs`) |
| `src/VisaFusion.Core` | Domain + Application layers (business rules, shared by Web and Api) |
| `src/VisaFusion.Data` | EF Core DbContext, entity configurations, migrations |
| `src/VisaFusion.Identity` | ASP.NET Core Identity stores mapping to legacy `Udaan_users`/`agents`/`registration` |
| `src/VisaFusion.Jobs` | Background worker: SMS queue, email queue, scheduled reports |

### Secrets (NFR-004) — never commit secrets

Connection strings and SMS/SMTP credentials are configuration, not source code.
`appsettings.json` and `appsettings.Development.json` contain placeholders only.

For local development, store real values with **User Secrets**:

```powershell
cd src/VisaFusion.Web
dotnet user-secrets init
dotnet user-secrets set "ConnectionStrings:DefaultConnection" "Server=...;Database=VisaFusion;Trusted_Connection=True;TrustServerCertificate=True"
dotnet user-secrets set "Sms:ApiKey" "..."      # if applicable
dotnet user-secrets set "Smtp:Password" "..."   # if applicable
```

Machine-local `appsettings.*.local.json` files are git-ignored
(see `.gitignore`). In CI/cloud, use Key Vault or environment variables.

### Build and test

```powershell
dotnet build VisaFusion.sln
dotnet test VisaFusion.sln
```
