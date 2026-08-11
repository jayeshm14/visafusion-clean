# Traceability Matrix — VisaFusion Baseline

Generated: 2026-08-06 | Source: SPEC-0001, ADR-0001, knowledge-graph/kg.json

## Requirement → Artifact Map

| Requirement | Architecture | Domain | Database | API | UI | Test | Migration |
|-------------|--------------|--------|----------|-----|----|------|-----------|
| FR-001 Business rules | ADR-0001 | CTX-Visa, CTX-Agent, CTX-Billing, CTX-Notify, CTX-Report | Mainentry, bighistory, StatusHistory, PaxStatus, invoice | /api/v1 | Razor Pages | Golden-file regression suite | MIG-0001 |
| FR-002 Data preservation | ADR-0001 | Persistence | All 52 tables | — | — | Row-count integrity tests | MIG-0001 |
| FR-003 RBAC | ADR-0001 | CTX-Identity | AspNetUsers, AspNetRoles | /api/v1/auth | All pages | Authorization tests | MIG-0001 |
| FR-004 Agent identity | ADR-0001 | CTX-Identity, CTX-Agent | Agents | /api/v1/auth | Agent views | Auth tests | MIG-0001 |
| FR-005 Notifications | ADR-0001 | CTX-Notify | sentmails | /api/v1/notify | Admin UI | Integration tests | MIG-0001 |
| FR-006 Reporting | ADR-0001 | CTX-Report | Views | /api/v1/reports | Report pages | Regression tests | MIG-0001 |
| FR-007 Security hardening | ADR-0001 | CTX-Identity | — | all | all | Security tests | — |
| FR-008 KG & traceability | ADR-0001 | KG | — | — | — | Traceability checks | — |

## Module → Legacy Mapping

| Module | Legacy pages | Knowledge Graph node |
|--------|--------------|----------------------|
| Visa Processing | insertEntry.asp, listforagents.asp | MOD-001 |
| Agent Management | topAgent.asp | MOD-002 |
| Billing | invoice.asp | MOD-003 |
| Notifications | SendSMS.asp | MOD-004 |
| Reporting | report pages | MOD-005 |
| Identity & Security | connection.asp | MOD-006 |

## Outstanding decisions (owner decisions, from findings/modernization_plan.md)

- 10 documented risk items require owner approval before migration of affected modules.
- Data-quality defects (6,517 orphaned Mainentry→agent, `entrytype` 100% NULL, empty
  `country`, junk dates, duplicated `statusID=508`) are flagged, not silently dropped.

## Update rule

This matrix MUST be updated after every completed task, in the same change as the
Knowledge Graph update, per constitution principle IV and `library/04` sync rules.

---

## SPEC-0001-AIENV — AI Environment Validation (governance/validation feature)

Generated: 2026-08-06 | Source: `specs/001-ai-environment-validation/spec.md`, ADR-0002

| Requirement | Architecture | Domain | Database | API | UI | Test | Migration |
|-------------|--------------|--------|----------|-----|----|------|-----------|
| FR-001 Check 12 integrations | ADR-0002, `library/04,05,06,07,08,11` | Integration registry | — | summary.json (v1) | report.md | Pester: registry/detection | — |
| FR-002 Traceability matrix | ADR-0002 | Integration | — | summary.json | report.md | Pester: matrix render | — |
| FR-003 Flag gaps | ADR-0002 | Status classifier | — | summary.json | Gap Report | Pester: partial/missing/contradictory | — |
| FR-004 Provenance | ADR-0002 | Integration | — | summary.json | report.md | Pester: provenance | — |
| FR-005 Repeatable dated result | ADR-0002 | ValidationResult | — | summary.json | report.md | Pester: determinism/exit code | — |
| FR-006 CI + on-demand | ADR-0002, `.github/workflows/ai-environment-validation.yml` | — | — | — | — | Pester: equivalence/ReportOnly | — |
| FR-007 Report artifacts | ADR-0002 | — | — | summary.json | report.md | Pester: contract | — |
| FR-008 CI trigger | `.github/workflows/ai-environment-validation.yml` | — | — | — | — | Pester: workflow | — |

### Module → Legacy Mapping (this feature)

This is a cross-cutting governance feature with no legacy page mapping (spec §8);
it does not alter legacy business behavior (Constitution Principle II).

---

## SPEC-0002 — Repository Inventory (governance/analysis feature)

Generated: 2026-08-06 | Source: `specs/002-repository-inventory/spec.md`

