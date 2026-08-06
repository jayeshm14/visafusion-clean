# Tasks: AI Environment Validation

**Input**: Design documents from `/specs/001-ai-environment-validation/`

**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/, quickstart.md

**Tests**: Included — the VisaFusion constitution (Principle V) mandates automated tests for every implementation; research.md selects Pester 5. Tests are written first (TDD) and must fail before implementation.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- Validation script: `scripts/ai-environment-validation/`
- Pester tests: `tests/ai-environment-validation/`
- CI workflow: `.github/workflows/`
- Generated reports: `reports/ai-environment-validation/`
- Governance: `adr/`, `knowledge-graph/`

## User Stories (derived from spec.md FRs)

| Story | Priority | Scope | Functional Requirements |
|-------|----------|-------|-------------------------|
| US1 | P1 (MVP) | Validation engine: detect 12 integrations, classify status, record provenance, repeatable dated result | FR-001, FR-003, FR-004, FR-005 |
| US2 | P2 | Report artifacts: traceability matrix, Markdown report, JSON summary per contract | FR-002, FR-007 |
| US3 | P2 | Execution modes: automated CI gate + on-demand runs | FR-006, FR-008 |

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [x] T001 Create validation directories `scripts/ai-environment-validation/`, `tests/ai-environment-validation/`, and `reports/ai-environment-validation/` per plan.md structure
- [x] T002 [P] Create ADR-0002 documenting the validation-gate architecture (script + CI workflow + report artifacts) in `adr/ADR-0002.md` (Constitution Principle IV, plan GATE D)
- [x] T003 [P] Create CI workflow skeleton `.github/workflows/ai-environment-validation.yml` with trigger paths `findings/**` and `library/**`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T004 Create the 12-integration registry (id, name, canonical search terms, governing doc, constitution principle) in `scripts/ai-environment-validation/integrations.psd1` per data-model.md
- [x] T005 Implement doc-scanning helper (Select-String over `findings/` and `library/`) in `scripts/ai-environment-validation/validate-ai-environment.ps1`
- [x] T006 Implement the status classifier (validated / partial / missing / contradictory per BR-002 and spec §17 rules) in `scripts/ai-environment-validation/validate-ai-environment.ps1`

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Validation Engine (Priority: P1) 🎯 MVP

**Goal**: Detect all 12 documented integrations across `findings/` and `library/`, apply the workflow-directive test (BR-002), classify each as validated/partial/missing/contradictory, record provenance, and produce a repeatable dated result (FR-001, FR-003, FR-004, FR-005).

**Independent Test**: Run `validate-ai-environment.ps1 -SourceDirs @('findings','library') -OutputDir 'reports/ai-environment-validation'`; the run reports status for all 12 integrations with provenance (source file + line), and exits non-zero when any integration is non-validated.

### Tests for User Story 1 (Pester — write FIRST, ensure they FAIL before implementation) ⚠️

- [x] T007 [P] [US1] Write Pester tests for integration detection and status classification (incl. name-only-mention → partial per BR-002) in `tests/ai-environment-validation/validate-ai-environment.Tests.ps1`

### Implementation for User Story 1

- [x] T008 [US1] Implement the integration scanning loop using the registry (T004) and doc scanner (T005) in `scripts/ai-environment-validation/validate-ai-environment.ps1` (depends on T004, T005)
- [x] T009 [US1] Implement workflow-directive detection (BR-002: directive required, not just a name mention) in `scripts/ai-environment-validation/validate-ai-environment.ps1`
- [x] T010 [US1] Implement provenance recording (source file + line per finding) in `scripts/ai-environment-validation/validate-ai-environment.ps1` (FR-004)
- [x] T011 [US1] Implement repeatable run semantics (ISO-8601 date, deterministic ordering, exit code reflects `passed`) in `scripts/ai-environment-validation/validate-ai-environment.ps1` (FR-005, NFR-001)

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Report Artifacts & Contract (Priority: P2)

**Goal**: Produce the traceability matrix (FR-002), the version-controlled Markdown report, and the machine-readable JSON summary conforming to the v1 contract (FR-007, AC-006).

**Independent Test**: After a US1 run, `reports/ai-environment-validation/report.md` and `summary.json` exist; `summary.json` validates against the `contracts/validation-summary.md` schema (validated by the contract test) and `report.md` contains the per-integration traceability matrix.

### Tests for User Story 2 (Pester — write FIRST) ⚠️

- [x] T012 [P] [US2] Write Pester contract test for the `summary.json` schema (field names, types, required-ness, 12 integration entries) in `tests/ai-environment-validation/validate-ai-environment.Tests.ps1`

### Implementation for User Story 2

- [x] T013 [US2] Implement Markdown report generation (`report.md`), including a Gap Report section for non-validated integrations (BR-003), in `scripts/ai-environment-validation/validate-ai-environment.ps1`
- [x] T014 [US2] Implement JSON summary generation per `contracts/validation-summary.md` (`summary.json`) in `scripts/ai-environment-validation/validate-ai-environment.ps1`
- [x] T015 [US2] Implement the traceability-matrix rendering (FR-002) into `report.md` in `scripts/ai-environment-validation/validate-ai-environment.ps1`

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - CI Gate & Execution Modes (Priority: P2)

