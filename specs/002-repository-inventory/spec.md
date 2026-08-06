# Feature Specification: Repository Inventory

**Identifier**: SPEC-0002
**Title**: Repository Inventory
**Status**: Draft
**Created**: 2026-08-06
**Category**: migration
**Input**: User description: "Analyze the complete repository. Generate Repository Inventory, Technology Inventory, Dependency Graph, Project Structure, Legacy Inventory, External Dependencies, COM Dependencies, Configuration Inventory. Output markdown only. No implementation."

> This template is the VisaFusion override of the SpecKit `spec-template`.
> It is resolved first by the Spec Kit template stack (`.specify/templates/overrides/`)
> and MUST contain the 24 required sections defined in `library/03_SpecKit_SDD_Framework.md` §4.
> Do not remove or reorder the 24 numbered sections below.

## 1. Identifier

- **SPEC-0002**: Repository Inventory

## 2. Title

Repository Inventory

## 3. Objective

Produce a complete, evidence-based inventory of the VisaEntry repository as a
set of markdown documents. The inventory captures the repository contents,
technologies in use, dependency relationships, project structure, the legacy
Classic ASP application surface, external and COM dependencies, and the
configuration inventory. The output is documentation only — no code is
implemented or modified. This inventory is the baseline reference that
subsequent modernization work items (SPEC-0001 and later) rely on for
traceability and gap analysis.

## 4. Business Context

The VisaEntry repository contains a legacy Classic ASP application (585 root
ASP files, 52-table SQL Server schema) that is being modernized to the
VisaFusion ASP.NET Core platform. Before any further modernization work can be
planned, the team needs a single, authoritative, machine-checkable picture of
what exists today. The inventory documents the current state so that every
future requirement can be traced to a real legacy artifact, and so that
external and COM dependencies are known before the target platform is
finalized. This work item is a documentation deliverable that de-risks the
migration by making the current state explicit and verifiable.

## 5. Scope

In scope for this work item (the scope boundary covers the ENTIRE repository,
including the legacy Classic ASP application and the modernization artifacts
such as `library/`, `findings/`, `specs/`, `scripts/`, and `adr/`):

- **Repository Inventory**: complete listing of repository contents, including
  root files, directories, and their purpose.
- **Technology Inventory**: technologies, languages, and frameworks detected in
  the repository.
- **Dependency Graph**: relationships between repository components and
  artifacts.
- **Project Structure**: the logical and physical structure of the repository.
- **Legacy Inventory**: the legacy Classic ASP application surface (pages,
  modules, includes, data access).
- **External Dependencies**: third-party libraries, services, and systems the
  application depends on.
- **COM Dependencies**: Component Object Model (COM) components referenced by
  the legacy application.
- **Configuration Inventory**: configuration files, connection strings, and
  settings.

All output is markdown documentation. No source code is written or modified.

## 6. Out of Scope

- No implementation of any kind (no code, no schema changes, no migrations).
- No changes to the legacy application or its data.
- No database modifications.
- No deployment or environment changes.
- No security remediation (findings are recorded, not fixed).
- No performance tuning or refactoring.

## 7. Stakeholders

- **Migration Engineering Team**: consume the inventory to plan and trace
  modernization work items.
- **Architects**: use the dependency and technology inventories to finalize the
  target architecture.
- **Security reviewers**: use the configuration and dependency inventories to
  identify risk surface.
- **Project leadership**: use the inventory as the authoritative baseline for
  scope and progress tracking.

## 8. Legacy Mapping

This work item is a documentation deliverable over the entire repository. It
maps to the legacy application as a whole, using the live-verified snapshots in
`@findings/exiting_architecture.md`, `@findings/deepanalysis.md`, and
`@findings/modernization_plan.md` as the baseline. The inventory must be
consistent with these findings and must not invent artifacts that do not exist
in the repository. Where the repository and the findings disagree, the
discrepancy is recorded in the inventory rather than silently resolved.

## 9. Functional Requirements

- **FR-001**: The system MUST produce a Repository Inventory that lists the
  top-level directories and files of the repository with their purpose.
- **FR-002**: The system MUST produce a Technology Inventory that lists every
  technology, language, and framework detected in the repository.
- **FR-003**: The system MUST produce a Dependency Graph that shows the
  relationships between repository components and artifacts.
- **FR-004**: The system MUST produce a Project Structure document describing
  the physical and logical structure of the repository.
- **FR-005**: The system MUST produce a Legacy Inventory that enumerates the
  legacy Classic ASP application surface, including pages, modules, includes,
  and data-access artifacts.
- **FR-006**: The system MUST produce an External Dependencies inventory that
  lists external libraries, services, and systems the application depends on.
- **FR-007**: The system MUST produce a COM Dependencies inventory that lists
  COM components referenced by the legacy application.
- **FR-008**: The system MUST produce a Configuration Inventory that lists
  configuration files, connection strings, and settings.
- **FR-009**: All inventory output MUST be delivered as markdown documentation.
- **FR-010**: The inventory MUST be derived from the actual repository contents
  and the live-verified findings, and MUST NOT invent artifacts.

## 10. Business Rules

- **BR-001**: Every inventory entry MUST be traceable to an actual repository
  artifact or a cited finding.
- **BR-002**: Where the repository contents and the findings disagree, the
  discrepancy MUST be recorded in the inventory rather than silently resolved.
- **BR-003**: The inventory is documentation only; no implementation is
  performed as part of this work item.

