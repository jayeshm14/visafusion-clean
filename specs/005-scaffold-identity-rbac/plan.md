# Implementation Plan: Solution Scaffold Completion, Identity Consolidation & RBAC

**Branch**: `005-scaffold-identity-rbac` | **Date**: 2026-08-11 | **Spec**: [SPEC-0005](spec.md)

**Input**: Feature specification from `/specs/005-scaffold-identity-rbac/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command; its definition describes the execution workflow.

## Summary

Complete Phase 0 of the phased rollout (`library/complete_migration_plan.md` §10):
"App boots; login works for all 5 roles against migrated (hashed) credentials; backdoor
query params confirmed inert." The scaffold, complete DbContext, static asset copy, and
the identity import pipeline were already delivered by SPEC-0003/SPEC-0004 (verified
2026-08-11). This feature delivers the remaining trust boundary:

1. **Identity host integration** — ASP.NET Core Identity services registered against
   the migrated store (`VisaFusionIdentityDbContext` mapping the existing
   `AspNetUsers`/`AspNetRoles`/`AspNetUserRoles` tables), real
   `POST /api/v1/auth/login` / `logout` / `POST /api/v1/public/register` endpoints,
   Web `/Auth/Login` + `/Auth/AccessDenied` Razor Pages, and claim-bound `AgentId`
   (fixes §2.3).
2. **Employee day-gate enforced in login** (clarification Q2; re-clarified 2026-08-11) —
   both the Web cookie login and the API login apply the legacy gate for `emp` per
   `authenticate.asp` lines 62–79: login succeeds iff a `security` row exists for today
   with `closingtime IS NULL`; otherwise rejected with `rsn=O` via a day-gate evaluation
   on `ISecurityGateService`. `rsn=C` is legacy dead code (line 72) and is NOT produced.
   Web redirects to `/Auth/Login?rsn=O`; API returns 403 with `rsn=O` in the
   problem-details body.
3. **Self-service change-password** (clarification Q3) — `/Auth/ChangePassword` (Web)
   + `POST /api/v1/auth/change-password` (API) replacing `changepassword.asp` +
   `newpassword.asp`; new passwords must meet the password policy (minimum 8
   characters, no forced complexity) and are hashed via `UserManager.ChangePasswordAsync`
   WITHOUT the legacy forced lowercasing (documented security fix). The privileged
   for-agent password set is documented as a contract only and deferred.
4. **RBAC enforcement** — a policy catalog from the §4.2 matrix applied to every
   endpoint and the 13 §4.3 anonymous write endpoints re-secured with their named
   target routes and minimum roles (11 role-secured returning 501 until their module
   feature, 2 public-by-design). The admin user-management write endpoints
   (`/api/v1/admin/users`, `/api/v1/admin/superusers`) are **documented contracts
   only** (clarification Q1) — deferred to the User-management module feature
   (Phase 3), gated on owner decision Risk #7.
5. **URL rewrite** for the documented legacy entry URLs.
6. **§7 alignment** — the identity importer reads `active` and sets
   `LockoutEnabled = !active` (fixing the current hardcoded-1 deviation, verified in
   `IdentityImporter.cs` line 188).
7. **Phase 0 verification** via automated tests (AC-001..AC-012, TS-001..TS-014).

## Technical Context

**Language/Version**: C# 12 / .NET 8 (LTS) — fixed by SPEC-0003 NFR-005.

**Primary Dependencies**: ASP.NET Core Identity 8 (shared framework +
`Microsoft.Extensions.Identity.Stores` already referenced by `VisaFusion.Identity`),
EF Core 8 (already referenced), JWT bearer + cookie auth (already wired in
`VisaFusion.Web/Program.cs`), xUnit + WebApplicationFactory (existing three test
projects). No new NuGet packages are required.

**Storage**: SQL Server. Two databases:
- Legacy `VisaEntry` — read-only source of truth; never modified (SPEC-0004).
- Target `VisaFusion` — contains the EF-migrated business schema (38 entities) plus
  the identity store tables (`AspNetUsers`/`AspNetRoles`/`AspNetUserRoles`) created
  idempotently by the `identity` migration step (SPEC-0004 T040). The day-gate reads
  the business-schema `security` table via the existing `SecurityDay` entity
  (`VisaEntryDbContext`, SPEC-0004 §3.1).

**Testing**: xUnit across the existing three test projects. RBAC matrix tests use the
hermetic `WebApplicationFactory` (`tests/FunctionalTests`) with token-minting (JWT
signed with the test-config key) so role denials are proven without a live database.
The day-gate is tested in two layers: hermetic functional tests **stub
`ISecurityGateService`** (open day) so the emp-login success path is proven without a
database (AC-001), and integration tests seed the `security` table (no row today, row
with a closing time set, open row) for the `rsn=O`-rejection/success outcomes
(AC-011/TS-013). Identity store
invariants and lockout semantics live in `tests/IntegrationTests` (self-skipping when
SQL Server is unreachable, per the existing convention). Unit tests cover the policy
catalog, claim resolution, URL rewrite mapping, and the day-gate evaluation.

**Target Platform**: Windows Server / SQL Server (same as legacy); the single-process
host `VisaFusion.Web` serves the Razor Pages UI + `/api/v1` (SPEC-0003 FR-002).

**Project Type**: Cross-cutting Phase 0 feature over the existing solution — new
`VisaFusionIdentityDbContext` in the Identity project, day-gate evaluation added to
`ISecurityGateService` in `VisaFusion.Core`, auth endpoints in `VisaFusion.Api`, auth
Razor Pages + middleware in `VisaFusion.Web`, a policy catalog in `VisaFusion.Api`,
and a lockout-alignment fix in `VisaFusion.Migration`.

**Performance Goals**: Login + token issuance add negligible latency (sub-100 ms
target including Identity store reads); the day-gate adds one indexed
`security`-table lookup for `emp` logins only; RBAC policy checks are in-memory after
authentication; URL rewrite resolves internally without an extra round trip.

**Constraints**:
- No new business features; the 11 §4.3 role-secured routes are secured placeholders
  (auth + role + 501) until their module feature delivers the payload. The admin
  user-management endpoints (`/api/v1/admin/users`, `/api/v1/admin/superusers`) and
  the agent password-set route are **documented contracts only — not implemented in
  this feature** (spec §15; clarification Q1).
- The day-gate applies to `emp` logins only, exactly as `authenticate.asp` lines
  62–79 enforce it; adm/su/agt/guest logins are not gated.
- Change-password and registration enforce the password policy (minimum 8 characters,
  no forced complexity); new passwords are stored hashed (no lowercasing, no
  plaintext); the legacy `flag=1|2|3` outcomes map to inline
  success/mismatch/policy-violation messages.
- `VisaEntryDbContext` (business schema) is NOT modified — a separate
  `VisaFusionIdentityDbContext` maps the identity store to avoid mixing Identity
  conventions with the legacy table/column mappings and to avoid a Data↔Identity
  reference cycle.
- No EF Core migration for the identity tables — the migration tool's idempotent DDL
  is the schema source of truth; it is extended with the four standard auxiliary
  tables the runtime store needs.
- All queries parameterized; no plaintext password material in logs, responses, or
  configuration; secrets already guarded by `ProductionSecretsGuard`.
- The `identity` step stays idempotent (re-run is a safe no-op for existing rows).

**Scale/Scope**: 2,365 `Udaan_users` + 43 `registration` + 4,218 `agents` accounts
(identity import already delivered); 11 secured §4.3 routes + 2 public routes + 3
documented-only deferred contracts; 4 rewritten legacy URLs; 4 Razor Pages
(Login, AccessDenied, Register, ChangePassword); 1 policy catalog (11 policies);
day-gate evaluation on `ISecurityGateService`; ~17 test cases across the three test
projects.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| # | Principle | Gate | Status |
|---|-----------|------|--------|
| I | Specification-First (SDD) | SPEC-0005 exists with all 24 required sections, revised after repository verification and eight clarification answers (2026-08-11); no implementation before this plan | PASS |
| II | Legacy as Source of Truth | Every endpoint/role/URL traces to `library/complete_migration_plan.md` §4/§4.3/§7/§9/§10 or `findings/*.md`; the day-gate mirrors `authenticate.asp` lines 62–79 and the §8 Test Matrix; change-password mirrors `changepassword.asp`/`newpassword.asp`; no invented business features; §4.3 routes return 501 (no fake payloads); deferred endpoints are documented contracts only | PASS |
| III | Data Preservation & Integrity | Legacy identity tables untouched; import idempotent; `active`→lockout preserves the legacy flag meaning; the `security` table is read-only for the day-gate; no data deleted | PASS |
| IV | Traceability & Governance | FR↔policy↔endpoint↔test matrix in spec §24 (incl. FR-018/FR-019 rows); ADR-0001 baseline; knowledge-graph and decision-log updates after implementation | PASS |
| V | Quality, Delivery & No-Assumption | Repo state verified 2026-08-11 (no guessing about SPEC-0003/0004 deliverables); automated tests mandatory; solution must build; backdoor params confirmed inert by test | PASS |

**Gate result**: PASS — no violations. No Complexity Tracking entries required (no new
projects, no new packages, no architectural deviation).

**Post-design re-check (after Phase 1 design)**: PASS — the design (separate identity
DbContext, policy catalog, 501 placeholders, migration-tool schema extension,
`ISecurityGateService` day-gate evaluation restricted to the legacy `rsn=O` rejection
with `rsn=C` dead code not reproduced, change-password and registration enforcing the
password policy (min 8 chars, no forced complexity) via
`UserManager.ChangePasswordAsync`, deferred admin contracts) derives exclusively from
the spec, the §4/§4.3/§7 plan sections, and the verified repository state. No invented
behavior.

## Project Structure

### Documentation (this feature)

```text
specs/005-scaffold-identity-rbac/
├── plan.md                 # This file (/speckit.plan command output)
├── spec.md                 # SPEC-0005 (24 sections, revised post-verification + 8 clarification answers)
├── research.md             # Phase 0 output (/speckit.plan command)
├── data-model.md           # Phase 1 output (/speckit.plan command)
├── quickstart.md           # Phase 1 output (/speckit.plan command)
├── contracts/              # Phase 1 output (/speckit.plan command)
├── checklists/
│   └── requirements.md     # Specification quality checklist (PASS)
└── tasks.md                # Phase 2 output (/speckit.tasks command — regenerated)
```

### Source Code (repository root)

```text
src/
├── VisaFusion.Core/
│   └── Application/
│       └── SecurityGateService.cs        # MODIFY — add day-gate evaluation to ISecurityGateService/SecurityGateService (currently a placeholder)
├── VisaFusion.Identity/
│   ├── IdentityIntegration.cs            # EXISTS — Roles constants (su/adm/emp/agt/guest)
│   ├── Persistence/
│   │   └── VisaFusionIdentityDbContext.cs # NEW — IdentityDbContext<VisaFusionUser, IdentityRole, string>
│   └── VisaFusion.Identity.csproj
├── VisaFusion.Api/
│   ├── Endpoints/
│   │   ├── AuthEndpoint.cs               # EXISTS stub — replaced with real login/logout/change-password handlers
│   │   ├── PublicEndpoint.cs             # NEW — POST /api/v1/public/register (guest-only) + /queries
│   │   └── ... (Employee/Health/Representative endpoints unchanged)
│   ├── Authorization/
│   │   ├── AuthorizationPolicies.cs      # NEW — policy catalog from §4.2 matrix
│   │   ├── IdentityClaims.cs            # NEW — claim types + AgentId resolution helper
│   │   └── SecuredPlaceholderEndpoint.cs # NEW — shared 501 handler for §4.3 routes
│   ├── Contracts/
│   │   ├── LoginRequest.cs / LoginResponse.cs / RegisterRequest.cs / ChangePasswordRequest.cs   # NEW
│   │   └── (reuse ApiError.cs)
│   └── VisaFusion.Api.csproj
├── VisaFusion.Web/
│   ├── Program.cs                        # MODIFY — AddIdentityCore + policies + rewrite middleware + auth endpoints
│   ├── Middleware/
│   │   ├── LegacyUrlRewriteMiddleware.cs  # NEW — legacy .asp → new routes
│   │   └── ExceptionHandlingMiddleware.cs # EXISTS
│   ├── Pages/
│   │   ├── Auth/Login.cshtml(.cs)        # NEW — cookie sign-in page (+ day-gate rsn=O redirect)
│   │   ├── Auth/AccessDenied.cshtml(.cs) # NEW
│   │   ├── Auth/Register.cshtml(.cs)     # NEW — guest-only registration page
│   │   └── Auth/ChangePassword.cshtml(.cs) # NEW — self-service change-password page
│   └── (Areas/* remain; Index pages later populated by module features)
└── VisaFusion.Migration/
    ├── Identity/
    │   ├── IdentityImporter.cs           # MODIFY — read `active`; LockoutEnabled=!active + LockoutEnd
    │   └── PasswordHasher.cs             # UNCHANGED
    └── (commands unchanged)
```

**Structure Decision**: Follows the existing six-project layout delivered by SPEC-0003
(Web, Api, Core, Data, Identity, Jobs, Migration) — no new projects. The day-gate
evaluation lives in `VisaFusion.Core` (`ISecurityGateService`) because it is a shared
domain rule used by both the Web and API login surfaces; the identity-store mapping
lives in `VisaFusion.Identity` (`VisaFusionIdentityDbContext`); auth endpoints and the
policy catalog live in `VisaFusion.Api`; auth pages and the URL-rewrite middleware live
in `VisaFusion.Web`.

## Complexity Tracking

> Fill ONLY if Constitution Check has violations that must be justified

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| — | — | — |

No violations. A second DbContext (`VisaFusionIdentityDbContext`) is used instead of
deriving `VisaEntryDbContext` from `IdentityDbContext`, because the business context
maps 38 entities to legacy table/column names with alternate keys and deferred FKs —
mixing Identity conventions in would be a higher-risk change, and Data↔Identity is a
one-way reference (Identity → Data) that a single-context design would invert into a
cycle. The day-gate adds one method to the existing `ISecurityGateService` placeholder
(no new abstraction); the deferred admin endpoints add no routes (documented contracts
only, per clarification Q1).
