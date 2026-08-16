# Implementation Plan: Core Entry Workflow

**Branch**: `006-core-entry-workflow` | **Date**: 2026-08-14 | **Spec**: [SPEC-0006](spec.md)

**Input**: Feature specification from `/specs/006-core-entry-workflow/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command; its definition describes the execution workflow.

## Summary

Deliver Phase 1 of the phased rollout (`library/ExecutionPlan.md` Phase 1, items 4–6):
the core entry workflow. The 52-table data model was already migrated by SPEC-0004
(entities + `VisaEntryDbContext` mappings verified this session: `Entry`→`Mainentry`
`VisaEntryDbContext.cs:111`, `EntryPassenger`→`entryDetails` `:163`,
`PaxCountryStatus`→`PaxStatus` `:183`). This feature delivers the remaining Phase 1
surface:

1. **Stored procedures/functions** — recreate the owner-supplied T-SQL scripts
   verbatim (`specs/006-core-entry-workflow/scripts/01-08`, run in order at cutover):
   `RefnoSeq`/`usp_AllocateNextRefno` (01), `fn_IsEmbassyClosed` (02),
   `usp_RecordEntryStatusChange` (08 — final, supersedes 06/07 per GR-0004),
   `usp_ProvisionSuperUser` + `SuperUserProvisioningAudit` (06). Report/cleansing/
   normalization objects (03/04/05) are created per the scripts but are out of this
   feature's API scope (GR-0002).
2. **`Entry` aggregate hardening** — add `RowVersion` (rowversion) to `Entry` for
   optimistic concurrency (clarify session 2026-08-14 Q1; AC-011); the aggregate
   invariants (≥1 passenger, valid refno) live in `VisaFusion.Core.EntryService`
   (currently a placeholder, verified `EntryService.cs:12`).
3. **`HolidayService`** — implement the authoritative transactional
   holiday/weekly-off/Sunday check in `VisaFusion.Core` (currently a placeholder,
   verified `HolidayService.cs:12`); `fn_IsEmbassyClosed` remains the read-only
   reporting mirror (FR-006, BR-003).
4. **Web API layer** — the **Entries** module controller set under `/api/v1`
   (spec §15): `POST /entries`, `GET /entries/{refno}`, `PUT /entries/{refno}`
   (If-Match/ETag), `POST /entries/{refno}/status`, `POST /entries/{refno}/awb`,
   all gated by the Phase-0 `EntryOperations` policy (verified
   `AuthorizationPolicies.cs:22,42` — emp/adm/su). `POST /api/v1/admin/superusers`
   is a documented-only deferred contract (spec §15; `secured-write-routes.md` §3.1).

## Technical Context

**Language/Version**: C# 12 / .NET 8 (LTS) — fixed by SPEC-0003 NFR-005.

**Primary Dependencies**: EF Core 8 (already referenced by `VisaFusion.Data`),
ASP.NET Core Identity 8 (already wired in `VisaFusion.Web/Program.cs:77`), xUnit +
WebApplicationFactory (existing three test projects). No new NuGet packages are
required.

**Storage**: SQL Server. Two databases:
- Legacy `VisaEntry` — read-only source of truth; never modified (SPEC-0004).
- Target `VisaFusion` — contains the EF-migrated business schema (38 entities,
  SPEC-0004) plus the identity store. The owner-supplied procs/functions run against
  the legacy-named physical tables (`Mainentry`, `entryDetails`, `PaxStatus`,
  `StatusHistory`, `bighistory`, `status`, `agents`, `AspNetUsers`/`AspNetRoles`/
  `AspNetUserRoles`) — the EF entities map to those exact names via `ToTable`
  (verified `VisaEntryDbContext.cs:111,163,183,223,246`), so the scripts run verbatim.

**Testing**: xUnit across the existing three test projects. Hermetic functional tests
use the `WebApplicationFactory` with token-minting (JWT signed with the test-config
key) to prove the 5-role matrix (anonymous→401, wrong role→403, correct role→
200/201/204 per contract §1-§5; deferred superuser endpoint NOT registered) without a live database. Integration tests (self-skipping when SQL Server
is unreachable, per the existing convention) execute the stored procedures against a
real SQL Server and assert atomicity/audit behavior (AC-003/AC-004/AC-006). Unit tests
cover `Entry` aggregate invariants, `HolidayService`/`fn_IsEmbassyClosed` rule parity,
and refno allocation logic.

**Target Platform**: Windows Server / SQL Server (same as legacy); the single-process
host `VisaFusion.Web` serves the Razor Pages UI + `/api/v1` (SPEC-0003 FR-002).

**Project Type**: Database + Web API feature over the existing solution — owner-supplied
T-SQL scripts recreated verbatim, `EntryService`/`HolidayService` placeholders in
`VisaFusion.Core` implemented, `RowVersion` added to the `Entry` entity in
`VisaFusion.Data`, Entries module endpoints in `VisaFusion.Api`.

**Performance Goals** (spec §13): `usp_AllocateNextRefno` < 50ms;
`usp_RecordEntryStatusChange` < 100ms; `fn_IsEmbassyClosed`/`HolidayService` < 10ms;
API entry operations < 500ms; list endpoints paginated (default 50, max 200).

**Constraints**:
- Owner-supplied T-SQL scripts are recreated **verbatim** — no behavior may be
  invented (GR-0001). Every `-- TODO: confirm column name` in the scripts is a
  pre-cutover verification task against the live schema (`sp_help` /
  `INFORMATION_SCHEMA.COLUMNS`), not a spec blocker.
- `usp_RecordEntryStatusChange` is called explicitly by `VisaFusion.Core.EntryService`
  (not a trigger); caller passes the authenticated `AspNetUsers.Id` as `@ActorUserId`
  (string, never a formatted actor string — anti-spoofing per GR-0004); the proc
  composes `UpdatedBy = {role}:{username}` with role precedence `su > adm > emp > agt`
  (verified `scripts/08_finalize_entry_status_change_updatedby.sql:33-123`).
- `usp_ProvisionSuperUser` is su-only (no `@Role` parameter), password passed
  pre-hashed, writes the `SuperUserProvisioningAudit` row; key columns `NVARCHAR(450)`
  matching the actual Identity schema (GR-0003 item 3 / GR-0004).
- `fn_IsEmbassyClosed` is intentionally a read-only reporting/BI mirror; the
  authoritative transactional check lives in `VisaFusion.Core.HolidayService`
  (owner-confirmed 2026-08-14, FR-006/BR-003).
- Status is free-form per legacy — no transition validation (clarification Q3).
- Refno allocation is legacy-compatible max+1, atomic via `usp_AllocateNextRefno`;
  gaps acceptable (clarification Q2, option A).
- PUT requires `If-Match` with the current ETag (`Entry.RowVersion`); stale write →
  409 (clarify session 2026-08-14 Q1; AC-011).
- No bulk entry endpoint (clarify session 2026-08-14 Q2 — §13 bulk line removed).
- Report/cleansing/normalization objects (scripts 03/04/05) are created per the
  scripts but are NOT exposed via this feature's API (GR-0002; clarify Q4).
- All queries parameterized; no plaintext password material in logs, responses, or
  configuration; no string-concatenated SQL.

**Scale/Scope**: 52 tables migrated (SPEC-0004, disposition §3); data-volume baseline
`Mainentry` ≈ 271,724 rows, `entryDetails` ≈ 312,655, `bighistory` ≈ 1.4M (spec §13,
verified `complete_migration_plan.md` §3 rows 75-77); 5 Entries-module endpoints + 1
deferred documented contract; 8 owner-supplied SQL scripts; 2 Core services
implemented; 1 entity modified (`Entry` + RowVersion); ~15-20 test cases across the
three test projects.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| # | Principle | Gate | Status |
|---|-----------|------|--------|
| I | Specification-First (SDD) | SPEC-0006 exists with all 24 required sections; all clarifications resolved (sessions 2026-08-13 Q1-Q4, 2026-08-14 Q1-Q2); Gap Reports GR-0001..GR-0004 all RESOLVED; no implementation before this plan | PASS |
| II | Legacy as Source of Truth | Every object traces to the owner-supplied scripts (01-08, recreated verbatim), `library/complete_migration_plan.md` §3/§4.2/§5, or `findings/*.md`; entity mappings verified against `TableCatalog.cs:114,117,118` and `VisaEntryDbContext.cs`; legacy pages mapped (`makeEntry`, `insertEntry`, `editentry*`, `editdone`, `sendawbgo` per `complete_migration_plan.md` §5 line 189); no invented business features; deferred endpoints are documented contracts only | PASS |
| III | Data Preservation & Integrity | No business tables dropped (only `dtproperties`); legacy `VisaEntry` untouched and read-only; `SuperUserProvisioningAudit` is the one genuinely new table, signed off by owner (GR-0003 item 1); migration idempotent and reversible where practical | PASS |
| IV | Traceability & Governance | FR↔architecture↔domain↔database↔API↔test matrix in spec §24; ADR for any policy gap (Risk 5); knowledge-graph and decision-log updates after implementation | PASS |
| V | Quality, Delivery & No-Assumption | Repo state verified 2026-08-14 (entities, DbContext mappings, policies, Core placeholders, scripts 01-08 all confirmed by tool calls this session); automated tests mandatory; solution must build; no guessing — all ambiguities closed via Gap Reports | PASS |

**Gate result**: PASS — no new projects, no new packages. One approved placement
deviation: `EntryService`/`HolidayService` implementations live in `VisaFusion.Data`
(interfaces stay in Core) per deviation-log entry 1 — mirror of SPEC-0005 deviation 5
(already recorded; no Complexity Tracking entry required).

**Post-design re-check (after Phase 1 design)**: PASS — the design (verbatim script
recreation, `RowVersion` on `Entry`, `EntryService`/`HolidayService` interfaces in
`VisaFusion.Core` with implementations in `VisaFusion.Data` per deviation-log entry 1,
Entries-module endpoints under `/api/v1` gated by the existing
`EntryOperations` policy, deferred superuser contract) derives exclusively from the
spec, the owner-supplied scripts, and the verified repository state. No invented
behavior.

## Project Structure

### Documentation (this feature)

```text
specs/006-core-entry-workflow/
├── plan.md                 # This file (/speckit.plan command output)
├── spec.md                 # SPEC-0006 (24 sections, clarifications + GR-0001..0004 resolved)
├── research.md             # Phase 0 output (/speckit.plan command)
├── data-model.md           # Phase 1 output (/speckit.plan command)
├── quickstart.md           # Phase 1 output (/speckit.plan command)
├── contracts/              # Phase 1 output (/speckit.plan command)
├── checklists/
│   └── requirements.md     # Specification quality checklist (PASS)
├── scripts/                # Owner-supplied T-SQL (01-08, recreated verbatim at cutover)
└── tasks.md                # Phase 2 output (/speckit.tasks command — NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
src/
├── VisaFusion.Core/
│   └── Application/
│       ├── EntryService.cs               # MODIFY — placeholder → Entry aggregate service (invariants, refno allocation, status change via usp_RecordEntryStatusChange, sent-AWB)
│       └── HolidayService.cs             # MODIFY — placeholder → authoritative holiday/weekly-off/Sunday transactional check
├── VisaFusion.Data/
│   ├── Persistence/
│   │   ├── Entities/Entry.cs             # MODIFY — add RowVersion (rowversion) for optimistic concurrency (AC-011)
│   │   └── VisaEntryDbContext.cs         # MODIFY — configure Entry.RowVersion (IsRowVersion)
│   └── (all other entities unchanged — SPEC-0004 delivered the 38-entity schema)
├── VisaFusion.Api/
│   ├── Endpoints/
│   │   ├── EntriesEndpoint.cs            # NEW — POST/GET/PUT /api/v1/entries, POST .../status, POST .../awb (EntryOperations policy)
│   │   └── (Auth/Public/Health/Employee/Representative endpoints unchanged)
│   ├── Contracts/
│   │   ├── CreateEntryRequest.cs         # NEW
│   │   ├── EntryResponse.cs              # NEW (includes ETag from RowVersion)
│   │   ├── UpdateEntryRequest.cs         # NEW
│   │   ├── ChangeEntryStatusRequest.cs   # NEW
│   │   └── RecordAwbRequest.cs           # NEW
│   └── (Authorization/AuthorizationPolicies.cs UNCHANGED — EntryOperations already exists)
├── VisaFusion.Web/
│   └── Program.cs                        # MODIFY — map Entries endpoints (pattern: existing endpoint mapping)
└── VisaFusion.Migration/
    └── (scripts 01-08 executed in order at cutover; no code change — SPEC-0004 tooling)
```

**Structure Decision**: Follows the existing seven-project layout delivered by
SPEC-0003/0004 (Web, Api, Core, Data, Identity, Jobs, Migration) — no new projects.
Business-rule interfaces live in `VisaFusion.Core` (`IEntryService`, `IHolidayService`);
their Data-accessing implementations live in `VisaFusion.Data` (approved deviation-log
entry 1, mirror of SPEC-0005 deviation 5) per the Constitution Engineering Process
(single-source rules shared by Web UI and API);
endpoints live in `VisaFusion.Api` following the existing minimal-API endpoint pattern
(static `Handle` methods, verified `AuthEndpoint.cs`/`EmployeeEndpoint.cs`); the
`RowVersion` column is added to the existing `Entry` entity in `VisaFusion.Data`.

## Complexity Tracking

> Fill ONLY if Constitution Check has violations that must be justified

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| — | — | — |

No violations. The owner-supplied scripts are recreated verbatim (no re-derivation —
GR-0001 fallback would only apply if the scripts did not exist); `RowVersion` is a
single additive column on the existing `Entry` entity; `EntryService`/`HolidayService`
extend existing placeholder interfaces (no new abstractions); the deferred superuser
endpoint adds no routes (documented contract only, per spec §15).