| Requirement | Architecture | Domain | Database | API | UI | Test | Migration |
|-------------|--------------|--------|----------|-----|----|------|-----------|
| FR-001 Directory + root file inventory | spec §4/§18 | repo structure | — | — | `reports/repository-inventory/01-repository-inventory.md` | TS-001 (10/10 files) | — |
| FR-002 Technology inventory | spec §6 | tech registry | — | — | `reports/repository-inventory/02-technology-inventory.md` | C-001/C-002 | — |
| FR-003 Dependency graph | spec §7 | dep edges | — | — | `reports/repository-inventory/03-dependency-graph.md` | C-002 | — |
| FR-004 Project structure | spec §8 | structure registry | — | — | `reports/repository-inventory/04-project-structure.md` | TS-001 | — |
| FR-005 Legacy module map | spec §9 | legacy modules (MOD-001..006) | — | — | `reports/repository-inventory/05-legacy-inventory.md` | TS-004 (findings §3.5/§3.6) | — |
| FR-006 External dependencies | spec §10 | external registry | — | — | `reports/repository-inventory/06-external-dependencies.md` | TS-005 (no secrets) | — |
| FR-007 COM dependencies | spec §11 | COM registry | — | — | `reports/repository-inventory/07-com-dependencies.md` | C-002 | — |
| FR-008 Config + security flags | spec §12 | config registry | — | — | `reports/repository-inventory/08-configuration-inventory.md` | TS-005 (no secret values) | — |
| FR-009 README + discrepancies | spec §5 | — | — | — | `reports/repository-inventory/README.md`, `discrepancies.md` | TS-001, C-003 (0 TODO) | — |
| FR-010 Deterministic, reviewable | NFR-001 | — | — | — | all category docs | TS-002/TS-003, T037 | — |

### Module → Legacy Mapping (this feature)

Documentation-only feature: `INV-Legacy` documents legacy modules MOD-001..MOD-006;
`INV-Config` documents the SEC-Backdoor finding. No legacy business behavior
changes (Constitution Principle II). Deliverable location fixed by spec §5 as
`reports/repository-inventory/` (CHK004 remediation).

---

## SPEC-0004 — Complete Data Model Migration

Generated: 2026-08-09 | Source: `specs/004-data-model-migration/spec.md`, plan.md,
research.md, data-model.md, contracts/, tasks.md (54 tasks)

| Requirement | Architecture | Domain | Database | API | UI | Test | Migration |
|-------------|--------------|--------|----------|-----|----|------|-----------|
| FR-001 52-table disposition | MIG-Plan | data-model §3 | DB-VisaFusion | — | — | TS-001 (T023, T041) | MIG-0001 |
| FR-002 verbatim preservation | MIG-Plan | data-model §6 | DB-VisaFusion | — | — | TS-001 (T023) | MIG-0001 |
| FR-003 PK/FK/index reconstruction | MIG-Plan | data-model §2/§4 | DB-VisaFusion | — | — | TS-002 (T020, T041) | MIG-0001 |
| FR-004 identity import (hashed) | MIG-Plan | data-model §5 | AspNetUsers | — | — | TS-003 (T037, T041) | MIG-0001 |
| FR-005 cleansing rules (a-d) | MIG-Plan | data-model §6 | DB-VisaFusion | — | — | TS-004/TS-005 (T028-T035) | MIG-0001 |
| FR-005a copy-time dedupe (status 508) | MIG-Plan | data-model §6, CopyTransform | DB-VisaFusion | — | — | T035, CopyTests | MIG-0001 |
| FR-011 duplicate-key guard | MIG-Plan | data-model §3.1, DuplicateKeyGuard | DB-VisaFusion | — | — | CopyTests (GAP-0002) | MIG-0001 |
| FR-006 append-only audit | MIG-Plan | data-model §7 | StatusHistory, bighistory, sentmails, smshistory | — | — | TS-006 (T024, T027) | MIG-0001 |
| FR-007 migration report | MIG-Plan | contracts/migration-report.schema.json | — | MIG-Report | — | TS-001 (T042, T045) | MIG-0001 |
| FR-008 legacy untouched | MIG-Plan | — | VisaEntry (read-only) | — | — | TS-007 (T048) | MIG-0001 |
| FR-009 validation | MIG-Plan | data-model §8 | DB-VisaFusion | — | — | TS-001..TS-008 (T041, T043) | MIG-0001 |
| NFR-002 4-hour window | MIG-Plan | — | — | — | — | T053 | MIG-0001 |
| BR-001 no business drop | MIG-Plan | data-model §3.5 | DB-VisaFusion | — | — | T054 | MIG-0001 |
| BR-002 hashed passwords | MIG-Plan | data-model §5 | AspNetUsers | — | — | TS-003 (T039) | MIG-0001 |
| BR-004 COND archived | MIG-Plan | data-model §3.3 | DB-VisaFusion | — | — | — | MIG-0001 |
| BR-005 sign-off gating | MIG-Plan | data-model §6 | — | — | — | T035 | MIG-0001 |
| fixed-order step guard (§2, exit 1) | MIG-Plan | StepRunner.EnsureRequestedStepIsRunnable | DB-VisaFusion (run state) | — | — | StepRunnerPredecessorTests (TS-008) | MIG-0001 |

