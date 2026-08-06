# Implementation Plan: AI Environment Validation

**Branch**: `001-ai-environment-validation` | **Date**: 2026-08-06 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `/specs/001-ai-environment-validation/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command; its definition describes the execution workflow.

## Summary

Establish a repeatable validation workflow (SPEC-0001) that confirms the 12
documented engineering integrations (GraphRAG, MCP, ADRs, C4, DDD, Event
Storming, Docs-as-Code, Backstage, OpenTelemetry, CodeQL, Dependabot, NDepend)
are consistent with the authoritative docs in `findings/` and `library/`. The
validation runs both as an automated CI gate (triggered on changes to
`findings/`/`library/`) and on demand, producing a version-controlled Markdown
report plus a machine-readable JSON summary. This keeps OpenCode operating as a
complete AI-native engineering environment rather than just a coding prompt.

## Technical Context

**Language/Version**: PowerShell 5.1 (repo convention; `.specify/scripts/powershell/*.ps1`), compatible with PowerShell 7 (`pwsh`) for GitHub Actions.

**Primary Dependencies**: PowerShell built-in cmdlets only (`Get-ChildItem`, `Select-String`, `ConvertTo-Json`, `ConvertFrom-Json`); GitHub Actions `actions/checkout@v4`; Pester 5 for tests.

**Storage**: Filesystem — Markdown report + JSON summary under `reports/ai-environment-validation/` (version-controlled).

**Testing**: Pester 5 (PowerShell unit tests for the validation script); GitHub Actions workflow as the CI gate.

**Target Platform**: Windows PowerShell 5.1 (local) and GitHub Actions `ubuntu-latest` with `pwsh`.

**Project Type**: Validation tooling (script + CI workflow) — not an application.

**Performance Goals**: Validation completes well within the 30-minute NFR-002 budget (expected < 1 minute for 12 integrations across ~20 docs).

**Constraints**: Read-only over documentation; reproducible (deterministic); no secrets; no production data access; no business behavior change.

**Scale/Scope**: 12 integrations; 17 `library/` docs + 3 `findings/` reports; 1 report directory.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **GATE A — Specification-First (Principle I)**: SPEC-0001 exists, follows the 24-section template, and is approved. → **PASS**
- **GATE B — Legacy as Source of Truth (Principle II)**: No legacy business behavior is modified; this is a governance/validation feature with no legacy page mapping. → **PASS**
- **GATE C — Data Preservation (Principle III)**: No database changes. → **PASS**
- **GATE D — Traceability & Governance (Principle IV)**: Knowledge Graph must be updated after the task; the CI-gate architecture is an architectural decision requiring an ADR. → **REQUIRED: create ADR-0002** during implementation.
- **GATE E — Quality (Principle V)**: Automated tests (Pester) required; documentation updated; repository stays buildable/deployable. → **PASS** (tests planned)
- **GATE F — Security**: Read-only over docs; no secrets; no anonymous write endpoints. → **PASS**

No gate violations requiring Complexity Tracking justification. ADR-0002 is a required artifact, not a violation.

### Post-Design Re-evaluation (after Phase 1)

The design (PowerShell script + GitHub Actions workflow + version-controlled
report artifacts + Pester tests) introduces no new gate violations:

- **GATE A**: PASS — spec unchanged and approved.
- **GATE B**: PASS — no legacy behavior touched.
- **GATE C**: PASS — no DB changes.
- **GATE D**: ADR-0002 remains the single required artifact; the contract
  versioning rule (breaking changes require an ADR) is documented in
  `contracts/validation-summary.md`.
- **GATE E**: PASS — Pester tests planned; Docs-as-Code honored (all
  artifacts version-controlled).
- **GATE F**: PASS — validation is read-only over docs; no secrets.

## Project Structure

### Documentation (this feature)

```text
specs/001-ai-environment-validation/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
.github/workflows/
└── ai-environment-validation.yml   # CI gate (trigger: findings/**, library/**)

scripts/ai-environment-validation/
├── integrations.psd1             # 12-integration registry (id, canonical terms, governing doc, principle)
└── validate-ai-environment.ps1   # Validation script (scan + report generation)

reports/ai-environment-validation/  # Version-controlled output (generated)
├── report.md
└── summary.json

tests/ai-environment-validation/
└── validate-ai-environment.Tests.ps1   # Pester unit tests
```

**Structure Decision**: The feature is delivered as a PowerShell validation
script plus a GitHub Actions workflow, mirroring the existing
`.specify/scripts/powershell/` convention. The report output lives under a
dedicated `reports/` directory so it is version-controlled and PR-reviewed
(Docs-as-Code, `library/06`). Tests use Pester, consistent with the repo's
PowerShell tooling. No application project is created because this is a
governance/validation feature, not a business module.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

No violations to justify. (ADR-0002 is a required governance artifact, not a
complexity violation.)