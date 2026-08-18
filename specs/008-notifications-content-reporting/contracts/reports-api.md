# API Contract: Reporting Module — Operational Reports (SPEC-0008)

**Date**: 2026-08-18 | **Spec**: [SPEC-0008](../spec.md)

Defines the on-screen operational report endpoints (spec §15). Backs the legacy pages `pendinglist.asp`, `todaySubmission*.asp`, `todayCollection*.asp`, `todayTransaction.asp`, `dailyVisaFee.asp`, `dailybill.asp` (`@findings/modernization_plan.md` §6.6).

## General

- Base path: `/api/v1`
- Format: JSON (UTF-8)
- Auth: `emp`/`adm`/`su` (JWT bearer). `agt`/`guest` receive `403` (AC-008).
- Data access: parameterized EF Core LINQ only — no string-built SQL (NFR-002; fixes the §6.6 SQLi finding).
- Determinism: fixed ORDER BY for the same input date range (NFR-006).
- Errors: standardized problem-details JSON: `400` (invalid/out-of-range date inputs rejected before any query runs), `401`/`403`.
- v1 renders on-screen only; report dispatch by email is deferred (owner Q2:A, 2026-08-18) and will reuse `POST /api/v1/notifications/email` when enabled.

## Endpoints

| # | Endpoint | Policy | Legacy page | Output rows |
|---|----------|--------|-------------|-------------|
| 1 | `GET /api/v1/reports/agent-status/today` | `emp`/`adm`/`su` | (route pre-registered SPEC-0005 T030) | agent status snapshot for today |
| 2 | `GET /api/v1/reports/pending` | `emp`/`adm`/`su` | `pendinglist.asp` | pending entries (refno, pax, agent, country, submitted date) |
| 3 | `GET /api/v1/reports/today-submission` | `emp`/`adm`/`su` | `todaySubmission*.asp` | entries submitted today |
| 4 | `GET /api/v1/reports/today-collection` | `emp`/`adm`/`su` | `todayCollection*.asp` | collections received today |
| 5 | `GET /api/v1/reports/today-transaction` | `emp`/`adm`/`su` | `todayTransaction.asp` | today's transactions |
| 6 | `GET /api/v1/reports/daily-visa-fee` | `emp`/`adm`/`su` | `dailyVisaFee.asp` | visa fees by country/day |
| 7 | `GET /api/v1/reports/daily-bill` | `emp`/`adm`/`su` | `dailybill.asp` | daily bills |

Common query parameters (all optional, validated):

| Param | Type | Notes |
|-------|------|-------|
| `dateFrom` | date | ISO-8601; must be a real calendar date |
| `dateTo` | date | ISO-8601; must be ≥ `dateFrom` when both present |
| `agentId` | int | optional filter for agent-scoped rows |

Invalid dates produce `400` before query execution (spec §17). Row DTO field names are defined in `src/VisaFusion.Api/Contracts/ReportContracts.cs` during implementation and mirror the legacy column names the report pages render.
