# Quickstart: AI Environment Validation

**Date**: 2026-08-06 | **Spec**: [spec.md](spec.md) | **Plan**: [plan.md](plan.md)

This guide proves the feature works end-to-end. It validates the environment
claim against the authoritative docs, produces the report artifacts, and
exercises the CI gate. Implementation details live in `tasks.md`; this is a
validation/run guide.

## Prerequisites

- Windows PowerShell 5.1 or PowerShell 7 (`pwsh`).
- Pester 5 installed (`Install-Module Pester -MinimumVersion 5.0`), for tests.
- A clone of the repository at the feature branch
  `001-ai-environment-validation`.
- The authoritative docs in place: `findings/` (3 reports) and `library/`
  (17 standards).

## Setup

No build or install beyond the prerequisites. The validation script uses only
PowerShell built-in cmdlets.

## Run the validation (on demand)

```powershell
& ./scripts/ai-environment-validation/validate-ai-environment.ps1 `
  -SourceDirs @('findings', 'library') `
  -OutputDir 'reports/ai-environment-validation'
```

**Expected outcome**:
- `reports/ai-environment-validation/report.md` is written (human-readable
  per-integration status with provenance).
- `reports/ai-environment-validation/summary.json` is written (machine-readable
  summary, schema v1 per `contracts/validation-summary.md`).
- Exit code `0` when all 12 integrations are `validated`; non-zero when any is
  `partial` / `missing` / `contradictory` (matches `passed` in the summary).

## Verify with the unit tests

```powershell
Invoke-Pester ./tests/ai-environment-validation/validate-ai-environment.Tests.ps1
```

**Expected outcome**: All Pester tests pass. Tests cover:
- All 12 integrations detected across `findings/` and `library/`.
- Workflow-directive detection (BR-002): a name-only mention is `partial`,
  not `validated`.
- Report artifacts written with the expected schema (contracts v1).
- Determinism: identical inputs produce identical results (NFR-001).

## Exercise the CI gate

The GitHub Actions workflow (`.github/workflows/ai-environment-validation.yml`)
runs the validation on every change to `findings/**` or `library/**`
(FR-008, AC-007):

- Commit a change to any file under `findings/` or `library/` and push.
- The workflow runs the validation script and fails the check when
  `passed` is `false`.
- A failing check blocks merge (Constitution Principle V quality gate).

**Expected outcome**: The workflow is green when the docs remain consistent
with the 12 integrations, and red when a documented integration is removed or
loses its workflow directive.

## Negative test (proving detection works)

1. Temporarily rename a governing document (e.g.,
   `library/05_GraphRAG_and_MCP.md`).
2. Re-run the validation script.
3. **Expected outcome**: the affected integration(s) are flagged `missing`
   with provenance, `passed` is `false`, and the CI gate fails.
4. Restore the file and re-run: result returns to all-`validated`.

## References

- Data model: [data-model.md](data-model.md)
- JSON contract: [contracts/validation-summary.md](contracts/validation-summary.md)
- Specification: [spec.md](spec.md)