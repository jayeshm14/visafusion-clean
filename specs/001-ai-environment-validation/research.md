# Research: AI Environment Validation

**Date**: 2026-08-06 | **Spec**: [spec.md](spec.md) | **Plan**: [plan.md](plan.md)

This document records the decisions made to resolve the technical unknowns in
the plan's Technical Context. Each entry follows: Decision / Rationale /
Alternatives considered.

## 1. Validation script language

- **Decision**: PowerShell 5.1 (compatible with PowerShell 7 / `pwsh`).
- **Rationale**: The repository already uses PowerShell for SpecKit tooling
  (`.specify/scripts/powershell/*.ps1`), so a PowerShell script is consistent
  with repo conventions and runs identically on Windows (local) and
  `ubuntu-latest` (GitHub Actions via `pwsh`). It uses only built-in cmdlets,
  so no dependency install is required.
- **Alternatives considered**: Python (would add a runtime dependency and
  diverge from repo tooling); a Node.js script (same drawback); a pure
  GitHub Actions YAML with shell steps (harder to unit-test and reuse on
  demand).

## 2. How to detect the 12 integrations in the docs

- **Decision**: For each of the 12 integrations, scan `findings/` and
  `library/` with `Select-String` for the canonical term, then apply the
  workflow-directive test (BR-002): an integration is "validated" only when a
  governing doc contains a workflow directive (a sentence prescribing the
  practice), not merely a name mention.
- **Rationale**: This encodes the verification standard used to validate the
  environment claim and satisfies BR-002 and FR-003 (flag missing / partial /
  contradictory).
- **Alternatives considered**: Manual review (not repeatable); a curated
  allow-list of "known good" docs (fragile, not provenance-based).

## 3. Report format and location

- **Decision**: Markdown report (`report.md`) plus a machine-readable JSON
  summary (`summary.json`), both version-controlled under
  `reports/ai-environment-validation/`.
- **Rationale**: Docs-as-Code (`library/06`) requires artifacts to be
  version-controlled and PR-reviewed. The JSON summary lets the CI gate and
  the Knowledge Graph consume the status programmatically (FR-007, AC-006).
- **Alternatives considered**: Markdown only (not machine-readable); ad hoc
  on-demand output (not version-controlled, violates Docs-as-Code).

## 3. CI gate trigger

- **Decision**: GitHub Actions workflow triggers on `paths: ['findings/**',
  'library/**']` and blocks merge on failure.
- **Rationale**: Clarified (FR-008, AC-007). Triggering only on the
  authoritative inputs keeps the gate cheap and detects drift immediately.
- **Alternatives considered**: Trigger on every file (noisy); scheduled daily
  (delays drift detection).

## 4. Test framework

- **Decision**: Pester 5 for PowerShell unit tests of the validation script.
- **Rationale**: Pester is the standard PowerShell test framework, consistent
  with the repo's PowerShell tooling, and satisfies Principle V (automated
  tests).
- **Alternatives considered**: No tests (violates Principle V); a custom
  assertion harness (reinvents Pester).

## 5. ADR for the CI-gate architecture

- **Decision**: Create ADR-0002 documenting the validation-gate architecture
  (script + CI workflow + report artifacts) during implementation.
- **Rationale**: Constitution Principle IV requires an ADR for every
  architectural decision; the CI gate is an architectural decision.
- **Alternatives considered**: No ADR (violates Principle IV); fold into
  ADR-0001 (ADR-0001 is scoped to the specs layout, not this feature).

## Consolidated decisions

| Unknown | Decision |
|---------|----------|
| Script language | PowerShell 5.1 / pwsh |
| Integration detection | `Select-String` + workflow-directive test (BR-002) |
| Report format | Markdown + JSON under `reports/ai-environment-validation/` |
| CI trigger | `paths: findings/**, library/**` |
| Test framework | Pester 5 |
| ADR | ADR-0002 (created during implementation) |