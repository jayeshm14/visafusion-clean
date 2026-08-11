# Tasks: Complete Data Model Migration (SPEC-0004)

**Input**: Design documents from `/specs/004-data-model-migration/`

**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: Test tasks are included because the constitution (Principle V) mandates automated tests and the spec defines test scenarios TS-001..TS-008 (§23). Tests are written first and must FAIL before implementation.

**Organization**: Tasks are grouped by user story. The spec defines no explicit user stories, so they are derived from the migration workflow — the fixed command sequence in `contracts/migration-cli.md` §2 mapped to the functional requirements (FR-001..FR-009). Each story is an independently testable increment of the migration pipeline.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (US1..US6)
- Include exact file paths in descriptions

## Path Conventions

- Solution: `VisaFusion.sln` at repository root; projects under `src/`; tests under `tests/`
- New project: `src/VisaFusion.Migration/` (console, per plan.md Project Structure)
- Target schema: `src/VisaFusion.Data/` (existing project, extended)
- Tests: `tests/UnitTests/`, `tests/IntegrationTests/`, `tests/FunctionalTests/` (existing projects)

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [X] T001 Create `VisaFusion.Migration` console project in `src/VisaFusion.Migration/VisaFusion.Migration.csproj` and add it to `VisaFusion.sln`
- [X] T002 [P] Add project references to `VisaFusion.Data` and `VisaFusion.Identity` in `src/VisaFusion.Migration/VisaFusion.Migration.csproj`
- [X] T003 [P] Configure Serilog structured logging (file + SQL sinks) in `src/VisaFusion.Migration/Program.cs` (NFR-006)
- [X] T004 [P] Create `src/VisaFusion.Migration/appsettings.json` with connection-string placeholders (`Legacy:VisaEntry`, `Target:VisaFusion`) and environment-variable mapping — no secrets in source (NFR-004)
- [X] T005 [P] Add migration test scaffolding: project references to `VisaFusion.Migration` in `tests/UnitTests/VisaFusion.UnitTests.csproj`, `tests/IntegrationTests/VisaFusion.IntegrationTests.csproj`, `tests/FunctionalTests/VisaFusion.FunctionalTests.csproj`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [X] T006 Create the CLI runner with the fixed command order (`preflight → snapshot → schema → copy → cleanse → identity → validate → report`) and exit codes 0-5 in `src/VisaFusion.Migration/Program.cs` (contracts/migration-cli.md §2, §4)
- [X] T007 [P] Create the run-state/idempotency record (guards re-runs as no-ops) in `src/VisaFusion.Migration/Commands/RunState.cs` (NFR-001)
- [X] T008 [P] Create the configuration model (connection strings, batch sizes, sign-off records) in `src/VisaFusion.Migration/Configuration/MigrationOptions.cs`
- [X] T009 [P] Create the step-runner with checkpoint rollback and fail-fast integrity handling in `src/VisaFusion.Migration/Commands/StepRunner.cs` (spec §18)
- [X] T010 [P] Create the target entity classes for M-disposition tables (part 1: `Entry`, `EntryPassenger`, `PaxCountryStatus`, `StatusHistoryEntry`, `EntryAuditLog`, `EmailLog`, `AwbLog`, `SmsLog`, `SmsQueue`) in `src/VisaFusion.Data/Persistence/Entities/` (data-model.md §3.1)
- [X] T011 [P] Create the target entity classes for M-disposition tables (part 2: `Agent`, `SecurityDay`, `MasterBalance`, `Bank`, `Holiday`, `WeeklyOff`, `Embassy`, `CountryInfo`, `VisaInfo`, `Status`, `Category`, `EntryType`, `Poe`, `Attestation`, `Certificate`, `PaxAttestation`, `ContentUpdate`) in `src/VisaFusion.Data/Persistence/Entities/` (data-model.md §3.1)
- [X] T012 [P] Create the target entity classes for M-RO and COND tables (`DeletedItemAudit`, `AgentStaging`, `LedgerHistory`, `Invoice`, `InvoiceDetail`, `Hotel`, `Cab`, `PaxHotel`, `PaxCab`, `Scheduler`, `PriWork`, `Subscriber`) in `src/VisaFusion.Data/Persistence/Entities/` (data-model.md §3.2, §3.3)
- [X] T013 Configure the EF Core model in `src/VisaFusion.Data/Persistence/VisaEntryDbContext.cs`: table mappings, primary keys per data-model.md §2, foreign keys per §4, and indexes for the high-volume tables (FR-003)

**Checkpoint**: Foundation ready — user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Migration Tooling, Preflight & Snapshot (Priority: P1) 🎯 MVP

**Goal**: The operator can run `preflight` and `snapshot` against the legacy `VisaEntry` database and get a validated baseline (FR-008, FR-009).

