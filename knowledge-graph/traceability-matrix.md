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
