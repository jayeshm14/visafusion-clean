# API Contract: Agents Module (SPEC-0007)

**Date**: 2026-08-17 | **Spec**: [SPEC-0007](../spec.md) | **Data model**: [data-model.md](../data-model.md)

This contract defines the **Agents** module endpoints delivered by this feature (spec §15; `library/complete_migration_plan.md` §4.3 lines 162-163, 193). It backs the legacy pages `editdoneagent1.asp`, `editdonebyagent1.asp`, `listforagents.asp`, `agentpaxStatus.asp`, `searchPax*`, `searchEntry*`, `agentStatement*`, `Agent.asp`, `AgentAccount.asp`.

## General

- Base path: `/api/v1`
- Format: JSON (UTF-8)
- Auth: bearer token (JWT) — `Authorization: Bearer <token>`
- Authorization: Phase-0 policies (verified `AuthorizationPolicies.cs`): `AgentSelf` (roles `agt`,`emp`,`adm`,`su`), `AgentLedger` (roles `agt`,`emp`,`adm`,`su`), `AdminPanel` (roles `adm`,`su`). Own-agent scoping uses the claim-bound `AgentId` (`IdentityClaims.AgentIdClaimType`), never a query string (BR-007, AC-013).
- Errors: standardized problem-details JSON: `400` validation, `401` unauthenticated, `403` unauthorized, `404` not found, `409` conflict, `500` unhandled.
- Pagination: list endpoints default 50, max 200.

## 1. `PUT /api/v1/agents/{id}` — Update agent (FR-003, AC-001)

Requires `AdminPanel`. Backs `editdoneagent1.asp`.

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `companyname` | string? | no | |
| `description` | string? | no | |
| `street1`/`street2`/`area`/`city`/`pincode` | string? | no | address |
| `phoneno`/`faxno`/`emailid`/`smsno` | string? | no | contact |
| `directorname`/`directorPH`/`acMgrPH`/`visaInchargeName`/`visaInchargePH` | string? | no | people |
| `acno`/`payment` | string? | no | financial |
| `taai`/`tafi`/`membership`/`iata` | string? | no | memberships |

Server behavior: at least one field required; `404` when `{id}` does not exist. Success: `200 OK` with the updated agent.

## 2. `PUT /api/v1/agents/{id}/self` — Agent updates own record (FR-020, AC-014)

Requires `AgentSelf`. Backs `editdonebyagent1.asp`. The `{id}` must equal the claim-bound `AgentId`; otherwise `403` (BR-007). Same field set as §1. Success: `200 OK`.

## 3. `GET /api/v1/agents/{id}/entries` — Agent's entries list (FR-017, AC-012)

Requires `AgentSelf`. Backs `listforagents.asp`. `agt` callers may only read their own `{id}` (claim-bound); `emp`/`adm`/`su` may read any. Returns a paginated list of the agent's entries (refno, paxname, travel date, status). Optional `?q=` keyword filter (FR-021, `Search` policy) matching refno/paxname; scoping enforced by the claim-bound `{id}` (BR-007). Success: `200 OK`.

## 3a. `GET /api/v1/agents/{id}/statuses` — Agent's passenger statuses (FR-018, AC-012)

Requires `AgentSelf`. Backs `agentpaxStatus.asp`. `agt` callers may only read their own `{id}` (claim-bound); `emp`/`adm`/`su` may read any. Returns the passenger statuses for the agent's entries (paxname, refno, status, updated). Optional `?q=` keyword filter (FR-021, `Search` policy). Success: `200 OK`.

## 4. `GET /api/v1/agents/{id}/statement` — Agent's financial statement (FR-019, AC-012)

Requires `AgentLedger`. Backs `agentStatement*`. `agt` callers may only read their own `{id}` (BR-008); `emp`/`adm`/`su` may read any. Returns the agent's ledger summary (debits, credits, balance). Success: `200 OK`.

## 5. `GET /api/v1/agents` — Agent list (FR-002, AC-001)

Requires `AdminPanel`. Backs `viewagent.asp`. Paginated; optional keyword filter (name/company). Success: `200 OK`.

## 6. `POST /api/v1/agents` — Create agent + `agt` login (FR-001, BR-009, AC-017)

Requires `AdminPanel`. Backs `addnewagents.asp`/`newagent.asp`. Single atomic operation: creates the `Agent` row and the linked `agt` login together.

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `companyname` | string | yes | agent name |
| `username` | string | yes | login username (unique) |
| `password` | string | yes | initial password (hashed; never plaintext) |
| `emailid` | string? | no | |
| `phoneno` | string? | no | |
| (other agent fields) | string? | no | as §1 |

Server behavior: transaction — agent row + `agt` user + `AgentId` claim link; rollback on any failure. `409 Conflict` when the `username` already exists (CHK025). The initial `password` is delivered out-of-band (manual handover); email/SMS delivery is Phase 2 Notifications (CHK002). Success: `201 Created` with the new agent id.

## 7. `POST /api/v1/agents/{id}/deactivate` and `POST /api/v1/agents/{id}/reactivate` — Lifecycle (FR-004, FR-022, AC-016)

Require `AdminPanel`. Deactivate sets the `Active` flag to the inactive convention (R-007) and blocks the linked login; reactivate restores both. `404` when `{id}` does not exist. Success: `200 OK`.