**Independent Test**: Run `dotnet run --project src/VisaFusion.Migration -- preflight` with the legacy app stopped and a backup present → exit 0; run `snapshot` → baseline row counts + checksums recorded for all 52 tables.

### Tests for User Story 1

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [X] T014 [P] [US1] Unit test for run-state idempotency (re-run is a no-op) in `tests/UnitTests/RunStateTests.cs` (TS-008)
- [X] T015 [P] [US1] Integration test for `preflight` (legacy reachable, backup exists, app offline, sign-offs present) in `tests/IntegrationTests/PreflightTests.cs`
- [X] T016 [P] [US1] Integration test for `snapshot` (52-table baseline row counts + checksums) in `tests/IntegrationTests/SnapshotTests.cs`

### Implementation for User Story 1

- [X] T017 [US1] Implement the `preflight` command in `src/VisaFusion.Migration/Commands/PreflightCommand.cs` (contracts/migration-cli.md §2)
- [X] T018 [US1] Implement the `snapshot` command (baseline row counts + checksums for all 52 tables) in `src/VisaFusion.Migration/Commands/SnapshotCommand.cs` (FR-009)
- [X] T019 [US1] Implement the legacy read-only data access (parameterized queries only) in `src/VisaFusion.Migration/Data/LegacyReader.cs` (NFR-003)

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Target Schema (Priority: P2)

**Goal**: The target `VisaFusion` database schema is created with reconstructed primary keys, foreign keys, and indexes (FR-003).

**Independent Test**: Run `schema` → target database exists with all migrated tables, every table has a PK, no orphaned FKs (AC-003).

### Tests for User Story 2

- [X] T020 [P] [US2] Integration test for schema creation (all target tables present, PKs/FKs/indexes applied) in `tests/IntegrationTests/SchemaTests.cs` (TS-002)

### Implementation for User Story 2

- [X] T021 [US2] Create the EF Core migration for the target schema in `src/VisaFusion.Data/Migrations/` (initial migration, all tables per data-model.md §3)
- [X] T022 [US2] Implement the `schema` command (applies EF Core migrations to the target database) in `src/VisaFusion.Migration/Commands/SchemaCommand.cs` (contracts/migration-cli.md §2)

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Data Copy (Priority: P3)

**Goal**: All migrated tables are batch-copied from the legacy snapshot to the target in FK-dependency order with zero data loss (FR-001, FR-002, FR-006).

**Independent Test**: Run `copy` after `schema`; per-table source == target row counts (except documented cleansing); append-only audit tables byte-identical (TS-001, TS-006).

### Tests for User Story 3

- [X] T023 [P] [US3] Integration test for batch copy row-count parity per table in `tests/IntegrationTests/CopyTests.cs` (TS-001)
- [X] T024 [P] [US3] Integration test for append-only audit tables byte-identical after copy in `tests/IntegrationTests/AuditTableTests.cs` (TS-006)

### Implementation for User Story 3

- [X] T025 [US3] Implement the batch copy engine (SqlBulkCopy, bounded batch sizes, FK-dependency order: parents before children) in `src/VisaFusion.Migration/Copy/BulkCopyEngine.cs` (spec §13)
- [X] T026 [US3] Implement the `copy` command in `src/VisaFusion.Migration/Commands/CopyCommand.cs` (contracts/migration-cli.md §2)
- [X] T027 [US3] Implement the append-only audit table handling (no UPDATE/DELETE, no reordering) in `src/VisaFusion.Migration/Copy/AuditTableCopier.cs` (FR-006, BR-003)

**Checkpoint**: At this point, User Stories 1-3 should all work independently

---

## Phase 6: User Story 4 - Cleansing Rules (Priority: P4)

**Goal**: The four approved cleansing rules are applied, each gated by recorded business sign-off (FR-005, BR-005).

**Independent Test**: Run `cleanse`; `statusID=508` has a single description; 6,517 orphaned `Mainentry` rows have NULL agent and are flagged; junk dates clamped (AC-005).

### Tests for User Story 4

- [X] T028 [P] [US4] Unit test for the `statusID=508` duplicate resolution in `tests/UnitTests/CleansingStatus508Tests.cs` (TS-004)
- [X] T029 [P] [US4] Unit test for the orphaned-agent NULL + flag rule in `tests/UnitTests/CleansingOrphanTests.cs` (TS-005)
- [X] T030 [P] [US4] Unit test for the `entrytype` default and junk-date clamp rules in `tests/UnitTests/CleansingDefaultsTests.cs`

### Implementation for User Story 4

