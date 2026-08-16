# API Contract: Entries Module (SPEC-0006)

**Date**: 2026-08-14 | **Spec**: [SPEC-0006](../spec.md) | **Data model**:
[data-model.md](../data-model.md) | **Deferred routes**:
[secured-write-routes.md](../../005-scaffold-identity-rbac/contracts/secured-write-routes.md)

This contract defines the **Entries** module controller set delivered by this feature
(spec §15; `library/complete_migration_plan.md` §5 line 189). It backs the legacy pages
`makeEntry`, `insertEntry`, `editentry*`, `editdone`, `sendawbgo`. One controller set
per module; other modules land with their own features (clarification Q4).

## General

- Base path: `/api/v1`
- Format: JSON (UTF-8)
- Auth: bearer token (JWT) — `Authorization: Bearer <token>`
- Authorization: all write endpoints require the Phase-0 **`EntryOperations`** policy
  (verified `AuthorizationPolicies.cs:22,42` — roles `emp`, `adm`, `su`; FR-009)
- Errors: standardized problem-details JSON (Phase-0 exception handling): `400`
  validation, `401` unauthenticated, `403` unauthorized, `404` not found, `409`
  conflict, `500` unhandled. All errors carry a correlation ID (NFR-006).
- Pagination: list endpoints default 50, max 200 (spec §13).

## 1. `POST /api/v1/entries` — Create entry (FR-008, AC-007)

Requires `EntryOperations`. Backs `makeEntry`/`insertEntry`.

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `paxname` | string | yes | |
| `passportno` | string | yes | |
| `dateOfBirth` | date? | no | |
| `category` | int? | no | |
| `totalPassengers` | int? | no | |
| `travelDate` | date? | no | |
| `remarks` | string? | no | external remark |
| `agentInstruction` | string? | no | |

Server behavior:
- Allocates the reference number via `usp_AllocateNextRefno` (BR-001, AC-003).
- Creates the `Entry` aggregate with ≥ 1 `EntryPassenger` (BR-005; invariant enforced
  by `VisaFusion.Core.EntryService`).
- Bookable-date rule enforced transactionally by `HolidayService` (BR-003) where a
  travel date is supplied.

Success: `201 Created`

| Field | Type | Description |
|-------|------|-------------|
| `refno` | int | allocated reference number |
| `etag` | string | `Entry.RowVersion` as base64 — required for later `If-Match` (AC-011) |
| `entry` | object | the created entry (see §2 response shape) |

Errors:
- `400` — validation failure (problem-details; e.g. non-bookable travel date with
  reason, missing required passenger fields).
- `409` — duplicate reference number (problem-details; §18).

## 2. `GET /api/v1/entries/{refno}` — Get entry by reference number (FR-008)

Read-only; requires the same role set as write operations - authenticated with `emp`,`adm` or `su` role per
`EntryOperations` (legacy `refnoDetail.asp` performed no role check — it included the unauthenticated `connection.asp`;
this policy matrix is deliberate hardening applied uniformly to the Entries module).

Success: `200 OK`

| Field | Type | Description |
|-------|------|-------------|
| `refno` | int | |
| `paxname` | string | |
| `passportno` | string | |
| `agent` | int? | owning agent id |
| `status` | int? | current entry status |
| `travelDate` / `subdate` / `coldate` / `receivedate` / `sentDate` | date? | |
| `totalPassengers` | int? | |
| `passengers` | array | `EntryPassenger` list (id, paxname, passportno, dateOfBirth, category) |
| `paxStatuses` | array | `PaxCountryStatus` chain (paxId, countryId, statusId, remarks, fees) |
| `etag` | string | `Entry.RowVersion` as base64 — for `If-Match` on PUT (AC-011). Wire format: base64 of the 8-byte rowversion, sent as the JSON field value (no quotes) and echoed in the `If-Match` header as an HTTP quoted-string: `If-Match: "<base64>"` (RFC 7232 §2.3.2) |

Errors:
- `404` — refno not found (problem-details).

## 3. `PUT /api/v1/entries/{refno}` — Update entry (FR-008, AC-011)