## 11. Non-functional Requirements

- **NFR-001**: The inventory MUST be reproducible — re-running the analysis
  against the same repository state yields the same inventory.
- **NFR-002**: The inventory MUST be complete, covering the entire repository
  and all eight required inventory categories.
- **NFR-003**: The inventory MUST be maintainable — structured so it can be
  updated as the repository evolves.
- **NFR-004**: The inventory is a static documentation deliverable with no
  automated CI enforcement; it is validated by manual review against the
  repository and the findings documents.

## 12. Security

- The inventory is documentation only and performs no writes to the
  application, database, or configuration.
- Configuration Inventory MUST flag any plaintext credentials or connection
  strings found, but MUST NOT include the actual secret values in the
  documentation.
- No secrets, passwords, or connection-string values are to be reproduced in
  the markdown output.

## 13. Performance

- The analysis MUST complete within a reasonable time for a repository of this
  size (585 root ASP files, 52-table schema). No specific latency target is
  imposed; the deliverable is documentation, not a runtime service.

## 14. UI Requirements

- No user interface is produced. The deliverable is markdown documentation
  consumed by stakeholders and tooling.

## 15. API Contracts

- No APIs are produced or consumed. The deliverable is static markdown
  documentation.

## 16. Database Changes

- No database changes. The inventory documents the existing 52-table schema
  but does not modify it.

## 17. Validation Rules

- Each inventory category MUST be validated against the actual repository
  contents.
- The inventory MUST be cross-checked against `@findings/exiting_architecture.md`,
  `@findings/deepanalysis.md`, and `@findings/modernization_plan.md`.
- Any artifact listed in the inventory MUST exist in the repository or be
  explicitly marked as a documented finding.

## 18. Error Handling

- If a repository artifact cannot be classified, the inventory MUST record it
  as "unclassified" rather than omit it.
- If the repository and findings disagree, the discrepancy MUST be recorded in
  a dedicated discrepancies section.

## 19. Audit Requirements

- The inventory MUST record the date of analysis and the repository state
  (commit/branch) it was produced against.
- Each inventory entry MUST be traceable to a repository path or finding.

## 20. Acceptance Criteria

- **AC-001**: All eight required inventory categories (Repository, Technology,
  Dependency Graph, Project Structure, Legacy, External Dependencies, COM
  Dependencies, Configuration) are present as markdown.
- **AC-002**: Every inventory entry is traceable to a real repository artifact
  or a documented finding.
- **AC-003**: No source code is written or modified as part of this work.
- **AC-004**: The inventory is consistent with the legacy findings documents.
- **AC-005**: No secrets or full connection-string values appear in the
  documentation output.

## 21. Risks

- **Risk**: Repository is large and classification may be incomplete.
  **Mitigation**: Record unclassified artifacts explicitly rather than omitting
  them.
- **Risk**: Findings documents may be out of date relative to the repository.
  **Mitigation**: Record discrepancies rather than silently resolving them.
- **Risk**: COM and external dependencies may be referenced indirectly.
  **Mitigation**: Cross-reference includes, connection strings, and data access
  artifacts to surface indirect references.

## 22. Dependencies

- Access to the complete repository contents.
- The live-verified findings documents (`@findings/exiting_architecture.md`,
  `@findings/deepanalysis.md`, `@findings/modernization_plan.md`).
- No external services or runtime dependencies.

## 23. Test Scenarios

- **TS-001**: Verify all eight inventory categories are present as markdown.
- **TS-002**: Verify each inventory entry maps to a real repository path or
  finding.
- **TS-003**: Verify no source code was written or modified (git status clean
  of unintended changes).
- **TS-004**: Verify the inventory is consistent with the findings documents.
- **TS-005**: Verify no secrets or full connection values appear in the output.

## 24. Traceability Matrix

| Requirement | Architecture | Domain | Database | API | UI | Test | Migration |
|-------------|--------------|--------|----------|-----|----|------|-----------|
| FR-001      |              |        |          |     |    | TS-001 |           |
| FR-002      |              |        |          |     |    | TS-001 |           |
| FR-003      |              |        |          |     |    | TS-001 |           |
| FR-004      |              |        |          |     |    | TS-001 |           |
| FR-005      |              |        |          |     |    | TS-001 |           |
| FR-006      |              |        |          |     |    | TS-001 |           |
| FR-007      |              |        |          |     |    | TS-001 |           |
| FR-008      |              |        |          |     |    | TS-001 |           |
| FR-009      |              |        |          |     |    | TS-002 |           |
| FR-010      |              |        |          |     |    | TS-002 |           |

## Assumptions

- The repository root is the authoritative source for the inventory.
- The findings documents are the authoritative baseline for legacy behavior and
  are used as input context.
- "Output markdown only" means the deliverable is markdown documentation and no
  implementation is performed.
- The inventory is a snapshot of the current repository state and is expected to
  be updated as the repository evolves.

## Clarifications

### Session 2026-08-06

- Q: Should the inventory be a single document or one per category? → A: The
  feature description lists eight distinct categories; the inventory is
  produced as markdown covering all eight categories, structured so each
  category is clearly delineated.
- Q: What does "the complete repository" include? → A: The entire repository,
  including the legacy Classic ASP application and the modernization artifacts
  (library/, findings/, specs/, scripts/, adr/).
- Q: Should the inventory be validated by an automated check? → A: No — it is a
  static documentation deliverable with no automated CI enforcement; validated
  by manual review.