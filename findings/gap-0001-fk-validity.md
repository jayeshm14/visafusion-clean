# GAP-0001 — FK map vs live data: 14 of 27 relationships cannot be enforced

- **Status**: OPEN — owner decision required before release (spec.md §Gap GAP-0001)
- **Detected**: 2026-08-09 (FK map verification against the live `VisaEntry` database)
- **Reporter**: VisaFusion migration tooling (SPEC-0004, deterministic rules: never guess)
- **Affected feature**: MIG-0001 (VisaEntry → VisaFusion data migration)

## 1. Finding

The reconstructed foreign-key map in `specs/004-data-model-migration/data-model.md`
§4 was verified against the live `VisaEntry` database on 2026-08-09. **14 of the
27 documented relationships cannot be enforced on the target** because the legacy
data violates them: child rows carry a sentinel `0` with no matching lookup row,
or reference a parent row that does not exist (orphans). No cleansing rule beyond
the approved FR-005 a–d was signed off for these values.

Per the deterministic rule (library/01: never guess, never invent), no data is
changed and no constraint is forced. The **DEFER** disposition is applied to each
affected relationship: the column and its index are kept, the FK constraint is
omitted, and the relationship is recorded in the migration report
`deferredForeignKeys` section (spec.md §Gap GAP-0001; data-model.md §4).

## 2. Deferred relationships (14)

| # | Child (legacy) | Column | Parent | Violation | Count |
|---|----------------|--------|--------|-----------|-------|
| 1 | `Mainentry` | `category` | `Category` | sentinel `0`, no lookup row | 271,692 |
| 2 | `Mainentry` | `attestation` | `Attestation` | sentinel `0`, no lookup row | 30,176 |
| 3 | `Mainentry` | `poe` | `Poe` | sentinel `0`, no lookup row | 3 |
| 4 | `Mainentry` | `status` | `status` | sentinel `0`, no lookup row | 3 |
| 5 | `PaxStatus` | `PaxID` | `entryDetails` | orphaned reference | 1 |
| 6 | `PaxStatus` | `category` | `Category` | sentinel `0`, no lookup row | 2,755 |
| 7 | `PaxStatus` | `entrytype` | `EntryType` | sentinel `0`, no lookup row | 67 |
| 8 | `StatusHistory` | `PaxID` | `entryDetails` | orphaned reference (append-only audit) | 2,465 |
| 9 | `sentmails` | `agentsid` | `agents` | orphaned reference | 9,661 |
| 10 | `sentawb` | `agentsid` | `agents` | orphaned reference | 404 |
| 11 | `smshistory` | `agentID` | `agents` | orphaned reference | 2,259 |
| 12 | `masterbalance` | `agentid` | `agents` | orphaned reference | 117 |
| 13 | `Ledger` | `agentID` | `agents` | orphaned reference | 525 |
| 14 | `Ledger` | `bank` | `bank` | orphaned reference | 2 |

The 13 remaining relationships are **KEEP** (0 orphans, or covered by an approved
cleansing rule — e.g. `Entry.agent` → `Agent.agentsID` with 6,517 orphans migrated
to NULL under FR-005c).

## 3. Impact

- The target schema enforces referential integrity for all KEEP relationships
  (AC-003); the 14 DEFER relationships keep their column and index but no FK
  constraint, so the target remains loadable without data changes (FR-002).
- The migration report records every deferred relationship with its reason, so the
  reconstruction decision is auditable (FR-007; `ReportCommand.AddDeferredForeignKey`
  writes all 14 entries; `contracts/migration-report.schema.json` §deferredForeignKeys;
  covered by `tests/UnitTests/ReportSchemaTests.cs`).
- Until the owner decision below is recorded, the DEFER disposition stands as the
  documented default; no FK is invented and no data is repaired.

## 4. Owner decision required

Choose one of:

| Option | Behavior | Risk |
|--------|----------|------|
| **A. Accept DEFER (recommended)** | Keep the current disposition: column + index kept, FK constraint omitted, relationship recorded in the report `deferredForeignKeys` section. Data preserved verbatim (FR-002). | Referential integrity for these 14 relationships is enforced by application logic until the data is repaired; a future cleansing feature may enable the FKs. |
| **B. Approve cleansing rules, then enforce FKs** | Approve new cleansing rules (beyond FR-005 a–d) to repair the sentinel-`0`/orphan values, then add the FK constraints in a subsequent migration run (NFR-001 idempotent re-run). | Requires business sign-off per rule (BR-005); changes data values that are currently preserved verbatim. |
| **C. Other** | Any alternative disposition the owner directs. | Owner-defined. |

**Recommended**: Option A. It preserves all data verbatim (the deterministic
contract), keeps the migration unblocked, and records every deferred relationship
for audit and future repair.

## 5. Evidence

- FK map verified against the live `VisaEntry` database 2026-08-09 (data-model.md §4
  note; spec.md §Gap GAP-0001).
- Violation counts above are the live-verified values recorded in
  `ReportCommand.AddDeferredForeignKey` (`src/VisaFusion.Migration/Commands/ReportCommand.cs`).
- The report schema contract documents the section:
  `contracts/migration-report.schema.json` §deferredForeignKeys ("GAP-0001
  relationships recorded as DEFER: column + index kept, FK constraint omitted,
  reason documented (data-model.md §4)").
- `tests/UnitTests/ReportSchemaTests.cs` asserts the serialized report carries the
  `deferredForeignKeys` entries (TS-009, AC-007).

## 6. Resolution trail

- [ ] Owner selects an option (recommended A) and records the decision.
- [ ] If B: author the approved cleansing rules (sign-off gated, BR-005), re-run
      the migration, then add the FK constraints in a subsequent run.
- [ ] Update this file's Status, spec.md §Gap GAP-0001, and
      `knowledge-graph/traceability-matrix.md` when the decision is recorded.
- [ ] Re-run the migration CLI: `validate` passes with the deferred relationships
      reported, not enforced.