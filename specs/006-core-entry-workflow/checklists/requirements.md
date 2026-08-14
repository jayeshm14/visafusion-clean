# Specification Quality Checklist: Core Entry Workflow

**Purpose**: Validate specification completeness and quality before proceeding to planning
**Created**: 2026-08-13
**Updated**: 2026-08-14 (after GR-0002 resolution)
**Feature**: [spec.md](spec.md)

## Content Quality

- [x] No implementation details (languages, frameworks, APIs)
- [x] Focused on user value and business needs
- [x] Written for non-technical stakeholders
- [x] All mandatory sections completed

## Requirement Completeness

- [x] No [NEEDS CLARIFICATION] markers remain — **all resolved (clarify session 2026-08-13: Q1→B owner-supplied T-SQL scripts, Q2→A legacy max+1 refno, Q3→A free-form status, Q4→A Entries module only)**
- [x] Requirements are testable and unambiguous
- [x] Success criteria are measurable
- [x] Success criteria are technology-agnostic (no implementation details)
- [x] All acceptance scenarios are defined
- [x] Edge cases are identified
- [x] Scope is clearly bounded
- [x] Dependencies and assumptions identified

## Feature Readiness

- [x] All functional requirements have clear acceptance criteria
- [x] User scenarios cover primary flows (via Test Scenarios §23)
- [x] Feature meets measurable outcomes defined in Success Criteria
- [x] No implementation details leak into specification

## Audit Fixes Applied (2026-08-13)

- [x] §15 API Contracts now match `complete_migration_plan.md` §5 exactly (EntriesController: POST /entries, GET /entries/{refno}, PUT /entries/{refno}, POST /entries/{refno}/status, POST /entries/{refno}/awb; superusers deferred per secured-write-routes §3.1) — invented endpoints removed
- [x] `PaxStatus` target entity renamed to `PaxCountryStatus` (matches TableCatalog.cs:118 and §3 row 77)
- [x] Policy count fixed: 10 role-based + SuperUserOnly (not 11+1)
- [x] Disposition legend includes DROP (Results, country, hits, adcount, dtproperties)
- [x] Clarification Q1 re-pointed to `library/complete_migration_plan.md` §3 (verified lines 69-128)
- [x] Gap Report GR-0001 added for stored procs (source T-SQL absent from repo; "§15" citation does not exist)
- [x] `.specify/feature.json` updated to `specs/006-core-entry-workflow`

## Notes

- **Owner artifacts received 2026-08-14**: six T-SQL scripts in `specs/006-core-entry-workflow/scripts/` (01-06). GR-0001 RESOLVED.
- **GR-0002 RESOLVED (2026-08-14)**: (a) renamed mapping confirmed canonical (`RefnoSeq`/`sp_AllocateNextRefno`/`fn_IsEmbassyClosed`; the `fn_IsEmbassyClosed` read-only-mirror vs C# `HolidayService` split is intentional by design); (b) `usp_RecordEntryStatusChange` and `usp_ProvisionSuperUser` supplied in `scripts/06_status_change_and_superuser_provisioning.sql`. FR-005/FR-007, BR-002/BR-004, AC-004/AC-006 unblocked.
- **GR-0003 RESOLVED (2026-08-14)**: (1) `SuperUserProvisioningAudit` new table signed off and kept in scope; (2) all procedure prefixes standardized to `usp_` per `library/09_SQLServer_Data_Engineering.md` §Naming (scripts 01/03/04/05 renamed, script 06 already `usp_`); (3) Identity schema assumptions verified against actual schema — role seed CONFIRMED, `UNIQUEIDENTIFIER` key types CONTRADICTED and corrected to `NVARCHAR(450)` in script 06.
- **GR-0004 RESOLVED (2026-08-14)**: owner decision — `UpdatedBy` = `{role}:{username}` (e.g. `adm:jsmith`), role precedence `su > adm > emp > agt`, composed by the proc from the authenticated `@ActorUserId` (anti-spoofing; caller passes Identity user Id, never a formatted string). Final proc in `scripts/08_finalize_entry_status_change_updatedby.sql` (supersedes 06/07). Two regressions in the file-08 draft caught and corrected this session: `@ActorUserId UNIQUEIDENTIFIER`→`NVARCHAR(450)` (Identity keys are nvarchar(450) strings, `IdentityImporter.cs:149/245`; same fix as file 06 GR-0003 item 3) and `Mainentry.agentid`→`Mainentry.agent` (migration lines 642/677-681). `PaxStatus` verification CONFIRMED (migration lines 759-799, `IX_PaxStatus_PaxID` at 896-897) — the owner's flagged "still open" item is closed. FR-005/BR-002/AC-004 finalize against file 08.
- **Clarify session 2026-08-14 (2 questions)**: (1) PUT concurrency → **optimistic concurrency** — `RowVersion` on `Entry`, `If-Match` required, stale write → 409 (new AC-011, §15/§16/§18/§23 updated); (2) §13 "bulk entry operations" line → **removed** — no bulk entry endpoint in scope (legacy Entries pages have no bulk flow; the only bulk op in the plan is `bulk-collect`, Collection module, out of scope per clarify Q4). Data-volume baseline anchored to findings (`Mainentry` ≈ 271,724; `entryDetails` ≈ 312,655; `bighistory` ≈ 1.4M).
- **Pre-cutover task**: verify every `-- TODO: confirm column name` in the scripts against live schema (`sp_help` / `INFORMATION_SCHEMA.COLUMNS`) — owner-flagged caveat, carried forward from GR-0001.
- Spec is otherwise ready for `/speckit.plan`.