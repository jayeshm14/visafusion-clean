# Migration CLI Contract (SPEC-0004)

**Date**: 2026-08-09 | **Spec**: [SPEC-0004](../spec.md) | **Report schema**:
[migration-report.schema.json](migration-report.schema.json)

The migration is an **operator-run console process** (`VisaFusion.Migration`), not an
API surface (spec §15). This contract defines the operator-facing interface: commands,
ordering, exit codes, and outputs. It is the contract the implementation must satisfy
and the quickstart validates.

## 1. Invocation

```text
dotnet run --project src/VisaFusion.Migration -- <command> [options]
```

Configuration (connection strings, batch sizes, sign-off records) comes from
`appsettings.json` / environment / User Secrets — **no secrets in source** (NFR-004).

## 2. Commands (executed in order)

| # | Command | Purpose | Spec |
|---|---------|---------|------|
| 1 | `preflight` | Verify legacy DB reachable (read-only), target DB reachable (write), pre-migration backup exists, legacy app offline, sign-offs present | FR-008, NFR-002 |
| 2 | `snapshot` | Record the static snapshot baseline (row counts + checksums of all 52 tables) | FR-009 |
| 3 | `schema` | Apply EF Core migrations to create the target `VisaFusion` schema (PKs, FKs, indexes) | FR-003 |
| 4 | `copy` | Batch-copy migrated tables in FK-dependency order (parents first) | FR-001, FR-002 |
| 5 | `cleanse` | Apply the four approved cleansing rules (a–d), each gated by recorded sign-off | FR-005 |
| 6 | `identity` | Import `agents` → `registration` → `Udaan_users` into Identity, hashing passwords, first-source-wins dedup | FR-004 |
| 7 | `validate` | Row counts, checksums, referential-integrity checks; fail-fast on violations | FR-009, §18 |
| 8 | `report` | Write the migration report (JSON + human summary) | FR-007, NFR-005 |

**Ordering is fixed** and enforced by the runner: `preflight → snapshot → schema →
copy → cleanse → identity → validate → report`. A step may not run before its
predecessor completes successfully.

## 3. Idempotency (NFR-001)

- Re-running a completed step is a **no-op** (guarded by a run-state record in the
  target database) or a documented, safe re-run.
- `validate` and `report` are always safe to re-run.

## 4. Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success — all steps completed, validation passed, report written |
| 1 | Preflight failure (legacy unreachable, backup missing, app not stopped) |
| 2 | Step failure — rolled back to the last validated checkpoint (§18) |
| 3 | Validation failure — discrepancies found, reported, not corrected |
| 4 | Integrity violation — fail-fast abort (§18) |
| 5 | Configuration error (missing secrets/connection strings) |

## 5. Outputs

| Output | Format | Location |
|--------|--------|----------|
| Migration report | JSON (schema: `migration-report.schema.json`) | `reports/migration-<runId>.json` |
| Human summary | Markdown | `reports/migration-<runId>.summary.md` |
| Migration log | Structured (Serilog, file + SQL) | `logs/` + SQL sink (NFR-006) |

## 6. Validation Contract (FR-009)

Per step, and again at `validate`:

- **Row counts**: source vs target per table (AC-002).
- **Checksums**: match for migrated tables, excluding approved cleansing (documented
  per table).
- **Referential integrity**: no orphaned FKs in the target (AC-003).
- **Identity**: no plaintext passwords (AC-004); no duplicate usernames/emails;
  skipped duplicates listed in the report.
- **Legacy**: byte-identical to pre-migration state (AC-006).

## 7. Reversibility (AC-008)

- A full backup of the legacy database is taken before any step (spec §22).
- A failed step rolls back to the last validated checkpoint (§18).
- Restore from the pre-migration backup returns the target to its pre-migration state.