# Validation Report — SPEC-0006 Core Entry Workflow (T032)

**Date**: 2026-08-16 | **Spec**: [SPEC-0006](spec.md) | **Quickstart**:
[quickstart.md](quickstart.md) | **Environment**: local SQL Server (VivaanPC),
legacy `VisaEntry` read-only (bighistory 1,430,841 rows), target `VisaFusion`
(Mainentry 271,724 rows; PaxStatus 359,338; bighistory 0 rows)

## 1. Setup executed

| Step | Result |
|------|--------|
| `dotnet build VisaFusion.sln` | PASS |
| Scripts 01-08 applied to `VisaFusion` in order (sqlcmd, `-b`) | PASS — all 8 |
| Script 05 archive INSERTs | PASS — `LegacyEmailListArchive` 15 rows (emailid 15 + emaild1 0), `LegacyChangeLogArchive` 22 rows (changes 1 + changesbill 21) |
| Objects verified | PASS — 2 sequences, 1 scalar function, 9 stored procedures, 2 archive tables (see §4) |
| Identity import (`identity` step) | **BLOCKED** — GAP-0004 (98 oversized `agents.emailid` values; see §6) |

## 2. Automated test suites

| Suite | Result | Notes |
|-------|--------|-------|
| `tests/UnitTests` | 138/138 PASS | Entry aggregate invariants, HolidayService rule, refno allocation logic, **+4 `EntryAuditTests` (T040: create/update audit-row shape, `UpdatedBy` role precedence su>adm>emp>agt, unattributed actor rejected)** |
| `tests/FunctionalTests` | 135/135 PASS | Hermetic RBAC matrix, problem-details, optimistic concurrency, SQLi, secured-write routes |
| `tests/IntegrationTests` | 52/52 PASS | Stored-proc execution, atomicity, audit rows, snapshot/copy/validate, identity invariants — now exercised against the live DB (self-skip convention no longer masks them); **+1 `EntryAuditIntegrationTests` (T040: real-DB create/update `bighistory` rows, stale-write 409 writes no audit row)** |

## 3. Validation scenarios (quickstart §3)

| Scenario | Coverage | Result |
|----------|----------|--------|
| Refno allocation (AC-003) | `RefnoAllocationTests` (concurrent 50-call uniqueness) | PASS |
| Status change atomicity (AC-004) | `StatusChangeIntegrationTests` + direct happy-path run (synthetic PaxID, seeded actor, full cleanup) | PASS — `PaxStatus.statusID` updated, `StatusHistory` + `bighistory` written, `@NewStatusHistoryId` returned, `UpdatedBy` = `emp:t032-perf-user` (GR-0004 format) |
| Status change rollback | `StatusChangeIntegrationTests` (ghost refno → RAISERROR, no partial writes) | PASS |
| Bookable-date rule (AC-005) | `EmbassyClosedTests` + `HolidayService` unit tests | PASS — rule parity |
| Super-user provisioning (AC-006) | `SuperUserProvisioningTests` | PASS — su+adm roles, audit row, duplicate refused, non-su refused |
| Create entry (AC-007) | Functional tests (correct-role success paths) + `EntryAuditIntegrationTests` (real-DB create writes `bighistory` row) | PASS |
| Get entry | Functional tests (200/404) | PASS |
| Optimistic concurrency (AC-011) | Functional tests (stale → 409, fresh → 200) + `EntryAuditIntegrationTests` (real-DB stale If-Match → 409, no audit row) | PASS — **T040 defect fix: `UpdateAsync` now compares the caller's token explicitly (the previous EF-token-overwrite check was vacuous; deviation log T040 #4)** |
| Status endpoint | Functional tests (200 + 400 for bad status id) | PASS |
| Sent-AWB | Functional tests (204/404) | PASS |
| RBAC matrix (AC-008) | Functional tests (401/403/200-201-204) | PASS |
| Deferred superuser route | `SecuredWriteRoutesTests` (route absent → 404) | PASS |
| SQLi regression | Functional tests (raw `'` inputs) | PASS |
| Golden-file parity | Migration plan §10 — deferred to cutover (requires live-app side-by-side) | DEFERRED |

## 4. Performance assertions (spec §13, NFR-003/NFR-004)

Measured against the live `VisaFusion` database (2026-08-16, sqlcmd, `SYSDATETIME`
microsecond deltas):