### Module → Legacy Mapping (this feature)

Migration-only feature: reads the legacy `VisaEntry` database (52 tables, read-only)
and writes the target `VisaFusion` database. No legacy page behavior changes
(Constitution Principle II). Blocking decisions recorded: CountryID target reference
(data-model.md §4), COND-table owner confirmations, `invoice`/`invoicedetail`
disposition (migration plan §12). ADR-0003 (migration tooling) accepted 2026-08-10 (T052).

### Resolved defects (2026-08-10, full-suite verification of the 16 spec'd test files)

1. **`ChecksumSql` CONCAT_WS single-column defect**: tables with exactly one
   non-identity column (`Attestation`, `certificate`, `cab`, `hotel`) generated
   `CONCAT_WS('|', col)` — 2 arguments, which SQL Server rejects (requires 3–254).
   Fixed by padding with a constant `N''` so the expression is always valid and the
   source/target comparison stays deterministic. Regressions caught by 4
   `ValidationTests` integration tests.
2. **`TableCatalog` COND `TargetTable` null**: the 7 COND tables (`hotel`, `cab`,
   `paxhotel`, `paxCab`, `scheduler`, `priwork`, `subscriber`) had
   `TargetTable: null`, but `schema` creates them (data-model.md §3.3, BR-004) —
   verified live. `TargetTable` set for all 7 (target names match legacy); copy
   still skips Cond disposition explicitly. Caught by
   `SchemaTests.Catalog_Has_38_Target_Tables` (38 = 26 M + 5 MRO + 7 COND).

### Resolved defect — silent exit-2 on out-of-order `--step` (2026-08-09)

Found during DoD deep verification: requesting `--step validate|cleanse|identity`
before `copy` completed exited 2 (StepFailure) with **no log output**. Root cause:
`Program.cs` registered Serilog with `AddLogging(dispose: true)`; the StepRunner
predecessor check threw `PreflightException` outside its try block, and during stack
unwinding the `using` provider disposed the shared static `Log.Logger` before
Program.cs's `catch` ran `Log.Fatal` — so the exception was swallowed.
Fix: (1) `AddLogging(dispose: false)` so the outer catch/finally stays authoritative
(NFR-006); (2) extracted the pure `StepRunner.EnsureRequestedStepIsRunnable` guard
into the try block so out-of-order/unknown steps raise `PreflightException` → exit 1
with a precise message (contract §2, §4). Regression tests:
`tests/UnitTests/StepRunnerPredecessorTests.cs` (TS-008).

### Open gap — GAP-0001 (FK map vs live data, 2026-08-09)

Verified against the live `VisaEntry` database: 14 of the 27 FK relationships in
`data-model.md` §4 cannot be enforced (sentinel `0` values with no lookup row, or
orphaned references). Disposition recorded in `findings/gap-0001-fk-validity.md`;
the DbContext omits the DEFER-ed FK constraints (indexes retained) and marks the
two FK principal indexes (`Entry.Refno`, `Invoice.Invoiceno`) unique (verified).
Requires owner confirmation of the DEFER disposition (gap §4).

### Open gap — GAP-0002 (legacy `agents.agentsID` duplicate, 2026-08-09)

Verified against the live `VisaEntry` database: `agents.agentsID = 4114` has two
rows (populated `CUSTOMER-UDAAN` profile + all-NULL ghost row). `agentsID` is an
identity column in legacy, so the ghost row required explicit `IDENTITY_INSERT`
and is not reproducible by application flow. No approved cleansing rule covers
it; the copy step's `DuplicateKeyGuard` fails fast (exit 2) before writing any
row. Owner decision required (recommended: keep populated profile, drop ghost).
See `findings/gap-0002-agents-duplicate.md`.

### Resolved gap — GAP-0003 (target database strategy, 2026-08-11)

Owner decision (Option A): confirm the separate `VisaFusion` target database per
ADR-0003 / SPEC-0004; "in-place" means the same SQL Server instance — the legacy
`VisaEntry` database stays read-only (FR-008) and is never written to. Recorded
in `findings/gap-0003-inplace-vs-target-db.md`; constitution v1.3.1 and
ADR-0001 (Amendment 2026-08-11) reflect the clarification.
