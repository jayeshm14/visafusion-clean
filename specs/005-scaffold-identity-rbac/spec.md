# Feature Specification: Scaffold, Identity Consolidation & RBAC

**Identifier**: SPEC-0005
**Title**: Solution Scaffold Completion, Identity Consolidation & RBAC Enforcement
**Status**: Draft
**Created**: 2026-08-11
**Category**: security (cross-cutting: architecture scaffold completion + identity consolidation + authorization)
**Input**: User description: "Scaffold VisaFusion.Web/.Api/.Core/.Data/.Identity/.Jobs per §2 target architecture, EF Core DbContext skeleton, URL rewrite, static asset copy per §9. Identity consolidation: Udaan_users + agents + registration → AspNetUsers per §7, hash-on-migration, never store plaintext (§5.4.4 finding). RBAC matrix: implement §4 full endpoint × role matrix, all 13 anonymous write endpoints re-secured per §4.3."

> This template is the VisaFusion override of the SpecKit `spec-template`.
> It is resolved first by the Spec Kit template stack (`.specify/templates/overrides/`)
> and MUST contain the 24 required sections defined in `library/03_SpecKit_SDD_Framework.md` §4.
> Do not remove or reorder the 24 numbered sections below.

## 1. Identifier

- **SPEC-0005**: Solution Scaffold Completion, Identity Consolidation & RBAC Enforcement

## 2. Title

Solution Scaffold Completion, Identity Consolidation & RBAC Enforcement

## 3. Objective

Deliver the remaining Phase 0 trust-boundary pieces the solution needs before any
business module feature can be built safely, on top of the verified baseline already
delivered by SPEC-0003 (six-project scaffold, single-process host, auth schemes,
observability) and SPEC-0004 (complete 52-table migration, identity import with hashed
passwords, static asset copy, `wwwroot` self-hosting). Verified on 2026-08-11 against
the repository: the six projects build and boot; the `VisaEntryDbContext` maps all 38
migrated entities with parameterized queries only; 879 static files are present under
`wwwroot`; the `identity` migration step imports `Udaan_users` + `agents` +
`registration` into `AspNetUsers` with PBKDF2-hashed passwords (never plaintext) and
seeded roles (`su`/`adm`/`emp`/`agt`/`guest`).

