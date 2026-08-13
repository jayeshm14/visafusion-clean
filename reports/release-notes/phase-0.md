# VisaFusion Phase 0 Release Notes

**Date**: 2026-08-13
**Scope**: Phase 0 — solution scaffold, complete data-model migration, identity
consolidation & RBAC enforcement (SPEC-0003, SPEC-0004, SPEC-0005).

---

## 1. What Phase 0 delivers

### Solution scaffold (SPEC-0003)
- Single-process ASP.NET Core host (`src/VisaFusion.Web`): Razor Pages back-office
  + `/api/v1` surface, Serilog + OpenTelemetry (NFR-006), centralized
  problem-details exception handling, configuration-driven rate limiting.
- Six-project solution (`Web`, `Api`, `Core`, `Data`, `Identity`, `Jobs`) per
  ADR-0001; `ProductionSecretsGuard` fails fast in Production with dev-only
  config (NFR-004).

### Data-model migration (SPEC-0004)
- `VisaFusion.Migration` console: 8 fixed-order commands (snapshot → schema →
  copy → cleanse → identity → validate → report), exit codes 0–5, run-state
  idempotency (NFR-001), append-only audit tables, approved-cleansing sign-off
  gating (BR-005), duplicate-key fail-fast (GAP-0002).
- 52-table disposition migrated to the target `VisaFusion` database; legacy
  `VisaEntry` stays read-only (FR-008).

### Identity consolidation & RBAC (SPEC-0005)
- **Auth API**: `POST /api/v1/auth/login` (5-role JWT, `AgentId` claim for agt,
  `SuperUser` claim for su), `POST /api/v1/auth/logout`, `POST
  /api/v1/auth/change-password` (204/400/401; legacy `changepassword.asp`
  flag 1/2/3 outcomes mirrored).
- **Public register**: `POST /api/v1/public/register` — guest-only account,
  privileged roles in the payload are never read (fixes the §2.2 escalation
  finding); under-8 passwords rejected. The register rules live in the shared
  `RegistrationFlow` (`src/VisaFusion.Api/Registration/RegistrationFlow.cs`)
  used by both the API endpoint and the Web page, so the two surfaces can
  never diverge.
- **Register page**: `/Auth/Register` (Razor Page, T040) — the `regsub*.asp`
  rewrite target now resolves to a real page (review finding #1): guest-only
  form posting through the shared `RegistrationFlow`, success mirrors the
  legacy `regsubdone.asp` confirmation, errors render the API problem-details
  inline.
- **RBAC enforcement**: 11-policy catalog derived from the §4.2 role matrix;
  all 11 §4.3 secured write routes registered (anonymous → 401, wrong role →
  403, correct role → 501 placeholder); representative endpoints switched to
  policies; authorization denials logged (subject/endpoint/outcome, no
  password material).
- **Legacy URL rewrite**: `Default.asp` → `/`, `authenticate.asp`/`logon.asp`
  → `/Auth/Login`, `regsub*.asp` → `/Auth/Register` (301); any other `.asp`
  → clear 404 (NFR-005).
- **Static assets**: all legacy asset directories (`forms/`, `css/`, `js/`,
  `images/`, `fonts/`, `updateimg/`) self-hosted from wwwroot (no CDN).
- **Security fixes**: `connection.asp` backdoor and its query parameters
  inert (verified); no plaintext password material in logs, responses, or
  config; identity import hashes on migration (PBKDF2).

## 2. Test status (2026-08-13)

| Suite | Result |
|-------|--------|
| `tests/UnitTests` | 109/109 passed |
| `tests/FunctionalTests` | 128/128 passed |
| `tests/IntegrationTests` | SPEC-0005-relevant classes 12/12 passed (identity lockout, day-gate, import idempotency, no-concatenated-SQL) against a live SQL Server; SPEC-0004 Snapshot/Validation checksum classes fail with `Execution Timeout Expired` (SHA2_256 over 271k+ `Mainentry` rows exceeds the 30 s command timeout — pre-existing, files last touched by `3db83b8`, out of SPEC-0005 scope) |

Build: `VisaFusion.sln` — 0 warnings / 0 errors.

## 2a. Rigorous-testing pass (SPEC-0005, all phases)

Requirement→test coverage sweep across spec.md, plan.md, tasks.md and the three
contracts; every FR/AC/TS mapped to a test and the gaps below closed with new
tests (18 functional + 2 unit):

- **Web login page** (`WebLoginPageTests`, 8 tests): GET form, `?rsn=O` reason
  text, valid POST → cookie + redirect to `/`, bad creds → generic error with
  **no** cookie, emp day-gate rejection → 302 `/Auth/Login?rsn=O` with no
  cookie, API 403 `rsn=O`, non-emp never gated (stub mirrors the real
  emp-only rule).
- **Access-denied page** (`AccessDeniedPageTests`): GET `/Auth/AccessDenied` → 200.
- **Change-password page** (`ChangePasswordPageTests`, 5 tests): unauthenticated
  → login redirect with `ReturnUrl`, flag 2/3 messages, policy message, success
  (cookie-scheme flow via the login page).
- **Logout API** (`LogoutApiTests`): bearer → 204, anonymous → 401.
- **Rate limiting** (`RateLimitTests`): with no `RateLimiting:*` config the
  register route is not throttled; with owner-supplied thresholds (2/60 s) the
  third request is rejected with 429. Thresholds are injected via environment
  variables because `Program.Main` reads the keys before `builder.Build()` and
  `WebApplicationFactory`'s `ConfigureAppConfiguration`/`UseSetting` are only
  applied at Build time.
- **NFR-006 denial logging** (`AuthorizationDenialLoggingTests`, 2 unit tests):
  the denial template carries subject/endpoint/outcome; no password placeholder
  in any `Log*` call under `src/`.

## 3. Review fixes (post-`150ca7c`)

1. **`/Auth/Register` page** (finding #1): created to satisfy the
   `regsub*.asp` → `/Auth/Register` 301 contract (`contracts/web-ui.md` §1.3,
   `plan.md` line 197); task T040 added.
2. **Lockout timing** (finding #2): login now checks the password before the
   lockout state, eliminating the account-existence timing side-channel
   (`deviation-log.md` §7; matches SignInManager's own ordering).
3. **AWB `agt (own)` qualifier** (finding #3): the 501 placeholder cannot
   enforce it yet — tracked in `Program.cs` route comment + tasks.
4. **`IdentityImporter.TryTake` dedup** (finding #4): a row rejected for a
   duplicate email no longer claims its username, so a later row with the same
   username and a fresh email can import (`deviation-log.md` §8; new unit test).
5. **Tasks board hygiene** (finding #5): T030/T031 checkboxes corrected.

## 4. Known limitations / deferred (per contracts)

- Admin user-management and agent password-set routes are **deferred** and do
  not exist yet (`contracts/secured-write-routes.md` §3) — they 404.
- The 11 §4.3 secured write routes are authorization placeholders returning
  501; business implementations land in later phases.
- `POST /api/v1/public/queries` is a 501 placeholder (search endpoints land in
  later phases).
- GAP-0001 (FK DEFER disposition) and GAP-0002 (`agents.agentsID` 4114
  duplicate) require owner decisions before the migration copy step can
  complete end-to-end.

## 5. Phase 0 exit criterion

"App boots; login works for all 5 roles against migrated (hashed) credentials;
backdoor query params confirmed inert" (`complete_migration_plan.md` §10) —
proven by TS-001 (AuthLoginTests), TS-002 (IdentityImportTests +
SecuritySpotCheckTests), and TS-006 (BackdoorAndIsolationTests).