Requires `EntryOperations`. Backs `editentry*`/`editdone`. **Optimistic concurrency**
(clarify session 2026-08-14 Q1): `If-Match` header with the current ETag is **required**;
a stale write → `409 Conflict`.

| Header | Value |
|--------|-------|
| `If-Match` | ETag from the last `GET`/`POST` response (`Entry.RowVersion` as base64) — HTTP quoted-string: `If-Match: "<base64>"` (RFC 7232 §2.3.2); server compares against the current rowversion |

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `paxname` | string | yes | |
| `passportno` | string | yes | |
| `dateOfBirth` | date? | no | |
| `category` | int? | no | |
| `totalPassengers` | int? | no | |
| `travelDate` | date? | no | |
| `remarks` | string? | no | |
| `agentInstruction` | string? | no | |

Success: `200 OK` with the updated entry (same shape as §2) and a fresh `etag`.

Errors:
- `400` — validation failure (problem-details).
- `404` — refno not found.
- `409` — stale write: `If-Match` ETag does not match the current `RowVersion`
  (problem-details; AC-011).

## 4. `POST /api/v1/entries/{refno}/status` — Change entry status (FR-005, AC-004)

Requires `EntryOperations`. Backs the legacy status-change flow. Calls
`usp_RecordEntryStatusChange` explicitly via `VisaFusion.Core.EntryService` (not a
trigger; FR-005).

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `paxId` | int | yes | passenger id |
| `countryId` | int | yes | country |
| `newStatusId` | int | yes | must exist in `dbo.status` |
| `remarks` | string? | no | |
| `changeDate` | date? | no | defaults to server time |

Server behavior:
- Resolves the authenticated caller's `AspNetUsers.Id` from the JWT `sub` claim and
  passes it as `@ActorUserId` — **never a formatted actor string** (anti-spoofing,
  GR-0004; interface contract for `EntryService`).
- The proc atomically updates `PaxStatus.statusID` and writes `StatusHistory` +
  `bighistory` rows in one transaction (AC-004).

Success: `200 OK`

| Field | Type | Description |
|-------|------|-------------|
| `statusHistoryId` | bigint | `@NewStatusHistoryId` output |
| `updatedBy` | string | `{role}:{username}` composed by the proc (GR-0004) |

Errors:
- `400` — nonexistent status code (problem-details with valid taxonomy reference;
  §18), or no `PaxStatus` row for the given refno/paxId/countryId.
- `404` — refno not found.

## 5. `POST /api/v1/entries/{refno}/awb` — Record sent-AWB (FR-008)

Requires `EntryOperations`. Backs `sendawbgo`. Records the sent-AWB event for the
entry (legacy `sentawb`/`sentmails` behavior per `complete_migration_plan.md` §5).

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `awb` | string | yes | airway-bill number |
| `toEmail` | string? | no | recipient email |
| `remark` | string? | no | |

Success: `204 No Content`

Errors:
- `400` — validation failure: empty `awb` (legacy guard: `sendawbgo.asp:24` `if trim(request("awb"))=""`; no charset rule exists in legacy — preserved as-is per Legacy-as-Source-of-Truth).
- `404` — refno not found.

## 6. Deferred (documented-only — NOT implemented in this feature)

Per `secured-write-routes.md` §3.1 and spec §15:

| Route | Role rules | Backing proc | Status |
|-------|------------|--------------|--------|
| `POST /api/v1/admin/superusers` | **su-only** (`SuperUserOnly` claim policy), audited | `usp_ProvisionSuperUser` (script 06) | **Deferred** — proc created per script; route NOT registered by this feature |

## Traceability

- FR-003/FR-004/AC-003 → §1 (refno allocation via `usp_AllocateNextRefno`)
- FR-005/BR-002/AC-004 → §4 (`usp_RecordEntryStatusChange`)
- FR-006/BR-003/AC-005 → `HolidayService` (C#) + `fn_IsEmbassyClosed` (script 02)
- FR-007/BR-004/AC-006 → §6 (deferred; proc + audit table created)
- FR-008/FR-009/AC-007/AC-008 → §1-§5 (Entries endpoints, `EntryOperations` policy)
- AC-011 → §3 (If-Match/ETag optimistic concurrency)