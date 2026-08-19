# Migration Baseline — VisaFusion

**Scope**: Read-only discovery (2026-08-19). Every claim verified this session
or cited verbatim from the live findings docs.

---

## 1. Governing migration plan

- `library/complete_migration_plan.md` — overall plan (52-table legacy schema,
  §4.2 role × module matrix, §12 external integrations).
- `findings/exiting_architecture.md`, `findings/deepanalysis.md`,
  `findings/modernization_plan.md` — live-verified legacy snapshots:
  585 root ASP files, 52-table SQL Server schema, module map
  (modernization_plan §6), legacy page list (§13), data-quality issues,
  security findings (incl. `connection.asp` backdoor).

## 2. Legacy database (read-only source `VisaEntry`)

Row counts verified this session:
- `Mainentry` 271,724 | `bighistory` 1,430,841 | `StatusHistory` 1,287,261
- `sentmails` 553,523 | `PaxStatus` 359,338 | `invoice` 271,239

Known data-quality defects (findings + traceability matrix): 6,517 orphaned
`Mainentry`→agent, `entrytype` 100% NULL, empty `country`, junk dates,
duplicated `statusID=508`. Flagged, not silently dropped.

## 3. New database (`VisaFusion`)

- EF Core with **4 migrations** in `src/VisaFusion.Data/Migrations` (9 files
  incl. `.Designer.cs` and model snapshot).
- `src/VisaFusion.Data/Persistence/`: `VisaEntryDbContext`,
  `VisaEntryDbContextFactory` + 3rd persistence file.
- **41 entity files** under `src/VisaFusion.Data/Persistence/Entities/`
  (corrected path — not `Entities/` at project root).
- Data-backed application services in `src/VisaFusion.Data/Application/`
  (6 files: e.g. `EntryService`, `SecurityGateService`, `HolidayService`,
  `SmsService`, `EmailService`, `UserManagementService`, `AgentService`).
- `VisaFusion.Data/Infrastructure/` (1 file).

## 4. Owner-supplied T-SQL (scripts, not EF)

`specs/004-data-model-migration/` and `specs/006-core-entry-workflow/` carry
owner-provided SQL scripts (01–09) including:
- `usp_AllocateNextRefno` (ref-number allocation)
- `fn_IsEmbassyClosed` (embassy-closure rule)
- report, cleansing, and normalization procedures.
These are invoked via parameterized commands — the deterministic bridge
between legacy procedures and EF-managed schema.

## 5. Module → legacy mapping (from `knowledge-graph/traceability-matrix.md`)

| Module | Legacy pages | KG node |
|---|---|---|
| Visa Processing | `insertEntry.asp`, `listforagents.asp` | MOD-001 |
| Agent Management | `topAgent.asp` | MOD-002 |
| Billing | `invoice.asp` | MOD-003 |
| Notifications | `SendSMS.asp` | MOD-004 |
| Reporting | report pages | MOD-005 |
| Identity & Security | `connection.asp` | MOD-006 |
| Public Site | `querieDetail.asp`, `contact.asp`, `register.asp` | MOD-007 |

## 6. ADRs driving migration tooling

- ADR-0003 — Migration as a dedicated console project (`VisaFusion.Migration`).
- ADR-0004 — Out-of-order migration steps fail fast with logged exit 1.
- ADR-0005 — New `emailQueue` table + data-backed notification services
  (SPECK-0008; `VisaFusion.Jobs` runs `EmailQueueWorker`/`SmsQueueWorker`).

## 7. Migration progress (release notes)

- `reports/release-notes/phase-1.md`, `phase-2.md` (2026-08-17) — phase-2
  covers SPEC-0007 public-site parity (US1–5) and AdminLTE removal (AC-008).
- Specs committed: SPEC-0001…0008 including 004-data-model-migration and
  006-core-entry-workflow.

## 8. Notifications / external integrations (status)

- New platform: data-backed `emailQueue`/`SmsQueue` with **log-only** dispatch
  providers (no live SMS/SMTP transport yet).
- Legacy integrations per complete_migration_plan §12: SMS provider (messaging
  4u) and SMTP (spectranet) — not yet re-implemented as live transports
  (GAP_REPORT GAP-008; owner decision pending per findings risk items).

## 9. Knowledge graph state

- `knowledge-graph/traceability-matrix.md` — 320 lines, requirement → artifact
  and module → legacy maps, update rule (must be updated with every task).
- `knowledge-graph/kg.json` — **committed file is invalid JSON**
  (unbalanced brackets; `ConvertFrom-Json` fails) → GAP_REPORT GAP-001.
