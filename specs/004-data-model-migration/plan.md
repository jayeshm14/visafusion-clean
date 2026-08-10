# Implementation Plan: Complete Data Model Migration

**Branch**: `004-data-model-migration` | **Date**: 2026-08-09 | **Spec**: [SPEC-0004](spec.md)

**Input**: Feature specification from `/specs/004-data-model-migration/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command; its definition describes the execution workflow.

## Summary

Migrate the complete legacy `VisaEntry` database surface — all 52 tables — into the
VisaFusion target data model with **zero data loss**, reconstructed referential
integrity, and the per-table disposition defined in `library/complete_migration_plan.md`
§3 (M / M-RO / COND / ARCH / DROP). The migration is an **offline, operator-run
process** (legacy app stopped for the maintenance window, NFR-002): a static snapshot
is copied to the target `VisaFusion` database, primary keys are reconstructed
(identity-first with surrogate fallback), foreign keys and indexes are added, the three
legacy identity sources are imported into ASP.NET Core Identity with passwords hashed
on import (first-source-wins dedup), approved cleansing rules are applied with business
sign-off, and a machine-readable migration report is produced. The legacy database is
never modified and remains restorable until cutover.

## Technical Context

**Language/Version**: C# 12 / .NET 8 (LTS) — fixed by SPEC-0003 NFR-005.

**Primary Dependencies**: EF Core 8 (Microsoft.EntityFrameworkCore.SqlServer),
ASP.NET Core Identity 8, Serilog (structured logging, file + SQL sinks), OpenTelemetry
(tracing/metrics), Microsoft.Data.SqlClient (bulk copy), xUnit + WebApplicationFactory
(testing). All established by SPEC-0003 and `library/08`/`library/11`.

**Storage**: SQL Server. Two databases involved:
- **Legacy `VisaEntry`** — read-only source of truth; **never modified** (FR-008,
  AC-006). Offline during the migration window (clarification Q2).
- **Target `VisaFusion`** — the migrated schema with reconstructed PKs, FKs, and
  indexes (FR-003); created/populated by this feature.

**Testing**: xUnit across the existing three test projects (`tests/UnitTests`,
`tests/IntegrationTests`, `tests/FunctionalTests`); migration-specific tests run
against a disposable copy of the legacy schema (see `quickstart.md`).

**Target Platform**: Windows Server / SQL Server (same platform as the legacy app);
the migration tool runs as a console process on the operator's machine or a
maintenance host.

**Project Type**: Data migration tooling — a new console project
`VisaFusion.Migration` inside the existing `VisaFusion.sln` (see Project Structure),
plus EF Core migrations for the target schema. Not a web/API surface (spec §15).

**Performance Goals**: Full 52-table migration + validation completes in under
4 hours (NFR-002). Largest tables: `bighistory` 1.4M, `StatusHistory` 1.3M,
`sentmails` 553K, `invoicedetail` 358K, `PaxStatus` 359K, `entryDetails` 313K,
`Mainentry` 272K, `invoice` 271K rows. Batch copy + index strategy keeps memory
bounded and the target available (spec §13).

**Constraints**:
- Offline migration: legacy app stopped for the window; no concurrent-write
  reconciliation (clarification Q2).
- No business table dropped; only `dtproperties` and confirmed-empty/scratch tables
  (`country`, `Results`, `hits`, `adcount`) are excluded (BR-001).
- COND tables (`hotel`, `cab`, `paxhotel`, `paxCab`, `scheduler`, `priwork`,
  `subscriber`) are archived, not migrated, until owner confirmation (BR-004).
- All queries parameterized; no string-concatenated SQL (NFR-003).
- No secrets in source; credentials from configuration (NFR-004).
- Passwords hashed on import; never plaintext (BR-002).
- Legacy column names and types preserved; normalization is a separate module
  concern (spec Assumptions).

**Scale/Scope**: 52 tables, ~7.5M total rows across the migrated surface; 3 identity
sources merged into ASP.NET Core Identity; 1 machine-readable report (JSON) + human
summary (NFR-005).

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| # | Principle | Gate | Status |
|---|-----------|------|--------|
| I | Specification-First (SDD) | SPEC-0004 exists with all 24 required sections; status Draft with 5 recorded clarifications; no implementation before approval | PASS |
| II | Legacy as Source of Truth | Migration source is the live `VisaEntry` DB (verified 2026-08-06); disposition contract is `library/complete_migration_plan.md` §3; no invented business features; `database.sql` demo script explicitly rejected (confirmed drift) | PASS |
| III | Data Preservation & Integrity | No business table dropped (only `dtproperties` + confirmed-empty/scratch); legacy DB untouched and restorable; every step validated before/after (FR-009); reversible (AC-008) | PASS |
| IV | Traceability & Governance | Spec §24 traceability matrix maps every FR to DB/test/migration; ADR required for the migration-tooling decision (new project); Knowledge Graph updated after implementation | PASS |
| V | Quality, Delivery & No-Assumption | All 5 clarifications resolved (no open unknowns); automated tests mandatory (TS-001..TS-008); repo stays buildable; no invented behavior | PASS |

**Gate result**: PASS — no violations. No Complexity Tracking entries required.

**Post-design re-check (after Phase 1)**: PASS — `research.md`, `data-model.md`,
`contracts/`, and `quickstart.md` derive exclusively from the spec, the disposition
table (`library/complete_migration_plan.md` §3), and the live schema dump
(`findings/modernization_plan.md` §12). No invented business behavior; no business
table drops beyond BR-001; no secrets in artifacts; the one open item (CountryID
target reference) is recorded as a gap in `data-model.md` §4, not assumed.

## Project Structure

### Documentation (this feature)

```text
specs/004-data-model-migration/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
│   ├── migration-report.schema.json   # Machine-readable report contract (FR-007, NFR-005)
│   └── migration-cli.md               # Operator CLI contract (commands, exit codes)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
src/
├── VisaFusion.Migration/        # NEW console project (this feature)
│   ├── Program.cs               # CLI entry point (operator commands, exit codes)
│   ├── Commands/                # One command per migration step (validate, backup-check,
│   │                            #   copy, cleanse, identity, report)
│   ├── Copy/                    # Batch copy engine (SqlBulkCopy, ordered by FK dependency)
│   ├── Cleansing/               # Approved cleansing rules (FR-005) with sign-off flags
│   ├── Identity/                # Legacy identity import (first-source-wins, hashing)
│   ├── Validation/              # Row-count, checksum, RI validation (FR-009)
│   ├── Reporting/               # Migration report writer (JSON + human summary)
│   └── appsettings.json         # Connection strings (legacy read-only, target write)
├── VisaFusion.Data/             # EXISTING — target DbContext + entities + EF migrations
│   └── Persistence/
│       ├── VisaEntryDbContext.cs        # EXISTING (scaffolding) — extended to full model
│       ├── Entities/                     # EXISTING 14 entities + new entities per data-model.md
│       └── Migrations/                   # EF Core migrations for the target schema
├── VisaFusion.Identity/          # EXISTING — ASP.NET Core Identity stores
├── VisaFusion.Core/              # EXISTING — domain services (unchanged by this feature)
├── VisaFusion.Web/               # EXISTING — host (unchanged by this feature)
├── VisaFusion.Api/               # EXISTING — /api/v1 (unchanged by this feature)
└── VisaFusion.Jobs/              # EXISTING — workers (unchanged by this feature)

tests/
├── UnitTests/                    # EXISTING — cleansing-rule and identity-dedup unit tests
├── IntegrationTests/             # EXISTING — migration step tests against disposable schema
└── FunctionalTests/              # EXISTING — end-to-end migration + report tests
```

**Structure Decision**: The migration is a one-shot operator process, not a runtime
surface, so it lives in a dedicated console project `VisaFusion.Migration` (new) that
references `VisaFusion.Data` (target DbContext/entities) and `VisaFusion.Identity`
(hashing). The target schema is defined by EF Core migrations in `VisaFusion.Data`
(the `__EFMigrationsHistory` table is the standard tooling artifact, spec §16). No
changes to Web/Api/Core/Jobs runtime behavior. This mirrors the SPEC-0003 decision
that the six §2 projects are the physical projects; the migration tool is an
additional operator-side project justified by the feature itself (FR-004/FR-007/FR-009).

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

No constitution violations — the gate passed. The new `VisaFusion.Migration` project
is a feature deliverable (the operator-run migration process), not a complexity
addition; it is documented in the Structure Decision above.