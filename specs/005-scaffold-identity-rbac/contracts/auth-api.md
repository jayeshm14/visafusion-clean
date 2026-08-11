# API Contract: Auth & Public Endpoints (SPEC-0005)

**Date**: 2026-08-11 | **Spec**: [SPEC-0005](../spec.md) | **Secured routes**:
[secured-write-routes.md](secured-write-routes.md) | **Web UI**: [web-ui.md](web-ui.md)

This contract defines the authentication and public write surface delivered by this
feature (spec §15). Per-module business endpoints are defined in their own module specs.

## General

- Base path: `/api/v1`
- Format: JSON (UTF-8)
- Auth: bearer token (JWT) — `Authorization: Bearer <token>` (Web UI uses cookies, see
  [web-ui.md](web-ui.md))
- Errors: standardized problem-details JSON (SPEC-0003): `400` validation, `401`
  unauthenticated, `403` unauthorized, `404` not found, `500` unhandled.

## 1. `POST /api/v1/auth/login`

Authenticates against the consolidated identity store and issues a JWT (FR-017).

| Field | Type | Description |
|-------|------|-------------|
| `username` | string | required |
| `password` | string | required |

Success: `200 OK`

| Field | Type | Description |
|-------|------|-------------|
| `token` | string | JWT bearer token |
| `username` | string | normalized username |
| `roles` | array<string> | roles of the principal (`su`→`adm` + `SuperUser` claim) |
| `agentId` | int? | present only for `agt` principals (claim-bound, FR-007) |

Token claims: `name`/`sub` (username), `role` (role set), `AgentId` (agt only),
`SuperUser` (su only).

Errors:
- `401` — bad credentials (problem-details).
- `403` with `{ rsn: "O" }` — `emp` login with no open-day `security` row for today
  (FR-018, day-gate). `rsn=C` is never produced: the legacy `rsn=C` branch
  (`authenticate.asp` line 72) is unreachable dead code, and reproducing it would
  change business behavior (FR-018 as clarified 2026-08-11).

The day-gate applies to `emp` logins only (verified `authenticate.asp` lines 62–79);
adm/su/agt/guest logins are not gated.

## 2. `POST /api/v1/auth/logout`

Authenticated. Revokes the client-side token/cookie (API: stateless JWT — client
discards; Web: cookie cleared via the cookie scheme). Success: `204 No Content`.

## 3. `POST /api/v1/auth/change-password`

Authenticated (any role). Self-service change-password replacing `changepassword.asp`
+ `newpassword.asp` (FR-019).

| Field | Type | Description |
|-------|------|-------------|
| `currentPassword` | string | required; must verify |
| `newPassword` | string | required; must meet the password policy (minimum 8 characters, no forced complexity) |
| `confirmPassword` | string | required; must equal `newPassword` |

Success: `204 No Content` — new password stored hashed via
`UserManager.ChangePasswordAsync` (no lowercasing, no plaintext).

Errors:
- `400` — wrong `currentPassword`, `newPassword` ≠ `confirmPassword`, or policy
  violation (< 8 characters) (mirrors legacy `changepassword.asp?flag=2|3`).
- `401` — unauthenticated.

## 4. `POST /api/v1/public/register`

Anonymous (public-by-design). Creates a `guest`-only account (FR-012, §2.2 fix).

| Field | Type | Description |
|-------|------|-------------|
| `username` | string | required, unique |
| `email` | string | required, valid, unique |
| `password` | string | required; must meet the password policy (minimum 8 characters, no forced complexity) |

Role is fixed server-side to `guest`; any privileged role in the payload is ignored or
rejected — never assigned (FR-012). Rate-limited (spec §17).

Success: `201 Created` (principal created as `guest`). Errors: `400` validation
(required/unique/format/policy), `409` duplicate username/email.

## 5. `POST /api/v1/public/queries`

Anonymous (public-by-design). Validated, rate-limited (spec §15). Payload defined in
the Public/Contact module contract — this feature only secures and rate-limits the
route (501 until the module feature delivers the payload, per §4.3).

## Traceability

- FR-017 → §1–§2; FR-018 → §1 (day-gate); FR-019 → §3; FR-012 → §4–§5
- AC-001/TS-001 → §1; AC-011/TS-013 → §1 (day-gate); AC-012/TS-014 → §3
- §15 API Contracts → this document
