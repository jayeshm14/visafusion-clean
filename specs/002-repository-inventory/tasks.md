---

description: "Task list for SPEC-0002 Repository Inventory implementation"
---

# Tasks: Repository Inventory

**Input**: Design documents from `/specs/002-repository-inventory/`

**Prerequisites**: plan.md (required), spec.md (required), research.md, data-model.md, contracts/, quickstart.md

**Tests**: This feature is a documentation deliverable (no code). Validation is manual review per NFR-004; no automated test tasks are generated. Validation scenarios are defined in `quickstart.md` (TS-001..TS-005).

**Organization**: Tasks are grouped by the eight inventory categories (FR-001..FR-008), each an independently deliverable and reviewable increment.

## Format: `[ID] [P?] [FR-###] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[FR-###]**: Which inventory category (functional requirement) this task belongs to (FR-001..FR-008)
- Include exact file paths in descriptions

## Path Conventions

- Deliverable root: `reports/repository-inventory/`
- Spec artifacts: `specs/002-repository-inventory/`

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Create the deliverable directory structure and index

- [ ] T001 Create the deliverable directory `reports/repository-inventory/`
- [ ] T002 [P] Create `reports/repository-inventory/README.md` index with metadata (date, repository state) and a Categories table mapping each category to its document path
- [ ] T003 [P] Create `reports/repository-inventory/discrepancies.md` with the discrepancy table contract (Artifact, Repository State, Finding State, Discrepancy, Resolution) per `contracts/inventory-document-format.md`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Establish the shared inventory conventions that all category documents must follow

**âš ï¸ CRITICAL**: No category document can be finalized until this phase is complete

- [ ] T004: Confirm the inventory contract `specs/002-repository-inventory/contracts/inventory-document-format.md` defines the required columns for all eight categories (C-001..C-005)
- [ ] T005 [P] Confirm the data model `specs/002-repository-inventory/data-model.md` defines all seven entities (Repository Artifact, Technology, Dependency, Legacy Page, External Dependency, COM Component, Configuration Item)
- [ ] T006 [P] Confirm the validation scenarios in `specs/002-repository-inventory/quickstart.md` (TS-001..TS-005) map to acceptance criteria AC-001..AC-005

**Checkpoint**: Foundation ready - category documents can now be written in parallel

---

## Phase 3: Category 1 - Repository Inventory (FR-001) MVP
**Goal**: Enumerate the complete repository contents and their purpose

**Independent Test**: TS-001 (file present) + TS-002 (every entry traceable to a real path)

- [ ] T007 [FR-001] Create `reports/repository-inventory/01-repository-inventory.md` with metadata block (Feature, Date) and `## Scope`
- [ ] T008 [P] [FR-001] Populate `## Entries` table (Path, Type, Category, Purpose, Source) for all top-level directories and files, using the evidence in `research.md` (585 root `.asp` files, directory list)
- [ ] T009 [FR-001] Add `## Notes` covering evidence limitations and any unclassified artifacts (per spec Â§18)

**Checkpoint**: Category 1 complete and independently reviewable

---

## Phase 4: Category 2 - Technology Inventory (FR-002)

**Goal**: List every technology, language, and framework detected in the repository

**Independent**: TS-001 + TS-002 (each technology traces to evidence)

- [ ] T010 [P] [FR-002] Create `reports/repository-inventory/02-technology-inventory.md` with metadata block and `## Scope`
- [ ] T011 [P] [FR-002] Populate `## Entries` (Name, Category, Evidence, Confidence, Status) for Classic ASP/VBScript, SQL Server, HTML/CSS/JS, and other detected technologies per `research.md`
- [ ] T012 [FR-002] Add `## Notes` with confidence levels and detection method

**Checkpoint**: US-2 complete and independently reviewable

---

## Phase 5: Category 3 - Dependency Graph (FR-003)

**Goal**: Show relationships between repository components and artifacts

**Independent**: TS-001 + TS-002 (each dependency traces to evidence)

