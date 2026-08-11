# GAP-0003 — Target database strategy: constitution "in-place VisaEntry" vs ADR-0003/SPEC-0004 "separate VisaFusion target"

- **Status**: RESOLVED — Option A confirmed by owner 2026-08-11
- **Detected**: 2026-08-11 (constitution amendment to v1.3.0, `SQL Server (VisaEntry DB, in-place)` vs accepted SPEC-0004 decision)
- **Reporter**: VisaFusion constitution governance (deterministic rules: never guess)
- **Affected feature**: MIG-0001 (VisaEntry → VisaFusion data migration); constitution v1.3.0; ADR-0001; ADR-0003

## 1. Finding

The owner hard-rule recorded in `.specify/memory/constitution.md` v1.3.0 states the
stack as "SQL Server (target database: `VisaEntry`, in-place deployment)". This
contradicts the accepted, ADR-backed decision for SPEC-0004, which explicitly
rejected in-place migration of `VisaEntry` and chose a separate target database
`VisaFusion`. Two documented governance artifacts now disagree on the target
database strategy; per the deterministic rules (never guess, never invent), the
conflict is raised for owner decision rather than silently resolved.

## 2. Contradiction evidence

| # | Artifact | Statement |
|---|----------|-----------|
| 1 | `.specify/memory/constitution.md` v1.3.0 (2026-08-11), Engineering Process & Security Standards | "SQL Server (target database: `VisaEntry`, in-place deployment)" |
| 2 | `adr/ADR-0001.md` (2026-08-06) | "Persistence: EF Core against the existing SQL Server `VisaEntry` database." (written before the SPEC-0004 research decision) |
| 3 | `specs/004-data-model-migration/research.md` L31 | "In-place migration of the legacy `VisaEntry` database — **rejected**: violates FR-008" |
| 4 | `specs/004-data-model-migration/research.md` L36–37 | "**Decision**: A separate target database `VisaFusion` (new), populated from the legacy `VisaEntry` snapshot. The legacy database is never written to." |
| 5 | `specs/004-data-model-migration/data-model.md` L17 | "Target database \| `VisaFusion` (new; separate from legacy `VisaEntry`)" |
| 6 | `specs/004-data-model-migration/plan.md` L33–35 | "**Legacy `VisaEntry`** — read-only source of truth; **never modified** (FR-008) … **Target `VisaFusion`** — the migrated schema with reconstructed PKs, FKs, and indexes" |
| 7 | `adr/ADR-0003.md` (2026-08-10), Decision 5 / Consequences | "the migration reads it read-only and writes only to the target `VisaFusion` database"; target schema defined by EF Core migrations in `VisaFusion.Data` |
| 8 | `specs/004-data-model-migration/quickstart.md` L28–29 | Connection strings `Legacy:VisaEntry` (read-only) and `Target:VisaFusion` (write) |
| 9 | Implemented tooling (`src/VisaFusion.Migration`) | `schema` command applies EF Core migrations to the target `VisaFusion` database (tasks T021/T022 done); `Legacy:VisaEntry` read-only access (T019 done) |

## 3. Impact

- The constitution (v1.3.0) and the accepted SPEC-0004 / ADR-0003 decision cannot
  both be honored as written. The migration tooling, its tests (51+ green as of
  2026-08-10), and the target EF model in `VisaFusion.Data` are all built around
  the separate-target design; the `preflight → snapshot → schema` run has already
  completed against that design.
- If the constitution line is the controlling rule, SPEC-0004's decision,
  ADR-0003, and the implemented tooling would all need to be superseded or
  reworked — a major change after implementation is complete.
- If the separate-target design is the controlling decision, the constitution
  v1.3.0 stack line needs a clarifying amendment (the "in-place" wording then
  describes deployment topology, not schema migration).
- Until an owner decision is recorded, the accepted SPEC-0004 / ADR-0003 design
  stands (no work is blocked); the constitution line is flagged as pending
  reconciliation.

## 4. Owner decision required

Choose one of:

| Option | Behavior | Risk |
|--------|----------|------|
| **A. Confirm separate target DB (recommended)** | Keep SPEC-0004 / ADR-0003 as accepted: legacy `VisaEntry` is never modified; the target `VisaFusion` database is populated on the existing SQL Server instance ("in-place" = same server, no new instance). Amend constitution v1.3.0 to read "SQL Server (existing instance; legacy `VisaEntry` preserved read-only; target database `VisaFusion`)". | Requires a MINOR/PATCH constitution amendment and a one-line ADR-0001 clarification (its "existing `VisaEntry` database" wording predates the SPEC-0004 decision). No tooling or data changes. |
| **B. True in-place migration on `VisaEntry`** | Supersede ADR-0003 and SPEC-0004's decision; redesign the migration tooling to write into `VisaEntry` in place; FR-008 ("legacy never modified") must be revised. | Major rework after implementation; contradicts the accepted research; FR-008 and NFR-002 (offline window) semantics change. Not recommended. |
| **C. Other** | Any alternative strategy the owner directs. | Owner-defined. |

**Recommended**: Option A. It preserves all accepted ADR/SPEC decisions and the
implemented tooling, removes the contradiction with a clarifying amendment, and
records the deployment-topology intent explicitly.

## 5. Evidence

- Constitution v1.3.0 (`G:\Projects\VisaEntry\.specify\memory\constitution.md`),
  "Engineering Process & Security Standards" section (stack line).
- `specs/004-data-model-migration/research.md` L31–43 (in-place rejected; separate
  `VisaFusion` target decided; alternatives recorded).
- `specs/004-data-model-migration/data-model.md` L17 (target database decision).
- `specs/004-data-model-migration/plan.md` L33–35 (legacy read-only contract).
- `adr/ADR-0003.md` Decision 5 and Consequences (target `VisaFusion` database).
- `adr/ADR-0001.md` (initial in-place phrasing, predates the SPEC-0004 decision).
- `specs/004-data-model-migration/quickstart.md` L28–29 (`Legacy:VisaEntry` /
  `Target:VisaFusion` connection strings).
- `specs/004-data-model-migration/tasks.md` T019/T021/T022 (implemented tooling
  against the separate-target design).

## 6. Resolution trail

- [x] Owner selected Option A on 2026-08-11.
- [x] Amended `.specify/memory/constitution.md` to v1.3.1 (stack line clarified:
      existing instance; legacy `VisaEntry` preserved read-only; target database
      `VisaFusion`); added a clarification note to `adr/ADR-0001.md`.
- [ ] (Not applicable — Option B not selected.)
- [x] Updated this file's Status and `knowledge-graph/traceability-matrix.md`;
      `knowledge-graph/kg.json` updated with the GAP-0003 Risk node and edges.