| Target | Measured | Threshold | Result |
|--------|----------|-----------|--------|
| `usp_AllocateNextRefno` | 0.5 ms avg (20 calls) | < 50 ms | PASS |
| `usp_RecordEntryStatusChange` | 19 ms (single happy-path call, synthetic data) | < 100 ms | PASS |
| `fn_IsEmbassyClosed` | 1.8 ms avg (1,000 calls) | < 10 ms | PASS |
| API entry operations | Functional correctness PASS (135/135); live-app timing | < 500 ms | DEFERRED to cutover live-app validation |

## 5. Defect fixes applied during validation

| # | Defect | Fix | Verified |
|---|--------|-----|----------|
| 1 | `SnapshotTests` "Execution Timeout Expired" — the checksum query (full-table SHA2_256 scan) over bighistory ≈1.4M rows exceeded the 30s default command timeout | `LegacyReader.ScalarAsync` sets `CommandTimeout = 300` (`src/VisaFusion.Migration/Data/LegacyReader.cs`) | Integration suite re-run: 51/51 PASS |
| 2 | `IdentityImportTests.Target_Identity_Store_Has_No_Plaintext_Passwords` failed on `"x"` — `SuperUserProvisioningTests` seeded its acting-su/non-su fixtures with `PasswordHash = 'x'`, tripping the global no-plaintext invariant under xUnit parallel execution | Seed hash changed `'x'` → `NULL` (matches the invariant's own contract: PBKDF2 or NULL; the seeded users' hash is never asserted) | Integration suite re-run: 51/51 PASS |
| 3 | `ValidationTests` "Execution Timeout Expired" — `ChecksumSql.ExecuteStringAsync` and `ValidationEngine` commands (`TargetRowCountAsync`, `TargetChecksumAsync`, referential-integrity) used the 30s default; the `CommandTimeout = 300` fix covered only `LegacyReader.ScalarAsync` (snapshot path) | `CommandTimeout = 300` added to `ChecksumSql.ExecuteStringAsync` + the `ValidationEngine` command sites (`src/VisaFusion.Migration/Validation/ChecksumSql.cs`, `ValidationEngine.cs`) | Integration suite re-run 2026-08-17: 51/51 PASS |
| 4 | `Mainentry.rowversion` column missing from the target schema — every real-DB create/update failed with "Invalid column name 'rowversion'" (surfaced by `EntryAuditIntegrationTests`, T040) | New idempotent script `scripts/09_add_entry_rowversion.sql` adds the additive column (data-model.md §16, AC-011); applied to the target. `ChecksumSql` excludes value-generated `rowversion`/`timestamp` columns from the copy-verification checksum (no copied legacy data — same rationale as the identity-column exclusion) so `ValidationTests`' byte-identical contract stays intact | Integration suite re-run 2026-08-17: 52/52 PASS |
| 5 | `UpdateAsync`'s AC-011 concurrency check was vacuous — `entry.RowVersion = expectedRowVersion` made EF's UPDATE WHERE compare the current rowversion against itself, so a stale If-Match never produced 409 (surfaced by `EntryAuditIntegrationTests` stale-write assertion, T040) | Explicit `SequenceEqual` comparison of the caller's token against the freshly-loaded value, throwing `EntryConflictException` before any mutation; EF's `DbUpdateConcurrencyException` catch retained as the race-window net | Integration suite re-run 2026-08-17: 52/52 PASS |

## 6. Blocked items

- **GAP-0004 — Identity import**: 98 of 4,218 legacy `agents.emailid` values
  exceed the 256-char `AspNetUsers.Email` column (multi-email junk values); the
  `identity` step aborts with a truncation error. Partial state: `AspNetUsers`
  11, `AspNetRoles` 5, `AspNetUserRoles` 11. Full report with decision options:
  `findings/gap-0004-oversized-agent-emails.md`. **Blocked until owner decision**
  (recommended: skip + record, Option A).
- Identity-dependent validation that requires a role-bound user beyond the
  test-seeded fixtures (e.g. a real `su`/`adm`/`emp` login for live-app API
  scenarios) is deferred pending GAP-0004. The stored-proc scenarios above are
  unaffected (they seed and clean their own fixtures).

## 7. Environment notes

- The integration tests' self-skip convention (early `return` when a proc/table
  is missing) had silently reported "pass" without exercising the procs; with
  scripts 01-08 applied and the Identity schema present, the suite now runs
  against the live DB (52/52). Script 09 (`09_add_entry_rowversion.sql`) is
  applied to the target as part of T040.
- The `identity` step's partial import (11 agents) is a recovery hazard for a
  plain re-run (the importer's in-memory dedup does not consult the target);
  recovery must truncate the identity tables or make the importer idempotent
  (see GAP-0004 §3).