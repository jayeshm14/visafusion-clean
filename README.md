# VisaFusion

Modernization of the legacy Classic ASP VisaEntry application to a
production-grade ASP.NET Core platform (VisaFusion), governed by a
deterministic, AI-native engineering environment.

**Constitution**: `.specify/memory/constitution.md` (v1.2.0) — the governing
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

## Documentation Index

- `library/01_System_Role_and_Principles.md` — mission, principles, Definition of Done
- `library/02_OpenCode_Operating_System.md` — fixed execution order
- `library/03_SpecKit_SDD_Framework.md` — Specification-Driven Development
- `library/12_VisaFusion_Legacy_Modernization_Playbook.md` — migration methodology
- `library/complete_migration_plan.md` — overall migration plan
