# GAP-0002 — Legacy `agents.agentsID` contains a duplicate PK (4114)

- **Status**: RESOLVED (2026-08-09) — owner directed Option A; FR-005e implemented
- **Detected**: 2026-08-09 (copy step fail-fast, `DuplicateKeyGuard`)
- **Reporter**: VisaFusion migration tooling (SPEC-0004, deterministic rules: never guess)
- **Affected feature**: MIG-0001 (VisaEntry → VisaFusion data migration)

## 1. Finding

The legacy `VisaEntry.agents` table contains **two rows with the same primary key**:

| agentsID | Description     | companyname  | emailid                | active | phoneno | smsno                 |
|----------|-----------------|--------------|------------------------|--------|---------|-----------------------|
| 4114     | CUSTOMER-UDAAN  | CUSTOMER A/C | pankaj@udaanindia.com  | Y      | (null)  | 919811049020,919212729826 |
| 4114     | CUSTOMER-UDAAN  | (null)       | (null)                 | (null) | (null)  | (null)                |

- **Full profile row**: populated contact/payment data (the row in normal use).
- **Ghost row**: every column `NULL` except `agentsID` and `Description` —
  an empty shell carrying the same key.

`agents.agentsID` is an **identity column in the legacy schema**
(`is_identity = 1`); the ghost row can therefore only have been created by an
explicit `IDENTITY_INSERT` (or a bad restore/merge). The duplicate is **not
reproducible by normal application flow** and is not covered by any approved
cleansing rule (FR-005 a–d).

## 2. Impact

The target schema (`VisaFusion.agents`) defines `agentsID` as the primary key.
`SqlBulkCopy` with `KeepIdentity` rejects the second row with a PK violation
mid-stream. Before the fail-fast guard (this change), the copy step aborted on a
raw constraint error with no actionable diagnosis.

The copy step now detects the duplicate **before writing any row** and fails
with exit 2 (step failure) and a precise gap message instead of guessing.

## 3. Not a documented rule

GAP-0001 (FK map vs live data) was a documented, owner-reviewable gap and was
resolved with the DEFER disposition. This duplicate is **not documented in any
approved cleansing rule or prior finding** — it was discovered by the copy-time
`DuplicateKeyGuard` scan, which is exactly the "never guess, never invent" path
(library/01 §deterministic-rules).

## 4. Owner decision required

Choose one of:

| Option | Behavior | Risk |
|--------|----------|------|
| **A. Keep full profile, drop ghost** | A new approved cleansing rule "agents 4114 dedupe" (FR-005e, sign-off gated) collapses to the populated row; copy-time transform `DeduplicateOn(agentsID)`, surviving row = first ranked (`CUSTOMER A/C`). | Low; ghost row is all-NULL. Must confirm the ghost is not referenced by `Mainentry.agent`/`smsQueue.agentID` (it is not — no other row can share the key). |
| **B. Keep ghost, drop full profile** | Not recommended; would destroy live contact data. | High. |
| **C. Keep both by re-keying** | Assign a new identity to the ghost row; changes key values not present in legacy. | Violates FR-001 key preservation for a row with no business content. |

**Recommended**: Option A. The ghost row is all-NULL and carries no referential
value; keeping the populated profile preserves every attribute in use.

## 5. Evidence

- `agents.agentsID = 4114` yields exactly 2 rows (verified live, 2026-08-09).
- Legacy `agents.agentsID` is identity (`is_identity = 1`).
- Target `agents.agentsID` is PK (identity, `ValueGeneratedOnAdd`); unique/`Id`
  constraints reject duplicates.
- The comprehensive legacy PK-duplicate scan over all 52 tables (target PKs as
  authority) found duplicates in exactly two tables:
  - `status.statusID = 508` → documented FR-005a (approved, copy-time transform) — not a gap.
  - `agents.agentsID = 4114` → this gap.

## 6. Resolution trail

- [ ] Owner selects an option (recommended A) and records sign-off.
- [ ] Add cleansing rule FR-005e (if A): dedupe `agents` on `agentsID`, keep
      first-ranked row; sign-off gated (BR-005).
- [ ] Register the approved rule in `CopyCommand.BuildApprovedTransforms`
      (copy-time) and in the cleanse step.
- [ ] Remove this gap's OPEN status; update spec.md, traceability-matrix.md,
      and this file.
- [ ] Re-run the migration CLI: copy step completes, validation passes.