The delta this feature delivers per `library/complete_migration_plan.md` §10 Phase 0
("App boots; login works for all 5 roles against migrated (hashed) credentials;
backdoor query params confirmed inert"):
1. **Identity host integration** — register ASP.NET Core Identity services
   (`AddIdentityCore` + stores) against a `VisaFusionIdentityDbContext` mapping the
   existing `AspNetUsers`/`AspNetRoles`/`AspNetUserRoles` store (§7); real
   `POST /api/v1/auth/login` / `logout` / `POST /api/v1/public/register` endpoints and
   Web `/Auth/Login` + `/Auth/AccessDenied` pages; token claims carry roles and the
   claim-bound `AgentId` (fixes §2.3 query-string identity).
2. **RBAC enforcement** — an authorization policy catalog derived from the full §4.2
   module × role matrix, applied to every existing endpoint and to the 13 §4.3
   anonymous write endpoints re-secured with their named target routes and minimum
   roles (11 role-secured, 2 public-by-design with validation); registration is
   guest-only (fixes §2.2 escalation); backdoor query parameters
   (`udaanappraj123guruadm`, `udaan12345functiondisplaymarquee`) confirmed inert.
3. **URL rewrite** — legacy `.asp` entry URLs (login, registration, `Default.asp`)
   redirect to their new routes; unknown legacy URLs return 404 (no wildcard
   forwarding), per §9/§4.3 mapping.
4. **Phase 0 verification** — the 5-role login exit criterion, no-plaintext invariant,
   and role-denial behavior proven by automated tests.

## 4. Business Context

The legacy Classic ASP application has **no enforced role-based access control**
(`findings/deepanalysis.md` §2.1): of 585 root files, 414 reference session state zero
times and 0 files perform a role-denial check. A public registrant could POST
`privilege=su` to `addNewUser.asp` and become a super user (§2.2). Any anonymous caller
could write to the database through 13 unauthenticated write endpoints (§2.4), open or
close the working day (§2.5), read any agent's financial ledger via a tamperable
`?agent=` parameter (§2.3), and passwords were stored and compared in **plaintext,
lowercased** (`Udaan_users`, `registration.pwd`; `findings/modernization_plan.md` §5.4.4).
A deliberate query-string backdoor in `connection.asp` echoed internals and could
deny service (§2.7).

The migration to VisaFusion cannot go live with any of these behaviors carried forward.
This feature establishes the trust boundary: one identity store, hashed credentials,
and hard, role-based denials at every endpoint. It is Phase 0 of the phased rollout
(`library/complete_migration_plan.md` §10): the app must boot, and login must work for
all 5 roles against migrated (hashed) credentials, before any module feature is built.

## 5. Scope

**Verified baseline (2026-08-11, repository inspection)** — NOT re-delivered here:
- Six §2 projects (Web, Api, Core, Data, Identity, Jobs) + Migration exist, build, and
  boot as one solution (SPEC-0003).
- `VisaEntryDbContext` maps all 38 SPEC-0004-migrated entities with parameterized
  queries only (SPEC-0004 FR-003) — the DbContext is complete, not a skeleton.
- 879 static files already copied to `wwwroot` (`css/`, `fonts/`, `forms/`, `images/`,
  `js/`, `updateimg/`) and served by `UseStaticFiles()` (SPEC-0003 T030).
- Identity import exists: `IdentityImporter`/`PasswordHasher`/`IdentityCommand`
  (SPEC-0004 T038–T040) create `AspNetUsers`/`AspNetRoles`/`AspNetUserRoles` and
  import `agents`(agt) → `registration`(guest) → `Udaan_users`(su/adm/emp/agt) with
  hashed passwords, first-source-wins dedup, and `AgentId` binding.
- JWT bearer + cookie auth schemes, representative `/api/v1` endpoints with inline
  role requirements, and `ProductionSecretsGuard` exist (SPEC-0003).

**In scope — the Phase 0 delta:**

**Identity host integration (per §7):**
- Register ASP.NET Core Identity in the host: `AddIdentityCore<IdentityIntegration.VisaFusionUser>`
  + roles + `VisaFusionIdentityDbContext` (a new Identity DbContext in the Identity
  project mapping the existing `AspNetUsers`/`AspNetRoles`/`AspNetUserRoles` store,
  extended with the standard claims/logins/tokens tables created idempotently by the
  migration tool) — no changes to `VisaEntryDbContext` or the EF migration pipeline.
- Real auth endpoints: `POST /api/v1/auth/login` (validates against the consolidated
  store, returns JWT with role claims + claim-bound `AgentId`), `POST /api/v1/auth/logout`,
  `POST /api/v1/public/register` (guest-only); Web `/Auth/Login` and `/Auth/AccessDenied`
  Razor Pages (cookie sign-in) that the existing `LoginPath`/`AccessDeniedPath` already
  reference but which do not exist today.
- Align the import with §7: read `active` from all three legacy sources and set
  `LockoutEnabled = !active` (with `LockoutEnd` for inactive accounts so they are
  actually blocked), resolving the current hardcoded `LockoutEnabled=1` deviation.
- Enforce the legacy **employee day-gate** in login (clarified): both the Web cookie
  login and the API login apply the gate for `emp` logins per `authenticate.asp`
  lines 62–79 — login succeeds iff a `security` row exists for today with
  `closingtime IS NULL` (open day); otherwise rejected with `rsn=O`. The `rsn=C`
  rejection is NOT produced (dead code at `authenticate.asp` line 72).
  `ISecurityGateService` (currently a placeholder) gains the day-gate evaluation.
- Deliver **self-service change-password** (clarified): `/Auth/ChangePassword` (Web)
  and `POST /api/v1/auth/change-password` (API), replacing `changepassword.asp` +
  `newpassword.asp`; new passwords hashed via `UserManager.ChangePasswordAsync`
  without the legacy forced lowercasing. The privileged for-agent password set
  (`changepasswordforagent.asp`/`newpasswordforagent.asp`) lands with the
  Agent/User-management module features — contract documented in §15.

**RBAC enforcement (per §4 / §4.3):**
- Authorization policy catalog in `VisaFusion.Api` derived from the §4.2 module × role
  matrix (EntryOperations, AgentSelf, AgentLedger, BillingOperations, Search,
  UserManagement, HolidayAdmin, SecurityGate, PasswordSelf, AdminPanel, SuperUserOnly).
- Apply policies to the existing representative endpoints (replacing inline role
  lists) and enforce the §4.3 matrix: 11 write routes created with their named target
  routes + minimum roles, returning 501 Not Implemented until their module feature
  delivers the payload; the 2 public-by-design routes (`POST /api/v1/public/queries`,
  `POST /api/v1/public/register`) remain anonymous with validation.
- Registration creates `guest` only. The admin user-management write endpoints
  (`POST /api/v1/admin/users`, `DELETE /api/v1/admin/users/{username}`,
  `POST /api/v1/admin/superusers`) are **documented as contracts (§15) but NOT
  implemented in this feature** — they land with the User-management module feature
  (Phase 3), which delivers the FR-013 role whitelist and the su-only audited path
  (gated on owner decision Risk #7).
- Backdoor query parameters confirmed inert (test-only).

**URL rewrite (per §9 / §4.3):**
- Middleware mapping the documented legacy entry URLs — `Default.asp`, `authenticate.asp`,
  `logon.asp`, `regsub*.asp` → their new routes (`/`, `/Auth/Login`, `/Auth/Register`) —
  with 301 redirects; any other `.asp` URL → 404 (no wildcard forwarding).

**Verification / hardening:**
- Phase 0 exit criteria proven by tests: 5-role login, no plaintext, role denials,
  backdoor inertness, URL rewrite, static assets self-hosted.

## 6. Out of Scope

- **Business module functionality** (entry creation, status updates, billing,
  collection, notifications, reports, content CMS) — separate feature specs.
- **Data remediation** (statusID=508 duplicate, junk dates, orphaned `Mainentry` rows,
  `grandtotal` overflow) — owned by SPEC-0004 (implemented) and owner decisions in
  `library/complete_migration_plan.md` §12.
- **Invoice/billing revival** — gated behind owner decision Risk #1 (§12).
- **UI page design and styling** beyond the minimal login / access-denied pages needed
  to exercise the identity and authorization flows.
- **Per-module API contracts** — established per module in later specs; this feature
  defines only the auth, user-management, and re-secured write contracts needed for
  the matrix.
- **Hosting/infrastructure automation** (CI/CD, Key Vault, backup cadence) — listed in
  §11 of the migration plan, delivered by ops, not this feature.
- **Decommissioning legacy `.asp` files** — Phase 4 activity, out of scope here.

## 7. Stakeholders

- **Back-office staff (Employee, Admin, Super-user)**: must log in with their existing
  credentials (now hashed) and reach only the modules their role permits.
- **Agents**: must log in and see only their own entries/statements (fixes the data-leak
  finding); must not reach admin functions.
- **Public registrants / guests**: can still register and submit public queries, but can
  never gain privileged roles.
- **System owner / business owner**: signs off the agent-binding key (Risk #2 in §12)
  and the su provisioning process (Risk #7).
- **Development team**: builds module features on the consolidated identity store and
  enforced policies.
- **Auditors**: rely on hashed credentials, audited su provisioning, and the enforced
  matrix as evidence of remediation.

## 8. Legacy Mapping

| Target piece | Legacy source | Citation |
|---|---|---|
| Six-project scaffold | 585 root ASP files, module map | `@findings/modernization_plan.md` §3.5, §6; `library/complete_migration_plan.md` §2 |
| EF Core DbContext skeleton | 52-table `VisaEntry` schema (0 FKs, 2 PKs) | `@findings/exiting_architecture.md` §2; SPEC-0004 |
| URL rewrite | Legacy page URLs (e.g. `authenticate.asp`, `Agent.asp`, `logon.asp`, `Default.asp`, `listforagents.asp`, `Administrator.asp`) | `@findings/modernization_plan.md` §3.5, §6 |
| Static asset copy | `forms/`, `updateimg/`, `images/`, `css/`, `js/`, `fonts/` (~30 MB + 57 forms) | `library/complete_migration_plan.md` §9 |
| Identity consolidation | `Udaan_users` (2,365), `agents` (4,218), `registration` (43) | `library/complete_migration_plan.md` §7; `@findings/modernization_plan.md` §5.1–5.4 |
| RBAC matrix | `Udaan_users.privilege`; role → module access matrix | `@findings/deepanalysis.md` §3; `library/complete_migration_plan.md` §4 |
| 13 anonymous write endpoints | `editdoneagent1.asp`, `editdonebyagent1.asp`, `execute.asp`, `editbill.asp`, `holidayDeleteSubmit.asp`, `holiday_WebEntry.asp`, `querieDetail.asp`, `sendawbgo.asp`, `todayAgentStatusalltemp.asp`, `openForDay.asp`, `closeForDay.asp`, `regsub*.asp`, `insertEntry.asp` | `@findings/deepanalysis.md` §2.4; `library/complete_migration_plan.md` §4.3 |

No new business behavior is introduced; legacy behavior is the source of truth, and the
remediation targets are the documented legacy findings.

## 9. Functional Requirements

**Scaffold completion**

- **FR-001**: The solution MUST contain the six §2 projects (Web, Api, Core, Data,
  Identity, Jobs) building with a single command and booting with no external services
  beyond SQL Server. (Verified delivered by SPEC-0003; this feature re-verifies at
  build.)
- **FR-002**: The EF Core DbContext MUST map every entity migrated by SPEC-0004 and
  MUST use parameterized queries only (no string-concatenated SQL). (Verified delivered
  by SPEC-0004 — `VisaEntryDbContext` is complete; no DbContext skeleton work remains.)
- **FR-003**: Legacy `.asp` entry URLs MUST be rewritten to their new routes (login,
  registration, `Default.asp`) so bookmarked legacy links continue to resolve during
  the transition window; unknown `.asp` URLs MUST produce a clear 404, never a silent
  redirect (NFR-005).
- **FR-004**: Static assets (`forms/`, `updateimg/`, `images/`, `css/`, `js/`, `fonts/`)
  MUST be served self-hosted from the app (no CDN), per §9. (Copied by SPEC-0003/0004;
  verified here.)

**Identity consolidation**

- **FR-005**: All legacy accounts MUST be consolidated into a single Identity user
  store: `Udaan_users` (su/adm/emp/agt) → roles `su`/`adm`/`emp`/`agt`; `registration`
  → role `guest`; per §7. (Import delivered by SPEC-0004 T038–T040; this feature MUST
  integrate that store into the running host so login actually uses it.)
- **FR-006**: Every migrated password MUST be hashed on import; no plaintext password
  value MUST exist anywhere in the new system, including the database, logs, and the
  admin user-edit screen (§5.4.4 finding). (Import hashing delivered; the runtime MUST
  never store, log, or return a plaintext password.)
- **FR-007**: Agent (agt) users MUST carry a stable `AgentId` bound at import time and
  surfaced as a claim in the issued token; the system MUST never re-derive agent
  identity from a URL/query parameter (fixes the `jn=` / `agent=` tampering finding,
  §2.3).
- **FR-008**: Super-user accounts MUST receive the `adm` role plus a distinct
  `SuperUser` claim so su-only operations can be authorized separately from ordinary
  admin actions.
- **FR-009**: Inactive legacy accounts (`active = false`) MUST be prevented from
  signing in (locked out), preserving the legacy `active` flag meaning. (Fixes the
  current importer deviation that hardcodes `LockoutEnabled=1` for all accounts.)
- **FR-017**: The host MUST register ASP.NET Core Identity (`AddIdentityCore` +
  roles + stores against the existing identity tables) so `UserManager`/`SignInManager`
  authenticate against the migrated store; cookie sign-in (Web UI) and JWT bearer
  (API) MUST both validate against it. Login MUST work for all 5 roles
  (Phase 0 exit criterion, NFR-002).
- **FR-018**: The login flow MUST enforce the legacy employee day-gate for `emp`
  users (per `authenticate.asp` lines 62–79): login succeeds iff a `security` row
  exists for today with `closingtime IS NULL` (open day); otherwise login is rejected
  with `rsn=O`. The legacy `rsn=C` closed-day rejection is NOT implemented — it is
  unreachable dead code in the legacy (the query filters `closingtime is null`, so the
  `closingtime<>""` branch at `authenticate.asp` line 72 never fires) and reproducing
  it would change business behavior. Web login redirects to `/Auth/Login?rsn=O`; API
  login returns 403 with `rsn=O` in the problem-details body. `ISecurityGateService`
  MUST expose the day-gate evaluation.
- **FR-019**: A signed-in user MUST be able to change their own password (replacing
  `changepassword.asp` + `newpassword.asp`); the new password MUST meet the password
  policy (minimum 8 characters, no forced complexity) and MUST be stored as a hash via
  `UserManager.ChangePasswordAsync`, **not** lowercased or stored as plaintext
  (documented security fix for `newpassword.asp` line 43). Wrong current password →
  error; new ≠ confirm → validation error. The privileged for-agent password set
  (`changepasswordforagent.asp`/`newpasswordforagent.asp`) is deferred to the
  Agent/User-management module features (contract in §15).

**RBAC enforcement**

- **FR-010**: Every module from the §4.2 matrix MUST enforce its role set as a hard
  denial on both the Web UI and the `/api/v1` surface — a user without the required
  role MUST be rejected (403), not merely hidden from (fixes §2.1).
- **FR-011**: All 13 anonymous write endpoints from §4.3 MUST be re-secured with the
  named target route and minimum role; none remain anonymous, none are dropped.
- **FR-012**: The two by-design public write endpoints (public registration → always
  `guest`; public contact queries) MUST remain anonymous but MUST validate input and be
  rate-limited; registration MUST NEVER assign a privileged role (fixes §2.2) and MUST
  enforce the password policy for the new account's password.
- **FR-013**: The user-management write endpoint MUST whitelist roles server-side
  (`adm`, `emp`, `agt`, `guest`); `su` MUST NOT be settable through it. `su` accounts
  MUST only be provisioned through a separate, su-only, audited endpoint
  (`POST /api/v1/admin/superusers`). (Contract documented in §15; implementation
  deferred to the User-management module feature, Phase 3 — out of scope here.)
- **FR-014**: Deleting a user whose role is `su` MUST require the caller to be an `su`
  (fixes "any account incl. su deletable", §2.9). (Contract documented in §15;
  implementation deferred to the User-management module feature, Phase 3.)
- **FR-015**: The legacy backdoor query parameters (`udaanappraj123guruadm`,
  `udaan12345functiondisplaymarquee`) MUST have no effect on any route (fixes §2.7).
- **FR-016**: Agent-scoped reads (status list, statement) MUST return only the
  authenticated agent's own data; requesting another agent's id MUST yield 403, not
  their data (fixes §2.3).

## 10. Business Rules

- **BR-001**: Role names are carried over verbatim from `Udaan_users.privilege`:
  `su`, `adm`, `emp`, `agt`, `guest` (§4.1).
- **BR-002**: Passwords are hashed on import; plaintext passwords are never stored,
  logged, or emailed (§5.4.4, §6 step 9).
- **BR-003**: Agent identity is bound at import and never re-derived from a caller
  parameter (§7, §2.3).
- **BR-004**: Public registration always results in the `guest` role, never a
  privileged role (§4.3).
- **BR-005**: `su` creation/deletion is restricted to `su` and is audited (§4.3).
- **BR-006**: The 13 anonymous write endpoints are re-secured, not dropped — all remain
  in scope with their legitimate workflows intact (§4.3).

## 11. Non-functional Requirements

- **NFR-001**: The solution MUST build with a single command and boot with no
  configuration beyond SQL Server.
- **NFR-002**: Login MUST work for all 5 roles against migrated (hashed) credentials
  (Phase 0 exit criterion, §10).
- **NFR-003**: All data access MUST be parameterized; no string-concatenated SQL.
- **NFR-004**: Secrets (connection string, JWT key, SMS/SMTP creds) MUST NOT be stored
  in source; they live in configuration (appsettings + User Secrets / Key Vault).
- **NFR-005**: The URL rewrite MUST NOT break existing public-site links; unknown or
  ambiguous legacy URLs must produce a clear 404, never a silent redirect to an
  unrelated page.
- **NFR-006**: Existing observability (Serilog + OpenTelemetry) MUST continue to work;
  authorization denials MUST be logged without logging any password material.
- **NFR-007**: The identity import MUST be repeatable and idempotent — re-running a
  completed import is a no-op or a documented safe re-run; it MUST NOT duplicate users.

## 12. Security

- Passwords hashed on import with a one-way password hasher; never stored, logged, or
  displayed in plaintext (§5.4.4).
- New/changed passwords enforce a minimum length of 8 characters with no forced
  complexity (NIST 800-63B aligned); the policy applies only to new credentials —
  migrated legacy hashes are unaffected.
- No query-string identity: agent id and all scoping data resolve from the
  authenticated principal's claims (§2.3).
- No anonymous write endpoints; the only anonymous endpoints are read-only public
  content plus the two by-design public submissions, both validated and rate-limited
  (§4.3).
- Role whitelisting server-side; no client-supplied role escalation (§2.2).
- `su` provisioning restricted to su and audited (§4.3).
- Legacy `connection.asp` backdoor and its query parameters have no effect (§2.7).
- Secrets out of source: connection string and JWT key come from configuration;
  `ProductionSecretsGuard` already fails fast in Production with dev-only config.
- The existing `_vti_cnf` metadata and scratch files are excluded from the static
  asset copy (§9).

## 13. Performance

- Identity import volume is small (2,365 + 43 accounts): the full import with hashing
  must complete well within the Phase 0 window (minutes, not hours).
- Login, token issuance, and role checks must add negligible latency (target: no
  perceptible delay over the pre-auth page load; plan target note: sub-100 ms for
  login + token issuance including identity-store reads). This is a target note, not
  a CI gate.
- URL rewrite must not add a full extra round trip; rewrites resolve internally.

## 14. UI Requirements

- A minimal login page (Web UI) that authenticates against the consolidated Identity
  store and routes the user to their role-appropriate landing page. An `emp` login
  rejected by the day-gate redirects back to `/Auth/Login?rsn=O` (no open-day row
  exists for today), mirroring the legacy `relogin.asp?rsn=`; `rsn=C` is never
  produced (legacy dead code, FR-018).
- Role-appropriate landing mapping (per §4.2): `su`/`adm` → AdminPanel, `agt` → agent
  portal (AgentSelf), `emp` → employee area (EntryOperations), `guest` → public home.
  The concrete landing-page routes land with each module feature (CHK011 — open
  planning decision); until then the post-login redirect defaults to the existing home
  page (`/Pages/Index.cshtml`).
- Accessibility (WCAG) requirements for the auth pages are a planning decision
  (deferred in the 2026-08-11 clarification session); the four auth pages will be
  reviewed for basic keyboard and contrast accessibility when the UI module feature
  specifies it.
- An access-denied page for authenticated-but-unauthorized requests.
- A minimal registration page (public) that creates `guest` accounts only.
- A change-password page (authenticated) that calls the identity store to update the
  current user's password and reports success / mismatch / policy-violation outcomes
  (mirroring the legacy `changepassword.asp?flag=1|2|3` outcomes as inline messages).
- Legacy static assets (forms, images, css, js, fonts) render correctly from the
  self-hosted wwwroot.
- Page-area visibility MUST continue to reflect the §4.2 matrix, but visibility is no
  longer the control — the server-side denial is.

## 15. API Contracts

- **Auth**: `POST /api/v1/auth/login`, `POST /api/v1/auth/logout` (Web UI uses cookies;
  API uses bearer tokens per SPEC-0003 FR-010). For `emp` logins, the day-gate
  (FR-018) applies: a rejected login returns `403` with `{ rsn: "O" }` in the
  problem-details body (`rsn=C` is never produced — legacy dead code, FR-018).
  `POST /api/v1/auth/change-password` (authenticated,
  current-password verified; returns 204 on success, 400 on wrong current password, new
  ≠ confirm, or a new password under 8 characters — policy violation per §17).
- Token/cookie lifetimes are a planning decision (tracked; checklist CHK040): the login
  endpoint MUST read the JWT expiry and cookie lifetime from configuration — no
  hard-coded values — and the owner confirms the values before go-live.
- **Public**: `POST /api/v1/public/register` (always `guest`), `POST /api/v1/public/queries`
  (anonymous, validated, rate-limited), read-only public content endpoints.
- **Admin — Users** (documented contract only; implementation deferred to the
  User-management module feature, Phase 3): `POST /api/v1/admin/users` (role whitelist
  `adm|emp|agt|guest`; `su` rejected), `DELETE /api/v1/admin/users/{username}`
  (su-deletion requires su), `POST /api/v1/admin/superusers` (su-only, audited).
- **Agent password set** (documented contract only; deferred to the Agent/
  User-management module features): `PUT /api/v1/agents/{id}/password` — `adm`,`su`,
  hashed via `UserManager`, no legacy lowercasing.
- **Re-secured writes** (per §4.3, minimum roles):
  - `PUT /api/v1/agents/{id}` — `adm`,`su`
  - `PUT /api/v1/agents/{id}/self` — `agt` (own record only)
  - `POST /api/v1/entries/{refno}/status` — `emp`,`adm`,`su` (replaces the retired
    arbitrary-SQL `execute.asp` endpoint)
  - `POST /api/v1/billing/entries` — `emp`,`adm`,`su`
  - `DELETE /api/v1/holidays/{id}` and `POST/DELETE /api/v1/holidays` — `adm`,`su`
  - `POST /api/v1/entries/{refno}/awb` — `emp`,`adm`,`su`,`agt` (own entries)
  - `POST /api/v1/reports/agent-status/today` — `emp`,`adm`,`su`
  - `POST /api/v1/admin/security-day/open` / `close` — `adm`,`su`
  - `POST /api/v1/entries` — `emp`,`adm`,`su`
- All `/api/v1` errors use the standardized problem-details JSON shape already
  established by SPEC-0003 (401 for unauthenticated, 403 for unauthorized).
- Versioning: `/api/v1` base path already established; contracts evolve at `/api/v1`.

## 16. Database Changes

- The identity store tables are created by the migration tool, not by a new EF
  migration: SPEC-0004's `IdentityImporter.EnsureIdentitySchemaAsync` already creates
  `AspNetUsers`/`AspNetRoles`/`AspNetUserRoles` idempotently (schema seeded with the
  five roles). This feature extends that DDL idempotently with the remaining standard
  tables the runtime store uses (`AspNetUserClaims`, `AspNetRoleClaims`,
  `AspNetUserLogins`, `AspNetUserTokens`) so the full ASP.NET Core Identity store
  contract is present. The `VisaEntryDbContext` EF migration pipeline is NOT touched.
- A new `VisaFusionIdentityDbContext` (in the Identity project) maps those tables with
  the default ASP.NET Core Identity schema; the custom columns
  `LegacyUdaanUserId`, `LegacyRegistrationId`, `AgentId` are mapped on `AspNetUsers`.
- Identity import: aligned with §7 — read `active` from all three legacy sources,
  set `LockoutEnabled = !active` (and a past `LockoutEnd` for inactive accounts), hash
  passwords with the platform password hasher in the same transaction as the import
  (§6 step 9), assign roles per §7, first-source-wins dedup (existing behavior).
- The legacy `Udaan_users` / `registration` tables are NOT dropped; they remain as the
  migration source of truth until cutover (Phase 4), per constitution Principle III.
- Reversible: the identity migration must be rollback-able; pre-import snapshot of the
  identity tables is taken.

## 17. Validation Rules

- Role values validated against the explicit enum (`adm`,`emp`,`agt`,`guest`) on the
  server; `su` is rejected through the standard user-management path.
- Registration input validated (required fields, unique username/email, password
  policy: minimum 8 characters, no forced complexity) with friendly error messages.
- The password policy counts the raw string length (UTF-16 code units) exactly as the
  single shared ASP.NET Core Identity password validator (`RequiredLength`) enforces
  it — no trimming or normalization is applied — and both the Web UI and the API MUST
  validate with the same shared rule so no password is accepted by one surface and
  rejected by the other.
- Agent self-service endpoints validate that the target `id` equals the caller's
  claim-bound `AgentId`; mismatch → 403.
- All query input parameterized; no raw SQL.
- Public write endpoints validate payloads and are rate-limited per §4.3. Concrete
  rate-limit thresholds (requests per period, burst) are an open planning decision
  (Risk R7): the limiter uses the ASP.NET Core built-in rate-limiting services with
  values read from configuration only — no threshold is hard-coded or invented — and
  the owner supplies the values before go-live.

## 18. Error Handling

- 401 (unauthenticated) and 403 (unauthorized) use the standardized problem-details
  JSON on the API; the Web UI redirects to login/access-denied pages.
- Identity import failures fail fast with a clear, logged error and a non-zero exit;
  no partial import state is left (rollback to the pre-import snapshot).
- Missing/invalid configuration (JWT key, connection string) fails fast in Production
  (existing `ProductionSecretsGuard`).
- No exceptions are swallowed (the legacy `on error resume next` pattern is not
  carried forward).

## 19. Audit Requirements

- `su` account provisioning and deletion are audited (who, when, target account) via
  the existing structured logging and the append-only audit tables where applicable.
- Authorization denials are logged (subject, endpoint, outcome) without any password
  material.
- The identity import produces a machine-readable report: source rows read, users
  created, roles assigned, duplicates skipped, password rows hashed (count only —
  never the values).
- Traceability: every requirement maps to the knowledge graph, the §4 matrix, and the
  §7 mapping (Traceability Matrix below).

## 20. Acceptance Criteria

- **AC-001**: The solution builds and boots; a user from each of the 5 roles can sign in
  with their migrated (hashed) credentials (Phase 0 exit criterion) — for `emp`, the
  login test runs with an open `security` day seeded for today (per §8 Test Matrix
  "on an open day → success"); the day-gate rejection paths are covered separately by
  AC-011.
- **AC-002**: No plaintext password value is retrievable anywhere post-migration —
  including the database, logs, and the admin user-edit screen (Test Matrix §8).
- **AC-003**: Attempting to read another agent's status list or statement via a
  manipulated id returns 403, not the other agent's data (§8 agent isolation test).
- **AC-004**: Each of the 13 §4.3 endpoints is unreachable anonymously and enforces its
  §4.2 minimum role; the by-design public endpoints remain reachable anonymously.
- **AC-005**: A guest cannot create or escalate to a privileged role at registration
  (Phase 0), and a registration password under 8 characters is rejected; `su` is only
  creatable via the su-only audited endpoint — verified when the User-management
  module feature lands (Phase 3), per §8 su self-escalation test.
- **AC-006**: The backdoor query parameters have no effect on any route (§8 backdoor
  test).
- **AC-007**: Bookmarked legacy `.asp` URLs resolve to their rewritten targets, and
  unknown legacy URLs produce a clear 404.
- **AC-008**: Static assets from §9 (forms, images, css, js, fonts) load from the
  self-hosted wwwroot.
- **AC-009**: Re-running the identity import is a no-op (no duplicate users).
- **AC-010**: An inactive legacy account cannot sign in.
- **AC-011**: An `emp` login succeeds iff a `security` row exists for today with
  `closingtime IS NULL` (open day); otherwise it is rejected with `rsn=O` — including
  on days whose row already has a closing time set (`rsn=C` is never produced, FR-018).
- **AC-012**: A signed-in user can change their own password; the new password is
  stored hashed (not lowercased, not plaintext); wrong current password, new ≠
  confirm, and new password under 8 characters are rejected (FR-019).

## 21. Risks

- **R1**: Agent-binding key ambiguity (which table is authoritative for agent login —
  `agents` vs `Udaan_users` `agt` rows) — Risk #2 in §12, carried forward; mitigated
  by import-time matching per §7 and a gap report if the match is ambiguous.
- **R2**: URL rewrite scope creep — mitigated by strict out-of-scope and a clear 404
  for unmapped URLs.
- **R3**: Import of legacy lowercased plaintext passwords: users whose remembered
  password is not the stored lowercase form cannot sign in after hashing. This is
  handled by hashing exactly the stored value (the only value that works today),
  preserving current behavior; flagged in the import report so the business can
  reset affected accounts.
- **R4**: A re-secured endpoint blocks a legitimate workflow that §4.3 did not
  enumerate — mitigated by the test matrix (§8) and the golden-file comparison before
  cutover.
- **R5**: Partial identity import state on failure — mitigated by transaction +
  pre-import snapshot (FR/NFR/§18).
- **R6**: Unmapped legacy static assets break public pages — mitigated by the §9 copy
  checklist and a post-copy link check.
- **R7**: Rate-limit thresholds for the public write endpoints
  (`POST /api/v1/public/register`, `POST /api/v1/public/queries`) are undecided
  (planning decision). Mitigated by using the framework's built-in rate limiter with
  configuration-driven values only — no invented thresholds — and tracking the owner
  decision before go-live (mirrors the §22 owner-decision tracking pattern).

## 22. Dependencies

- **SPEC-0003** (Target Architecture) — implemented; provides the six-project scaffold,
  hosting, auth schemes, observability, representative endpoints, and error shape this
  feature extends.
- **SPEC-0004** (Complete Data Model Migration) — implemented; provides the migrated
  schema, the identity import pipeline (`IdentityImporter`/`PasswordHasher`/
  `IdentityCommand`), the `VisaFusionUser` type + `Roles` constants
  (`VisaFusion.Identity.IdentityIntegration`), and the static asset copy this feature
  integrates into the running host.
- `library/complete_migration_plan.md` §4 (authorization matrix), §4.3 (13 write
  endpoints), §7 (identity consolidation), §9 (static asset copy), §10 (Phase 0 exit
  criteria), §12 (owner decisions).
- `@findings/modernization_plan.md` §5.1–5.4 (roles, login flow, plaintext finding,
  `active` columns).
- `@findings/deepanalysis.md` §2.1–2.9, §3 (security findings and role matrix).
- Owner decision Risk #2 (agent-binding key) from §12 — the §7 username ↔
  `agents.Description` binding is already implemented; owner confirmation is tracked
  for cutover, not blocking Phase 0.
- Owner decision Risk #7 (su provisioning process) from §12 — gates the deferred
  su-only user-management endpoints (Phase 3), not this feature.
- ADR-0001 (Target Architecture and Specs Layout).

## 23. Test Scenarios

- **TS-001**: Build + boot; all 5 roles sign in with migrated credentials (AC-001) —
  the `emp` case runs with an open `security` day seeded for today, per the §8 Test
  Matrix "on an open day → success" row.
- **TS-002**: Password hashing — no plaintext value retrievable in DB/logs/admin
  screen (AC-002, Test Matrix §8).
- **TS-003**: Agent isolation — agent A reads agent B's data via manipulated id →
  403 (AC-003).
- **TS-004**: Each of the 13 §4.3 endpoints: anonymous → 401; wrong role → 403;
  correct role → success (AC-004).
- **TS-005**: Guest registration escalation attempt rejected server-side (Phase 0);
  registration with a password under 8 characters rejected; su creation via the
  standard endpoint rejected + su-only endpoint works for su — verified when the
  User-management module feature lands (Phase 3).
- **TS-006**: Backdoor query params inert (AC-006).
- **TS-007**: URL rewrite — legacy links resolve; unknown URLs → 404 (AC-007).
- **TS-008**: Static assets served self-hosted (AC-008).
- **TS-009**: Identity import idempotency — re-run is a no-op (AC-009).
- **TS-010**: Inactive account cannot sign in (AC-010).
- **TS-011**: SQL injection regression — raw `'` inputs against the rewritten search
  endpoints remain parameterized (Test Matrix §8).
- **TS-012**: Golden-file parity for login/authorization behavior on a sanitized
  subset, where applicable (per §10 of the migration plan).
- **TS-013**: Employee day-gate — `emp` login succeeds when a `security` row exists
  for today with `closingtime IS NULL`; rejected with `rsn=O` when no such row exists
  (including when today's row has a closing time set); `rsn=C` is never produced
  (AC-011, FR-018; legacy behavior per `authenticate.asp` lines 62–79).
- **TS-014**: Change-password — success stores a hash (no lowercase, no plaintext),
  wrong current password rejected, new ≠ confirm rejected, new password under 8
  characters rejected (AC-012, FR-019).

## 24. Traceability Matrix

| Requirement | Architecture | Domain | Database | API | UI | Test | Migration |
|-------------|--------------|--------|----------|-----|----|------|-----------|
| FR-001      | §2           | —      | —        | —   | —  | TS-001 | —         |
| FR-002      | §2           | Data   | SPEC-0004 schema | — | — | TS-011 | —         |
| FR-003      | §2           | —      | —        | —   | Web | TS-007 | —         |
| FR-004      | §9           | —      | —        | —   | Web | TS-008 | §9        |
| FR-005      | §7           | Identity | AspNetUsers | —  | —  | TS-001 | §7        |
| FR-006      | §7, §12      | Identity | AspNetUsers.PasswordHash | — | Web | TS-002 | §6.9      |
| FR-007      | §7, §12      | Identity | AspNetUsers.AgentId | Api | —  | TS-003 | §7        |
| FR-008      | §4.1         | Identity | AspNetUserClaims | Api | —  | TS-005 | §7        |
| FR-009      | §7           | Identity | AspNetUsers.LockoutEnabled | — | — | TS-010 | §7        |
| FR-010      | §4.2         | SecurityGate | — | Api | Web | TS-004 | —         |
| FR-011      | §4.3         | —      | —        | Api | —  | TS-004 | —         |
| FR-012      | §4.3         | —      | —        | Api | Web | TS-005 | —         |
| FR-013      | §4.3         | Identity | —       | Api | Web | TS-005 | —         |
| FR-014      | §4.3         | Identity | —       | Api | —  | TS-005 | —         |
| FR-015      | §2.7         | SecurityGate | —    | —   | Web | TS-006 | —         |
| FR-016      | §4.2, §2.3   | SecurityGate | —    | Api | Web | TS-003 | —         |
| FR-017      | §7, §10      | Identity | AspNetUsers | Api | Web | TS-001 | §7        |
| FR-018      | §5, §7       | SecurityGate | security (SPEC-0004 §3.1) | Api | Web | TS-013 | mod-plan §3.8/§5.2; §8 Test Matrix |
| FR-019      | §7           | Identity | AspNetUsers.PasswordHash | Api | Web | TS-014 | mod-plan §5.4; deepanalysis §2.2 |
| NFR-002     | §10          | Identity | —      | Api | Web | TS-001 | §7        |
| NFR-007     | §18          | —      | AspNetUsers | —  | —  | TS-009 | §7        |
| AC-004      | §4.3         | —      | —        | Api | —  | TS-004 | —         |

## Assumptions

- **Verified 2026-08-11 (not assumptions):** the six §2 projects exist and build;
  `VisaEntryDbContext` maps all 38 SPEC-0004 entities; 879 static files are in
  `wwwroot`; the identity import (`IdentityImporter`/`PasswordHasher`/`IdentityCommand`)
  creates `AspNetUsers`/`AspNetRoles`/`AspNetUserRoles` and imports the three legacy
  sources with hashed passwords. SPEC-0005 does NOT re-deliver these.
- The runtime identity store is a new `VisaFusionIdentityDbContext` in the Identity
  project mapping the migration-tool-created identity tables; `VisaEntryDbContext`
  (business schema, EF-migrated) is untouched to avoid mixing Identity conventions
  with the legacy table/column mappings and to avoid a Data↔Identity reference cycle.
- The single-process host is `VisaFusion.Web` (Razor Pages + `/api/v1`); the API
  authenticates with bearer tokens (JWT), the Web UI with cookies (SPEC-0003 FR-010).
- The identity import hashes the stored legacy password value as-is (the only value
  that authenticates today), preserving current login behavior exactly; affected users
  whose remembered password differs are handled via password reset, flagged in the
  import report.
- `agents` remains the operational agent profile store; `Udaan_users` `agt` rows carry
  the login. The binding key (username ↔ `agents.Description`) follows §7 pending
  owner confirmation (Risk #2) — already implemented by SPEC-0004.
- Static assets are copied as-is (including the 57 embassy PDF/DOC forms) and served
  from wwwroot; `_vti_cnf` metadata and scratch files are excluded (§9).
- The URL rewrite covers the documented Phase 0 entry URLs only (`Default.asp`,
  `authenticate.asp`, `logon.asp`, `regsub*.asp`); unmapped legacy URLs return 404 (no
  blind wildcard forwarding). Module-phase rewrites are added by those module
  features.
- Inactive legacy accounts (`active = false`) map to lockout (§7); no data is deleted.
- The §4.3 write routes created in this feature enforce authentication + role and
  return 501 Not Implemented payloads until their module feature delivers the
  business payload; this closes the anonymous-write holes at the boundary without
  inventing business behavior.

## Clarifications

### Session 2026-08-11

- Q: How do the 13 anonymous write endpoints map to target routes and roles? → A:
  Exactly as `library/complete_migration_plan.md` §4.3 specifies — one row per legacy
  file, named target route, minimum role; `execute.asp` is retired as a generic
  arbitrary-SQL endpoint and replaced by the typed status-update route
  `POST /api/v1/entries/{refno}/status`; `querieDetail.asp` and `regsub*.asp` stay
  anonymous by design with validation + rate limiting.
- Q: What does "scaffold per §2" add beyond SPEC-0003? → A: Verified 2026-08-11:
  SPEC-0003 delivered the project skeleton, hosting, auth schemes, observability, and
  error shape; SPEC-0004 delivered the complete DbContext, the static asset copy, and
  the identity import with hashed passwords. The remaining Phase 0 delta this feature
  delivers is: Identity host integration (services + login/logout/register + Web auth
  pages + claim-bound agent identity), the RBAC policy catalog and the re-secured
  §4.3 write routes, the §7 `active`-based lockout alignment, and the legacy URL
  rewrite for the documented entry URLs.
- Q: Are the legacy identity tables dropped? → A: No. `Udaan_users` and `registration`
  remain as the migration source of truth until cutover (Phase 4); this feature only
  reads from them and writes to the Identity store (constitution Principle III).
- Q: Should the admin user-management write endpoints (`POST /api/v1/admin/users`,
  `DELETE /api/v1/admin/users/{username}`, `POST /api/v1/admin/superusers`) be
  implemented in this feature or deferred? → A: Deferred (option B) — contracts
  documented in §15; implementation, including the FR-013 role whitelist and the
  su-only audited path, lands with the User-management module feature (Phase 3),
  gated on owner decision Risk #7. §5 scope, §9 FR-013/FR-014, §20 AC-005, §23 TS-005,
  and §22 dependencies updated to match.
- Q: Should the legacy employee day-gate be enforced in this feature's login flow?
  → A: Enforced now (option A) — both the Web cookie login and the API login apply the
  day-gate for `emp` logins per `authenticate.asp` lines 62–79
  (`findings/modernization_plan.md` §3.8, §5.2): no open `security` row for today →
  rejected with `rsn=O`; day closed (closing time set) → `rsn=C`; open day → success.
  `ISecurityGateService` gains the day-gate evaluation; the Web login redirects to
  `/Auth/Login?rsn=O|C` (mirroring `relogin.asp?rsn=`), the API login returns 403 with
  the `rsn` in the problem-details body. §5, §9 FR-018, §14, §15, §20 AC-011, §23
  TS-013, §24 updated to match.
- Q: Is password management in Phase 0 scope? → A: Option A — self-service
  change-password (`/Auth/ChangePassword`, `POST /api/v1/auth/change-password`) is in
  Phase 0 (needed for R3 account resets after first login); the privileged for-agent
  password set lands with the Agent/User-management module features. New passwords are
  stored as proper hashes via `UserManager.ChangePasswordAsync` **without** the legacy
  forced lowercasing (documented security fix, replacing `newpassword.asp` line 43
  `rs("password")=lcase(...)`). §5, §9 FR-019, §14, §15, §20 AC-012, §23 TS-014, and §24
   updated to match; `plan.md`/`tasks.md` will reflect change-password when `/speckit.plan`
   regenerates them from this spec.
- Q: Should the new employee day-gate reject login with both `rsn=O` and `rsn=C`, or
  preserve the actual legacy behavior? → A: Preserve legacy exactly (option A) — login
  succeeds iff a `security` row exists for today with `closingtime IS NULL`; otherwise
  rejected with `rsn=O`. `rsn=C` is never produced (dead code at `authenticate.asp`
  line 72, verified 2026-08-11). FR-018, §5, §14, §15, AC-011, TS-013 corrected to match.
- Q: What password policy should the new system apply to newly created or changed
  passwords (public registration and change-password)? → A: Minimum 8 characters with
  no forced complexity (option B, NIST 800-63B aligned), applied only to new/changed
  passwords; migrated legacy hashes are unaffected. FR-012, FR-019, §12, §14, §17,
  AC-005, AC-012, TS-005, TS-014 updated to match.
