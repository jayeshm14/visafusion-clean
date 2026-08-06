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
