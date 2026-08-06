# Implementation Plan: Repository Inventory

**Branch**: `002-repository-inventory` | **Date**: 2026-08-06 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `/specs/002-repository-inventory/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command; its definition describes the execution workflow.

## Summary

Produce a complete, evidence-based inventory of the VisaEntry repository as
markdown documentation. The deliverable covers eight categories: Repository
Inventory, Technology Inventory, Dependency Graph, Project Structure, Legacy
Inventory, External Dependencies, COM Dependencies, and Configuration
Inventory. The inventory is derived from the actual repository contents and the
live-verified findings (`@findings/exiting_architecture.md`,
`@findings/deepanalysis.md`, `@findings/modernization_plan.md`). It is a static
documentation deliverable with no automated CI enforcement (per clarification
Q2) and covers the entire repository including modernization artifacts
(per clarification Q1). No source code is written or modified.

## Technical Context

**Language/Version**: Markdown (documentation only; no code language)

**Primary Dependencies**: None (static documentation; no runtime dependencies)

**Storage**: N/A — deliverable is markdown files under `reports/repository-inventory/`

**Testing**: Manual review checklist (NFR-004); no automated test framework

**Target Platform**: N/A — markdown consumed by stakeholders and tooling

**Project Type**: Documentation deliverable (repository analysis/inventory)

**Performance Goals**: N/A — not a runtime service; analysis completes in reasonable time for a repository of this size (585 root ASP files, 52-table schema)

**Constraints**: Markdown output only; no implementation; no secrets or full connection-string values in output (Security §12, AC-005)

**Scale/Scope**: Entire repository — legacy Classic ASP application (585 root ASP files) plus modernization artifacts (library/, findings/, specs/, scripts/, adr/, knowledge-graph/, reports/)

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **Principle I (Specification-First)**: PASS — SPEC-0002 is approved and follows the 24 required sections.
- **Principle II (Legacy as Source of Truth)**: PASS — the inventory maps to the legacy app using the findings documents; no business features invented; discrepancies recorded rather than guessed.
- **Principle III (Data Preservation)**: PASS — no database changes; the inventory documents the existing 52-table schema without modifying it.
- **Principle IV (Traceability & Governance)**: PASS — every inventory entry is traceable to a repository artifact or finding; the Knowledge Graph will be updated after completion.
- **Principle V (Quality, Delivery & No-Assumption)**: PASS — documentation is updated; no assumptions made; gaps recorded explicitly.
- **Principle V deviation (documented)**: NFR-004 specifies manual review with
  no automated CI enforcement. This is a deliberate, documented deviation from
  the "automated tests" expectation of Principle V, justified because SPEC-0002
  is a documentation-only deliverable (FR-009, BR-003): there is no executable
  implementation to test. Validation is performed by the manual review process
  defined in `quickstart.md` (TS-001..TS-005) and enforced via the
  requirements checklist (`checklists/inventory.md`).

**Gate result**: PASS — no violations. No complexity justification required.

## Project Structure

### Documentation (this feature)

```text
specs/002-repository-inventory/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Deliverable (repository root)

```text
reports/repository-inventory/
├── README.md                    # Index of the inventory
├── 01-repository-inventory.md   # FR-001: repository contents & purpose
├── 02-technology-inventory.md   # FR-002: technologies, languages, frameworks
├── 03-dependency-graph.md       # FR-003: component/artifact relationships
├── 04-project-structure.md      # FR-004: physical & logical structure
├── 05-legacy-inventory.md       # FR-005: legacy Classic ASP surface
├── 06-external-dependencies.md  # FR-006: external libraries/services/systems
├── 07-com-dependencies.md       # FR-007: COM components referenced
├── 08-configuration-inventory.md# FR-008: config files, connection strings, settings
└── discrepancies.md             # BR-002: repository vs findings discrepancies
```

**Structure Decision**: The deliverable is organized as one markdown file per
inventory category under `reports/repository-inventory/`, with a `README.md`
index and a dedicated `discrepancies.md` for BR-002. This matches the eight
categories in the feature description and keeps each category independently
reviewable. The spec artifacts live under `specs/002-repository-inventory/`.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

No constitution violations. Complexity Tracking is not required.

## Phase 0: Research

Research tasks (documented in `research.md`):

1. **Repository contents**: Enumerate the complete repository (top-level
   directories and files, file-type distribution). Confirmed: 585 root `.asp`
   files, plus `.htm`, `.html`, `.jpg`, `.png`, `.gif`, `.css`, `.js`, `.sql`,
   `.dll`, `.doc`, `.zip`, `.x3d`, `.db` files; directories include `library/`,
   `findings/`, `specs/`, `scripts/`, `adr/`, `knowledge-graph/`, `reports/`,
   `tests/`, `ActiveX/`, `Demo/`, `Templates/`, `UI/`, `forms/`, `css/`, `js/`,
   `images/`, `fonts/`, `assets/`, `updateimg/`, `NewYear2006/`, `r&d/`,
   `udaanuma-dev/`, `_notes/`, `_vti_cnf/`, `.github/`, `.opencode/`,
   `.specify/`, `.vs/`, `.vscode/`.
2. **Technology detection**: Identify technologies from file extensions and
   content (Classic ASP/VBScript, SQL Server, HTML/CSS/JS, COM components).
3. **Dependency mapping**: Trace includes, connection strings, and data-access
   artifacts to build the dependency graph.
4. **Legacy surface**: Enumerate legacy pages, modules, includes, and data
   access from the findings and repository.
5. **External & COM dependencies**: Identify third-party libraries, services,
   and COM components (e.g., `msoe.dll`, `ActiveX/`).
6. **Configuration**: Identify configuration files, connection strings, and
   settings (e.g., `connection.asp`, `connectionold.asp`, `connectionweb.asp`,
   `database.sql`, `opencode.json`).

## Phase 1 — Design & Contracts

**Prerequisites**: `research.md` complete.

1. **Data model** (`data-model.md`): Define the inventory schema — the eight
   inventory categories, their entities (e.g., Repository Artifact, Technology,
   Dependency, Legacy Page, External Dependency, COM Component, Configuration
   Item), attributes, and relationships. This is a documentation data model,
   not a database schema.
2. **Contracts** (`contracts/`): Define the markdown contract for each
   inventory category — the required sections and fields each inventory
   document must contain so the inventory is consistent and machine-checkable.
3. **Quickstart** (`quickstart.md`): Document the validation scenarios that
   prove the inventory is complete and consistent (TS-001..TS-005).

## Constitution Re-check (post-design)

- **Principle II**: PASS — the inventory remains derived from the repository
  and findings; no invented artifacts.
- **Principle IV**: PASS — traceability matrix in the spec maps each FR to a
  test scenario; Knowledge Graph update planned.
- **Principle V**: PASS — documentation-only; no code; no assumptions.

**GATE**: PASS.