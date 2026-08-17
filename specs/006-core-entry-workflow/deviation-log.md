# Deviation Log — SPEC-0006

**Purpose**: Records every deliberate deviation from the plan/spec baseline
(plan.md "Constitution Check" gate V states "no new packages, no architectural
deviation" — this log is where the verified service-placement interpretation
and the reference-number type handling are recorded, per the traceability
principle). Each entry cites the task, the deviation, and the reason.

| # | Task | Deviation | Decision / Reason |
|---|------|-----------|-------------------|
| 1 | T009/T014/T017/T020 | `EntryService` and `HolidayService` implementations live in `src/VisaFusion.Data/Application/` (not `src/VisaFusion.Core/Application/`); DI registration moved to the Web composition root `src/VisaFusion.Web/Program.cs` | tasks.md/plan.md place the implementations in the Core application layer, but both services query `VisaEntryDbContext`/`Holiday`/`WeeklyOff`, and `VisaFusion.Core.csproj` has zero project references (Data → Core is one-way) — a Core → Data reference would be a cycle. Exact mirror of the approved SPEC-0005 deviation-log entry 5 (`SecurityGateService`): interfaces (`IEntryService`, `IHolidayService`) stay in Core (single-source rule); implementations move to Data; Core placeholder registrations removed from `CoreServiceCollectionExtensions.cs`; registration happens only at the composition root (FR-002). |
| 2 | T014 | `usp_AllocateNextRefno` returns `@NewRefno BIGINT`; `Entry.Refno` is `int` (data-model.md §2) — explicit conversion required | The stored procedure is owner-supplied and applied verbatim (no behavior may be invented, GR-0001), so its `BIGINT` output type is not negotiable. `Entry.Refno` is `int` per the verified data model (Mainentry.refno int, business key for `GET /api/v1/entries/{refno}`). `AllocateRefnoAsync` converts the proc result to `int`; the practical refno space (current data) is far below `int` range, so no truncation risk. Documented in T014. |
| 3 | T001 | Build passes; `dotnet test` functional suite fails with `InternalServerError` on JSON-success-path scenarios; `dotnet run` boot cannot be validated end-to-end | Environmental block: this machine has no SQL Server instance (no MSSQL services, no `sqlcmd`; only .NET 9 runtime installed, projects target net8.0 — tests run via `DOTNET_ROLL_FORWARD=LatestMajor`). Root cause of the 500s is a runtime mismatch, not SQL: `WriteAsJsonAsync` → `JsonTypeInfo.SerializeAsync(PipeWriter, …)` requires `PipeWriter.UnflushedBytes` (added in .NET 9), which the net8.0 `ResponseBodyPipeWriter` does not implement — every 200/201-with-JSON-body path 500s (login success, health, entries create/update), while 400/401/403/404 problem-details paths (which use `WriteAsync(string)`) pass. The pre-existing baseline failures (AuthLoginTests, ApiSurfaceTests, etc.) are this same block, not regressions from this feature. Entries functional tests: 35/42 pass hermetically (RBAC anonymous/wrong-role, error formats, SecuredWriteRoutesTests 8/8 after the three implemented entries rows were removed from the placeholder matrix); the 7 remaining failures (correct-role success paths, concurrency, status-id 400) all require a successful create (201 JSON body) and fail on the same runtime block — they validate at cutover on a real .NET 8 runtime. Integration tests self-skip (46/46 pass). Full functional/boot validation requires a reachable SQL Server per quickstart.md §1. |
| 4 | T027 | `complete_migration_plan.md` §5 (13 anonymous write endpoints) listed `agt` (own entries) for `POST /api/v1/entries/{refno}/awb`; the ratified contract (`contracts/entries-api.md` §5) and implementation restrict it to `emp`,`adm`,`su` | Legacy `sendawbgo.asp` is fully anonymous (one of the 13 anonymous write endpoints) with no agent-scoping — "own entries" is not grounded in legacy behavior. Restricting to `emp`,`adm`,`su` is the security-by-default translation (00_Constitution §3: anonymous write endpoints removed); agent self-service AWB is not implemented. Plan line 169 corrected to match the contract. |

*Log format: [#] [Task] — [Deviation] — [Decision/Reason]*

### Resolution of entry 3 (2026-08-16)

Entry 3's environmental block is **RESOLVED**: the .NET 8 runtime (8.0.20,
8.0.29, 8.0.30) is now installed on this machine, so the net8.0 host runs
natively (no `DOTNET_ROLL_FORWARD=LatestMajor`) and the
`PipeWriter.UnflushedBytes` mismatch no longer occurs. Full-suite verification
on 2026-08-16: `tests/UnitTests` 134/134, `tests/FunctionalTests` 135/135
(including the previously-blocked correct-role success paths, concurrency, and
status-id 400 scenarios), `tests/IntegrationTests` 51/51 against a live SQL
Server. One test-data defect found and fixed during the verification pass:
`EntriesRbacTests` used `NewStatusId = 2` (not a legacy status code,
deepanalysis.md §4.4) on the status success path — corrected to `101` (Dox
Received).

