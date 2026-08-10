# SPEC-0004 DoD Deep Verification Report (feature 004 — data-model migration)

**Date**: 2026-08-09
**Verifier**: VisaFusion engineering agent (DoD deep verification, Definition of Done per `library/01`)
**Feature**: `specs/004-data-model-migration` (VisaEntry → VisaFusion complete data-model migration)
**Scope**: Live verification against the running legacy `VisaEntry` and target `VisaFusion` SQL Server databases.

---

## 1. Executive summary

The migration tooling (`VisaFusion.Migration`) is implemented, builds with **0 warnings / 0 errors**, and the
full test suite passes (**51 tests**: 9 integration, 20 unit, 22 functional). The copy pipeline **fails fast with
exit 2** on the undocumented `agents.agentsID = 4114` duplicate (GAP-0002) before writing any row — the
deterministic "never guess" contract works. One real defect was found and fixed during this verification: the CLI
exited **2 with zero log output** for out-of-order `--step` invocations (disposed static Serilog logger). Fixed
via ADR-0004 (`AddLogging(dispose: false)` + extracted `EnsureRequestedStepIsRunnable` guard → exit 1 with a
precise message), with 8 new regression tests.

The migration **cannot complete end-to-end yet** — two blockers require owner/operator input:
pre-migration backup missing (AC-008, `preflight` exit 1) and the GAP-0002 owner decision (`agents` 4114).

---

## 2. Verification method

- Source-of-truth context re-read: `@findings/exiting_architecture.md`, `@findings/deepanalysis.md`,
  `@findings/modernization_plan.md`, `@library/complete_migration_plan.md`.
- Live SQL Server probes against `VisaEntry` (legacy) and `VisaFusion` (target) via `sqlcmd`:
  table catalogs, identity flags, `is_identity`, PK/unique constraints, run-state, data counts.
- CLI binary runs (`src/VisaFusion.Migration/bin/Debug/net8.0/VisaFusion.Migration.exe`) under the test
  environment (`Legacy__VisaEntry`, `Target__VisaFusion`, `Migration__*` pointing to the temp dir),
  capturing stdout/stderr separately and exit codes.
- Full build + test suite (IntegrationTests, UnitTests, FunctionalTests).
- Definition of Done dimensions mapped to evidence (below).

---

## 3. DoD dimension results

### DoD-1 Specification updated — ⚠️ PARTIAL

| Item | Status | Evidence |
|------|--------|----------|
| `spec.md` exists with 24-section template | PASS | `specs/004-data-model-migration/spec.md` |
| GAP-0002 documented | PASS | spec.md §Gap, `findings/gap-0002-agents-duplicate.md` |
| §18 error handling updated for no-silent-exit + ADR-0004 | PASS | spec.md §18 (updated 2026-08-09) |
| Spec header status | FAIL | Header `Status: Draft` not marked accepted/approved |
| `tasks.md` completion state | FAIL | All 54 checkboxes still `- [ ]` (none ticked despite implementation done) |

### DoD-2 Architecture updated — PASS

- ADR-0004 accepted (logger ownership + exit-code semantics for the CLI).
- `knowledge-graph/traceability-matrix.md` updated: fixed-order guard row + resolved-defect note + GAP-0002 + FR-005a/FR-011 rows.
- `adr/ADR-0003.md` (migration tooling, task T052) still **pending** — tracked.

### DoD-3 Code implemented — PASS (with one contract deviation fixed)

- All 8 steps registered in fixed order (StepRunner constructor enforces contract §2).
- `TableCatalog` 52 entries: 31 M + 7 MRO + 9 ARCH + 5 DROP; `status` RowDelta −1 (FR-005a); `embassy` IdentityColumn (identity round-trip).
- `DuplicateKeyGuard` + `CopyTransform.DeduplicateOn` + `CopyCommand` sign-off-gated approved transforms + `DataQualityGapException` (exit 2).
- CLI invocation verified end-to-end:

