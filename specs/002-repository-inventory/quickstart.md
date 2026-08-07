# Quickstart: Repository Inventory Validation

**Feature**: SPEC-0002 — Repository Inventory
**Date**: 2026-08-06

## Purpose

This guide documents the runnable validation scenarios that prove the
repository inventory deliverable is complete and consistent. It is a
validation/run guide — implementation details belong in `tasks.md` and the
implementation phase.

## Prerequisites

- Access to the complete repository at `G:\Projects\VisaEntry`.
- The findings documents present at `findings/exiting_architecture.md`,
  `findings/deepanalysis.md`, `findings/modernization_plan.md`.
- The inventory documents generated under `reports/repository-inventory/`.

## Validation scenarios

### TS-001: All eight categories present

**Steps**:
1. Confirm `reports/repository-inventory/` contains all eight category
   documents plus `README.md` and `discrepancies.md`.

**Expected outcome**: All 10 files exist.

### TS-002: Every entry traceable

**Steps**:
1. For each entry in each inventory document, confirm the `Path`/`Name`/`ProgID`
   maps to a real repository artifact or a cited finding.

**Expected outcome**: No entry references a non-existent artifact; any
non-repository entry is marked as a documented finding.

### TS-003: No source code modified

**Steps**:
1. Run `git status` and confirm no unintended source changes.

**Expected outcome**: Only the inventory documents and spec artifacts are new;
no legacy `.asp` or other source files were modified.

### TS-004: Consistent with findings

**Steps**:
1. Cross-check the legacy inventory (`05-legacy-inventory.md`) against
   `@findings/modernization_plan.md` §6 (module map) and §13 (legacy pages).
2. Confirm any discrepancy is recorded in `discrepancies.md`.

**Expected outcome**: The legacy inventory is consistent with the findings, or
discrepancies are explicitly recorded.

### TS-005: No secrets in output

**Steps**:
1. Search all inventory documents for the patterns `pwd=`, `password=`,
   `uid=`, and full connection-string values.

**Expected outcome**: No secret values appear; configuration entries use
`Value Summary` descriptions only (spec AC-005).

## Contract validation

Validate each document against `contracts/inventory-document-format.md`:

- **C-001**: metadata block present.
- **C-002**: `## Entries` with all required columns.
- **C-003**: no `NEEDS CLARIFICATION`/TODO markers.
- **C-004**: no secret values.
- **C-005**: every entry traceable.

## Acceptance criteria mapping

| Acceptance criterion | Validation scenario |
|----------------------|---------------------|
| AC-001 (8 categories present) | TS-001 |
| AC-002 (entries traceable) | TS-002 |
| AC-003 (no source code written) | TS-003 |
| AC-004 (consistent with findings) | TS-004 |
| AC-005 (no secrets) | TS-005 |

## References

- Data model: `data-model.md`
- Contract: `contracts/inventory-document-format.md`
- Spec: `spec.md`