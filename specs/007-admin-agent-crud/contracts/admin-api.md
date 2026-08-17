# API Contract: Admin Module — Security-Day, Users, Superusers (SPEC-0007)

**Date**: 2026-08-17 | **Spec**: [SPEC-0007](../spec.md) | **Data model**: [data-model.md](../data-model.md)

This contract defines the **Admin** module endpoints delivered by this feature (spec §15; `library/complete_migration_plan.md` §4.3 lines 171-172, 178, 194). It backs the legacy pages `openForDay.asp`, `closeForDay.asp`, `securityHome.asp`, `addNewUser.asp`, `editdonetest.asp`, `deleteUser.asp`/`deleteSubmit.asp`.

## General

- Base path: `/api/v1`
- Format: JSON (UTF-8)
- Auth: bearer token (JWT) — `Authorization: Bearer <token>`
- Authorization: Phase-0 policies (verified `AuthorizationPolicies.cs`): `SecurityGate` (roles `adm`,`su`), `UserManagement` (roles `adm`,`emp` — **DP-001 correction** from `adm,su`; `su` passes via the inherited `adm` claim), `SuperUserOnly` (claim-based `su`).
- Errors: standardized problem-details JSON: `400` validation, `401` unauthenticated, `403` unauthorized, `404` not found, `409` conflict, `500` unhandled.

## 1. `POST /api/v1/admin/security-day/open` — Open the working day (FR-008, AC-004)

Requires `SecurityGate`. Backs `openForDay.asp` (legacy anonymous INSERT — now `adm`/`su` only, BR-003).

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `date` | date | yes | the working day (defaults to server-local today) |

Server behavior: inserts a `SecurityDay` row with `Openingtime`/`Openby` (actor username). `409` when the day is already open. **Concurrency (CHK022)**: the operation is atomic per date — the unique-date constraint makes concurrent opens resolve to a single winner; the loser receives `409`. Success: `200 OK`.

## 2. `POST /api/v1/admin/security-day/close` — Close the working day (FR-008, AC-004)

Requires `SecurityGate`. Backs `closeForDay.asp` (legacy anonymous UPDATE — now `adm`/`su` only, BR-003).

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `date` | date | yes | the working day |

Server behavior: sets `Closingtime`/`Closedby` on the open row. `404` when no open row exists for the date. **Concurrency (CHK022)**: a close racing an open for the same date either closes the row (winner) or returns `404` (no open row at execution time) — no partial state. Success: `200 OK`.

## 3. `GET /api/v1/admin/security-day/today` — Current day status (FR-008)

Requires `SecurityGate`. Backs `securityHome.asp`. Returns the open/closed state for today. Success: `200 OK`.

## 4. `POST /api/v1/admin/users` — Create user (FR-005, AC-003)

Requires `UserManagement` (`adm`,`emp`; **DP-001**). Backs `addNewUser.asp`/`editdonetest.asp`.

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `username` | string | yes | unique |
| `password` | string | yes | hashed; never plaintext |
| `role` | string | yes | whitelist enum: `adm`, `emp`, `agt`, `guest` — `su` rejected with `400` (BR-004) |
| `agentId` | int? | no | required when `role=agt` (claim link) |

Server behavior: role validated against the whitelist server-side (closes the legacy self-registration→SU escalation, §2.2). Success: `201 Created`.

## 5. `POST /api/v1/admin/superusers` — Provision super-user (FR-006, AC-003)

Requires `SuperUserOnly` (claim-based `su`). Audited (spec §19). Backs the su-provisioning path.

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `username` | string | yes | existing account to elevate |

Server behavior: grants `su` role + `SuperUser` claim; audit event recorded. Success: `200 OK`.

## 6. `POST /api/v1/admin/users/{id}/deactivate` — Deactivate user (FR-007, FR-023, AC-018)

Requires `UserManagement`. Backs `deleteUser.asp`/`deleteSubmit.asp` (legacy hard-delete — now deactivation). Deactivating an `su` target additionally requires `SuperUserOnly` (FR-007). Login blocked; row and audit references preserved; reversible. Success: `200 OK`.