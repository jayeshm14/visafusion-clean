# API Contract: Public Module — Queries, Registration (SPEC-0007)

**Date**: 2026-08-17 | **Spec**: [SPEC-0007](../spec.md)

This contract defines the **Public** module endpoints relevant to this feature (spec §15; `library/complete_migration_plan.md` §4.3 lines 168, 173). It backs the legacy pages `querieDetail.asp`, `regsub.asp`/`regsubmit.asp`/`regsubdone.asp`. The public site pages themselves are Razor Pages (see [ui-contract.md](ui-contract.md)).

## General

- Base path: `/api/v1`
- Format: JSON (UTF-8)
- Auth: none (anonymous by design — BR-005 allows only validated, rate-limited anonymous POSTs)
- Errors: standardized problem-details JSON: `400` validation, `429` rate-limited, `500` unhandled.

## 1. `POST /api/v1/public/queries` — Contact-query submission (FR-011, AC-007)

Anonymous, validated, rate-limited. Backs `querieDetail.asp` (legacy anonymous INSERT).

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `name` | string | yes | length limit |
| `email` | string | yes | valid email |
| `subject` | string | yes | length limit |
| `message` | string | yes | length limit |

Server behavior: rate-limited per IP (e.g., 5/hour); inserts the query; no authentication required. Success: `201 Created`.

## 2. `POST /api/v1/public/register` — Public registration (FR-012)

Anonymous by design; output role is always `guest`, never privileged (fixes §2.2). Backs `regsub.asp`/`regsubmit.asp`/`regsubdone.asp`. Already delivered by SPEC-0005 (`RegistrationFlow`); this feature reuses it unchanged for the public site's registration page.

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `username` | string | yes | unique |
| `password` | string | yes | hashed |
| `email` | string | yes | |

Server behavior: creates a `guest`-role account only. Success: `201 Created`.