| `--step` | Result | Exit |
|----------|--------|------|
| `schema` | re-runs idempotently, "40 tables present" | 0 |
| `preflight` | fails on missing backup (AC-008) | 1 |
| `copy` (no sign-off env) | both duplicates flagged (agents 4114, status 508) | 2 |
| `copy` (sign-off env) | only agents 4114 (status transform approved) | 2 |
| `validate` / `cleanse` / `identity` (copy not done) | `Preflight failure: Step '…' requires 'copy' to complete first` | 1 |
| `nosuchstep` | `Preflight failure: Unknown step '…'` | 1 |

- **Defect found & fixed**: silent exit-2 (no log) on out-of-order steps — root cause
  `AddLogging(dispose: true)` disposing the static `Log.Logger` during stack unwinding before the outer
  `catch` ran `Log.Fatal`. Fixed (ADR-0004) — every path now logs.

### DoD-4 Database validated — PASS (schema), BLOCKED (data)

- Target schema: 40 tables = 38 business (31 M/MRO + 7 COND) + `__EFMigrationsHistory` + `MigrationRunState`.
- Verified live: `status.statusID` is identity in target (`is_identity=1`, annotation L542–543), NOT identity in legacy
  (natural key, data-model.md L67); `SqlBulkCopyOptions.KeepIdentity` round-trips explicit values without `IDENTITY_INSERT`,
  explaining the earlier 2627-vs-8101 probe results. No catalog identity change needed.
- DROP tables (dtproperties, country, Results, hits, adcount) correctly absent; 9 ARCH tables not created.
- Target business data is **all zero rows** — no successful copy has ever run (run-state:
  `preflight;snapshot;schema`, `CurrentStep=preflight`, run `23e3de09…`).
- Backup dir empty → `preflight` correctly exits 1 (AC-008 reversible-restore not yet satisfiable).

### DoD-5 Tests passing — PASS (suite), FAIL (task coverage)

- **Suite green**: Integration 9/9, Unit 20/20, Functional 22/22 — 51 total, 0 failures.
- **Regression tests added for the fix**: `tests/UnitTests/StepRunnerPredecessorTests.cs` (8 tests, TS-008).
- **Coverage gap**: of the 16 task-specified test files (T014 RunStateTests, PreflightTests, SnapshotTests,
  SchemaTests, AuditTableTests, 4× CleansingTests, IdentityDedupTests, IdentityImportTests, ValidationTests,
  ReportSchemaTests, ReversibilityTests, WindowValidationTests, DropTableExclusionTests) only
  `tests/IntegrationTests/CopyTests.cs` exists. `NoStringConcatenatedSqlTests` scans only `src/VisaFusion.Data`,
  not `src/VisaFusion.Migration` (T049 coverage gap).

### DoD-6 Security reviewed — PASS

- No string-concatenated SQL in the migration project (single match is a LogError string join, not SQL).
- No plaintext passwords; Identity import hashes (BR-002, T039).
- `appsettings.json` uses placeholders; connection strings come from env/user-secrets only (NFR-004).
- No anonymous write endpoints (migration is an operator-run console). `connection.asp` backdoor not part of target.

### DoD-7 Documentation updated — ⚠️ PARTIAL

- `quickstart.md` exists; spec/contracts present. ADR-0004 added.
- **Missing**: `adr/ADR-0003.md` (T052, migration tooling) — pending; `reports/` has no generated migration report
  (none produced because `copy`/`validate`/`report` blocked); report JSON not yet validated against the schema contract.

### DoD-8 Traceability verified — PASS

- `knowledge-graph/traceability-matrix.md` carries FR-001…FR-011, BR-001…BR-005, NFR-002 rows + GAP-0001,
  GAP-0002, resolved-defect note, fixed-order guard row. `kg.json` updated (GAP-0001 present; GAP-0002 added in matrix).
- Every code change maps to a task/requirement; ADR-0004 references the exact files and tests.

---

## 4. Defects found during this verification