- [X] T031 [US4] Implement cleansing rule (a) — resolve `statusID=508` duplicate description in `src/VisaFusion.Migration/Cleansing/Status508Rule.cs` (FR-005a)
- [X] T032 [US4] Implement cleansing rule (b) — default the 100%-NULL `Mainentry.entrytype` in `src/VisaFusion.Migration/Cleansing/EntryTypeDefaultRule.cs` (FR-005b)
- [X] T033 [US4] Implement cleansing rule (c) — migrate 6,517 orphaned `Mainentry.agent` rows with NULL agent and flag them in `src/VisaFusion.Migration/Cleansing/OrphanAgentRule.cs` (FR-005c)
- [X] T034 [US4] Implement cleansing rule (d) — clamp junk dates (1970/2207) in `src/VisaFusion.Migration/Cleansing/JunkDateRule.cs` (FR-005d)
- [X] T035 [US4] Implement the `cleanse` command with sign-off gating (each rule requires a recorded sign-off) in `src/VisaFusion.Migration/Commands/CleanseCommand.cs` (BR-005)

**Checkpoint**: At this point, User Stories 1-4 should all work independently

---

## Phase 7: User Story 5 - Identity Import (Priority: P5)

**Goal**: The three legacy identity sources are imported into ASP.NET Core Identity with passwords hashed on import and first-source-wins dedup (FR-004, BR-002).

**Independent Test**: Run `identity`; `AspNetUsers` contains imported users with hashed passwords (no plaintext); no duplicate usernames/emails; skipped duplicates listed in the report (TS-003).

### Tests for User Story 5

- [X] T036 [P] [US5] Unit test for first-source-wins dedup priority (`agents` → `registration` → `Udaan_users`) in `tests/UnitTests/IdentityDedupTests.cs`
- [X] T037 [P] [US5] Integration test for hashed-password import (no plaintext in `AspNetUsers`) in `tests/IntegrationTests/IdentityImportTests.cs` (TS-003)

### Implementation for User Story 5

- [X] T038 [US5] Implement the identity import pipeline (priority order, role mapping `su`/`adm`/`emp`/`agt`/`guest`) in `src/VisaFusion.Migration/Identity/IdentityImporter.cs` (FR-004, data-model.md §4)
- [X] T039 [US5] Implement password hashing on import (never plaintext) in `src/VisaFusion.Migration/Identity/PasswordHasher.cs` (BR-002, AC-004)
- [X] T040 [US5] Implement the `identity` command in `src/VisaFusion.Migration/Commands/IdentityCommand.cs` (contracts/migration-cli.md §2)

**Checkpoint**: At this point, User Stories 1-5 should all work independently

---

## Phase 8: User Story 6 - Validation & Report (Priority: P6)

**Goal**: The migration is validated (row counts, checksums, referential integrity) and a machine-readable report is produced (FR-007, FR-009).

**Independent Test**: Run `validate` — all checks pass, exit 0; run `report` — JSON validates against `contracts/migration-report.schema.json` (TS-001..TS-008).

### Tests for User Story 6

- [X] T041 [P] [US6] Integration test for validation (row counts, checksums, RI, no plaintext) in `tests/IntegrationTests/ValidationTests.cs` (TS-001, TS-002, TS-003)
- [X] T042 [P] [US6] Unit test for the report JSON against `contracts/migration-report.schema.json` in `tests/UnitTests/ReportSchemaTests.cs` (AC-007, TS-009)

### Implementation for User Story 6

- [X] T043 [US6] Implement the validation engine (row counts, checksums excluding approved cleansing, referential-integrity checks) in `src/VisaFusion.Migration/Validation/ValidationEngine.cs` (FR-009)
- [X] T044 [US6] Implement the `validate` command (fail-fast on integrity violations) in `src/VisaFusion.Migration/Commands/ValidateCommand.cs` (spec §18)
- [X] T045 [US6] Implement the report writer (JSON per `contracts/migration-report.schema.json` + human summary) in `src/VisaFusion.Migration/Reporting/ReportWriter.cs` (FR-007, NFR-005)
- [X] T046 [US6] Implement the `report` command in `src/VisaFusion.Migration/Commands/ReportCommand.cs` (contracts/migration-cli.md §2)
**Checkpoint**: All user stories should now be independently functional

---

