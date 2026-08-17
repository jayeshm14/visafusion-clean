# Feature Specification: Admin/Agent CRUD, Security-Day Gate, Public Site, and Professional UI Theme

**Identifier**: SPEC-0007
**Title**: Admin/Agent CRUD, Security-Day Gate, Public Site, and Professional UI Theme
**Status**: Draft
**Created**: 2026-08-17
**Category**: web
**Input**: User description: "Admin/agent CRUD, security gate, public site, theme — 8. Agent/admin CRUD, security-day gate admin-only (§4.2), public site parity — 9. Professional UI theme per §14: replace AdminLTE, design-token system, WCAG-AA baseline, UTF-8 fix"

> This template is the VisaFusion override of the SpecKit `spec-template`.
> It is resolved first by the Spec Kit template stack (`.specify/templates/overrides/`)
> and MUST contain the 24 required sections defined in `library/03_SpecKit_SDD_Framework.md` §4.
> Do not remove or reorder the 24 numbered sections below.

## 1. Identifier

- **SPEC-0007**: Agent/Admin Management (CRUD + Self-Service Portal), Security-Day Gate, Public Site, and Professional UI Theme

## 2. Title

Agent/Admin Management (CRUD + Self-Service Portal), Security-Day Gate, Public Site, and Professional UI Theme — Phase 3 items 8-9 of `library/ExecutionPlan.md`

## 3. Objective

Deliver Phase 3 items 8-9 of `library/ExecutionPlan.md`: (8) agent/admin CRUD with enforced RBAC, the security-day open/close gate restricted to `adm`/`su` per §4.2, and public site parity; (9) the professional UI theme per §14 — replace AdminLTE with a bespoke Bootstrap 5.3.7 theme, introduce a design-token system, meet a WCAG-AA accessibility baseline, and fix the legacy iso-8859-1 encoding to UTF-8. This feature converts the legacy display-only role gates into enforced authorization and replaces the partially-applied AdminLTE shell with a production-grade, accessible, token-driven UI.

## 4. Business Context

The legacy Classic ASP app has no real authorization: role checks are display-only and `openForDay.asp`/`closeForDay.asp` are completely anonymous — any logged-in or anonymous user can open/close the working day (`@findings/deepanalysis.md` §2.4 findings 10-11, line 84). Agent records are managed through a set of Classic ASP pages (`addnewagents.asp`, `editagent.asp`, `viewagent.asp`, `deleteUser.asp`, `newagent.asp`, `neweditagent.asp`), and user accounts through `addNewUser.asp`/`deleteUser.asp`. The public site (`Default.asp`, `contactus.asp`, `queries.asp`, `embassyhome.asp`, `CountryInfo.asp`, `VisaInfo.asp`, `forms.asp`, `registration.asp`, `subscribe.asp`) is table-based HTML served as iso-8859-1, with AdminLTE 4 + Bootstrap 5.3.7 applied only to shell pages (`logon.asp`, `Administrator.asp`, `Agent.asp`, `Default.asp`, `update.asp`) and a leftover AdminLTE demo dropdown on `Default.asp` (`@findings/modernization_plan.md` §8.1, §9.2). The target enforces the role matrix the legacy module design implies (§4.2 of `@library/complete_migration_plan.md`) and replaces the AdminLTE shell with a bespoke theme per the ratified constitution (`@library/01_System_Role_and_Principles.md` — "Bootstrap 5.3.7 with a bespoke theme (AdminLTE is NOT used)").

## 5. Scope

- Agent record CRUD (create, read, update, deactivate) for `adm`/`su` per §4.2/§4.3
- Agent self-service portal: own entries, own statuses, own statement, own account — all scoped to the authenticated agent's own record (fixes the §2.3 agent-data-leak finding; §4.2 lines 146-149)
- Admin user-account management (create/delete users, role whitelist, su-only su creation) per §4.2/§4.3
- Security-day open/close restricted to `adm`/`su` (replacing the anonymous legacy endpoints)
- Public site parity for the §6.12 pages
- Professional UI theme: replace AdminLTE, design-token system, WCAG-AA baseline, UTF-8 fix
- Map all work to legacy pages per `@findings/modernization_plan.md` §6 and §13

## 6. Out of Scope