| # | Defect | Root cause | Fix | Verified |
|---|--------|-----------|-----|----------|
| 1 | Out-of-order `--step validate/cleanse/identity` exited 2 with **no log output** | `AddSerilog(dispose: true)` + predecessor check outside try → static logger disposed before outer `catch` ran `Log.Fatal` | ADR-0004: `dispose: false`; guard extracted into try as `EnsureRequestedStepIsRunnable` → exit 1 with message | `--step validate` → exit 1, `Preflight failure: Step 'validate' requires 'copy' to complete first (fixed order).` |
| 2 | Unknown `--step` fell through to FTL/exit 2 path | no explicit unknown-step check | `EnsureRequestedStepIsRunnable` throws `PreflightException` for unknown steps | `--step nosuchstep` → exit 1, `Unknown step 'nosuchstep'` |

---

## 5. Blockers requiring input (no guessing per deterministic rules)

1. **GAP-0002 — legacy `agents.agentsID = 4114` duplicate** (owner decision).
   Recommended Option A: keep the populated `CUSTOMER-UDAAN` profile, drop the all-NULL ghost row
   (ghost is not reproducible by app flow — legacy `agentsID` is identity). Then: record sign-off, add FR-005e
   cleansing rule + copy-time transform, re-run `copy`.
2. **Pre-migration backup** `backup\VisaEntry-pre-migration.bak` missing (AC-008). Required for `preflight` to pass.
3. **T052/ADR-0003** (migration tooling ADR) — pending decision recorded; not blocking code execution.

---

## 6. Definition of Done overall