## Phase 9: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T047 [P] Run the full `quickstart.md` validation sequence end-to-end (all 8 commands, exit 0) in `specs/004-data-model-migration/quickstart.md` — **BLOCKED**: `copy`/`validate`/`report` cannot exit 0 until the GAP-0002 owner decision (FR-005e sign-off) and the pre-migration backup exist (AC-008); see `reports/migration/dod-verification-feature-004.md` §5
- [X] T048 [P] Verify reversibility: restore from the pre-migration backup reproduces the target state in `tests/FunctionalTests/ReversibilityTests.cs` (TS-007, AC-008)
- [X] T049 [P] Security review: no plaintext passwords, no secrets in source, no string-concatenated SQL in `src/VisaFusion.Migration/` (spec §12, NFR-003, NFR-004)
- [X] T050 [P] Update the Knowledge Graph and traceability matrix in `knowledge-graph/` (constitution Principle IV)
- [X] T051 [P] Update documentation: `specs/004-data-model-migration/` artifacts reflect the implemented behavior (constitution Principle V)
- [X] T052 [P] Create ADR-0003 documenting the migration-tooling decision (new `VisaFusion.Migration` console project) in `adr/ADR-0003.md` (constitution Principle IV)
- [X] T053 [P] Add a performance-validation task: verify the full migration + validation completes within the 4-hour window (NFR-002) in `tests/FunctionalTests/WindowValidationTests.cs`
- [X] T054 [P] Add a schema test asserting DROP-disposition tables (`dtproperties`, `country`, `Results`, `hits`, `adcount`) are absent from the target schema in `tests/IntegrationTests/DropTableExclusionTests.cs` (BR-001)

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies — can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion — BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - US1 (P1) → US2 (P2) → US3 (P3) → US4 (P4) → US5 (P5) → US6 (P6) — sequential pipeline order (the CLI contract enforces fixed command order)
- **Polish (Final Phase)**: Depends on all user stories being complete

### User Story Dependencies

- **US1 (P1)**: Can start after Foundational — no dependencies on other stories
- **US2 (P2)**: Depends on US1 (schema runs after preflight/snapshot) — independently testable
- **US3 (P3)**: Depends on US2 (copy needs the target schema) — independently testable
- **US4 (P4)**: Depends on US3 (cleansing runs on copied data) — independently testable
- **US5 (P5)**: Depends on US2 (identity import needs the target schema; it reads from the legacy DB, not the copied data) — can run in parallel with US3 and US4
- **US6 (P6)**: Depends on US3, US4, US5 (validation covers all) — final gate

### Within Each User Story

- Tests MUST be written and FAIL before implementation
- Models/entities before services
- Services before commands
- Core implementation before integration
- Story complete before moving to next priority

### Parallel Opportunities

- All Setup tasks marked [P] can run in parallel
- All Foundational tasks marked [P] can run in parallel (within Phase 2)
- US4 and US5 can run in parallel after US3 (cleansing and identity import touch different tables)
- All tests for a story marked [P] can run in parallel
- Entity-creation tasks T010/T011/T012 can run in parallel

---

## Parallel Example: User Story 1

```bash
# Launch all tests for User Story 1 together:
Task: "Unit test for run-state idempotency in tests/UnitTests/RunStateTests.cs"
Task: "Integration test for preflight in tests/IntegrationTests/PreflightTests.cs"
Task: "Integration test for snapshot in tests/IntegrationTests/SnapshotTests.cs"

# Launch implementation tasks:
Task: "Implement preflight command in src/VisaFusion.Migration/Commands/PreflightCommand.cs"
Task: "Implement snapshot command in src/VisaFusion.Migration/Commands/SnapshotCommand.cs"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL — blocks all stories)
3. Complete Phase 3: User Story 1 (preflight + snapshot)
4. **STOP and VALIDATE**: Test User Story 1 independently
5. Deploy/demo if ready

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add US1 (preflight/snapshot) → Test independently → Demo (MVP!)
3. Add US2 (schema) → Test independently
4. Add US3 (copy) → Test independently
5. Add US4 (cleansing) and US5 (identity) → Test independently
6. Add US6 (validation/report) → Test independently → Full migration ready

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: US1 → US2 (pipeline front)
   - Developer B: US3 (copy engine)
   - Developer C: US4 (cleansing) after US3
   - Developer D: US5 (identity) after US3
3. Stories complete and integrate independently; US6 validates the whole pipeline

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Verify tests fail before implementing
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- Avoid: vague tasks, same-file conflicts, cross-story dependencies that break independence
- The CountryID target reference gap (data-model.md §4) must be resolved before T013 (FK configuration) — do not invent a mapping

---

## Phase 10: Convergence

**Purpose**: Remaining work identified by the `/speckit.converge` assessment (2026-08-11) — gaps between the spec/plan/tasks and the implemented codebase.

- [X] T055 Author the GAP-0001 gap report `findings/gap-0001-fk-validity.md` documenting the 14 deferred foreign keys (DEFER disposition: column + index kept, FK constraint omitted; sentinel-0/orphan evidence per `data-model.md` §4 and `ReportCommand.AddDeferredForeignKey`) and the owner-decision request per `spec.md` §Gap GAP-0001 (missing)