### GR-0001 pre-cutover verification sign-off (T033, 2026-08-16)

**Caveat closed.** Every `-- TODO: confirm column name` in the owner-supplied
scripts 01-08 was verified against the live `VisaFusion` schema
(`INFORMATION_SCHEMA.COLUMNS` via sqlcmd, T033) and the scripts updated to the
confirmed names. Verification results:

| Script | TODO | Verified resolution |
|--------|------|---------------------|
| 01 | `START WITH` seeds | `MAX(refno)=283630` → RefnoSeq `START WITH 283631`; `MAX(invoiceno)=366251` → InvoiceNumberSeq `START WITH 366252` (computed against live data) |
| 02 | holidaylist/weeklyoff columns | `holidaylist.countryID` (embassy id, NOT EmbassyID), `holidaylist.holiday` (date, NOT HolidayDate), `weeklyoff.embassyid`, `weeklyoff.weekend` (VBScript weekday 1=Sun..7=Sat, NOT DayOfWeek); `@@DATEFIRST=7` confirmed so `DATEPART(WEEKDAY,..)=1` = Sunday — matches authoritative `HolidayService` |
| 03 | report columns | `agents.agentsID/Description`, `status.statusID/Description`, `PaxStatus.CountryID/statusID/coldate/visafee`, `Mainentry.refno/subdate` all confirmed; **`Mainentry.agentid` corrected to `Mainentry.agent`** (4 places — owning-agent FK column is `agent`, same correction as GR-0004 in 07/08) |
| 04 | StatusHistory join + junk-date scope | **`StatusHistory` has no `refno`** — join corrected to `PaxID + CountryID + StatusID`; `sh.Date` confirmed; junk-date scan extended to `coldate`/`receivedate`/`sentDate` (defect confirmed present: 0/2/8 rows outside 1971..2100) |
| 05 | archive columns + FK templates | `emailid`/`emaild1`/`changes`/`changesbill` are dispositioned ARCH and **absent from VisaFusion** — archive INSERTs now read `VisaEntry.dbo.*` (legacy, read-only); column types confirmed `varchar(50)` → archive `NVARCHAR(50)`; FK templates corrected (`Mainentry.agent`, invalid `StatusHistory.refno` example removed — StatusHistory links via PaxStatus.PaxID) |
| 06 | StatusHistory/bighistory + Identity | StatusHistory = `Id/PaxID/Date/CountryID/StatusID/Remarks/UpdatedBy` (no refno/ChangedByUserId/Remark); bighistory = `bighistoryid/refno/agent/Date/UpdatedBy/Remarks`; draft INSERTs corrected; Identity schema confirmed standard (no naming customization — `VisaFusionIdentityDbContext` + `IdentityImporter.EnsureIdentitySchemaAsync`) |
| 07/08 | — | No TODO markers; 08 is authoritative (supersedes 06/07) |

**Remaining open items (NOT column-name TODOs — business decisions, Risk #8,
deliberately not invented):** script 04's statusID-508 split/relabel rule and
the orphan-agent resolution choice (match/placeholder/archive). These stay
open pending business sign-off; the procedures default to `@WhatIfOnly=1`
(quarantine/report only) until then.

**Environment note:** the target `VisaFusion` database had the legacy tables
copied (Mainentry 271,724 rows; PaxStatus 359,338) but the owner-supplied
scripts 01-08 and the Identity schema were NOT yet applied — the integration
tests' self-skip convention (early `return` when a proc is missing) had
silently reported "pass" without exercising the procs. Scripts 01-08 are
applied and the Identity import run as part of T032 (see validation report).

### GAP-0004 — Identity import blocked by oversized agent emails (2026-08-16)

The `identity` migration step aborts on 98 of 4,218 legacy `agents` rows whose
`emailid` exceeds the 256-char `AspNetUsers.Email` column (multi-email junk
values; no documented handling rule — `data-model.md` §5 says "direct copy").
Partial state left behind: `AspNetUsers` 11, `AspNetRoles` 5, `AspNetUserRoles`
11. Full report with decision options: `findings/gap-0004-oversized-agent-emails.md`.
**Blocked until owner decision** (recommended: skip + record, Option A). The
T032 scenarios that need a role-bound Identity user (`usp_RecordEntryStatusChange`
`@ActorUserId`, `usp_ProvisionSuperUser`) are deferred pending that decision;
all other T032 validation proceeds.

### T032 validation defect fixes (2026-08-16)