- [ ] T013 [P] [FR-003] Create `reports/repository-inventory/03-dependency-graph.md` with metadata block and `## Scope`
- [ ] T014 [P] [FR-003] Populate `## Entries` (Source, Target, Type, Evidence) for include, data-access, mail, http, filesystem, and database relationships from `research.md`
- [ ] T015 [FR-003] Add `## Notes` describing how dependencies were traced (includes, connection strings, data-access artifacts)

**Checkpoint**: US-3 complete and independently reviewable

---

## Phase 6: Category 4 - Project Structure (FR-004)

**Goal**: Describe the physical and logical structure of the repository

**Independent**: TS-001 + TS-002 (structure entries trace to real directories)

- [ ] T016 [P] [FR-004] Create `reports/repository-inventory/04-project-structure.md` with metadata block and `## Scope`
- [ ] T017 [P] [FR-004] Populate `## Entries` (Directory, Purpose, Contents summary) for all top-level directories from `research.md`
- [ ] T018 [FR-004] Add `## Notes` on the logical grouping of directories (legacy, assets, tooling, documentation)

**Checkpoint**: US-4 complete and independently reviewable

---

## Phase 7: Category 5 - Legacy Inventory (FR-005)

**Goal**: Enumerate the legacy Classic ASP application surface

**Independent**: TS-004 (consistent with findings) + TS-002

- [ ] T019 [P] [FR-005] Create `reports/repository-inventory/05-legacy-inventory.md` with metadata block and `## Scope`
- [ ] T020 [P] [FR-005] Populate `## Entries` (Path, Module, Role, Data Access, Auth Level) for legacy pages, mapping to `@findings/modernization_plan.md` Â§6 module map and Â§13 legacy pages
- [ ] T021 [FR-005] Add `## Notes` recording any discrepancy between the repository and findings (per BR-002)

**Checkpoint**: US-5 complete and independently reviewable

---

## Phase 8: Category 6 - External Dependencies (FR-006)

**Goal**: List external libraries, services, and systems the application depends on

**Independent**: TS-001 + TS-002 (each dependency traces to evidence)

- [ ] T022 [P] [FR-006] Create `reports/repository-inventory/06-external-dependencies.md` with metadata block and `## Scope`
- [ ] T023 [P] [FR-006] Populate `## Entries` (Name, Type, Used By, License, Security Note) for external services (e.g., SQL Server, mail services) from `research.md`
- [ ] T024 [FR-006] Add `## Notes` with security notes (no secret values) per spec Â§12

**Checkpoint**: US-6 complete and independently reviewable

---

## Phase 9: Category 7 - COM Dependencies (FR-007)

**Goal**: List COM components referenced by the legacy application

**Independent**: TS-001 + TS-002 (each ProgID traces to evidence)

- [ ] T025 [P] [FR-007] Create `reports/repository-inventory/07-com-dependencies.md` with metadata block and `## Scope`
- [ ] T026 [P] [FR-007] Populate `## Entries` (ProgID, Assembly/File, Reference Count, Purpose, Security Note) for the 8 COM ProgIDs from `research.md` (adodb.recordset, CDONTS.Newmail, OSSMTP.SMTPSession, scripting.filesystemObject, CDO.Message, CDO.Configuration, adodb.connection, MSXML2.ServerXMLHTTP)
- [ ] T027 [FR-007] Add `## Notes` covering the `ActiveX/OSSMTP.dll` archive and `msoe.dll` root file

**Checkpoint**: US-7 complete and independently reviewable

---

## Phase 10: Category 8 - Configuration Inventory (FR-008)

**Goal**: List configuration files, connection strings, and settings

**Independent**: TS-005 (no secrets) + TS-001

