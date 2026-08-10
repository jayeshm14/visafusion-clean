# Feature Specification: Complete Data Model Migration

**Identifier**: SPEC-0004
**Title**: Complete Data Model Migration — all 52 tables
**Status**: Accepted
**Created**: 2026-08-09
**Accepted**: 2026-08-10 (implementation complete; DoD verification `reports/migration/dod-verification-feature-004.md`; end-to-end run still gated on GAP-0002 owner decision + pre-migration backup, §21/§22)
**Category**: migration
**Input**: User description: "Complete Data Model Migration — all 52 tables"

> This template is the VisaFusion override of the SpecKit `spec-template`.
> It is resolved first by the Spec Kit template stack (`.specify/templates/overrides/`)
> and MUST contain the 24 required sections defined in `library/03_SpecKit_SDD_Framework.md` §4.
> Do not remove or reorder the 24 numbered sections below.

## 1. Identifier

- **SPEC-0004**: Complete Data Model Migration

## 2. Title

Complete Data Model Migration — all 52 tables

## 3. Objective

Migrate the complete legacy `VisaEntry` database surface — all 52 tables — into the
VisaFusion target data model with **zero data loss**, reconstructed referential
integrity, and the per-table disposition defined in `library/complete_migration_plan.md`
§3. This feature delivers the production data foundation every module feature
(entry, status, billing, notifications, reporting, identity) builds on: the target
schema is fully populated, validated, and reversible, and the legacy database is
preserved untouched as the source of truth until cutover is confirmed.

## 4. Business Context

The legacy Classic ASP application has operated for 25 years on a SQL Server
`VisaEntry` database with **52 tables, 0 foreign keys, and only 2 primary keys**
(`findings/exiting_architecture.md` §2). Data integrity is enforced only by
application logic, which is applied inconsistently across 585 ASP pages. The
result is orphaned rows (6,517 `Mainentry` rows reference missing agents),
duplicate lookup values (`statusID=508` has two descriptions), dead modules
(`Ledger` with 26,563/26,565 NULL `transdate`), and junk dates.

The modernization cannot succeed on this foundation: the target application
requires foreign keys, primary keys, indexes, and clean reference data to enforce
the business rules the legacy app applied inconsistently. This feature performs
the one-time, validated migration of all production data into the target schema,
fixing only the data-quality issues that have explicit business sign-off and
preserving everything else byte-for-byte.

## 5. Scope

- Migrate **all 52 legacy tables** to the target schema per the disposition table
  in `library/complete_migration_plan.md` §3 (M, M-RO, COND, ARCH, DROP).
- Reconstruct referential integrity: primary keys, foreign keys, and indexes on
  the target tables (the legacy schema has none).
- Apply the approved data-cleansing rules (duplicate `statusID=508`, `entrytype`
  NULL default, orphaned `Mainentry` agent references, junk dates) **only where
  business sign-off exists**; everything else is migrated verbatim.
- Migrate the three legacy identity sources (`Udaan_users`, `registration`,
  `agents`) into the target identity stores with **passwords hashed on import,
  never re-stored in plaintext**.
- Provide a reversible migration: the legacy database remains untouched and
  restorable; every migration step is validated before and after.
- Produce a migration report: per-table row counts before/after, cleansing
  actions applied, and validation results.

## 6. Out of Scope

- **No new business features** — this feature migrates data only; module
  functionality is implemented in the module feature specs.
- **No UI changes** — no pages, forms, or workflows are built here.
- **No API changes** — the `/api/v1` surface is unchanged by this feature.
- **No schema redesign beyond integrity reconstruction** — column names and
  types are carried over; renaming/reshaping is a separate decision.
- **COND-disposition tables** (`hotel`, `cab`, `paxhotel`, `paxCab`,
  `scheduler`, `priwork`, `subscriber`) are migrated only after the owner
  confirms active use; until then they are archived, not dropped.
- **Dropping business tables** — only `dtproperties` (SQL Server system table)
  and confirmed-empty/scratch tables (`country`, `Results`, `hits`, `adcount`)
  are not migrated; no business table is dropped.
- **The legacy database is not modified** — it remains the source of truth
  until cutover.

## 7. Stakeholders

- **Back-office staff (Employee/Admin)**: rely on the migrated data being
  complete and correct for daily visa processing.
- **Agents**: rely on their account, entry, and status data being intact.
- **System owner / business owner**: must sign off on the data-cleansing rules
  and the COND-table decisions.