- Identity/RBAC foundation (covered by SPEC-0005)
- Entry workflow (covered by SPEC-0006)
- Notifications/SMS/email (Phase 2)
- Reporting (Phase 2)
- Billing and agent financial statement generation (`agentStatement*.asp` statement *management* is billing-module scope; the agent's own statement *view* is in scope per FR-020)
- Tour modules
- Data cleansing (Phase 4)
- The ~700 `updateDDMMYY.asp` static snapshot pages (content migration)
- Agent email/SMS actions (`emailAgent.asp`, `SendSMS*.asp`, `sendSMSToQueue.asp`) — Phase 2 Notifications module (`POST /notifications/sms`, `POST /notifications/email` per §4.3 line 198)
- AWB sending (`sendawbgo.asp` → `POST /api/v1/entries/{refno}/awb`) — already delivered by SPEC-0006

## 7. Stakeholders

- System administrators (`adm`/`su`) — manage agents, users, and the working day
- Agents (`agt`) — portal users; own data scoped to their own record; their records are managed by `adm`/`su`
- Employees (`emp`) — subject to the security-day gate
- Public visitors — public site pages
- Migration team — data integrity validation

## 8. Legacy Mapping

| Target capability | Legacy pages | Source |
|---|---|---|
| Agent CRUD | `addnewagents.asp`, `editagent.asp`, `viewagent.asp`, `deleteUser.asp`, `newagent.asp`, `neweditagent.asp` | modernization_plan §6.4 |
| Agent self-service portal | `Agent.asp`, `agentHome.asp`, `listforagents.asp`, `agentpaxStatus.asp`, `agentinvoice.asp`, `AgentAccount.asp`; search `searchPax*`, `searchEntry*` | modernization_plan §6.5; complete_migration_plan §4.2 lines 146-149 |
| User management | `addNewUser.asp`, `deleteUser.asp`/`deleteSubmit.asp` | complete_migration_plan §4.3 |
| Security-day open/close | `securityHome.asp`, `openForDay.asp`, `closeForDay.asp` | modernization_plan §6.10; deepanalysis §2.4 |
| Public site | `Default.asp`, `profile.asp`, `contactus.asp`/`contact.asp`/`contactsendpre.asp`, `queries.asp`/`getqueries.asp`/`querieDetail.asp`, `embassyhome.asp`, `CountryInfo.asp`, `VisaInfo.asp`, `forms.asp`, `registration.asp`, `subscribe.asp` | modernization_plan §6.12 |
| Theme shell | `logon.asp`, `Administrator.asp`, `Agent.asp`, `Default.asp`, `update.asp` (AdminLTE 4) | modernization_plan §8.1 |

## 9. Functional Requirements

- FR-001: `adm`/`su` can create an agent in a single operation — the agent record (name, contact details) and its linked `agt` login are created together (BR-009)
- FR-002: `adm`/`su` can view agent records (list + detail)
- FR-003: `adm`/`su` can update agent records
- FR-004: agent records with business data (entries, ledger) are deactivated, not deleted — deactivation blocks the agent's login and portal access while preserving all business data; unreferenced records may be deleted
- FR-005: `adm`/`emp` can create user accounts with a role whitelist (`adm`, `emp`, `agt`, `guest`); `su` is never settable via this path
- FR-006: only `su` can create `su` accounts (audited)
- FR-007: deactivating a user whose role is `su` requires `su` (deletion is implemented as deactivation per FR-023)
- FR-008: `adm`/`su` can open and close the working day (security-day gate)
- FR-009: `emp` logins are blocked on closed days (existing gate rule from SPEC-0005 reused)
- FR-010: public site pages render with functional and content parity to legacy — same pages, content, and behavior under the new theme, with known legacy defects (e.g., the AdminLTE demo dropdown) fixed (session 2026-08-17)
- FR-011: public contact-query submission (anonymous, validated, rate-limited to 5/hour per source, per `contracts/public-api.md` §1)
- FR-012: public registration creates guest-role accounts only (reuses SPEC-0005 Register flow)
- FR-013: the professional theme is applied across all surfaces (public, admin, agent, auth)
- FR-014: a design-token system defines colors, typography, spacing, and radii
- FR-015: all pages meet the WCAG-AA baseline
- FR-016: all pages are served as UTF-8
- FR-017: `agt` can view their own entries list (legacy `listforagents.asp`), scoped to their own `agentId` from claims, never from query string
- FR-018: `agt` can view their own passenger statuses (legacy `agentpaxStatus.asp`), own-agent only, via `GET /api/v1/agents/{id}/statuses` (§15)
- FR-019: `agt` can view their own financial statement (legacy `agentStatement*`), own-only (fixes the §2.3 anonymous-read finding)
- FR-020: `agt` can view their own account/profile (legacy `AgentAccount.asp`) and update their own agent record (legacy `Agent.asp` → `PUT /api/v1/agents/{id}/self`)
- FR-021: `agt` search (`searchPax*`, `searchEntry*`) is scoped to their own agent — implemented as a `?q=` keyword filter on `GET /api/v1/agents/{id}/entries` and `GET /api/v1/agents/{id}/statuses` (§15, `Search` policy); scoping enforced by the claim-bound `{id}` per BR-007
- FR-022: `adm`/`su` can reactivate a deactivated agent, restoring their login and portal access (reversible lifecycle per session 2026-08-17)
- FR-023: user account deletion is implemented as deactivation — login blocked, row and audit references preserved, reversible (session 2026-08-17)

## 10. Business Rules

- BR-001: role matrix per §4.2 is enforced server-side, not display-only
- BR-002: security-day gate: `emp` logins allowed only when a `security` row exists for the date with `closingtime IS NULL` (existing rule, SPEC-0005 T018)
- BR-003: open/close day is `adm`/`su` only; the operation is atomic per date — concurrent open/close attempts resolve to a single winner, the loser receives `409 Conflict` (CHK022)
- BR-004: `su` accounts are created only by `su`
- BR-005: no anonymous write endpoints (public forms are the only anonymous POSTs, validated + rate-limited)
- BR-006: agent records referenced by business data are deactivated, never deleted; deactivation blocks login and preserves data; reactivation restores login (data preservation + security by default)
- BR-007: agent self-service data is scoped to the authenticated agent's own record — `agentId` from claims, never from query string (fixes §2.3 agent-data-leak finding)
- BR-008: agent financial ledger is own-only (fixes §2.3 anonymous-read finding)
- BR-009: agent creation provisions the agent record and its `agt` login atomically in one operation (FR-001); a duplicate login username returns `409 Conflict` (CHK025); the initial password is delivered out-of-band (manual handover) — email/SMS delivery is Phase 2 Notifications (CHK002)

## 11. Non-functional Requirements

- UTF-8 encoding on every page and API response
- WCAG-AA baseline (contrast, focus, keyboard navigation, labels)
- Self-hosted static assets (no CDN)
- Page load < 2s on the admin/agent surfaces; public forms respond < 1s
- Design tokens as the single source of visual truth

## 12. Security

- Enforced RBAC per §4.2 (401/403, never display-only)
- Role whitelist on user creation; `su` only via the su-only audited path
- No anonymous write endpoints except validated, rate-limited public forms
- No query-string identity; identity from authenticated session/claims
- An `agt` user without a linked `AgentId` cannot use agent-portal routes (403); user creation with role `agt` always links a valid agent (CHK026)
- Deactivated agent and user accounts cannot authenticate (FR-004/FR-022/FR-023). Mechanism: deactivation **locks the linked login account** (`agents.Active` set to the deactivated value + linked `AspNetUsers` account locked so authentication is rejected); reactivation **unlocks** it. Data rows and audit references are preserved; nothing is deleted. The lock lives in the Identity store (one source of truth for authentication), the `Active` flag lives in the agent record (one source of truth for business state) — both updated atomically by the deactivate/reactivate service operations.
- Audit events for user creation/deactivation, su provisioning, security-day open/close

## 13. Performance

- Admin/agent pages < 2s server response
- Public pages < 1s server response
- Static assets self-hosted and cacheable

## 14. UI Requirements

- Replace AdminLTE with a bespoke Bootstrap 5.3.7 theme
- Design-token system (colors, typography, spacing, radii) as CSS custom properties
- WCAG-AA baseline: contrast ≥ 4.5:1, visible focus, keyboard navigable, labeled controls
- UTF-8 everywhere (fix legacy iso-8859-1)
- Responsive layout for public pages
- Admin/agent surfaces use a sidebar + topbar shell layout — AdminLTE-style structure with fully bespoke styling (session 2026-08-17)
- Empty/zero states are explicit: agent lists, entries lists, statuses, and statements with no data render a friendly empty-state message (never a blank page or raw table header) (CHK027)

## 15. API Contracts

Per `@library/complete_migration_plan.md` §4.3 (authorization policies from Phase 0):

- `POST /api/v1/agents` — `adm`,`su` (create agent + linked `agt` login atomically, FR-001/BR-009; legacy `addnewagents.asp`/`newagent.asp`)
- `GET /api/v1/agents` — `adm`,`su` (list, FR-002; legacy `viewagent.asp`)
- `PUT /api/v1/agents/{id}` — `adm`,`su` (update agent; legacy `editdoneagent1.asp`)
- `PUT /api/v1/agents/{id}/self` — `agt` (own record only; legacy `editdonebyagent1.asp`)
- `GET /api/v1/agents/{id}/entries` — `agt` own / `emp`,`adm`,`su` (policy `AgentSelf`; legacy `listforagents.asp`); optional `?q=` keyword filter (FR-021, `Search` policy, scoped to the claim-bound `{id}`)
- `GET /api/v1/agents/{id}/statuses` — `agt` own / `emp`,`adm`,`su` (policy `AgentSelf`; legacy `agentpaxStatus.asp`, FR-018); optional `?q=` keyword filter (FR-021)
- `GET /api/v1/agents/{id}/statement` — `agt` own / `emp`,`adm`,`su` (policy `AgentLedger`; legacy `agentStatement*`)
- `POST /api/v1/agents/{id}/deactivate` — `adm`,`su` (FR-004; blocks the linked login, data preserved)
- `POST /api/v1/agents/{id}/reactivate` — `adm`,`su` (FR-022; restores login)
- `POST /api/v1/admin/security-day/open` — `adm`,`su` (legacy `openForDay.asp`)
- `POST /api/v1/admin/security-day/close` — `adm`,`su` (legacy `closeForDay.asp`)
- `GET /api/v1/admin/security-day/today` — `adm`,`su` (today status, FR-008; legacy `securityHome.asp`)
- `POST /api/v1/admin/users` — `adm`,`emp` (role whitelist `adm`,`emp`,`agt`,`guest`; `su` rejected; legacy `addNewUser.asp`/`editdonetest.asp`)
- `POST /api/v1/admin/superusers` — `su` only (audited)
- `POST /api/v1/admin/users/{id}/deactivate` — `adm`,`emp`; `su`-target additionally requires `su` (FR-007/FR-023; legacy `deleteUser.asp`/`deleteSubmit.asp`)
- `POST /api/v1/public/queries` — anonymous (validated, rate-limited; legacy `querieDetail.asp`)
- `POST /api/v1/public/register` — anonymous (output role always `guest`; legacy `regsub.asp`/`regsubmit.asp`/`regsubdone.asp`)

## 16. Database Changes

- No new business tables expected: `agents`, `security`, `AspNetUsers` already migrated (SPEC-0004/0005)
- Deactivation flag on `Agent` (FR-004/FR-022/AC-016): deactivated agents cannot authenticate; flag is reversible via reactivation. **Value convention (verified from legacy source)**: `Active = 'Y'` is active, `'N'` is inactive — `addnewagents.asp:57` writes `'Y'` on create, `editdoneagent1.asp:54-57` writes `'Y'`/`'N'` from the edit checkbox, `connection.asp:39` filters `where Active = 'Y'` (CHK008/R-007 resolved; T003 still confirms no anomalous values in live data)
- All changes reversible; no data deletion

## 17. Validation Rules

- Agent fields: required name, valid contact details
- User creation: role must be in the whitelist (`adm`, `emp`, `agt`, `guest`)
- Public forms: required fields, length limits, rate limits

## 18. Error Handling

- Standardized problem-details responses (401/403/404/409)
- Validation errors returned as field-level messages
- No stack traces or connection details leaked

## 19. Audit Requirements

- User creation/deactivation (actor, target, role)
- su provisioning (actor, target)
- Security-day open/close (actor, date, action)

**Observability (CHK030)**: beyond audit events, the new endpoints emit structured logs (Serilog) for authentication failures, security-day gate conflicts (409), and deactivate/reactivate operations; OpenTelemetry counters track public-query submissions and security-day open/close calls. No new infrastructure — extends the existing Serilog/OTel setup.

## 20. Acceptance Criteria

- AC-001: `adm`/`su` can create, view, update, deactivate, and reactivate agent records
- AC-002: non-`adm`/`su` roles receive 403 on agent-management endpoints
- AC-003: only `su` can create `su` accounts; attempts by others are 403 + audited
- AC-004: open/close day works for `adm`/`su`; anonymous/other roles are rejected
- AC-005: `emp` login on a closed day is rejected with the existing gate rule
- AC-006: public site pages render with functional and content parity under the new theme, UTF-8, and no legacy demo dropdown
- AC-007: public contact-query submission works and is rate-limited
- AC-008: no AdminLTE assets are referenced by any rendered page
- AC-009: design tokens are the single source of visual truth
- AC-010: WCAG-AA automated checks pass on all rendered pages (axe-core, per `contracts/ui-contract.md` §3)
- AC-011: every page and API response declares UTF-8
- AC-012: `agt` sees only their own entries, statuses, and statement; other agents' data returns 403/404
- AC-013: `agt` self-service uses `agentId` from claims, never from query string
- AC-014: `agt` can update their own agent record via `PUT /api/v1/agents/{id}/self`; other agents' records are rejected
- AC-015: `agt` search results are scoped to their own agent
- AC-016: a deactivated agent's login is rejected while their portal data remains intact; reactivation restores login and portal access
- AC-017: creating an agent also creates a linked `agt` login in the same operation
- AC-018: deleting a user deactivates the account — login blocked, row preserved, reversible; deactivating an `su` target requires `su`

## 21. Risks

- GAP-0004: identity import blocked — agent/user provisioning depends on its resolution
- Feature size: agent portal (FR-017..021) plus admin CRUD plus theme in one feature — mitigated by the phased task breakdown in plan.md
- Theme regression on legacy-parity pages

## 22. Dependencies

- SPEC-0005 (identity/RBAC foundation, Register flow, day-gate rule)
- SPEC-0006 (entry workflow — agent references)
- GAP-0004 resolution (identity import)

## 23. Test Scenarios

- Unit: role-matrix enforcement, security-day gate, validation rules, own-agent scoping
- Integration: agent CRUD, user creation/deactivation, security-day open/close, public forms, agent self-service (own-entries/statuses/statement/search)
- Functional: end-to-end admin flows, agent portal flows, public site parity
- UI: WCAG-AA automated checks, UTF-8 verification, no-AdminLTE assertion

## 24. Traceability Matrix

| Requirement | Legacy source | Test |
|---|---|---|
| FR-001..004 | §6.4 pages | TS-001..004 |
| FR-005..007 | §4.3 | TS-005..007 |
| FR-008..009 | §6.10, deepanalysis §2.4 | TS-008..009 |
| FR-010..012 | §6.12 | TS-010..012 |
| FR-013..016 | §8.1, §9.2 | TS-013..016 |
| FR-017..021 | §6.5, §4.2 lines 146-149 | TS-017..021 |
| FR-022 | lifecycle decision, session 2026-08-17 | TS-022 |
| FR-023 | user-deactivation decision, session 2026-08-17 | TS-023 |

## Assumptions

- Agent CRUD means admin-side management of agent records and user accounts, plus the agent self-service portal (own entries, statuses, statement, account) scoped to the authenticated agent's own record
- Agent email/SMS actions belong to the Phase 2 Notifications module; AWB sending is already delivered by SPEC-0006
- The ~700 `updateDDMMYY.asp` static snapshot pages are content migration, not code
- Theme direction is the ratified constitution: bespoke Bootstrap 5.3.7 theme, AdminLTE NOT used
- Public registration reuses the SPEC-0005 Register flow (guest role)
- The security-day gate rule (emp login blocking) already exists from SPEC-0005; this feature adds the admin-only open/close surface
- Referenced agent records are deactivated, never hard-deleted (data preservation)

## Clarifications

### Session 2026-08-17

- Q: Is the agent self-service portal in scope? → A: Yes — portal is in scope (FR-017..021)
- Q: When an agent record is deactivated, what should happen to that agent's login and their existing business data? → A: Option A — deactivation blocks login and portal access, preserves all business data; reactivation restores login (FR-004, FR-022, AC-016)
- Q: When an admin creates a new agent, should the agent's login credentials be created in the same operation, or as a separate step? → A: Option A — single operation: agent record and `agt` login created together (FR-001, BR-009, AC-017)
- Q: What layout should the bespoke professional theme use for the admin and agent surfaces? → A: Option A — sidebar + topbar shell, AdminLTE-style structure with fully bespoke theme (§14)
- Q: What does "public site parity" mean for the legacy public pages? → A: Option A — functional and content parity under the new theme; known legacy defects fixed (FR-010, AC-006)
- Q: When an admin deletes a user account (FR-007), should the account be hard-deleted or deactivated? → A: Option A — deactivate: login blocked, row and audit references preserved, reversible (FR-023, AC-018)