# Requirements Quality Checklist: Identity Consolidation, RBAC & Employee Day-Gate (SPEC-0005)

**Purpose**: Validate the quality, clarity, completeness, and consistency of the SPEC-0005
requirements (identity host integration, RBAC enforcement, employee day-gate,
change-password, URL rewrite, lockout alignment) before implementation. This checklist
tests the requirements themselves — not the implementation.
**Created**: 2026-08-11
**Feature**: [spec.md](../spec.md)

## Requirement Completeness

- [x] CHK001 Are login requirements defined for all five roles (`su`/`adm`/`emp`/`agt`/`guest`) against the consolidated identity store? → RESOLVED 2026-08-11 (Spec §9 FR-017, §20 AC-001, §23 TS-001) [Completeness, Spec §9 FR-017]
- [x] CHK002 Are requirements defined for all employee day-gate outcomes (`rsn=O` rejection, success; `rsn=C` never produced) on both login surfaces (Web + API)? → RESOLVED 2026-08-11 (Spec §9 FR-018, §14, §15, AC-011, TS-013) [Completeness, Spec §9 FR-018]
- [x] CHK003 Are change-password requirements specified in full (current-password verification, new≠confirm, password policy min 8, hashed storage, no lowercasing)? → RESOLVED 2026-08-11 (Spec §9 FR-019, §12, §14, §15, §17, AC-012, TS-014) [Completeness, Spec §9 FR-019]
- [x] CHK004 Are requirements defined for the identity store auxiliary tables (claims, logins, tokens) the runtime store needs? → RESOLVED 2026-08-11 (Spec §16; data-model §1.3 — four tables created idempotently by the migration-tool DDL) [Completeness, Spec §16]
- [x] CHK005 Is the `active`→lockout alignment specified for all three legacy sources (`agents`, `registration`, `Udaan_users`)? → RESOLVED 2026-08-11 (Spec §16, §9 FR-009, AC-010, data-model §4.3) — AMENDED 2026-08-11: the mechanism was corrected from "past `LockoutEnd`" to a **far-future `LockoutEnd`** — `UserManager.IsLockedOutAsync` in the installed 8.0.29 shared framework (verified against the v8.0.29 source) returns `true` only when `LockoutEnabled` AND `LockoutEnd >= UtcNow`, so a past date does not block; spec §7/§16, data-model §1.1/§3.2/§4.3, research §6 all updated [Completeness, Spec §9 FR-009]
- [x] CHK006 Are the deferred admin user-management endpoints documented as contracts-only (routes, role rules, audit, deferral owner decision)? → RESOLVED 2026-08-11 (Spec §15 Admin-Users contracts, §9 FR-013/FR-014, contracts/secured-write-routes.md §3.1, owner decision Risk #7) [Completeness, Spec §15]
- [x] CHK007 Are requirements defined for unknown legacy `.asp` URLs (clear 404, no wildcard forwarding)? → RESOLVED 2026-08-11 (Spec §9 FR-003 incl. matching rules, NFR-005, AC-007/TS-007) [Completeness, Spec §9 FR-003]

## Requirement Clarity

- [x] CHK008 Is the day-gate's rejection condition unambiguous (no `security` row for today with `closingtime IS NULL`; rows with a closing time set are excluded)? → RESOLVED 2026-08-11 (Spec §9 FR-018, §20 AC-011, data-model §2.1) [Clarity, Spec §9 FR-018]
- [x] CHK009 Is the API day-gate rejection response specified precisely (403 + `rsn` field in the problem-details body)? → RESOLVED 2026-08-11 (Spec §15, §9 FR-018, contracts/auth-api.md §1) [Clarity, Spec §15]
- [x] CHK010 Are change-password response codes specified (204 success, 400 wrong current / new≠confirm / policy violation)? → RESOLVED 2026-08-11 (Spec §15 incl. policy-violation 400, AC-012, TS-014, contracts/auth-api.md §3) [Clarity, Spec §15]
- [x] CHK011 Is "role-appropriate landing page" defined per role, or left to implementation? → RESOLVED 2026-08-11 (Spec §14: per-role mapping per §4.2 — su/adm→AdminPanel, agt→agent portal, emp→employee area, guest→public home; concrete routes deferred to module features, Phase 0 default = existing home page) [Clarity, Spec §14]
- [x] CHK012 Are the Web login day-gate redirects specified (`/Auth/Login?rsn=O`)? → RESOLVED 2026-08-11 (Spec §14, §9 FR-018, contracts/web-ui.md §1.1) [Clarity, Spec §14]
- [x] CHK013 Is the single `rsn=O` rejection stated unambiguously (`rsn=C` is legacy dead code and never produced) so implementers cannot invent a second rejection? → RESOLVED 2026-08-11 (Spec §9 FR-018, §5, §15, AC-011, TS-013, data-model §2.1) [Clarity, Spec §9 FR-018]

## Requirement Consistency

- [x] CHK014 Do AC-001 (all 5 roles sign in) and AC-011 (emp rejected without an open day) coexist explicitly through the seeded-open-day qualification? → RESOLVED 2026-08-11 (Spec §20 AC-001: "for emp, the login test runs with an open security day seeded for today"; day-gate rejections covered separately by AC-011) [Consistency, Spec §20 AC-001/AC-011]
- [x] CHK015 Is the day-gate scope (`emp` only) consistent across §9 FR-018, §14 (UI), and §15 (API)? → RESOLVED 2026-08-11 (FR-018, §14, §15, data-model §3 all state emp-only) [Consistency, Spec §9/§14/§15]
- [x] CHK016 Are the deferred endpoint contracts consistent across §5 (scope), §9 FR-013/FR-014, and §15 (API)? → RESOLVED 2026-08-11 (§5 scope, FR-013/FR-014 deferred to Phase 3, §15 documents contracts) [Consistency]
- [x] CHK017 Is the change-password hashing rule consistent with the import hashing rule (no plaintext value anywhere)? → RESOLVED 2026-08-11 (Spec §9 FR-006/FR-019, §12, AC-002/AC-012) [Consistency, Spec §9 FR-006/FR-019]
- [x] CHK018 Is the deliberate deviation from legacy lowercasing (change-password) stated explicitly as a security fix rather than silently changed? → RESOLVED 2026-08-11 (Spec §9 FR-019 "documented security fix", §12, plan.md Summary item 3) [Consistency, Assumption, Spec §9 FR-019]

## Acceptance Criteria Quality

- [x] CHK019 Does every functional requirement map to at least one acceptance criterion (e.g., FR-018→AC-011, FR-019→AC-012)? → RESOLVED 2026-08-11 (Spec §24 traceability; FR-013/FR-014→AC-005 verified in Phase 3) [Acceptance Criteria, Spec §24]
- [x] CHK020 Is the 5-role login exit criterion objectively verifiable (token returned with the expected role/`AgentId`/`SuperUser` claims)? → RESOLVED 2026-08-11 (Spec §20 AC-001 + §23 TS-001 assert role/AgentId/SuperUser claims; tasks T006/T007) [Measurability, Spec §20 AC-001]
- [x] CHK021 Can the day-gate acceptance criterion be verified from observable outputs (`rsn` codes) without internal knowledge? → RESOLVED 2026-08-11 (AC-011: 403 `rsn=O` / success; TS-013) [Measurability, Spec §20 AC-011]
- [x] CHK022 Is the no-plaintext criterion testable at every surface (database, logs, admin/user-edit screen)? → RESOLVED 2026-08-11 (AC-002 checks DB, logs, admin screen; TS-002; tasks T008/T037) [Acceptance Criteria, Spec §20 AC-002]

## Scenario Coverage

- [x] CHK023 Are alternate login scenarios covered (inactive account, bad credentials, day-gate rejections) in addition to the happy path? → RESOLVED 2026-08-11 (TS-010 inactive, data-model §4.1 rsn=B bad credentials, TS-013 day-gate rejections) [Coverage, Spec §23 TS-010/TS-013]
- [x] CHK024 Are change-password exception flows covered (wrong current password, new≠confirm, policy violation)? → RESOLVED 2026-08-11 (Spec §23 TS-014, §20 AC-012) [Coverage, Spec §23 TS-014]
- [x] CHK025 Are recovery/rollback requirements defined for the identity import (pre-import snapshot, idempotent re-run, no partial state)? → RESOLVED 2026-08-11 (Spec §16 reversible + pre-import snapshot, §18 rollback, NFR-007 idempotent, TS-009) [Coverage, Spec §16/§18]
- [x] CHK026 Is the public-by-design status of `POST /api/v1/public/register` and `/queries` specified together with their rate-limiting requirements? → RESOLVED 2026-08-11 (Spec §15 lists both public-by-design; Spec §17 + Risk R7 specify the built-in limiter with configuration-driven thresholds, owner decision before go-live) [Coverage, Spec §15/§17]

## Edge Case Coverage

- [x] CHK027 Is the edge case of a day with no open-day `security` row (no row, or only closed rows) specified as the single `rsn=O` rejection? → RESOLVED 2026-08-11 (Spec §20 AC-011 "including on days whose row already has a closing time set", §9 FR-018, TS-013) [Edge Case, Spec §9 FR-018]
- [x] CHK028 Is the day-boundary edge case addressed (the gate evaluates "today" — is behavior at midnight/date rollover specified)? → RESOLVED 2026-08-11 (AC-011 evaluates "today" at login time — the SQL Server current date — mirroring authenticate.asp's daily gate; at rollover the gate simply evaluates the new day; no invented rollover policy) [Edge Case, Gap]
- [x] CHK029 Are duplicate-username/email import edge cases addressed by the first-source-wins dedup requirement and re-run idempotency? → RESOLVED 2026-08-11 (Spec §16 first-source-wins dedup, NFR-007, TS-009, AC-009) [Edge Case, Spec §9 FR-005, AC-009]
- [x] CHK030 Are URL-rewrite edge cases specified (query strings, case sensitivity, trailing characters, `relogin.asp?rsn=` handling)? → RESOLVED 2026-08-11 (Spec §9 FR-003: case-insensitive matching, query strings preserved/carried, trailing-slash variants same target, `relogin.asp?rsn=*` NOT mapped, unknown → 404) [Edge Case, Gap]

## Non-Functional Requirements

- [x] CHK031 Is a measurable performance target defined for login + token issuance? → RESOLVED 2026-08-11 (Spec §13: sub-100 ms target note incl. identity-store reads, explicitly non-gated; plan.md §Performance Goals) [NFR, Spec §13]
- [x] CHK032 Are password-storage security requirements specified (hashed, never stored/logged/returned in plaintext)? → RESOLVED 2026-08-11 (Spec §12, §9 FR-006/FR-019, BR-002) [NFR, Spec §12]
- [x] CHK033 Is observability of authorization denials specified (subject, endpoint, outcome — without password material)? → RESOLVED 2026-08-11 (Spec §19, NFR-006; folded into tasks T031/T037) [NFR, Spec §19]
- [x] CHK034 Are secrets-handling requirements specified (configuration only, never in source)? → RESOLVED 2026-08-11 (Spec §9 NFR-004, §12 ProductionSecretsGuard) [NFR, Spec §12 NFR-004]

## Dependencies & Assumptions

- [x] CHK035 Are the SPEC-0003/SPEC-0004 deliverables recorded as verified dependencies rather than assumptions? → RESOLVED 2026-08-11 (Spec §5 verified-baseline list, §22 Dependencies, Assumptions section "Verified 2026-08-11 (not assumptions)") [Dependency, Spec §22]
- [x] CHK036 Are owner decisions Risk #2 (agent-binding key) and Risk #7 (su provisioning) documented as gating conditions? → RESOLVED 2026-08-11 (Spec §22: Risk #2 not blocking Phase 0; Risk #7 gates deferred endpoints) [Assumption, Spec §22]
- [x] CHK037 Is the assumption that import hashes the stored legacy password value as-is (preserving today's behavior) documented, including the R3 reset path? → RESOLVED 2026-08-11 (Assumptions section + Spec §21 R3 incl. Phase 0/Phase 3 reset boundary) [Assumption, Spec §21 R3]
- [x] CHK038 Is the test-only assumption that an open `security` day is seeded for the 5-role login test documented? → RESOLVED 2026-08-11 (Spec §20 AC-001 + §23 TS-001 seeded open day; tasks T007) [Assumption, Spec §20 AC-001]

## Ambiguities & Conflicts

- [x] CHK039 Does the spec explicitly resolve the AC-001 vs AC-011 login contradiction rather than leaving it implicit? → RESOLVED 2026-08-11 (AC-001 qualifies the emp case with a seeded open day and states day-gate rejections are covered separately by AC-011; TS-001 mirrors) [Conflict, Spec §20]
- [x] CHK040 Are JWT/cookie lifetimes specified or explicitly deferred to planning (no silent assumption)? → RESOLVED 2026-08-11 (Spec §15: lifetimes read from configuration only, owner confirms values before go-live) [Ambiguity, Spec §15]
- [x] CHK041 Is the legacy unreachable `rsn=C` branch (`authenticate.asp` line 72) acknowledged with observable behavior preserved? → RESOLVED 2026-08-11 (FR-018: `rsn=C` never produced) [Ambiguity, Spec §9 FR-018]

## Post-Re-Clarification Consistency (2026-08-11)

- [x] CHK042 Are the password-policy requirements (minimum 8 characters, no forced complexity) specified with the same rule on every password-setting surface in scope — registration (FR-012), change-password (FR-019), §12 Security, §14 UI, §15 API, §17 Validation Rules — with no conflicting wording anywhere? → RESOLVED 2026-08-11 (all six locations state min 8 / no forced complexity; §15 includes the policy-violation 400 case) [Consistency, Spec §9 FR-012/FR-019, §12, §14, §15, §17]
- [x] CHK043 Is it explicit that the policy applies ONLY to new/changed credentials — i.e., a migrated account whose legacy hash is shorter than 8 characters still verifies its current password normally, and only the newly chosen password must meet the policy? → RESOLVED 2026-08-11 (Spec §12: "the policy applies only to new credentials — migrated legacy hashes are unaffected") [Clarity, Spec §12]
- [x] CHK044 Is "minimum 8 characters" defined precisely enough for identical validation on Web and API (trimmed whitespace, Unicode code points vs bytes, no forced-complexity classes) so the shared validation rule cannot be implemented two ways? → RESOLVED 2026-08-11 (Spec §17: raw string length — UTF-16 code units — exactly as the single shared Identity `RequiredLength` validator enforces it; no trimming/normalization; both surfaces share the rule) [Clarity, Spec §12, §17]
- [x] CHK045 Are the password policy and the day-gate specified as single-source business rules implemented once in `VisaFusion.Core` and shared by the Web UI and the API — per the constitution's "never duplicated per surface" rule, which explicitly names the day-open gate? → RESOLVED 2026-08-11 (day-gate in `ISecurityGateService` via T018; Spec §17 states both surfaces MUST share the single password-validation rule) [Consistency, Constitution §Engineering Process, Spec §17]
- [x] CHK046 Is the policy-violation response specified on both surfaces — the Web inline message text and the API 400 error detail — so the user is told the exact rule (minimum 8 characters, no forced complexity)? → RESOLVED 2026-08-11 (Spec §14 change-password page reports policy-violation outcomes; Spec §15 API returns 400; contracts/web-ui.md §1.4 + contracts/auth-api.md §3; exact copy left to UI implementation per §17 "friendly error messages") [Completeness, Spec §14, §15]
- [x] CHK047 Is the R3 reset path (migrated users whose remembered password differs from the lowercased stored hash) reconciled with the password policy and with the deferred admin/for-agent reset endpoints — i.e., is it specified how a Phase 0 user who cannot sign in receives a policy-compliant reset given no reset endpoint is implemented by this feature? → RESOLVED 2026-08-11 (Spec §21 R3 amended 2026-08-11: Phase 0 implements NO reset endpoint — change-password requires sign-in and admin/for-agent password-set is deferred to Phase 3; affected users are flagged in the import report and reset via the Phase 3 path; no invented capability) [Consistency, Gap, Spec §21 R3, §15, contracts/secured-write-routes.md §3.2]
- [x] CHK048 Is the policy boundary reflected in the test scenarios — i.e., is there a TS assertion that a migrated short legacy hash still authenticates (AC-001), while registration/change-password reject a new password under 8 characters (TS-005/TS-014)? → RESOLVED 2026-08-11 (TS-001 asserts all 5 roles sign in with migrated hashed credentials; TS-005/TS-014 assert under-8 rejection for new credentials; Spec §12 guarantees the boundary) [Coverage, Spec §20 AC-001, §23 TS-005/TS-014]

## Notes

- This checklist validates the SPEC-0005 requirements as revised on 2026-08-11 (eight
  clarification answers; the two re-clarifications added on 2026-08-11 resolve the
  day-gate `rsn=C` dead-code outcome and the password policy: minimum 8 characters,
  no forced complexity).
- All 48 checks verified against the current spec/plan/tasks on 2026-08-11; items
  CHK001–CHK048 are marked RESOLVED with the governing spec reference. The two
  remaining planning decisions are documented in the spec: rate-limit threshold
  values (Spec §17 + Risk R7, configuration-driven) and token/cookie lifetimes
  (Spec §15). FR-003 was amended to specify the URL-rewrite matching rules and R3
  was amended to state the Phase 0/Phase 3 reset boundary.
