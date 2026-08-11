<!--
Sync Impact Report:
- Version change: 1.2.0 → 1.3.0
- Principles modified: II. Legacy as Source of Truth (feature set explicitly
  bounded to the three findings documents); III. Data Preservation & Integrity
  (no-drop rule cited to VisaFusion_migration_plan.md §3)
- Principles added: VI. Legacy Forensic Artifacts (verbatim preservation of
  Udaan_users table name, udaanuma-dev/r&d folder names, the two backdoor query
  parameters)
- Sections added: Mission
- Sections expanded: Engineering Process & Security Standards (full stack,
  single-source business rules in VisaFusion.Core, branding rule)
- Removed sections: none
- Deferred TODOs: none
-->

<!--
Sync Impact Report (amendment 1, GAP-0003 Option A):
- Version change: 1.3.0 → 1.3.1
- Sections modified: Engineering Process & Security Standards (SQL Server stack
  line clarified: existing instance; legacy `VisaEntry` preserved read-only;
  target database `VisaFusion`)
- Removed sections: none
- Deferred TODOs: none
-->

# VisaFusion Constitution

## Mission

- Modernize the legacy Classic ASP Visa system into ASP.NET Core.
- Follow Specification Driven Development.
- Never invent business features.
- Preserve legacy business behaviour.
- Preserve all production data.
- Never drop business tables except `dtproperties`.
- Normalize carefully.
- Everything must be traceable.
- Knowledge Graph must be updated after every completed task.
- Every architectural decision requires ADR.
- Every module requires SpecKit specification.
- Every implementation must have automated tests.
- Every change must update documentation.
- Every task must keep repository buildable.
- Every task must keep repository deployable.
- Stop whenever information is missing.
- Generate Gap Report instead of assumptions.

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
do not guess. Every work item MUST be mapped to its legacy pages using
`@findings/modernization_plan.md` §6 (module map) and §13 (legacy pages)
before specification or implementation begins. The feature set is bounded:
no new business features beyond what `@findings/modernization_plan.md`,
`@findings/deepanalysis.md`, and `@findings/exiting_architecture.md` already
document.

### III. Data Preservation & Integrity
Preserve all production data. Never drop business tables; only `dtproperties`
may be removed (see `VisaFusion_migration_plan.md` §3). Normalize carefully.
Database changes are validated before and after every task, and every schema
change is reversible where practical.

### IV. Traceability & Governance
Everything must be traceable: each requirement maps to an architecture
component, domain model, database object, API endpoint, UI page, test case,
documentation, and migration step. The Knowledge Graph must be updated after
every completed task. Every architectural decision requires an ADR (ADR-XXXX).
ADRs are stored under `/adr` as `ADR-XXXX.md`; the Knowledge Graph is
materialized under `/knowledge-graph` (kg.json + traceability-matrix.md).

### V. Quality, Delivery & No-Assumption Rule
Every implementation must have automated tests. Every change must update
documentation. Every task must keep the repository buildable and deployable.
Stop whenever information is missing — generate a Gap Report instead of making
assumptions.

### VI. Legacy Forensic Artifacts
The legacy forensic artifacts MUST be preserved verbatim and NEVER renamed:
the `Udaan_users` table name, the `udaanuma-dev` and `r&d` folder names, and
the two backdoor query parameters (`udaanappraj123guruadm`,
`udaan12345functiondisplaymarquee`). These literals are excluded from the
VisaFusion branding rule and from any renaming normalization; they remain
byte-identical for forensic traceability. Preservation applies to the
artifact/literal only — the backdoor parameters MUST remain functionally inert
and no insecure behavior is preserved.

## Engineering Process & Security Standards

Technology stack is fixed: ASP.NET Core (Razor Pages + Web API under the
versioned `/api/v1` base path), EF Core, SQL Server (existing instance; legacy
`VisaEntry` database preserved read-only; target database `VisaFusion`),
ASP.NET Core Identity, and Bootstrap 5.3.7 with a bespoke theme (AdminLTE is
NOT used). Solution name is **VisaFusion**.
GitHub is the single source of truth. Brand is **VisaFusion** everywhere
except the excluded literal legacy artifacts defined in Principle VI.

Every business rule (e.g., Canada date-of-birth handling, holiday / weekly-off
/ Sunday entry blocking, the day-open gate) MUST be implemented once in
`VisaFusion.Core` and shared by both the Web UI and the API — never duplicated
per surface.

Security by default: no plaintext passwords, no query-string identity, no
string-concatenated SQL, no anonymous write endpoints, and the legacy
`connection.asp` backdoor must be removed.

## Specs Layout Reconciliation

Per ADR-0001, feature specifications produced by `/speckit.specify` use the
SpecKit-native flat layout `specs/NNN-<short-name>/spec.md` (required for
tooling resolution via `.specify/feature.json`). The category folders
(`epics`, `features`, `modules`, `database`, `api`, `ui`, `security`,
`migration`, `testing`) remain for organizational and cross-cutting
specifications. Every feature spec embeds its `SPEC-XXXX` identifier in
section 1 and declares a `Category` field. This supersedes the earlier
category-subfolder-only reading of `library/03 §3`.

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

**Version**: 1.3.1 | **Ratified**: 2026-08-06 | **Last Amended**: 2026-08-11
