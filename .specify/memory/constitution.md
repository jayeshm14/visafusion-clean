<!--
Sync Impact Report:
- Version change: 0.0.0 (template) → 1.0.0 (initial ratification)
- Principles added: 5 (I. Specification-First, II. Legacy as Source of Truth,
  III. Data Preservation & Integrity, IV. Traceability & Governance,
  V. Quality, Delivery & No-Assumption Rule)
- Sections added: Engineering Process & Security Standards,
  Definition of Done & Fixed Execution Order
- Removed sections: none
- Deferred TODOs: none
-->

# VisaFusion Constitution

## Core Principles

### I. Specification-First (SDD)
Every work item begins with an approved SpecKit specification (SPEC-XXXX) that
follows the 24 required sections defined in
`library/03_SpecKit_SDD_Framework.md` §4. Implementation must stop if a
specification is missing or unapproved. Specifications evolve through review,
never through implementation. Every module requires a SpecKit specification.

### II. Legacy as Source of Truth
The legacy Classic ASP application is the functional specification. Never
invent business features. Preserve legacy business behaviour exactly. Where
behavior is ambiguous or data is inconsistent, stop and produce a Gap Report —
do not guess.

### III. Data Preservation & Integrity
Preserve all production data. Never drop business tables; only `dtproperties`
may be removed. Normalize carefully. Database changes are validated before and
after every task, and every schema change is reversible where practical.

### IV. Traceability & Governance
Everything must be traceable: each requirement maps to an architecture
component, domain model, database object, API endpoint, UI page, test case,
documentation, and migration step. The Knowledge Graph must be updated after
every completed task. Every architectural decision requires an ADR (ADR-XXXX).

### V. Quality, Delivery & No-Assumption Rule
Every implementation must have automated tests. Every change must update
documentation. Every task must keep the repository buildable and deployable.
Stop whenever information is missing — generate a Gap Report instead of making
assumptions.

## Engineering Process & Security Standards

Technology stack is fixed: ASP.NET Core, EF Core, SQL Server, and ASP.NET Core
Identity. Solution name is **VisaFusion**. GitHub is the single source of
truth. Security by default: no plaintext passwords, no query-string identity,
no string-concatenated SQL, no anonymous write endpoints, and the legacy
`connection.asp` backdoor must be removed.

## Definition of Done & Fixed Execution Order

Execution follows the fixed order defined in `library/02_OpenCode_Operating_System.md`
(Intake → Specification → Architecture → Knowledge Graph → Domain Modeling →
Database Design → API Contracts → UI Design → Implementation → Testing →
Validation → Documentation → Review → Release). No stage may be skipped.

A task is complete only when all hold: Specification updated, architecture
updated, code implemented, database validated, tests passing, security
reviewed, documentation updated, traceability verified.

## Governance

This constitution supersedes all other practices. Amendments require
documentation, stakeholder approval, and a migration plan. Versioning follows
semantic versioning: MAJOR for backward-incompatible governance/principle
changes, MINOR for new principles or materially expanded guidance, PATCH for
clarifications and non-semantic refinements. Every PR and review must verify
compliance with this constitution.

**Version**: 1.0.0 | **Ratified**: 2026-08-06 | **Last Amended**: 2026-08-06
