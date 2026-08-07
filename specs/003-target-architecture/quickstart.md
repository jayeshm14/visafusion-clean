# Quickstart: Target Architecture (SPEC-0003)

**Date**: 2026-08-06 | **Spec**: [SPEC-0003](../spec.md)

This guide proves the scaffolding works end-to-end. It maps to the spec's Test Scenarios
(TS-001..TS-005) and Acceptance Criteria (AC-001..AC-007). Implementation details live in
`tasks.md` and the implementation phase; this is a validation/run guide only.

## Prerequisites

- .NET 8 SDK installed.
- SQL Server reachable with the existing `VisaEntry` database (or a local dev copy).
- Connection string configured via User Secrets / `appsettings.Development.json`
  (never committed to source — NFR-004).

## Setup

```bash
# from repo root
dotnet restore VisaFusion.sln
dotnet build VisaFusion.sln
```

## Validation scenarios

### TS-001 — Solution builds cleanly (AC-001)

```bash
dotnet build VisaFusion.sln
```

**Expected**: build succeeds with all six projects (`VisaFusion.Web`, `VisaFusion.Api`,
`VisaFusion.Core`, `VisaFusion.Data`, `VisaFusion.Identity`, `VisaFusion.Jobs`) and the
three test projects. No warnings treated as errors.

### TS-002 — App boots; Web UI and `/api/v1` both respond (AC-002)

```bash
dotnet run --project src/VisaFusion.Web
```

**Expected**:
- Web UI loads at the root URL (Razor Pages Areas render).
- `GET /api/v1/health` returns `200` with `{"status":"ok",...}`.
- One representative endpoint per area (e.g. `GET /api/v1/employee`) returns `200` when
  called with a valid bearer token, `401` without one.

### TS-003 — Shared business rule via Web and Api (AC-003)

Invoke a representative rule (e.g. Canada DOB requirement) through both entry points and
compare results.

**Expected**: the same rule returns the same outcome via the Web UI and via the `/api/v1`
endpoint, proving shared-Core enforcement (FR-003).

### TS-004 — Security scan (AC-004, AC-005)

```bash
# scan for plaintext credentials and string-concatenated SQL
grep -rniE "pwd=|password=|uid=sa|sa123" src/ tests/   # expect no matches
grep -rniE "SELECT .*\+|EXEC\(|sp_executesql" src/     # expect no string-concatenated SQL
```

**Expected**: no plaintext credentials, no hardcoded secrets, no string-concatenated SQL
in the solution (NFR-003, §12).

### TS-005 — Backdoor query parameters inert (AC-006)

Request the Web UI and `/api/v1` with the legacy backdoor query parameters
(`udaanappraj123guruadm`, `udaan12345functiondisplaymarquee`).

**Expected**: no route recognizes them; behavior is unchanged (no effect) — the backdoor
is not carried forward (§12).

## Definition of Done

- All five scenarios pass.
- Solution builds and runs with no configuration beyond SQL Server (AC-007).
- No secrets in source; no string-concatenated SQL (AC-004/AC-005).

## References

- API surface: [contracts/api-v1-scaffolding.md](contracts/api-v1-scaffolding.md)
- Solution structure: [contracts/solution-structure.md](contracts/solution-structure.md)
- Data surface: [data-model.md](data-model.md)