Two defects surfaced when the integration suite first ran against the live DB
(scripts 01-08 + Identity schema present; the self-skip convention had masked
them). Both fixed and verified (51/51 integration PASS):

| # | Defect | Fix |
|---|--------|-----|
| 1 | `SnapshotTests` "Execution Timeout Expired" — the checksum query (full-table SHA2_256 scan) over bighistory ≈1.4M rows exceeded the 30s default command timeout | `LegacyReader.ScalarAsync` sets `CommandTimeout = 300` (`src/VisaFusion.Migration/Data/LegacyReader.cs`) |
| 2 | `IdentityImportTests.Target_Identity_Store_Has_No_Plaintext_Passwords` failed on `"x"` — `SuperUserProvisioningTests` seeded its acting-su/non-su fixtures with `PasswordHash = 'x'`, tripping the global no-plaintext invariant under xUnit parallel execution | Seed hash changed `'x'` → `NULL` (matches the invariant's own contract: PBKDF2 or NULL; the seeded users' hash is never asserted) |
| 3 | `ValidationTests` "Execution Timeout Expired" — `ChecksumSql.ExecuteStringAsync` and `ValidationEngine` commands (`TargetRowCountAsync`, `TargetChecksumAsync`, referential-integrity) used the 30s default; the `CommandTimeout = 300` fix covered only `LegacyReader.ScalarAsync` (snapshot path) | `CommandTimeout = 300` added to `ChecksumSql.ExecuteStringAsync` + the `ValidationEngine` command sites (`src/VisaFusion.Migration/Validation/ChecksumSql.cs`, `ValidationEngine.cs`) | Integration suite re-run 2026-08-17: 51/51 PASS |

Measured §13 performance timings and the full scenario matrix are recorded in
`validation-report.md`.

### T040 — create/update audit rows + two defects surfaced by the audit integration test (2026-08-17)

T040 replicates the legacy create/update audit inserts (insertEntry.asp:233,
editEntrySubmit.asp:189) as `bighistory` rows written by
`EntryService.CreateAsync`/`UpdateAsync` (SPEC-0006 §19). Four documented
decisions and two defect fixes:

| # | Decision / Defect | Detail |
|---|-------------------|--------|
| 1 | PUT audit remark = the request's external remark | The modern `UpdateEntryRequest` (contracts/entries-api.md §3) has **no internal-remark field**; the legacy update path audited the internal remark (`internalrem`, editEntrySubmit.asp:189). The external remark (`command.Remarks`) is the closest available value; noted in the service comment. |
| 2 | Create audit Agent = NULL | The modern `CreateEntryRequest` has no agent field (legacy `request("agent")`); the entry is created with `Agent = null`, and the audit row carries the same null. |
| 3 | Audit row written in the SAME `SaveChangesAsync` as the entry write | Atomicity: a stale PUT (409) rolls the audit row back with the entry — no audit row exists for a rejected write (verified by `EntryAuditIntegrationTests`). GR-0004's `{role}:{username}` composition (`ComposeUpdatedBy`, precedence su>adm>emp>agt) is extended from the status-change proc to the service-written rows; the actor is resolved server-side from JWT claims (`ResolveActorAsync`), never from the request body. |
| 4 | **Defect — `UpdateAsync` concurrency check was vacuous (AC-011 broken)** | The old code did `entry.RowVersion = expectedRowVersion` and relied on EF's `DbUpdateConcurrencyException`. EF's UPDATE WHERE uses the token's ORIGINAL (as-loaded) value, so the check compared the current rowversion against itself and always succeeded — a stale If-Match never produced 409. Surfaced by the new `EntryAuditIntegrationTests` stale-write assertion. Fix: explicit `SequenceEqual` comparison of the caller's token against the freshly-loaded value, throwing `EntryConflictException` BEFORE any mutation; the EF concurrency-exception catch remains as the race-window net. |
| 5 | **Defect — `Mainentry.rowversion` column missing from the target schema** | data-model.md §16 declares `RowVersion` **ADDED BY THIS FEATURE** (AC-011), but no DDL existed and the copied target schema had no `rowversion` column — every real-DB create/update failed with "Invalid column name 'rowversion'". New idempotent script `scripts/09_add_entry_rowversion.sql` adds the additive column (NFR-001/AC-010 no-op guard), applied to the target. `ChecksumSql` now excludes `rowversion`/`timestamp` columns from the copy-verification checksum (value-generated, no copied legacy data — same rationale as the identity-column exclusion), keeping `ValidationTests`' byte-identical contract intact. |

Full-suite verification on 2026-08-17: `tests/UnitTests` 138/138 (4 new
`EntryAuditTests`), `tests/FunctionalTests` 135/135, `tests/IntegrationTests`
52/52 (1 new `EntryAuditIntegrationTests`; ValidationTests/AuditTableTests
re-verified after the ChecksumSql exclusion).