- **Development team**: consumes the migrated schema for all module features.
- **Auditors**: rely on the append-only audit tables (`StatusHistory`,
  `bighistory`, `sentmails`, `smshistory`) being migrated without alteration.

## 8. Legacy Mapping

The migration source is the live `VisaEntry` SQL Server database (52 tables,
verified 2026-08-06). The authoritative table inventory and dispositions are:

- `findings/modernization_plan.md` §12 Appendix A — full 52-table column dump.
- `library/complete_migration_plan.md` §3 — per-table disposition (M / M-RO /
  COND / ARCH / DROP) with row counts and basis.
- `findings/deepanalysis.md` §4 — data-quality issues and cleansing rules.
- `findings/exiting_architecture.md` §2 — schema findings (0 FKs, 2 PKs,
  20 identity columns).

The legacy pages that read/write these tables are catalogued in
`findings/modernization_plan.md` §6 (module map) and §13 (file inventory);
this feature does not change any page behavior.

## 9. Functional Requirements

- **FR-001**: The system MUST migrate all 52 legacy tables into the target
  schema, with each table's disposition (M / M-RO / COND / ARCH / DROP) applied
  exactly as defined in `library/complete_migration_plan.md` §3. Empty tables
  (0 rows) are migrated with their full target schema (PK, FK, indexes) and
  reported with zero row counts; DROP-disposition tables are excluded
  regardless of row count.
