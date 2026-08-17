# GAP-0004 — Identity import blocked: 98 legacy `agents.emailid` values exceed the 256-char `AspNetUsers.Email` column

- **Status**: OPEN — owner decision required
- **Detected**: 2026-08-16 (T032 validation; `identity` migration step)
- **Reporter**: VisaFusion migration execution (deterministic rules: never guess)
- **Affected feature**: SPEC-0004 identity import (T037, FR-004, BR-002, AC-004); SPEC-0006 T032 validation scenarios that require an Identity user with a role binding (`usp_RecordEntryStatusChange` `@ActorUserId`, `usp_ProvisionSuperUser`)

## 1. Finding

The `identity` migration step (`src/VisaFusion.Migration/Identity/IdentityImporter.cs`)
inserts the legacy `emailid` value verbatim into `AspNetUsers.Email`
(`nvarchar(256)`, standard ASP.NET Core Identity schema). 98 of 4,218 legacy
`agents` rows carry `emailid` values longer than 256 characters — semicolon- or
comma-joined multi-email junk values (e.g. `deltrav@in.ibm.com;
travel.desk@geind.ge.com; deprabhu@cisco.com; …`). The first such row aborts the
import with:

> String or binary data would be truncated in table 'VisaFusion.dbo.AspNetUsers',
> column 'Email'. Truncated value: 'deltrav@in.ibm.com; travel.desk@geind.ge.com;
> deprabhu@cisco.com; devendra.parekh@parekhnet.com; dha…'

No handling rule for oversized emails is documented anywhere: the SPEC-0004
mapping table (`data-model.md` §5) specifies `Email` = `emailid` "direct copy",
and the plan (`complete_migration_plan.md` §7) specifies only the password
hashing rule. The importer has no length guard, and `IdentityImportTests` cover
only the no-plaintext invariant and role seeding — not email length.

## 2. Evidence

| # | Artifact | Statement |
|---|----------|-----------|
| 1 | Live legacy data (2026-08-16, sqlcmd) | `agents`: 4,218 rows, 98 with `LEN(emailid) > 256`; `Udaan_users`: 2,365 rows, 0 oversized; `registration`: 43 rows, 0 oversized |
| 2 | `specs/004-data-model-migration/data-model.md` §5 | `Email` = `emailid` direct copy (no truncation/skip rule) |
| 3 | `library/complete_migration_plan.md` §7 | Password hashing rule only; no email-length rule |
| 4 | `src/VisaFusion.Migration/Identity/IdentityImporter.cs` | `emailid` read verbatim (column 1), inserted into `AspNetUsers.Email`; no length guard |
| 5 | `tests/IntegrationTests/IdentityImportTests.cs` | Covers no-plaintext invariant + role seeding only |
| 6 | Live target state (2026-08-16, sqlcmd) | Partial import: `AspNetUsers` 11 rows, `AspNetRoles` 5 (su/adm/emp/agt/guest), `AspNetUserRoles` 11 — the step aborted on agent #12 |

## 3. Impact

- The `identity` step cannot complete as written; the migration sequence is
  blocked at this step (run state: `preflight;snapshot;schema;copy;cleanse`
  complete, `identity` failed).
- SPEC-0006 T032 validation scenarios that need an Identity user with a role
  binding are blocked: `usp_RecordEntryStatusChange` raises "Actor role not
  found" for any `@ActorUserId` (the 11 partial users have no role bindings
  beyond `agt`, and no `su`/`adm`/`emp` user exists), and `usp_ProvisionSuperUser`
  requires an existing `su` actor.
- The 11 partially-imported agents are a recovery hazard: the importer's
  in-memory first-source-wins dedup does not consult the target DB, so a plain
  re-run would create duplicate usernames for those 11 rows. Recovery must
  either truncate `AspNetUsers`/`AspNetUserRoles` first or make the importer
  idempotent against the target.
- The 98 affected agents would have no login account under any skip-based
  resolution (0.07% of the agent population; agents authenticate by
  `Description` username, and their `emailid` is a contact field, not a login
  credential).

## 4. Owner decision required

Choose one of:

| Option | Behavior | Risk |
|--------|----------|------|
| **A. Skip oversized-email rows + record (recommended)** | Importer skips rows whose `emailid` exceeds 256 chars, records them in the identity report (mirroring the existing `SkippedDuplicates` mechanism), and continues. 98 agents get no login; documented for business review. | Small importer change + test; no data invented; matches the project's quarantine-not-guess principle. |
| **B. Truncate to 256 chars** | Importer truncates `emailid` to 256 chars. | Corrupts multi-email junk values; invents a transform the spec does not define; the stored value is not a usable email anyway. Not recommended. |
| **C. Clean the legacy source first** | Business cleans the 98 `agents.emailid` values in the legacy DB, then the import re-runs. | Legacy is read-only (FR-008/FR-010); requires a sanctioned data-cleanup pass before cutover. |
| **D. Widen `AspNetUsers.Email`** | Change the Identity schema to `nvarchar(max)`. | Deviates from the standard Identity schema; the junk values remain junk; Identity email features (reset, confirmation) still unusable for those rows. Not recommended. |

**Recommended**: Option A — deterministic, reviewable, reversible, and the
closest to the project's "quarantine/flag ambiguous data, never guess-correct"
principle. It unblocks the migration and the T032 validation scenarios that
need a role-bound Identity user.

## 5. Evidence

- Live legacy query (2026-08-16): `SELECT COUNT(*) FROM dbo.agents WHERE LEN(emailid) > 256` → 98.
- Live target query (2026-08-16): `AspNetUsers` 11, `AspNetRoles` 5, `AspNetUserRoles` 11.
- `src/VisaFusion.Migration/Identity/IdentityImporter.cs` (import pipeline, no email guard).
- `specs/004-data-model-migration/data-model.md` §5 (direct-copy mapping).
- `tests/IntegrationTests/IdentityImportTests.cs` (coverage scope).

## 6. Resolution trail

- [ ] Owner decision on Option A/B/C/D.
- [ ] (If A) importer change + `IdentityReportSkipped` extension + test; re-run `identity` step from a clean identity state.
- [ ] Update this file's Status and `knowledge-graph/traceability-matrix.md`.