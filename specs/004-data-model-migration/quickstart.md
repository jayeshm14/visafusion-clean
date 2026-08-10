# Quickstart: Complete Data Model Migration (SPEC-0004)

**Date**: 2026-08-09 | **Spec**: [SPEC-0004](spec.md) | **CLI contract**:
[contracts/migration-cli.md](contracts/migration-cli.md) | **Data model**:
[data-model.md](data-model.md)

This guide validates the migration feature end-to-end. It is a **run/validation
guide** — implementation details live in `tasks.md` and the implementation phase.

## 1. Prerequisites

- SQL Server with the legacy `VisaEntry` database (live schema, verified 2026-08-06).
- .NET 8 SDK; the `VisaFusion.sln` solution builds (`dotnet build`).
- A pre-migration full backup of `VisaEntry` (spec §22) — required before any step.
- Business sign-off records for the cleansing rules (FR-005) and COND decisions
  (BR-004) — required before `cleanse` and before archiving COND tables.
- Configuration (connection strings, batch sizes) via `appsettings.json` / User
  Secrets — no secrets in source (NFR-004).

## 2. Setup

```text
dotnet restore
dotnet build VisaFusion.sln
```

Configure two connection strings (never committed):
- `Legacy:VisaEntry` — read-only access to the legacy database.
- `Target:VisaFusion` — write access to the target database.

## 3. Run the Migration (offline window)

The legacy application MUST be stopped for the window (NFR-002). Run the fixed
command sequence from [contracts/migration-cli.md](contracts/migration-cli.md) §2:

```bash
dotnet run --project src/VisaFusion.Migration -- preflight
dotnet run --project src/VisaFusion.Migration -- snapshot
dotnet run --project src/VisaFusion.Migration -- schema
dotnet run --project src/VisaFusion.Migration -- copy
dotnet run --project src/VisaFusion.Migration -- cleanse
dotnet run --project src/VisaFusion.Migration -- identity
dotnet run --project src/VisaFusion.Migration -- validate
dotnet run --project src/VisaFusion.Migration -- report
```

Each command exits `0` on success; non-zero exit codes are defined in the CLI
contract §4. A failed step rolls back to the last validated checkpoint (§18).

## 4. Validation Scenarios (map to spec TS-001..TS-008)

| Scenario | Command / check | Expected outcome |
|----------|-----------------|------------------|
| TS-001 Full migration | `validate` | All 52 tables accounted for; per-table source == target row counts (except documented cleansing); exit 0 |
| TS-002 Referential integrity | `validate` | No orphaned FKs; every target table has a PK (AC-003) |
| TS-003 Identity hashing | `validate` + query `AspNetUsers` | No plaintext password; all imported passwords hashed (AC-004) |
| TS-004 `statusID=508` | `validate` + query `Status` | Single description for `statusID=508` (AC-005) |
| TS-005 Orphaned entries | `validate` + query `Entry` | 6,517 orphaned rows have NULL agent; listed in report (AC-005) |
| TS-006 Append-only audit | `validate` + checksum | `StatusHistory`, `bighistory`, `sentmails`, `smshistory` byte-identical (FR-006) |
| TS-007 Reversibility | restore pre-migration backup | Target returns to pre-migration state (AC-008) |
| TS-008 Idempotency | re-run a completed step | No-op (NFR-001) |

## 5. Report Validation

- `reports/migration-<runId>.json` validates against
  [contracts/migration-report.schema.json](contracts/migration-report.schema.json)
  (FR-007, NFR-005).
- `reports/migration-<runId>.summary.md` is the human-readable summary.
- The report lists per table: source count, target count, cleansing actions, and
  discrepancies (spec §19).

## 6. Legacy Integrity Check

- After the run, verify the legacy `VisaEntry` database is byte-identical to the
  pre-migration backup (AC-006) — the migration never writes to it (FR-008).

## 7. Automated Tests

The existing test projects cover the migration rules:

```bash
dotnet test tests/UnitTests        # cleansing rules, identity dedup, PK strategy
dotnet test tests/IntegrationTests  # migration steps against a disposable schema copy
dotnet test tests/FunctionalTests   # end-to-end migration + report
```

All tests must pass before the feature is complete (constitution Principle V).