- **FR-002**: The system MUST preserve every migrated row's data values
  verbatim, except where an approved cleansing rule applies (FR-005). No
  retention limits or masking are applied during migration; personal data is
  preserved in full. Oversized or overflow values (e.g., `invoice.grandtotal`
  = 4.5×10¹⁴, `library/complete_migration_plan.md` §12 #6) are migrated
  verbatim where the target column type can represent them; where a value
  cannot be represented in the target column type, it is quarantined as a
  data-quality exception, reported in the migration report as a discrepancy,
  and never automatically repaired.
- **FR-003**: The system MUST reconstruct primary keys, foreign keys, and
  indexes on the target schema so that referential integrity is enforced.
  Primary keys use the existing identity column where one exists; a surrogate
  `Id` (bigint identity) key is added only where no identity column exists.
  Existing key values are preserved.
- **FR-004**: The system MUST migrate the three legacy identity sources
  (`Udaan_users`, `registration`, `agents`) into the target identity store,
  hashing passwords on import and never re-storing plaintext. Duplicate
  usernames/emails across sources are resolved first-source-wins in the
  priority order `agents` → `registration` → `Udaan_users`; skipped duplicates
  are listed in the migration report.
- **FR-005**: The system MUST apply the approved data-cleansing rules:
  (a) resolve the `statusID=508` duplicate description, (b) default the
  100%-NULL `Mainentry.entrytype`, (c) migrate the 6,517 orphaned `Mainentry`
  agent references with a NULL agent reference and flag them in the migration
  report for business follow-up, (d) clamp junk dates (values outside the
  documented data span 2001-12-02 → 2026-04-21, e.g., 1970/2207) to the nearest
  valid boundary — each only with business sign-off (operator + approver + date)
  recorded in the migration report.
- **FR-006**: The system MUST preserve the append-only audit tables
  (`StatusHistory`, `bighistory`, `sentmails`, `smshistory`) without
  alteration, deletion, or reordering.
- **FR-007**: The system MUST produce a migration report listing, per table:
  source row count, target row count, cleansing actions applied, and any
  discrepancies.
- **FR-008**: The system MUST keep the legacy database untouched and
  restorable throughout the migration; every step is reversible.
- **FR-009**: The system MUST validate the migrated data before and after each
  migration step (row counts, deterministic per-table checksums — e.g., SQL
  Server CHECKSUM_BINARY over the migrated rows — and referential integrity
  checks).

## 10. Business Rules

- **BR-001**: No business table is ever dropped; only `dtproperties` (system)
  and confirmed-empty/scratch tables are excluded from migration.
- **BR-002**: Passwords are hashed on import; plaintext passwords are never
  stored in the target system.
- **BR-003**: The append-only nature of audit tables is preserved — no
  UPDATE/DELETE on migrated audit rows.
- **BR-004**: COND-disposition tables are archived, not migrated, until the
  owner confirms active use. If an owner confirmation arrives after the
  migration has started, the table remains archived for the current run; the
  confirmation is recorded in the migration report and the table is migrated
  in a subsequent run (NFR-001 idempotent re-run).
- **BR-005**: Data-cleansing rules apply only where business sign-off exists;
  all other values are preserved verbatim.

## 11. Non-functional Requirements

- **NFR-001**: The migration MUST be repeatable and idempotent — re-running a
  completed step is a no-op or a documented, safe re-run. `preflight` verifies
  the target database is empty or in a known prior-run state (only
  `__EFMigrationsHistory` and run-state records present); a target that
  already contains migrated data aborts with a configuration error (exit
  code 5) until the operator explicitly confirms a clean re-run.
- **NFR-002**: The migration MUST complete within a maintenance window
  acceptable to the business (target: under 4 hours for the full 52-table
  surface, including validation). The legacy application is taken offline for
  the duration of the window; no concurrent writes are expected or
  reconciled. If the window is exceeded, the current step completes to its
  last validated checkpoint and the migration stops; the operator may resume
  from the checkpoint or restore the target from the pre-migration backup
  (AC-008).
- **NFR-003**: All migration queries are parameterized; no string-concatenated
  SQL.
- **NFR-004**: No secrets (connection strings, passwords) are committed to
  source; migration credentials come from configuration.
- **NFR-005**: The migration produces a machine-readable report (JSON) plus a
  human-readable summary.
- **NFR-006**: The migration is observable: progress, row counts, and errors
  are logged and traceable.

## 12. Security

- Passwords are hashed on import (never plaintext).
- Migration runs with least-privilege credentials; the migration account has
  read on the legacy database and write on the target database only.
- No anonymous access to migration tooling; migration runs are initiated by
  authorized operators only.
- The migration report contains no secrets or personal data beyond what the
  business requires for sign-off.

## 13. Performance

- The migration must handle the largest tables (`bighistory` 1.4M rows,
  `StatusHistory` 1.3M rows, `PaxStatus` 359K rows, `entryDetails` 313K rows,
  `Mainentry` 272K rows) without exhausting memory or blocking the target
  database for other workloads.
- Batch sizes and index strategy must keep the migration within the
  maintenance window (NFR-002).
- Validation queries (row counts, checksums) must complete within the window.

## 14. UI Requirements

- No user-facing UI is built by this feature.
- The migration report is the operator-facing deliverable (see FR-007).

## 15. API Contracts

- No API changes. The migration is an operator-run process, not an API
  surface.

## 16. Database Changes

- **Target schema**: the migrated tables with reconstructed primary keys,
  foreign keys, and indexes.
- **Legacy schema**: untouched (source of truth until cutover). The legacy
  application is stopped for the migration window (offline migration), so the
  legacy database is a static snapshot during the run.
- **Migration artifacts**: staging tables/views used for validation are
  removed after the migration completes; the `__EFMigrationsHistory` table is
  the standard tooling artifact.
- **Reversibility**: every step has a documented rollback (restore from the
  pre-migration backup).

## 17. Validation Rules

- Row counts match per table (source vs target).
- Checksums match for migrated tables (excluding approved cleansing).
- Referential integrity checks pass (no orphaned foreign keys in the target).
- The duplicate `statusID=508` is resolved to a single description.
- The 6,517 orphaned `Mainentry` agent references are migrated with a NULL agent
  reference and flagged in the migration report.
- Identity users import with hashed passwords; no plaintext remains.
- The target identity store has no duplicate usernames or emails; skipped
  duplicates are listed in the migration report.

## 18. Error Handling

- Migration failures are logged with the failing table, step, and row context.
- A failed step rolls back to the last validated checkpoint; the migration
  never leaves the target in a partially-validated state.
- Discrepancies between source and target are reported, not silently
  corrected.
- The migration aborts (fail-fast) on integrity violations rather than
  continuing with bad data.
- The CLI never exits silently (ADR-0004): an out-of-order or unknown
  `--step` raises `PreflightException` → exit 1 with a precise message
  (`StepRunner.EnsureRequestedStepIsRunnable`, contracts/migration-cli.md §2/§4);
  the static Serilog logger remains usable in the top-level catch/finally
  (`AddLogging(dispose: false)`) so every failure path is observable (NFR-006).

## 19. Audit Requirements

- The migration report records, per table: source count, target count,
  cleansing actions, and operator who ran the step.
- The migration log is retained for audit; it is append-only.
- The append-only audit tables (`StatusHistory`, `bighistory`, `sentmails`,
  `smshistory`) are migrated without alteration (FR-006).

## 20. Acceptance Criteria

- **AC-001**: All 52 tables are accounted for in the migration report with
  their disposition applied exactly as defined in
  `library/complete_migration_plan.md` §3.
- **AC-002**: Every migrated table has matching source and target row counts
  (except approved cleansing, which is documented).
- **AC-003**: The target schema enforces referential integrity: no orphaned
  foreign keys, and every table has a primary key.
- **AC-004**: No plaintext password exists in the target identity store; all
  imported passwords are hashed.
- **AC-005**: The duplicate `statusID=508` is resolved; the 100%-NULL
  `Mainentry.entrytype` is defaulted; the 6,517 orphaned entries are migrated
  with a NULL agent reference and flagged in the report; junk dates are
  clamped.
- **AC-006**: The legacy database is byte-identical to its pre-migration
  state (untouched).
- **AC-007**: The migration report is complete, machine-readable, and
  reproducible.
- **AC-008**: The migration is reversible: a restore from the pre-migration
  backup returns the target to its pre-migration state.

## 21. Risks

- **Data loss** (highest): mitigated by the untouched legacy source, the
  pre-migration backup, and per-step validation (FR-009).
- **Cleansing errors**: mitigated by business sign-off on every cleansing rule
  and a documented, reversible application.
- **COND-table decisions**: unresolved owner confirmations block only the
  COND tables; the rest of the migration proceeds (BR-004).
- **Migration window overrun**: mitigated by batching and index strategy
  (NFR-002).
- **Identity import errors**: mitigated by hashing on import and validating
  the imported users against the source.

## 22. Dependencies

- **SPEC-0003 (Target Architecture)**: the target schema, DbContext, and
  Identity integration point are established there.
- **Business owner sign-off**: required for the data-cleansing rules (FR-005)
  and the COND-table decisions (BR-004).
- **Pre-migration backup**: a full backup of the legacy database is taken
  before any migration step.
- **Findings**: `findings/modernization_plan.md` §12 (schema), §3
  (disposition), `findings/deepanalysis.md` §4 (data quality).

## 23. Test Scenarios

- **TS-001**: Full migration of all 52 tables completes; row counts match.
- **TS-002**: Referential integrity is enforced on the target (no orphans).
- **TS-003**: Identity import produces hashed passwords; no plaintext.
- **TS-004**: The duplicate `statusID=508` is resolved to one description.
- **TS-005**: The 6,517 orphaned entries are migrated with a NULL agent reference
  and flagged in the report.
- **TS-006**: The append-only audit tables are byte-identical after
  migration.
- **TS-007**: A restore from the pre-migration backup reproduces the target
  state (reversibility).
- **TS-008**: Re-running a completed migration step is a no-op (idempotency).
- **TS-009**: The migration report is produced, validates against
  `contracts/migration-report.schema.json`, and is reproducible (AC-007).

## 24. Traceability Matrix

| Requirement | Architecture | Domain | Database | API | UI | Test | Migration |
|-------------|--------------|--------|----------|-----|----|------|-----------|
| FR-001      |              |        | X        |     |    | TS-001 | X |
| FR-002      |              |        | X        |     |    | TS-001 | X |
| FR-003      |              |        | X        |     |    | TS-002 | X |
| FR-004      |              |        | X        |     |    | TS-003 | X |
| FR-005      |              |        | X        |     |    | TS-004, TS-005 | X |
| FR-006      |              |        | X        |     |    | TS-006 | X |
| FR-007      |              |        |          |     |    | TS-001, TS-009 | X |
| FR-008      |              |        | X        |     |    | TS-007 | X |
| FR-009      |              |        | X        |     |    | TS-001..TS-008 | X |

## Assumptions

- The legacy `VisaEntry` database is the authoritative source; the
  `database.sql` demo script is **not** used as the baseline (confirmed drift,
  `findings/modernization_plan.md` §4.7).
- The disposition table in `library/complete_migration_plan.md` §3 is the
  binding contract for per-table disposition.
- Business sign-off for the cleansing rules (FR-005) and COND decisions
  (BR-004) is obtained before the corresponding migration steps run.
- The migration runs in a maintenance window with a pre-migration backup.
- The target schema preserves legacy column names and types; normalization is
  a separate module concern.

## Clarifications

### Session 2026-08-09

- Q: Which tables require business sign-off before migration? → A: The COND
  tables (`hotel`, `cab`, `paxhotel`, `paxCab`, `scheduler`, `priwork`,
  `subscriber`) and the cleansing rules (FR-005). These are collected as
  blocking decisions in `library/complete_migration_plan.md` §12.
- Q: How should the 6,517 orphaned `Mainentry` rows (agent references a
  non-existent agent) be handled? → A: **Option B (Flag)** — migrate the rows
  with a NULL agent reference and list them in the migration report for
  business follow-up. This preserves all data (FR-002), keeps the `agent`
  foreign key enforceable (FR-003), and does not block the migration. Accepted
  by default on operator continuation (2026-08-09).
- Q: Is the legacy application taken offline during the migration window, or
  does it continue accepting writes? → A: **Option A (Offline)** — the legacy
  app is stopped for the migration window; a static snapshot is migrated. This
  makes the migration a deterministic snapshot-to-target copy with no
  concurrent-write reconciliation (2026-08-09).
- Q: How should duplicate usernames/emails across the three legacy identity
  sources (`Udaan_users`, `registration`, `agents`) be resolved? → A:
  **Option A (First-source-wins)** — import in priority order `agents` →
  `registration` → `Udaan_users`; the first occurrence wins, later duplicates
  are skipped and listed in the migration report for business follow-up
  (2026-08-09).
- Q: How should primary keys be reconstructed for the ~50 tables without one?
  → A: **Option A (Identity-first with surrogate fallback)** — use the
  existing identity column as the PK where one exists; add a surrogate `Id`
  (bigint identity) key only where no identity column exists. Existing key
  values are preserved (no re-keying of referenced data) (2026-08-09).
- Q: Does the target require any data-retention or masking treatment for the
  25 years of personal data, or is everything preserved verbatim? → A:
  **Option A (Preserve everything verbatim)** — no retention limits or masking
  applied during migration; any future retention policy is a separate, governed
  decision after cutover (2026-08-09).
- Q: What is the target reference for the `CountryID` columns
  (`PaxCountryStatus.CountryID`, `StatusHistoryEntry.CountryID`,
  `PaxAttestation.CountryID`, `Holiday.countryID`, `VisaInfo.countryID`) given
  the legacy `country` table is empty and dropped? → A: **Open — blocking
  decision.** The country concept lives in `CountryInfo`/`embassy`; the mapping
  must be confirmed by the business owner before T013 (FK configuration). Not
  resolved; recorded as a gap in `data-model.md` §4 (2026-08-09).

### Gap Resolutions (2026-08-09, checklist CHK028/029/031/037/039)

Resolved during the `/speckit.implement` requirements-quality gate. Each gap
was closed in the requirements above; no business behavior was invented:

- **CHK028 (COND confirmation after start)**: BR-004 now states the table
  remains archived for the current run, the confirmation is recorded in the
  report, and the table is migrated in a subsequent idempotent run.
- **CHK029 (window overrun)**: NFR-002 now states the current step completes
  to its last validated checkpoint and the migration stops; the operator may
  resume or restore (AC-008).
- **CHK031 (target pre-populated)**: NFR-001 now requires `preflight` to
  verify the target is empty or in a known prior-run state; a pre-populated
  target aborts with exit code 5 until a clean re-run is confirmed.
- **CHK037 (empty tables)**: FR-001 now requires empty tables to be migrated
  with their full target schema and reported with zero row counts.
- **CHK039 (oversized/overflow values)**: FR-002 now requires oversized values
  to be migrated verbatim where representable, otherwise quarantined and
  reported as a discrepancy — never automatically repaired.

### Gap GAP-0001 (FK map vs live data, 2026-08-09)

FK map in data-model.md §4 verified against the live `VisaEntry` database. 14 of
27 relationships cannot be enforced (sentinel `0` with no lookup row, or orphaned
references); no cleansing rule beyond FR-005 a–d was approved for them. Per the
deterministic rule, data is preserved verbatim and the DEFER disposition is
applied: column + index kept, FK constraint omitted, relationship recorded in the
migration report `deferredForeignKeys` section. Evidence and owner-decision
request in `findings/gap-0001-fk-validity.md`. Owning business decision required
(gap §4) before release of this feature.

### Gap GAP-0002 (legacy `agents.agentsID` duplicate, 2026-08-09)

The live `VisaEntry.agents` table holds two rows with `agentsID = 4114`
(a fully populated `CUSTOMER-UDAAN` profile plus an all-NULL ghost row carrying
the same key). `agentsID` is an identity column, so the ghost row required an
explicit `IDENTITY_INSERT` and is not reproducible by application flow. No
approved cleansing rule covers it, so the copy step's `DuplicateKeyGuard` fails
fast (exit 2) with a precise gap message before any row is written — the
deterministic "never guess" path (library/01). Owner decision required
(Option A recommended: keep the populated profile, drop the ghost row).
Evidence and decision request in `findings/gap-0002-agents-duplicate.md`.