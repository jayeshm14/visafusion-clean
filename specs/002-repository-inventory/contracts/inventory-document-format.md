# Contract: Inventory Document Format

**Feature**: SPEC-0002 — Repository Inventory
**Date**: 2026-08-06
**Version**: 1.0

## Purpose

Defines the required structure and fields for each inventory document so the
inventory is consistent, complete, and machine-checkable across all eight
categories. Every inventory document MUST conform to this contract.

## Document layout

Every inventory document MUST contain the following sections in order:

1. `# <Category> Inventory` — H1 heading with the category name.
2. `**Feature**: SPEC-0002` and `**Date**: <date>` — metadata block.
3. `## Scope` — what this category covers.
4. `## Entries` — the inventory table (see Entry table contract below).
5. `## Notes` — optional; caveats, evidence limitations, security notes
   (never secret values).

## Entry table contract

Each inventory document's `## Entries` section is a markdown table with the
columns required for that category, as defined in the data model
(`data-model.md`). Every row MUST have a value for every column; unknown values
use `UNKNOWN` (never omit the column or row).

### Required columns per category

| Category (file) | Required columns |
|-----------------|------------------|
| 01-repository-inventory.md | Path, Type, Category, Purpose, Source |
| 02-technology-inventory.md | Name, Category, Evidence, Confidence, Status |
| 03-dependency-graph.md | Source, Target, Type, Evidence |
| 04-project-structure.md | Directory, Purpose, Contents (summary) |
| 05-legacy-inventory.md | Path, Module, Role, Data Access, Auth Level |
| 06-external-dependencies.md | Name, Type, Used By, License, Security Note |
| 07-com-dependencies.md | ProgID, Assembly/File, Reference Count, Purpose, Security Note |
| 08-configuration-inventory.md | Artifact, Setting, Value Summary, Secret, Status |

## Discrepancy contract (`discrepancies.md`)

The `discrepancies.md` document MUST contain a table with columns:
`Artifact`, `Repository State`, `Finding State`, `Discrepancy`, `Resolution`.

- `Resolution` values: RECORDED (discrepancy documented, no resolution
  attempted), or a short note on how it was resolved.

## Index contract (`README.md`)

The `README.md` index MUST contain:

1. `# Repository Inventory` — title.
2. `**Date**: <date>` and `**Repository state**: <branch or commit>` — metadata.
3. `## Categories` — a table mapping each category to its document path and a
   one-line description.
4. `## How to update` — brief instructions for regenerating/updating the
   inventory.
5. `## Validation` — a pointer to `quickstart.md` and the acceptance criteria.

## Validation rules (this contract)

- **C-001**: Every document has the required metadata block.
- **C-002**: Every document has `## Entries` with all required columns.
- **C-003**: No `NEEDS CLARIFICATION` or TODO markers in any document.
- **C-004**: No secret values (passwords, full connection strings, tokens)
  appear in any document (spec AC-005).
- **C-005**: Every entry traces to a real repository artifact or a finding
  (spec BR-001).

## Traceability

| Contract rule | Spec requirement |
|---------------|------------------|
| C-001..C-005 | FR-001..FR-010, BR-001, AC-004, AC-005 |
