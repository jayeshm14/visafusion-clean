# Research: Solution Scaffold Completion, Identity Consolidation & RBAC (SPEC-0005)

**Date**: 2026-08-11 | **Spec**: [SPEC-0005](spec.md)
**Sources**: `library/complete_migration_plan.md` §4/§4.3/§7/§9/§10/§12,
`findings/modernization_plan.md` §3.8/§5.1–5.4, `findings/deepanalysis.md` §2/§3,
`findings/exiting_architecture.md` §3, SPEC-0003 (target architecture), SPEC-0004
(data model migration), and live repository verification on 2026-08-11
(`authenticate.asp`, `newpassword.asp`, `SecurityGateService`, `SecurityDay`,
`IdentityImporter`).

All `NEEDS CLARIFICATION` items from the plan's Technical Context were resolved in the
spec's Clarifications section (session 2026-08-11, 8 answers) and by repository
verification. No unresolved unknowns remain. This document records the technical
decisions and their rationale.

---

## 1. Employee Day-Gate Enforcement (clarification Q2)

- **Decision**: Enforce the legacy employee day-gate in both login surfaces now,
  preserving the legacy observable behavior exactly. Web cookie login and API JWT
  login apply the gate for `emp` logins: login succeeds iff a `security` row exists
  for today with `closingtime IS NULL` (open day); otherwise rejected with `rsn=O`.
  `rsn=C` is never produced (verified 2026-08-11: it is unreachable dead code — the
  legacy query filters `closingtime is null`, so the `closingtime<>""` branch at
  `authenticate.asp` line 72 never fires; `NULL <> ""` is falsy in VBScript). Web
  redirects to `/Auth/Login?rsn=O`; API returns `403` with `{ rsn: "O" }` in the
  problem-details body. The evaluation lives on `ISecurityGateService` (a placeholder
  service in `VisaFusion.Core`, verified by codegraph) which gains a day-gate
  evaluation method.
- **Rationale**: Legacy behavior is the source of truth (constitution Principle II).
  Verified in `authenticate.asp` lines 62–79: the `emp` privilege branch selects from
  `security` where `Day(date1)=today ... and closingtime is null`; no matching row →
  `relogin.asp?rsn=O`; a matching row (which by construction has `closingtime IS NULL`)
  → success. The `rsn=C` branch is dead code and is not reproduced — implementing it
  would change business behavior (re-clarification 2026-08-11). Documented identically
  in `findings/modernization_plan.md` §3.8 (line 141) and §5.2 (line 247) and the
  `library/complete_migration_plan.md` §8 Test Matrix row "Employee day-gate". Login is
  the exact boundary where the legacy app applied the gate; deferring would have
  changed login behavior during Phase 0.
- **Alternatives considered**:
  - Defer to the Employee module feature (Phase 1) — rejected (clarification Q2,
    option B): the gate is a login-boundary behavior and the plan's Phase 0 scope
    includes "auth gates" (`complete_migration_plan.md` §10).
  - Enforce only on the Web surface — rejected (clarification Q2, option C): the API
    login would diverge from legacy behavior.
  - Implement `rsn=C` as documented (closed-day rejection) — rejected (re-clarification
    2026-08-11): the branch is unreachable in the legacy code; reproducing it would
    invent behavior the legacy app does not exhibit.

## 2. Day-Gate Testability

- **Decision**: Two-layer test strategy. Hermetic functional tests (no SQL Server)
  stub `ISecurityGateService` to report an open day so the emp-login success path and
  the 5-role login exit criterion (AC-001/TS-001) are proven without a database.
  Integration tests (self-skipping when SQL Server is unreachable) seed the `security`
  table — no row today, a row with a closing time set, an open row — and assert the
  `rsn=O` rejection (first two) and success (open row) outcomes (AC-011/TS-013);
  `rsn=C` is never asserted because it is never produced (FR-018).
- **Rationale**: The hermetic convention established by SPEC-0003 keeps functional
  tests database-free; the gate is the one auth behavior that reads business data, so
  it must be isolated behind `ISecurityGateService` to stay hermetic while the
  database-backed paths are covered where SQL Server is available. The §8 Test Matrix
  case "on an open day → success" requires a seeded/opened day, which integration
  testing provides deterministically.
- **Alternatives considered**: Requiring a live database for all login tests —
  rejected (breaks the hermetic convention; NFR tests would fail on developer machines
  without SQL Server).

## 3. Self-Service Change-Password (clarification Q3)

- **Decision**: Self-service change-password is in Phase 0: `/Auth/ChangePassword`
  (Web) and `POST /api/v1/auth/change-password` (API, authenticated). The new password
  must meet the password policy (minimum 8 characters, no forced complexity — NIST
  800-63B, clarification 2026-08-11) and is stored via
  `UserManager.ChangePasswordAsync` as a hash — **without** the legacy forced
  lowercasing. Wrong current password → error; new ≠ confirm → validation error;
  policy violation → validation error.
  The privileged for-agent password set (`changepasswordforagent.asp` /
  `newpasswordforagent.asp`) is deferred to the Agent/User-management module features
  and documented as a contract (`PUT /api/v1/agents/{id}/password` — `adm`,`su`).
