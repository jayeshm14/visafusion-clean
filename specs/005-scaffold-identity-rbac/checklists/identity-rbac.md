# Requirements Quality Checklist: Identity Consolidation, RBAC & Employee Day-Gate (SPEC-0005)

**Purpose**: Validate the quality, clarity, completeness, and consistency of the SPEC-0005
requirements (identity host integration, RBAC enforcement, employee day-gate,
change-password, URL rewrite, lockout alignment) before implementation. This checklist
tests the requirements themselves — not the implementation.
**Created**: 2026-08-11
**Feature**: [spec.md](../spec.md)

## Requirement Completeness

- [ ] CHK001 Are login requirements defined for all five roles (`su`/`adm`/`emp`/`agt`/`guest`) against the consolidated identity store? [Completeness, Spec §9 FR-017]
- [ ] CHK002 Are requirements defined for all employee day-gate outcomes (`rsn=O` rejection, success; `rsn=C` never produced) on both login surfaces (Web + API)? [Completeness, Spec §9 FR-018]
- [ ] CHK003 Are change-password requirements specified in full (current-password verification, new≠confirm, password policy min 8, hashed storage, no lowercasing)? [Completeness, Spec §9 FR-019]
- [ ] CHK004 Are requirements defined for the identity store auxiliary tables (claims, logins, tokens) the runtime store needs? [Completeness, Spec §16]
- [ ] CHK005 Is the `active`→lockout alignment specified for all three legacy sources (`agents`, `registration`, `Udaan_users`)? [Completeness, Spec §9 FR-009]
- [ ] CHK006 Are the deferred admin user-management endpoints documented as contracts-only (routes, role rules, audit, deferral owner decision)? [Completeness, Spec §15]
- [ ] CHK007 Are requirements defined for unknown legacy `.asp` URLs (clear 404, no wildcard forwarding)? [Completeness, Spec §9 FR-003]

## Requirement Clarity

- [ ] CHK008 Is the day-gate's rejection condition unambiguous (no `security` row for today with `closingtime IS NULL`; rows with a closing time set are excluded)? [Clarity, Spec §9 FR-018]
- [ ] CHK009 Is the API day-gate rejection response specified precisely (403 + `rsn` field in the problem-details body)? [Clarity, Spec §15]
- [ ] CHK010 Are change-password response codes specified (204 success, 400 wrong current / new≠confirm / policy violation)? [Clarity, Spec §15]
- [x] CHK011 Is "role-appropriate landing page" defined per role, or left to implementation? → RESOLVED 2026-08-11 (Spec §14: per-role mapping per §4.2 — su/adm→AdminPanel, agt→agent portal, emp→employee area, guest→public home; concrete routes deferred to module features, Phase 0 default = existing home page) [Clarity, Spec §14]
- [ ] CHK012 Are the Web login day-gate redirects specified (`/Auth/Login?rsn=O`)? [Clarity, Spec §14]
- [ ] CHK013 Is the single `rsn=O` rejection stated unambiguously (`rsn=C` is legacy dead code and never produced) so implementers cannot invent a second rejection? [Clarity, Spec §9 FR-018]

## Requirement Consistency

- [ ] CHK014 Do AC-001 (all 5 roles sign in) and AC-011 (emp rejected without an open day) coexist explicitly through the seeded-open-day qualification? [Consistency, Spec §20 AC-001/AC-011]
- [ ] CHK015 Is the day-gate scope (`emp` only) consistent across §9 FR-018, §14 (UI), and §15 (API)? [Consistency, Spec §9/§14/§15]
- [ ] CHK016 Are the deferred endpoint contracts consistent across §5 (scope), §9 FR-013/FR-014, and §15 (API)? [Consistency]
- [ ] CHK017 Is the change-password hashing rule consistent with the import hashing rule (no plaintext value anywhere)? [Consistency, Spec §9 FR-006/FR-019]
- [ ] CHK018 Is the deliberate deviation from legacy lowercasing (change-password) stated explicitly as a security fix rather than silently changed? [Consistency, Assumption, Spec §9 FR-019]

