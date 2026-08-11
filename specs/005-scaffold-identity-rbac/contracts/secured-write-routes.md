# API Contract: Re-Secured Write Routes & Deferred Contracts (SPEC-0005)

**Date**: 2026-08-11 | **Spec**: [SPEC-0005](../spec.md) | **Auth contract**:
[auth-api.md](auth-api.md)

This contract documents the §4.3 re-secured write routes (11 role-secured + 2
public-by-design) and the documented-only deferred contracts. All routes/roles are
taken verbatim from `library/complete_migration_plan.md` §4.3.

## 1. Re-Secured Writes — 11 role-secured routes (501 until module feature)

Each route enforces authentication + the §4.2 minimum role and returns the standardized
501 problem-details body (no fake payloads) until its module feature delivers the
business payload (FR-011, spec §18). Anonymous → `401`; wrong role → `403`; correct
role → `501`.

| Route | Minimum roles | Legacy source | Module feature |
|-------|---------------|---------------|----------------|
| `PUT /api/v1/agents/{id}` | `adm`,`su` | agent edit pages | Agent management |
| `PUT /api/v1/agents/{id}/self` | `agt` (own record only, FR-016) | `editdonebyagent1.asp` | Agent self-service |
| `POST /api/v1/entries` | `emp`,`adm`,`su` | `insertEntry.asp` | Entry creation |
| `POST /api/v1/entries/{refno}/status` | `emp`,`adm`,`su` | `execute.asp` (retired arbitrary-SQL) | Entry lifecycle |
| `POST /api/v1/entries/{refno}/awb` | `emp`,`adm`,`su`,`agt` (own) | `sendawbgo.asp` | Entry lifecycle |
| `POST /api/v1/billing/entries` | `emp`,`adm`,`su` | `editbill.asp` | Billing |
| `POST /api/v1/holidays` | `adm`,`su` | `holiday_WebEntry.asp` | Holiday/weekly-off |
| `DELETE /api/v1/holidays/{id}` | `adm`,`su` | `holidayDeleteSubmit.asp` | Holiday/weekly-off |
| `POST /api/v1/reports/agent-status/today` | `emp`,`adm`,`su` | `todayAgentStatusalltemp.asp` | Reports |
| `POST /api/v1/admin/security-day/open` | `adm`,`su` | `openForDay.asp` | Security gate (§2.5 fix) |
| `POST /api/v1/admin/security-day/close` | `adm`,`su` | `closeForDay.asp` | Security gate (§2.5 fix) |

## 2. Public-by-design writes (anonymous + validation + rate-limit)

| Route | Notes |
|-------|-------|
| `POST /api/v1/public/register` | always `guest` (see [auth-api.md](auth-api.md) §4) |
| `POST /api/v1/public/queries` | validated, rate-limited (module feature delivers payload) |

## 3. Documented-only deferred contracts (NOT implemented in this feature)

These endpoints are documented for contract completeness; they land with their module
features (clarification Q1/Q3, spec §15). They must NOT exist as routes after this
feature ships.

### 3.1 Admin — Users (User-management module feature, Phase 3; gated on Risk #7)

| Route | Role rules | Legacy source |
|-------|------------|---------------|
| `POST /api/v1/admin/users` | whitelist `adm`,`emp`,`agt`,`guest`; **`su` rejected** (FR-013) | `addNewUser.asp`, `editdonetest.asp` (§2.2 escalation fix) |
| `DELETE /api/v1/admin/users/{username}` | caller must be `su` to delete an `su` (FR-014, §2.9) | `deleteUser.asp`/`deleteSubmit.asp` |
| `POST /api/v1/admin/superusers` | **su-only**, audited (FR-008/FR-013, §19) | — |

### 3.2 Agent password set (Agent/User-management module features)

| Route | Role rules | Legacy source |
|-------|------------|---------------|
| `PUT /api/v1/agents/{id}/password` | `adm`,`su`; hashed via `UserManager`, no legacy lowercasing (FR-019) | `changepasswordforagent.asp`, `newpasswordforagent.asp` |

## Traceability

- FR-011/AC-004/TS-004 → §1–§2
- FR-013/FR-014/AC-005/TS-005 → §3.1 (deferred)
- FR-019 → §3.2 (deferred); §3 of [auth-api.md](auth-api.md) for the self-service path
- FR-016/TS-003 → §1 (`/self` own-record rule)
- §4.3 → all routes above (verbatim minimum roles)
