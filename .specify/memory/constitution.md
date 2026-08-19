<!--
Sync Impact Report (amendment 4, v1.4.2):
- Version change: 1.4.1 → 1.4.2 (PATCH)
- Principles modified: I. Specification-First (SDD) (explicitly names the
  VisaFusion spec-template override `.specify/templates/overrides/spec-template.md`
  as the required template for the 24 sections defined in library/03 §4)
- Added sections: none
- Removed sections: none
- Deferred TODOs: none
-->

<!--
Sync Impact Report (amendment 3, v1.4.1):
- Version change: 1.4.0 → 1.4.1 (PATCH)
- Principles modified: IV. CoreUI is the UI Design System (added the full
  design-reference URL https://github.com/coreui/coreui-free-bootstrap-admin-template.git)
- Added sections: none
- Removed sections: none
- Deferred TODOs: unchanged from amendment 2 (implemented-UI reconciliation
  with the CoreUI mandate via future specification + ADR-0006 recordal)
-->

<!--
Sync Impact Report (amendment 2, v1.4.0):
- Version change: 1.3.1 → 1.4.0 (MINOR)
- Principles modified: I. Specification-First (SDD) (formalized as mandated
  principle 1, semantics unchanged); II. Legacy as Source of Truth (renamed to
  II. Legacy is Evidence per mandate); IV. Traceability & Governance (split into
  XII. AI-Native Knowledge Graph + XIII. Traceability); V. Quality, Delivery &
  No-Assumption Rule (distributed across XVIII. Testing / XIX. Documentation /
  XXI. No Unrelated Refactoring / XXIII. Definition of Done)
- Principles added: III. Role-Based Native Page Architecture Must Be Preserved,
  IV. CoreUI is the UI Design System, V. VisaFusion Functional Architecture
  Remains Authoritative, VI. Database Safety, VII. Data Preservation,
  VIII. Database Normalization, IX. Stored Procedures and SQL Functions,
  X. ASP.NET Core, XI. SpecKit, XIV. Reusable UI, XV. Authorization,
  XVI. Accessibility, XVII. Responsive Design, XX. GitHub, XXII. Stop Conditions
- Sections added: UI Design System (CoreUI)
- Sections expanded: Engineering Process & Security Standards (presentation
  stack changed from bespoke theme to CoreUI Free Bootstrap Admin Template;
  AdminLTE remains excluded); Definition of Done & Fixed Execution Order
  (added role-behavior, authorization, CoreUI-mapping, responsive, accessibility,
  and convergence gates)
- Removed sections: none
- Deferred TODOs: (1) reconcile the implemented UI (wwwroot/css/tokens.css,
  theme.css — bespoke theme) with the CoreUI mandate via a future specification
  and ADR; (2) ADR-0006 to record this constitution amendment (library/00 §5)
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
- Every architectural decision requires an ADR.
- Every module requires a SpecKit specification.
- Every implementation must have automated tests.
- Every change must update documentation.
- Every task must keep the repository buildable.
- Every task must keep the repository deployable.
- Stop whenever information is missing.
- Generate a Gap Report instead of assumptions.

## Core Principles

### I. Specification-First (SDD)
No implementation may begin without an approved feature specification. Every
work item begins with an approved SpecKit specification (SPEC-XXXX) that
follows the 24 required sections defined in
`library/03_SpecKit_SDD_Framework.md` §4 and the VisaFusion spec-template
override at `.specify/templates/overrides/spec-template.md`. Implementation
must stop if a specification is missing or unapproved. Specifications evolve
through review, never through implementation. Every module requires a SpecKit
specification.

### II. Legacy is Evidence
The existing application is the primary source for discovering existing
behavior. Do not invent behavior. Do not assume behavior. Do not silently
"improve" business rules. Where behavior cannot be established from available
evidence, create a GAP REPORT and stop. Every work item MUST be mapped to its
legacy pages using `@findings/modernization_plan.md` §6 (module map) and §13
(legacy pages) before specification or implementation begins. The feature set
is bounded: no new business features beyond what
`@findings/modernization_plan.md`, `@findings/deepanalysis.md`, and
`@findings/exiting_architecture.md` already document.

### III. Role-Based Native Page Architecture Must Be Preserved
The existing VisaFusion role-based native-pages architecture is authoritative
for roles, permissions, claims, navigation, menus, submenus, landing pages,
dashboards, native pages, workflows, actions, reports, routing, redirects, and
authorization boundaries. Do not flatten the application into one generic
dashboard. Do not merge role-specific workflows merely for UI consistency.
Detailed rules are defined in
`library/Role-Based Native Pages Architecture Addendum.md`.

### IV. CoreUI is the UI Design System
Use the official CoreUI Free Bootstrap Admin Template as the UI design
reference: https://github.com/coreui/coreui-free-bootstrap-admin-template.git
CoreUI governs presentation: layouts, visual language, components, responsive
behavior, navigation presentation, forms, tables, cards, alerts, modals, tabs,
dropdowns, sidebar, header, footer, icons, spacing, typography, and interaction
patterns. CoreUI does NOT replace VisaFusion business architecture.

### V. VisaFusion Functional Architecture Remains Authoritative
The final model is:

```text
Existing VisaFusion role-based functional architecture
                     +
              CoreUI presentation architecture
                     ↓
         Modern VisaFusion UI architecture
```

### VI. Database Safety
Never drop any existing business table. The ONLY table permitted to be dropped
is `dtproperties`. Do not perform destructive database operations during UI
modernization.

### VII. Data Preservation
Preserve existing production data. Do not change data semantics merely to make
UI implementation easier.

### VIII. Database Normalization
Normalize only when required and only after deterministic analysis of existing
relationships, dependencies, data usage, and migration impact. Do not
arbitrarily redesign the database.

### IX. Stored Procedures and SQL Functions
Create or modify stored procedures, SQL functions, views, indexes, constraints,
or other database objects only when justified by an approved specification,
architecture decision, performance requirement, security requirement, or
verified legacy behavior.

### X. ASP.NET Core
Use the existing approved ASP.NET Core architecture. Prefer Clean
Architecture, DDD where justified, SOLID, dependency injection, separation of
concerns, DTOs, validation, secure APIs, and testability. Do not introduce
unnecessary architectural complexity.

### XI. SpecKit
Every feature must follow the SpecKit pipeline:
constitution → specify → clarify → plan → checklist → tasks → analyze →
implement → converge.

### XII. AI-Native Knowledge Graph
Maintain a continuously synchronized Knowledge Graph tracking roles,
permissions, claims, navigation, menus, pages, features, specifications,
components, routes, APIs, use cases, entities, tables, stored procedures,
functions, tests, dependencies, and architecture decisions. The Knowledge
Graph MUST be updated after every completed task.

### XIII. Traceability
Everything must be traceable. Every implementation must be traceable:
Role → Permission → Navigation → Page → Feature → Specification → Use Case →
API → Database → Test. Every architectural decision requires an ADR (ADR-XXXX)
stored under `/adr`; the Knowledge Graph is materialized under
`/knowledge-graph` (kg.json + traceability-matrix.md).

### XIV. Reusable UI
Do not duplicate UI components unnecessarily. Every reusable CoreUI-based
VisaFusion component must have one canonical implementation.

### XV. Authorization
UI visibility is not security. Hiding a CoreUI navigation item does not
constitute authorization. Server-side authorization remains authoritative for
every protected page and every protected API.

### XVI. Accessibility
All migrated UI must preserve or improve semantic HTML, keyboard
accessibility, labels, focus handling, ARIA where appropriate, contrast,
accessible forms, and accessible navigation.

### XVII. Responsive Design
Validate desktop, tablet, and mobile behavior for every migrated surface.

### XVIII. Testing
Every implementation must have appropriate unit tests, integration tests, API
tests, authorization tests, regression tests, and UI tests where appropriate.

### XIX. Documentation
Update documentation whenever architecture, UI, behavior, dependencies,
migration mapping, or operational behavior changes.

### XX. GitHub
Use GitHub as the engineering system of record. Maintain branches, commits,
pull requests, issues where applicable, CI/CD, and traceability on GitHub.

### XXI. No Unrelated Refactoring
Do not modify unrelated modules merely because they appear old or inconsistent.

### XXII. Stop Conditions
Stop and create a GAP REPORT if: requirements are ambiguous; role behavior is
unknown; authorization behavior is unknown; existing page behavior cannot be
determined; CoreUI integration conflicts with existing architecture;
dependencies conflict; destructive database changes appear necessary; business
behavior would need to be invented; or specifications contradict existing
approved architecture.

### XXIII. Definition of Done
A feature is complete only when: specification is satisfied; plan is satisfied;
tasks are complete; implementation builds; tests pass; role behavior is
preserved; authorization is preserved; CoreUI mapping is complete; responsive
behavior is validated; accessibility is validated; Knowledge Graph is
synchronized; documentation is synchronized; traceability is complete; and
convergence reports no remaining gaps.

### XXIV. Legacy Forensic Artifacts
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
ASP.NET Core Identity, and the CoreUI Free Bootstrap Admin Template as the UI
design system (Bootstrap-based; AdminLTE is NOT used). Solution name is
**VisaFusion**. GitHub is the single source of truth. Brand is **VisaFusion**
everywhere except the excluded literal legacy artifacts defined in Principle
XXIV.

Every business rule (e.g., Canada date-of-birth handling, holiday / weekly-off
/ Sunday entry blocking, the day-open gate) MUST be implemented once in
`VisaFusion.Core` and shared by both the Web UI and the API — never duplicated
per surface.

Security by default: no plaintext passwords, no query-string identity, no
string-concatenated SQL, no anonymous write endpoints, and the legacy
`connection.asp` backdoor must be removed.

## UI Design System (CoreUI)

CoreUI governs presentation only: layouts, visual language, components,
responsive behavior, navigation presentation, forms, tables, cards, alerts,
modals, tabs, dropdowns, sidebar, header, footer, icons, spacing, typography,
and interaction patterns. CoreUI does NOT replace VisaFusion business
architecture. The final architecture combines both:

```text
Existing VisaFusion role-based functional architecture
                     +
              CoreUI presentation architecture
                     ↓
         Modern VisaFusion UI architecture
```

Role-specific native pages remain role-specific unless an approved
specification explicitly changes them. Role-aware navigation, breadcrumbs, and
application shell MUST be centralized (never hard-coded per Razor page).
Detailed implementation rules are defined in
`library/Role-Based Native Pages Architecture Addendum.md`.

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

Execution follows the fixed order defined in
`library/02_OpenCode_Operating_System.md` (Intake → Specification →
Architecture → Knowledge Graph → Domain Modeling → Database Design → API
Contracts → UI Design → Implementation → Testing → Validation →
Documentation → Review → Release). No stage may be skipped.

A task is complete only when all of Principle XXIII hold: specification
updated, architecture updated, code implemented, database validated, tests
passing, role behavior preserved, authorization preserved, CoreUI mapping
complete, responsive behavior validated, accessibility validated, security
reviewed, documentation updated, Knowledge Graph synchronized, traceability
verified, and convergence reports no remaining gaps.

## Governance

This constitution supersedes all other practices. Amendments require
documentation, stakeholder approval, and a migration plan. Versioning follows
semantic versioning: MAJOR for backward-incompatible governance/principle
changes, MINOR for new principles or materially expanded guidance, PATCH for
clarifications and non-semantic refinements. Every PR and review must verify
compliance with this constitution.

**Version**: 1.4.2 | **Ratified**: 2026-08-06 | **Last Amended**: 2026-08-19