## Acceptance Criteria Quality

- [ ] CHK019 Does every functional requirement map to at least one acceptance criterion (e.g., FR-018→AC-011, FR-019→AC-012)? [Acceptance Criteria, Spec §24]
- [ ] CHK020 Is the 5-role login exit criterion objectively verifiable (token returned with the expected role/`AgentId`/`SuperUser` claims)? [Measurability, Spec §20 AC-001]
- [ ] CHK021 Can the day-gate acceptance criterion be verified from observable outputs (`rsn` codes) without internal knowledge? [Measurability, Spec §20 AC-011]
- [ ] CHK022 Is the no-plaintext criterion testable at every surface (database, logs, admin/user-edit screen)? [Acceptance Criteria, Spec §20 AC-002]

## Scenario Coverage

- [ ] CHK023 Are alternate login scenarios covered (inactive account, bad credentials, day-gate rejections) in addition to the happy path? [Coverage, Spec §23 TS-010/TS-013]
- [ ] CHK024 Are change-password exception flows covered (wrong current password, new≠confirm, policy violation)? [Coverage, Spec §23 TS-014]
- [ ] CHK025 Are recovery/rollback requirements defined for the identity import (pre-import snapshot, idempotent re-run, no partial state)? [Coverage, Spec §16/§18]
- [x] CHK026 Is the public-by-design status of `POST /api/v1/public/register` and `/queries` specified together with their rate-limiting requirements? → RESOLVED 2026-08-11 (Spec §15 lists both public-by-design; Spec §17 + Risk R7 specify the built-in limiter with configuration-driven thresholds, owner decision before go-live) [Coverage, Spec §15/§17]

## Edge Case Coverage

- [ ] CHK027 Is the edge case of a day with no open-day `security` row (no row, or only closed rows) specified as the single `rsn=O` rejection? [Edge Case, Spec §9 FR-018]
- [ ] CHK028 Is the day-boundary edge case addressed (the gate evaluates "today" — is behavior at midnight/date rollover specified)? [Edge Case, Gap]
- [ ] CHK029 Are duplicate-username/email import edge cases addressed by the first-source-wins dedup requirement and re-run idempotency? [Edge Case, Spec §9 FR-005, AC-009]
- [ ] CHK030 Are URL-rewrite edge cases specified (query strings, case sensitivity, trailing characters, `relogin.asp?rsn=` handling)? [Edge Case, Gap]

## Non-Functional Requirements

- [ ] CHK031 Is a measurable performance target defined for login + token issuance? [NFR, Spec §13]
- [ ] CHK032 Are password-storage security requirements specified (hashed, never stored/logged/returned in plaintext)? [NFR, Spec §12]
- [ ] CHK033 Is observability of authorization denials specified (subject, endpoint, outcome — without password material)? [NFR, Spec §19]
- [ ] CHK034 Are secrets-handling requirements specified (configuration only, never in source)? [NFR, Spec §12 NFR-004]

## Dependencies & Assumptions

