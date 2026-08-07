# API Contract: Target Architecture (SPEC-0003) — `/api/v1` Scaffolding

**Date**: 2026-08-06 | **Spec**: [SPEC-0003](../spec.md)

This contract defines the **scaffolding** surface only (spec §15, FR-004, clarification
Q5). Per-module endpoints are defined in their own module specs.

## General

- Base path: `/api/v1`
- Format: JSON (UTF-8)
- Auth: bearer token (JWT) — `Authorization: Bearer <token>`
- Errors: standardized problem-details JSON (see below)

## Endpoints

### 1. Health / Version

`GET /api/v1/health`

| Field | Type | Description |
|-------|------|-------------|
| `status` | string | `ok` when the service is running |
| `version` | string | Api surface version, e.g. `1` |
| `environment` | string | e.g. `Development` / `Production` |

Success: `200 OK`. No auth required (health probe).

### 2. Representative endpoint per area (read-only)

One read-only endpoint per area proves routing, versioning, bearer-token auth, and
shared-Core wiring end-to-end. The representative endpoint is a **read-only list** stub
that returns a minimal DTO from the area's shared Core service (no business logic).

Pattern:

`GET /api/v1/{area}` (e.g. `GET /api/v1/employee`, `GET /api/v1/agent`, ...)

| Field | Type | Description |
|-------|------|-------------|
| `items` | array | empty or minimal stub list |
| `count` | integer | number of items |

Auth: bearer token required; endpoint is authorized for the area's role per the migration
plan §4 role matrix (scaffolding enforces the policy; actual module endpoints carry the
full matrix).

Success: `200 OK`. Unauthorized: `401` (missing/invalid token). Forbidden: `403`.

## Error Format (problem details)

```json
{
  "type": "https://tools.ietf.org/html/rfc9110#section-15.6.1",
  "title": "Unauthorized",
  "status": 401,
  "traceId": "..."
}
```

Standardized for all endpoints (spec §18): `400` validation, `401` unauthenticated,
`403` unauthorized, `404` not found, `500` unhandled (logged via Serilog, traced via
OpenTelemetry).

## Versioning

- `/api/v1` is the current surface; future breaking changes use `/api/v2` (spec §15).
- The version is exposed via the health endpoint and enforced by route constraint.

## Traceability

- FR-004 → this contract
- FR-010 (JWT auth) → "Auth" + error format
- AC-002 (single process serves Web + `/api/v1`) → verified by quickstart TS-002
- AC-003 (shared business rule via Web and Api) → verified by quickstart TS-003
