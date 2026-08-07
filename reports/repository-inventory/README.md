# Repository Inventory

**Feature**: SPEC-0002
**Date**: 2026-08-06
**Repository state**: branch `002-repository-inventory` @ `701b35d`

## Purpose

A complete, evidence-based inventory of the VisaEntry repository, produced as
markdown documentation. The inventory captures the repository contents,
technologies in use, dependency relationships, project structure, the legacy
Classic ASP application surface, external and COM dependencies, and the
configuration inventory. It is the baseline reference that subsequent
modernization work items rely on for traceability and gap analysis.

## Categories

| Category | Document | Description |
|----------|----------|-------------|
| Repository Inventory | [01-repository-inventory.md](01-repository-inventory.md) | Complete listing of repository contents and their purpose |
| Technology Inventory | [02-technology-inventory.md](02-technology-inventory.md) | Technologies, languages, and frameworks in use |
| Dependency Graph | [03-dependency-graph.md](03-dependency-graph.md) | Relationships between components and artifacts |
| Project Structure | [04-project-structure.md](04-project-structure.md) | Physical and logical repository layout |
| Legacy Inventory | [05-legacy-inventory.md](05-legacy-inventory.md) | Legacy Classic ASP application surface |
| External Dependencies | [06-external-dependencies.md](06-external-dependencies.md) | External libraries, services, and systems |
| COM Dependencies | [07-com-dependencies.md](07-com-dependencies.md) | COM components referenced by legacy pages |
| Configuration Inventory | [08-configuration-inventory.md](08-configuration-inventory.md) | Configuration files, connection strings, settings |
| Discrepancies | [discrepancies.md](discrepancies.md) | Repository-vs-findings discrepancies (BR-002) |

## How to update

This inventory is a snapshot of the repository state recorded above. To update it:

1. Re-run the analysis against the current repository state.
2. Update each category document to reflect the current contents.
3. Record the new repository state (branch/commit) and date in this README.
4. Record any new repository-vs-findings discrepancies in `discrepancies.md`.

## Validation

Validation scenarios are defined in `specs/002-repository-inventory/quickstart.md`
(TS-001..TS-005) and the document format contract in
`specs/002-repository-inventory/contracts/inventory-document-format.md` (C-001..C-005).
Acceptance criteria are defined in `specs/002-repository-inventory/spec.md` §20 (AC-001..AC-005).