- [ ] CHK035 Are the SPEC-0003/SPEC-0004 deliverables recorded as verified dependencies rather than assumptions? [Dependency, Spec §22]
- [ ] CHK036 Are owner decisions Risk #2 (agent-binding key) and Risk #7 (su provisioning) documented as gating conditions? [Assumption, Spec §22]
- [ ] CHK037 Is the assumption that import hashes the stored legacy password value as-is (preserving today's behavior) documented, including the R3 reset path? [Assumption, Spec §21 R3]
- [ ] CHK038 Is the test-only assumption that an open `security` day is seeded for the 5-role login test documented? [Assumption, Spec §20 AC-001]

## Ambiguities & Conflicts

- [ ] CHK039 Does the spec explicitly resolve the AC-001 vs AC-011 login contradiction rather than leaving it implicit? [Conflict, Spec §20]
- [x] CHK040 Are JWT/cookie lifetimes specified or explicitly deferred to planning (no silent assumption)? → RESOLVED 2026-08-11 (Spec §15: lifetimes read from configuration only, owner confirms values before go-live) [Ambiguity, Spec §15]
- [x] CHK041 Is the legacy unreachable `rsn=C` branch (`authenticate.asp` line 72) acknowledged with observable behavior preserved? → RESOLVED 2026-08-11 (FR-018: `rsn=C` never produced) [Ambiguity, Spec §9 FR-018]

## Post-Re-Clarification Consistency (2026-08-11)

- [ ] CHK042 Are the password-policy requirements (minimum 8 characters, no forced complexity) specified with the same rule on every password-setting surface in scope — registration (FR-012), change-password (FR-019), §12 Security, §14 UI, §15 API, §17 Validation Rules — with no conflicting wording anywhere? [Consistency, Spec §9 FR-012/FR-019, §12, §14, §15, §17]
- [ ] CHK043 Is it explicit that the policy applies ONLY to new/changed credentials — i.e., a migrated account whose legacy hash is shorter than 8 characters still verifies its current password normally, and only the newly chosen password must meet the policy? [Clarity, Spec §12]
- [x] CHK044 Is "minimum 8 characters" defined precisely enough for identical validation on Web and API (trimmed whitespace, Unicode code points vs bytes, no forced-complexity classes) so the shared validation rule cannot be implemented two ways? → RESOLVED 2026-08-11 (Spec §17: raw string length — UTF-16 code units — exactly as the single shared Identity `RequiredLength` validator enforces it; no trimming/normalization; both surfaces share the rule) [Clarity, Spec §12, §17]
- [ ] CHK045 Are the password policy and the day-gate specified as single-source business rules implemented once in `VisaFusion.Core` and shared by the Web UI and the API — per the constitution's "never duplicated per surface" rule, which explicitly names the day-open gate? [Consistency, Constitution §Engineering Process, Spec §17]
- [ ] CHK046 Is the policy-violation response specified on both surfaces — the Web inline message text and the API 400 error detail — so the user is told the exact rule (minimum 8 characters, no forced complexity)? [Completeness, Spec §14, §15]
- [ ] CHK047 Is the R3 reset path (migrated users whose remembered password differs from the lowercased stored hash) reconciled with the password policy and with the deferred admin/for-agent reset endpoints — i.e., is it specified how a Phase 0 user who cannot sign in receives a policy-compliant reset given no reset endpoint is implemented by this feature? [Consistency, Gap, Spec §21 R3, §15, contracts/secured-write-routes.md §3.2]
- [ ] CHK048 Is the policy boundary reflected in the test scenarios — i.e., is there a TS assertion that a migrated short legacy hash still authenticates (AC-001), while registration/change-password reject a new password under 8 characters (TS-005/TS-014)? [Coverage, Spec §20 AC-001, §23 TS-005/TS-014]

## Notes

- This checklist validates the SPEC-0005 requirements as revised on 2026-08-11 (eight
  clarification answers; the two re-clarifications added on 2026-08-11 resolve the
  day-gate `rsn=C` dead-code outcome and the password policy: minimum 8 characters,
  no forced complexity).
- CHK042–CHK048 appended 2026-08-11 (Option A) — post-re-clarification consistency
  checks for the password policy (single-source rule, boundary for migrated hashes,
  cross-surface wording, precise length definition) and the R3 reset reconciliation.
- Traceability references point to `spec.md` sections; `[Gap]`, `[Ambiguity]`,
  `[Conflict]`, `[Assumption]` markers indicate requirement-quality findings.
- Open gaps flagged for resolution before or during implementation: CHK011
  (role-appropriate landing page mapping), CHK028 (day-boundary), CHK030 (URL-rewrite
  edge cases), CHK040 (token/cookie lifetimes).