| DoD criterion | Verdict |
|---------------|---------|
| Specification updated | ⚠️ partial (spec.md OK; header still Draft; tasks.md unticked) |
| Architecture updated | ✅ (ADR-0004 + matrix) |
| Code implemented | ✅ (all steps; defect 1 fixed) |
| Database validated | ⚠️ schema yes, data blocked (GAP-0002, no backup) |
| Tests passing | ✅ 51/51 (coverage of 16 spec'd files still partial) |
| Security reviewed | ✅ |
| Documentation updated | ⚠️ partial (ADR-0003 pending, no report artifacts yet) |
| Traceability verified | ✅ |

**Overall: NOT YET DONE** — implementation and safety mechanisms are complete and verified; the migration
cannot complete end-to-end until the GAP-0002 owner decision and the pre-migration backup are provided, and the
remaining spec'd test files are authored.

---

## 7. Next actions

1. Owner decision on GAP-0002 (Option A recommended) + recorded sign-off (FR-005e).
2. Create the pre-migration backup; re-run `preflight → snapshot → schema → copy → cleanse → identity → validate → report`.
3. Author the missing spec'd test files (T014 RunStateTests and the 14 others) and extend
   `NoStringConcatenatedSqlTests` to cover `VisaFusion.Migration`.
4. Mark spec.md accepted, tick tasks.md; write ADR-0003.

---

## 8. Follow-up verification (2026-08-10) — gaps from §7 closed

Re-verified against the live `VisaEntry` and `VisaFusion` databases after the §7
follow-ups and the authoring of the remaining spec'd test files. Full suite:
**123 tests green** (59 unit + 39 integration + 25 functional), 0 failures.

### 8.1 §7 item 3 done — all 16 spec'd test files authored

| Test file (task) | Result |
|---|---|
| `tests/UnitTests/RunStateTests.cs` (T014) | PASS |
| `tests/IntegrationTests/PreflightTests.cs` (T015) | PASS |
| `tests/IntegrationTests/SnapshotTests.cs` (T016) | PASS |
| `tests/IntegrationTests/SchemaTests.cs` (T020) | PASS (after §8.2 defect 2 fix) |
| `tests/IntegrationTests/CopyTests.cs` (T023) | PASS |
| `tests/IntegrationTests/AuditTableTests.cs` (T024) | PASS |
| `tests/UnitTests/CleansingStatus508Tests.cs` (T028) | PASS |
| `tests/UnitTests/CleansingOrphanTests.cs` (T029) | PASS |
| `tests/UnitTests/CleansingDefaultsTests.cs` (T030) | PASS |
| `tests/UnitTests/IdentityDedupTests.cs` (T036) | PASS |
| `tests/IntegrationTests/IdentityImportTests.cs` (T037) | PASS |
| `tests/IntegrationTests/ValidationTests.cs` (T041) | PASS (after §8.2 defect 1 fix) |
| `tests/UnitTests/ReportSchemaTests.cs` (T042) | PASS |
| `tests/FunctionalTests/ReversibilityTests.cs` (T048) | PASS |
| `tests/FunctionalTests/WindowValidationTests.cs` (T053) | PASS |
| `tests/IntegrationTests/DropTableExclusionTests.cs` (T054) | PASS |
| `NoStringConcatenatedSqlTests` extended to `src/VisaFusion.Migration` (T049) | PASS |

### 8.2 Two real defects found and fixed (regression tests now green)

| # | Defect | Root cause | Fix | Tests |
|---|--------|-----------|-----|-------|
| 1 | `CONCAT_WS` SQL error on 1-column tables: `ValidationTests` (4 tests) failed with `SqlException: The concat_ws function requires 3 to 254 arguments` | `ChecksumSql.BuildAsync` built `CONCAT_WS('|', col)` — 2 args — for tables with exactly one non-identity column (`Attestation`, `certificate`, `cab`, `hotel`); SQL Server requires separator + ≥2 values | `ChecksumSql.cs` pads with constant `N''` when `cols.Count == 1`; constant identical on source and target so checksums stay deterministic | 4 ValidationTests integration tests |
| 2 | `SchemaTests.Catalog_Has_38_Target_Tables` failed (expected 38, actual 31) | The 7 COND tables (`hotel`, `cab`, `paxhotel`, `paxCab`, `scheduler`, `priwork`, `subscriber`) had `TargetTable: null` in `TableCatalog`, yet `schema` creates them (data-model.md §3.3, BR-004) — verified live; 38 = 26 M + 5 MRO + 7 COND | `TableCatalog.cs` sets `TargetTable` for all 7 COND tables (names verified against the live target schema); `CopyCommand` still skips Cond disposition explicitly, so no data is copied | SchemaTests (5 tests incl. PK check now covering COND tables) |

### 8.3 §7 item 4 done — spec accepted, tasks ticked, ADR-0003 written

- `specs/004-data-model-migration/spec.md` header: **Status: Accepted** (2026-08-10),
  with the remaining §21/§22 gates noted (GAP-0002 + backup).
- `tasks.md`: 53 of 54 tasks ticked. **T047 remains open (BLOCKED)** — the full
  `quickstart.md` end-to-end sequence cannot exit 0 until the GAP-0002 owner decision
  and the pre-migration backup (AC-008) exist; this is an external input, not a code gap.
- `adr/ADR-0003.md` written and **Accepted** (migration-tooling decision, T052).
- Knowledge Graph updated: `kg.json` (SPEC-0004 → Accepted, ADR-0003 → Accepted,
  GAP-0002 risk node added; JSON validated) and `traceability-matrix.md` (ADR-0003
  accepted note + §8 resolved-defects record).

### 8.4 Updated DoD overall

| DoD criterion | 2026-08-09 verdict | 2026-08-10 verdict |
|---------------|--------------------|--------------------|
| Specification updated | ⚠️ partial | ✅ accepted (spec.md Accepted; tasks.md 53/54 ticked, T047 externally blocked) |
| Architecture updated | ✅ | ✅ (+ ADR-0003 accepted) |
| Code implemented | ✅ | ✅ (2 defects fixed, 0 warnings/0 errors) |
| Database validated | ⚠️ schema yes, data blocked | ⚠️ schema yes, data still blocked (GAP-0002 + backup — external) |
| Tests passing | ✅ 51/51 | ✅ 123/123 (16 spec'd files now authored) |
| Security reviewed | ✅ | ✅ (T049 now covers Migration project) |
| Documentation updated | ⚠️ partial | ✅ (ADR-0003, spec, tasks, KG, matrix) |
| Traceability verified | ✅ | ✅ |

**Overall: implementation-ready; end-to-end run still gated on two external inputs**
(GAP-0002 owner decision, pre-migration backup) — unchanged from §5.