- **Rationale**: Verified in `newpassword.asp` (repo root): it is the POST handler for
  the self-service flow, verifies username + current password, requires new == confirm,
  and stores `rs("password")=lcase(request("pass2"))` — the lowercased-plaintext
  finding (line 43). The lowercasing is a security weakness; per constitution
  "security by default", new passwords are hashed as entered (documented deviation,
  spec FR-019). Change-password is needed in Phase 0 because Risk #3 accounts
  (lowercased-hash imports) may need a reset right after first login. The for-agent
  variant is an agent-management operation that belongs with the Agent/
  User-management module features.
- **Alternatives considered**: For-agent reset also in Phase 0 (option B) — rejected
  (agent-management scope, owned by later module features); defer all password
  management (option C) — rejected (R3 resets needed in Phase 0).

## 4. Admin User-Management Endpoints (clarification Q1)

- **Decision**: The admin user-management write endpoints
  (`POST /api/v1/admin/users`, `DELETE /api/v1/admin/users/{username}`,
  `POST /api/v1/admin/superusers`) are **documented contracts only** in this feature —
  NOT implemented. They land with the User-management module feature (Phase 3 of the
  rollout), which delivers the FR-013 role whitelist (`adm`/`emp`/`agt`/`guest`; `su`
  rejected) and the su-only audited `POST /api/v1/admin/superusers` path, gated on
  owner decision Risk #7 (`library/complete_migration_plan.md` §12).
- **Rationale**: Verified `library/complete_migration_plan.md` §4.3 documents these
  target routes (`POST /api/v1/admin/users`, `POST /api/v1/admin/superusers`) as the
  re-secured replacements for `addNewUser.asp`/`editdonetest.asp`. Phase 0's mandate is
  the trust boundary (authN/Z), not the user-management workflow itself; provisioning
  su is an owner-governed process that requires Risk #7 confirmation.
- **Alternatives considered**: Implement now (option A) — rejected (su provisioning is
  gated on an open owner decision); implement as 501 placeholders — rejected (the
  routes would exist without their module feature, contradicting the deferral).

## 5. Identity Host Integration Pattern

- **Decision**: Register ASP.NET Core Identity in the host with
  `AddIdentityCore<IdentityIntegration.VisaFusionUser>` + roles + a new
  `VisaFusionIdentityDbContext` (Identity project) mapping the migration-tool-created
  `AspNetUsers`/`AspNetRoles`/`AspNetUserRoles` tables, extended idempotently with the
  standard `AspNetUserClaims`/`AspNetRoleClaims`/`AspNetUserLogins`/`AspNetUserTokens`
  tables. `VisaEntryDbContext` and the EF migration pipeline are untouched. JWT bearer
  (API) and cookies (Web) both validate against the store.
- **Rationale**: The identity store schema is owned by the migration tool
  (`IdentityImporter.EnsureIdentitySchemaAsync`, verified: DDL creates the three core
  tables seeded with the five roles; `AspNetUsers` carries `LegacyUdaanUserId`,
  `LegacyRegistrationId`, `AgentId`). Mixing Identity into the business DbContext would
  invert the one-way Identity → Data dependency. This is the standard ASP.NET Core
  Identity registration surface and matches SPEC-0003's auth-scheme wiring.
- **Alternatives considered**: Derive `VisaEntryDbContext` from `IdentityDbContext` —
  rejected (38 legacy-mapped entities + Identity conventions conflict; dependency
  cycle); a second EF migration pipeline for the identity store — rejected (migration
  tool is the schema source of truth, keep one DDL owner).

## 6. Lockout Alignment (`active` → Lockout)

- **Decision**: The importer reads `active` from all three legacy sources
  (`agents.active`, `registration.active`, `Udaan_users.active`) and sets
  `LockoutEnabled = !active`, plus a past `LockoutEnd` for inactive accounts so they
  are actually blocked at sign-in (FR-009/AC-010).
- **Rationale**: Verified `IdentityImporter.cs` line 188 hardcodes `LockoutEnabled = 1`
  in the INSERT VALUES — the deviation documented in the spec §5/§9. The legacy
  `active` flag's meaning is preserved (inactive → cannot sign in).
- **Alternatives considered**: Leave the hardcode — rejected (contradicts FR-009 and
  AC-010; inactive accounts would remain signable).

## 7. Gate Evaluation

- **Constitution Check (pre-research)**: PASS — all five principles satisfied (see
  plan.md).
- **Constitution Check (post-design)**: PASS — data model, contracts, and quickstart
  derive from the spec, the §4/§4.3/§7 plan sections, and verified legacy source only;
  no invented behavior, no business-table drops, no secrets in artifacts.

## Unresolved / Deferred

- Owner decision Risk #7 (su provisioning process) — gates the deferred su-only
  user-management endpoints (Phase 3), not this feature (`complete_migration_plan.md`
  §12).
- Owner decision Risk #2 (agent-binding key) — the §7 username ↔ `agents.Description`
  binding is already implemented; confirmation is tracked for cutover.
- JWT/cookie lifetimes and registration field set — plan-level execution details with
  no acceptance-test impact; decided at implementation time within the documented
  contracts.
