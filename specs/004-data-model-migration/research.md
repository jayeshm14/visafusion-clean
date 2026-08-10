# Research: Complete Data Model Migration (SPEC-0004)

**Date**: 2026-08-09 | **Spec**: [SPEC-0004](spec.md)
**Sources**: `library/complete_migration_plan.md` §3/§6/§7/§12, `findings/modernization_plan.md`
§12 (Appendix A schema dump), `findings/deepanalysis.md` §4 (data quality),
`findings/exiting_architecture.md` §2 (schema findings), SPEC-0003 (target
architecture), `.specify/memory/constitution.md` v1.2.0.

All `NEEDS CLARIFICATION` items from the plan's Technical Context were resolved in the
spec's Clarifications section (session 2026-08-09, 5 answers). No unresolved unknowns
remain. This document records the technical decisions and their rationale.

---

## 1. Migration Tooling

- **Decision**: A new console project `VisaFusion.Migration` inside `VisaFusion.sln`,
  referencing `VisaFusion.Data` (target DbContext/entities) and `VisaFusion.Identity`
  (password hashing). One command per migration step; EF Core migrations define the
  target schema.
- **Rationale**: The migration is an operator-run, one-time process (spec §15 — not an
  API surface). A console tool gives deterministic, auditable, scriptable steps with
  explicit exit codes, and reuses the existing target DbContext and Identity hashing
  rather than duplicating them. EF Core migrations are the standard tooling artifact
  (spec §16) and give the target schema a versioned, reversible definition.
- **Alternatives considered**:
  - SSIS/SSDT packages — rejected: external tooling outside the fixed stack, harder to
    version in the repo, and not parameterized-by-default in the same way.
  - Pure T-SQL script — rejected: violates the "no string-concatenated SQL" and
    testability standards; no structured report generation.
  - In-place migration of the legacy `VisaEntry` database — rejected: violates FR-008
    (legacy untouched) and the offline-snapshot decision (clarification Q2).

## 2. Target Database

- **Decision**: A separate target database `VisaFusion` (new), populated from the
  legacy `VisaEntry` snapshot. The legacy database is never written to.
- **Rationale**: FR-008/AC-006 require the legacy database to remain byte-identical
  and restorable until cutover; a separate target makes reversibility (AC-008) a
  restore of the target, not a repair of the source. SPEC-0003 already wires the
  solution to the `VisaEntry` database; this feature adds the `VisaFusion` target
  database as the migrated destination.
- **Alternatives considered**: In-place remediation of `VisaEntry` — rejected (violates
  FR-008; no reversibility without destructive restore).

## 3. Offline Snapshot Strategy

- **Decision**: The legacy application is stopped for the maintenance window; the
  migration copies a static snapshot (clarification Q2, NFR-002).
- **Rationale**: Eliminates change-data-capture and concurrent-write reconciliation
  entirely; validation (FR-009) compares two static states, so row counts and
  checksums are deterministic.
- **Alternatives considered**: Online migration with CDC — rejected (complexity, risk,
  and no requirement for zero-downtime migration); hybrid offline+reconciliation —
  rejected (no benefit once the app is stopped).

## 4. Primary Key Reconstruction

- **Decision**: Identity-first with surrogate fallback (clarification Q4, FR-003):
  use the existing identity column as the PK where one exists; add a surrogate `Id`
  (bigint identity) key only where no identity column exists. Existing key values are
  preserved.
- **Rationale**: Preserves existing key values so referenced data is not re-keyed
  (e.g., `Mainentry.id`, `entryDetails.PaxID`, `agents.agentsID`), keeps the migration
  deterministic, and gives every table a PK as AC-003 requires.
- **Identity columns identified from the live schema dump** (`modernization_plan.md`
  §12): `agents.agentsID`, `bighistory.bighistoryid`, `embassy.EmbassyID`,
  `entryDetails.PaxID`, `Ledger.id`, `Mainentry.id`, `newagents.newagentsID`,
  `priwork.id`, `registration.registID`, `scheduler.messageid`, `sentawb.id`,
  `sentmails.id`, `subscriber.id`, `diary.ID`, `dtproperties.id`, `adcount.adcountid`.
  All other migrated tables receive a surrogate `Id` key.
- **Alternatives considered**: Natural keys everywhere — rejected (many tables have no
  reliable natural key, e.g., `security` keyed on `date1`); surrogate everywhere —
  rejected (would re-key referenced data and break value preservation, FR-002).

## 5. Foreign Key Reconstruction

- **Decision**: FKs are added on the target for the relationships the legacy app
  actually enforces in code, per the module map (`findings/modernization_plan.md` §6)
  and the target entity relationships in `data-model.md`. Orphaned rows are handled by
  the approved cleansing rules (FR-005) so FK enforcement succeeds.
- **Rationale**: FR-003 requires referential integrity on the target; the legacy has 0
  FKs, so the FK set is derived from documented relationships (e.g.,
  `entryDetails.refno → Mainentry.refno`, `PaxStatus.refno → Mainentry.refno`,
  `Mainentry.agent → agents.agentsID`). The 6,517 orphaned `Mainentry.agent` rows are
  migrated with NULL agent (clarification Q1) so the FK remains enforceable.