**Goal**: Automated CI gate triggered on `findings/`/`library/` changes that blocks merge on failure (FR-008), plus on-demand agent runs (FR-006), with identical results across modes (AC-005).

**Independent Test**: Push a change under `findings/` or `library/`; the workflow runs the validation and fails the check when `passed` is false. An on-demand run of the script produces the same result as the CI gate for the same inputs.

### Tests for User Story 3 (Pester — write FIRST) ⚠️

- [x] T016 [P] [US3] Write Pester tests for CI/on-demand result equivalence and `passed` flag semantics in `tests/ai-environment-validation/validate-ai-environment.Tests.ps1`

### Implementation for User Story 3

- [x] T017 [US3] Finalize `.github/workflows/ai-environment-validation.yml` to run `scripts/ai-environment-validation/validate-ai-environment.ps1` and fail the check on non-zero exit (depends on T003)
- [x] T018 [US3] Implement on-demand parameterization (`-SourceDirs`, `-OutputDir`, `-ReportOnly`) in `scripts/ai-environment-validation/validate-ai-environment.ps1` (FR-006)

**Checkpoint**: All user stories should now be independently functional

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [x] T019 [P] Run the `quickstart.md` validation end-to-end, fix any gaps found, and assert completion within the 30-minute NFR-002 budget
- [x] T020 Update the Knowledge Graph (`knowledge-graph/kg.json` + `knowledge-graph/traceability-matrix.md`) with SPEC-0001, ADR-0002, and this feature's artifacts (Constitution Principle IV)
- [x] T021 [P] Update documentation (README/docs) describing the validation workflow and its outputs
- [x] T022 [P] Security review: confirm read-only access over docs, no secrets, no production data in `scripts/ai-environment-validation/` and `.github/workflows/ai-environment-validation.yml` (spec §12)
- [x] T023 Re-run `specs/001-ai-environment-validation/checklists/validation.md` and resolve flagged requirement gaps (e.g., CHK019 recovery flow — doc restored → status returns to validated)

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - User stories can then proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2 → P2)
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 2 (P2)**: Can start after Foundational (Phase 2) - Depends on US1 run outputs (report artifacts consume the validation result)
- **User Story 3 (P2)**: Can start after Foundational (Phase 2) - T018 (on-demand parameterization) depends on US1; T017 (CI gate) depends on US2 (summary.json passed flag)

### Within Each User Story

- Tests (Pester) MUST be written and FAIL before implementation
- Registry/scanning helpers before the scanning loop (T008 depends on T004, T005)
- Core implementation before integration
- Story complete before moving to next priority

### Parallel Opportunities

- T002 and T003 (Phase 1) can run in parallel
- T008, T009, T010, T011 within US1 touch the same script file (`validate-ai-environment.ps1`) — run sequentially
- T013, T014, T015 within US2 also share the script — run sequentially; T012 (test) is parallelizable
- T016 (US3 test) can run in parallel; T017 and T018 touch different files (workflow vs script) and can run in parallel
- Polish tasks T019–T022 are parallelizable (different files)

---

## Parallel Example: User Story 1

```powershell
# Tests are written FIRST and must fail before implementation:
Task: "Write Pester tests for integration detection and status classification in tests/ai-environment-validation/validate-ai-environment.Tests.ps1"

# Implementation follows in strict order (shared file):
Task: "Implement the integration scanning loop in scripts/ai-environment-validation/validate-ai-environment.ps1"
Task: "Implement workflow-directive detection in scripts/ai-environment-validation/validate-ai-environment.ps1"
Task: "Implement provenance recording in scripts/ai-environment-validation/validate-ai-environment.ps1"
Task: "Implement repeatable run semantics in scripts/ai-environment-validation/validate-ai-environment.ps1"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup (incl. ADR-0002)
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1 (validation engine with per-integration status + provenance)
4. **STOP and VALIDATE**: Run the script on-demand and check all 12 integrations are classified with provenance
5. Deploy/demo if ready

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 (engine) → Test independently → on-demand runs produce correct statuses (MVP!)
3. Add User Story 2 (reports) → Test independently → report.md + summary.json per contract
4. Add User Story 3 (CI gate) → Test independently → automated gate blocks merge on drift
5. Each story adds value without breaking previous stories

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: User Story 1
   - Developer B: User Story 2 (after US1 outputs exist)
   - Developer C: User Story 3 (after US1/US2)
3. Stories complete and integrate independently

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Verify tests fail before implementing (TDD)
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- Avoid: vague tasks, same file conflicts, cross-story dependencies that break independence
- Tasks T008–T011 (US1), T013–T015 (US2) share `validate-ai-environment.ps1` and MUST be executed sequentially