- [ ] T028 [P] [FR-008] Create `reports/repository-inventory/08-configuration-inventory.md` with metadata block and `## Scope`
- [ ] T029 [P] [FR-008] Populate `## Entries` (Artifact, Setting, Value Summary, Secret, Status) for `connection.asp`, `connectionold.asp`, `connectionweb.asp`, `database.sql`, `opencode.json` - using Value Summary descriptions WITHOUT secret values (spec AC-005)
- [ ] T030 [FR-008] Add `## Notes` flagging the plaintext-credential security finding in `connection.asp` without reproducing the value

**Checkpoint**: Complete - all eight categories delivered

---

## Phase 11: Polish & Cross-Cutting Concerns

**Purpose**: Final validation, consistency, and governance

- [ ] T031 [P] Run TS-001 validation: confirm all 10 files exist under `reports/repository-inventory/`
- [ ] T032 [P] Run TS-002 validation: confirm every entry traces to a real artifact or finding
- [ ] T033 [P] Run TS-003 validation: confirm `git status` shows no unintended source changes
- [ ] T034 [P] Run TS-004 validation: cross-check `05-legacy-inventory.md` against findings; confirm discrepancies recorded
- [ ] T035 [P] Run TS-005 validation: search all documents for `pwd=`, `password=`, `uid=`, full connection strings; confirm no secrets
- [ ] T036 [P] Validate all documents against `contracts/inventory-document-format.md` (C-001..C-005)
- [ ] T037 [P] Run NFR-001 reproducibility check: re-derive one category (e.g., Category 1) from the same repository state and confirm the output is identical; record the method (repository state / branch) used
- [ ] T038 Update the Knowledge Graph (`knowledge-graph/kg.json` + `knowledge-graph/traceability-matrix.md`) per Principle IV
- [ ] T039 Update `specs/002-repository-inventory/checklists/inventory.md` marking validated items `[x]`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup - BLOCKS all category documents
- **Categories (Phase 3-10)**: All depend on Foundational completion; can proceed in parallel
- **Polish (Phase 11)**: Depends on all categories being complete

### Category Dependencies

- **FR-001..FR-008**: Each category is independent and can be written in parallel after Phase 2
- **FR-005 (Legacy)**: Depends on the findings documents being available (already present)

### Within Each Category

- Create the document with metadata â†’ populate `## Entries` â†’ add `## Notes`

### Parallel Opportunities

- All Setup tasks marked [P] can run in parallel
- All Foundational tasks marked [P] can run in parallel
- All category documents (FR-001..FR-008) can be written in parallel after Phase 2
- All Polish validation tasks marked [P] can run in parallel

---

## Parallel Example: Categories 1-8

```bash
# Launch all category documents together after Phase 2:
Task: "Create 01-repository-inventory.md"
Task: "Create 02-technology-inventory.md"
Task: "Create 03-dependency-graph.md"
Task: "Create 04-project-structure.md"
Task: "Create 05-legacy-inventory.md"
Task: "Create 06-external-dependencies.md"
Task: "Create 07-com-dependencies.md"
Task: "Create 08-configuration-inventory.md"
```

---

## Implementation Strategy

### MVP First (Category 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational
3. Complete Phase 3: Category 1 (Repository Inventory)
4. **STOP and VALIDATE**: Run TS-001/TS-002 on Category 1
5. Review/demo if ready

### Incremental Delivery

1. Complete Setup + Foundational â†’ Foundation ready
2. Add Category 1 â†’ validate â†’ review (MVP)
3. Add Categories 2-8 â†’ validate each â†’ review
4. Each category adds value without breaking previous ones

### Parallel Team Strategy

With multiple reviewers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Reviewer A: Categories 1-4
   - Reviewer B: Categories 5-8
3. Categories complete and integrate independently

---

## Notes

- [P] tasks = different files, no dependencies
- [FR-###] label maps task to a specific inventory category for traceability
- Each category is independently completable and reviewable
- This is a documentation deliverable - no automated tests; validation is manual per NFR-004
- Commit after each task or logical group
- Stop at any checkpoint to validate a category independently
- Avoid: vague tasks, same-file conflicts, cross-category dependencies that break independence