- **Alternatives considered**: FK on every plausible column pair — rejected (would
  invent relationships the legacy never had); no FKs — rejected (violates FR-003/AC-003).

## 6. Identity Import

- **Decision**: Import `agents` → `registration` → `Udaan_users` in that priority
  order into ASP.NET Core Identity; first-source-wins on duplicate usernames/emails;
  passwords hashed on import (never plaintext); skipped duplicates listed in the
  report (clarification Q3, FR-004, BR-002).
- **Rationale**: The three sources have no cross-source uniqueness; the priority order
  puts the most authoritative source (`agents`, the business partner table) first.
  Hashing on import satisfies BR-002/AC-004. `Udaan_users` privilege values map to
  Identity roles (`su`/`adm`/`emp`/`agt`) per SPEC-0003 data-model.md §2.
- **Alternatives considered**: Merge same-email records — rejected (no defined merge
  rule per attribute; risks inventing data); block on duplicates — rejected (would
  halt the migration on a data-quality issue better reported than resolved).

## 7. Cleansing Rules

- **Decision**: Apply exactly the four approved rules (FR-005), each gated by recorded
  business sign-off: (a) resolve the `statusID=508` duplicate description to a single
  value; (b) default the 100%-NULL `Mainentry.entrytype`; (c) migrate the 6,517
  orphaned `Mainentry.agent` rows with NULL agent and flag them in the report;
  (d) clamp junk dates (1970/2207 values in `Mainentry`). Everything else is migrated
  verbatim (FR-002).
- **Rationale**: These are the data-quality issues documented in
  `findings/deepanalysis.md` §4.3 with explicit business sign-off required (BR-005).
  The `statusID=508` duplicate is a lookup-table defect; the orphaned rows are handled
  per clarification Q1; junk dates are clamped to the documented valid range.
- **Alternatives considered**: No cleansing (verbatim only) — rejected: the duplicate
  `statusID` would break the `status` FK and the `statusID=508` acceptance criterion
  (AC-005); blocking on orphans — rejected (clarification Q1).

## 8. Validation Strategy

- **Decision**: Per-step validation (FR-009): source vs target row counts per table,
  checksums (excluding approved cleansing), and referential-integrity checks (no
  orphaned FKs in the target). Fail-fast on integrity violations (spec §18).
- **Rationale**: AC-002/AC-003/AC-006 require count, checksum, and RI parity; the
  offline snapshot makes these deterministic. Checksums exclude the four approved
  cleansing rules, which are documented per table in the report.
- **Alternatives considered**: Sample-based validation — rejected (does not prove
  zero data loss); validation only at the end — rejected (spec §18 requires
  checkpoint rollback, so validation must be per-step).

## 9. Batching and Performance

- **Decision**: Batch copy (SqlBulkCopy) with bounded batch sizes, ordered by FK
  dependency (parents before children), with indexes created after the bulk load for
  the largest tables. Target: full migration + validation under 4 hours (NFR-002).
- **Rationale**: The largest tables (`bighistory` 1.4M, `StatusHistory` 1.3M) must not
  exhaust memory or block the target (spec §13). Loading into heap tables then adding
  indexes is the standard high-volume pattern and keeps the window bounded.
- **Alternatives considered**: EF Core `AddRange` per row — rejected (too slow for
  multi-million-row tables); index-first load — rejected (index maintenance during
  bulk load slows the copy).

## 10. Migration Report

- **Decision**: A machine-readable JSON report (per-table source count, target count,
  cleansing actions, discrepancies, operator) plus a human-readable summary
  (FR-007, NFR-005). Schema defined in `contracts/migration-report.schema.json`.
- **Rationale**: AC-007 requires a complete, machine-readable, reproducible report;
  the JSON contract makes it consumable by tooling and auditors.
- **Alternatives considered**: Text-only report — rejected (not machine-readable,
  NFR-005); report embedded in the DB — rejected (report is an operator artifact, not
  business data).

## 11. Gate Evaluation

- **Constitution Check (pre-research)**: PASS — all five principles satisfied (see
  plan.md).
- **Constitution Check (post-design)**: PASS — data model, contracts, and quickstart
  derive from the spec, the disposition table, and the live schema only; no invented
  behavior, no business-table drops, no secrets in artifacts.

## Unresolved / Deferred

- COND-table owner confirmations (`hotel`, `cab`, `paxhotel`, `paxCab`, `scheduler`,
  `priwork`, `subscriber`): blocking decisions collected in
  `library/complete_migration_plan.md` §12; until confirmed, these tables are archived
  (BR-004) and the rest of the migration proceeds.
- `invoice`/`invoicedetail` disposition (M-RO vs M) depends on the owner's answer on
  whether billing continues (migration plan §12 #1); default is M-RO (pre-2009
  historical) per the disposition table.
- `masterbalance` and `newagents` usage confirmation (migration plan §12 #11): pending
  owner input; default dispositions (M / M-RO) apply.
- Post-cutover legacy database retention: a cutover-planning decision, out of scope
  for this feature (spec §6).