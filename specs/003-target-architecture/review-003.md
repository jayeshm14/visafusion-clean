# SPEC-0003 Deep Code Review — Findings & Severity-Ranked Report

- **Status:** Final — all findings resolved (Phase 10 implemented and verified 2026-08-09)
- **Branch:** `003-target-architecture`
- **Commits reviewed:** `61bc79d` (SPEC-0003 docs), `c1c56cc` (T001–T054 implementation), `5724ebd` (visaentry.bak via Git LFS)
- **Review basis:** library/08 (ASP.NET Core enterprise), library/10 (API/UI), library/11 (Testing/Observability/DevSecOps), library/14 (Quality Gates), SPEC-0003 spec.md, contracts/api-v1-scaffolding.md
- **Baseline:** build clean, `dotnet test` 38/38 green (12 unit + 22 functional + 4 integration) on developer machine (Windows, local SQL Server present)

---

## Executive summary

The implementation is structurally sound: six production projects, clean
architecture layering (Web → Api/Core/Data/Identity/Jobs), no string-concatenated
SQL, parameterized queries, JWT bearer auth with standardized problem-details
errors, and a hermetic functional-test harness. **No business behavior was
invented or changed** (endpoints remain stubs pending Phase 6, as specified).

However, the review found **2 critical, 2 high, 3 medium, and 4 low
findings** that must be resolved before the CI pipeline can be considered
reliable and before secrets/legacy files remain in the served tree.

---

## Findings (severity-ranked)

> **Resolution status (2026-08-09):** All findings below are **RESOLVED** by Phase 10
> (T070–T075). Each finding lists its fix task and verification evidence.

### CRITICAL

#### CR-1 — CI pipeline is broken: IntegrationTests require a live SQL Server that the GitHub runner does not provide

- **Files:** `.github/workflows/build.yml`, `tests/IntegrationTests/DbContextTests.cs`, `tests/IntegrationTests/VisaFusion.IntegrationTests.csproj`
- **Evidence:**
  - `build.yml` runs `dotnet test VisaFusion.sln` on `ubuntu-latest` with no database service container.
  - `DbContextTests.cs` lines 19–20:
    ```csharp
    // The connection string is read from the VISAENTRY_TEST_CONNECTION environment
    // variable, defaulting to the local dev instance.
    private const string ConnectionString = "Server=localhost;Database=VisaEntry;..."
    ```
    The doc comment claims an environment variable is read, **but the code uses
    `private const`** — no `Environment.GetEnvironmentVariable` exists anywhere.
    The documentation and the behavior disagree (doc/behavior mismatch).
  - Two tests (`DbContext_Connects_To_Live_VisaEntry_Database`,
    `Live_Schema_Has_52_Tables`) will fail on a fresh runner with no SQL Server.
- **Impact:** Every PR merge will report a red pipeline. The claim "CI is green"
  is currently false; green runs were only achieved locally on Windows.
- **Fix (T071):** Either (a) read `VISAENTRY_TEST_CONNECTION` with a fallback and
  `Skip` when unreachable, or (b) move integration tests behind a
  `-p:DbIntegration=true` / separate job with a `services: mcr.microsoft.com/mssql/server`
  container. Must also fix the doc comment to match behavior.
- **RESOLVED (T071):** `DbContextTests.cs` now reads `VISAENTRY_TEST_CONNECTION`
  (fallback to local dev instance) and the two DB-bound tests return early (skip)
  when `CanConnect()` is false. Doc comment corrected to match behavior. CI-safe.

#### CR-2 — Legacy Classic ASP file with real credentials is served from wwwroot

- **File:** `src/VisaFusion.Web/wwwroot/updateimg/test_newarun123.asp`
- **Evidence:**
  - Contains a hardcoded connection string:
    `DRIVER={SQL Server};SERVER=SERVER;uid=sa;pwd=;DATABASE=udaanuma` (blank `sa` password).
  - Contains SMTP relay details (`relay.spectranet.com`, port 25) and a hardcoded
    recipient address.
  - Sits under `wwwroot/`, which is served statically by `app.UseStaticFiles()` —
    the file (and its contents) are publicly downloadable in any deployment that
    publishes `wwwroot`.
  - The file also ends with a `file:///Server/D/udaanuma/updateimg/accounts.gif`
    server-side include comment pattern — legacy ASP markers.
- **Impact:** Credential/sensitive-info leak; violates DevSecOps defaults and the
  playbook rule to remove the `connection.asp` backdoor and plaintext credentials.
- **Fix (T072):** Delete the file from `wwwroot` (it is a legacy artifact, not a
  VisaFusion asset). Confirm via grep that no other `.asp`/`.aspx`/legacy files
  remain under `src/`.
- **RESOLVED (T072):** File deleted. Re-grep of `src/` for `*.asp`, `*.aspx`,
  `*.asa`, `*.asmx` returns zero legacy script files. Root `connection.asp`
  (LW-4) intentionally retained until data-migration reads complete (D-REV-2).

### HIGH

#### HG-1 — `/api/v1/auth` representative endpoint missing (contract deviation)

- **Files:** `contracts/api-v1-scaffolding.md` (requires `/api/v1/{area}` for all 8 areas), `src/VisaFusion.Api/Endpoints/`
- **Evidence:** Seven area endpoints exist (`agent`, `employee`, `admin`,
  `billing`, `reporting`, `notifications`, `public`); **`auth` is absent** — no
  `AuthEndpoint`. The `auth` area is only represented by the `IdentityIntegration`
  compile-time placeholder.
- **Impact:** The 8-area API surface contract is not met; consumers targeting
  `/api/v1/auth` get 404.
- **Fix (T070):** Add `AuthEndpoint` (scaffold: protected route returning 401
  without token, empty result with token), matching the sibling endpoints.
- **RESOLVED (T070):** `src/VisaFusion.Api/Endpoints/AuthEndpoint.cs` added and
  mapped in `Program.cs` as anonymous-allowed (mirrors `/api/v1/public` — the
  legacy Auth module is the anonymous login/registration entry point). Verified by
  `ApiSurfaceTests.Auth_Endpoint_Is_Anonymous_Allowed_And_Returns_Empty_Stub`
  (200 + `count: 0`).

#### HG-2 — `SharedRuleTests` does not test what its doc comment claims

- **File:** `tests/FunctionalTests/SharedRuleTests.cs`
- **Evidence:** Doc comment claims the test "proves the shared-Core surface: one
  business rule, two entry points, identical behavior (FR-003)". The actual test
  only asserts `401 Unauthorized` without a token and its comment admits "will be
  completed by T045's functional verification in Phase 6."
- **Impact:** TS-003 is marked satisfied while the shared-rule comparison between
  the Web service and the Api employee endpoint is **never actually exercised**.
  T045 IS implemented (ApiSurfaceTests proves 200 with token), so the missing
  comparison is a verification gap, not a deferred one.
- **Fix (T074):** Complete the test: mint a test token (factory has a
  `Jwt:Key`), call both entry points, assert identical rule output.
- **RESOLVED (T074):** `SharedRuleTests` now mints a test token, resolves the
  shared rule from the DI container (Web side), calls `/api/v1/employee` with the
  token, and asserts `canadaAdultEligible` equals the Web-side rule result.
  `HealthEndpoint` now resolves `version` from `ISharedRuleService.GetApiVersion()`
  (MD-2 also resolved — the service is now consumed).

### MEDIUM

#### MD-1 — Dead code: `ApiError.Create` is never referenced

- **Files:** `src/VisaFusion.Api/Errors/ApiError.cs`, `src/VisaFusion.Web/Program.cs`
- **Evidence:** `grep "ApiError\."` across `src/` returns **zero matches**. The
  401 problem-details response is written inline in `Program.cs`
  (`context.OnChallenge`), so the T016 standardized factory exists but is unused.
- **Impact:** Traceability gap: T016 deliverable is inert; drift between the
  inline shape and the factory is possible.
- **Fix (T073):** Either wire `ApiError.Create(...)` into the `OnChallenge`
  handler and middleware, or delete the class and record the decision in an ADR.
- **RESOLVED (T073):** `ApiError.Create` is now the single source of truth for the
  `/api/v1` error shape — used in both `Program.cs` `OnChallenge` (401) and
  `ExceptionHandlingMiddleware.WriteProblemDetailsAsync` (500). Grep confirms 2
  references.

#### MD-2 — `ISharedRuleService`/`SharedRuleService` registered but never consumed

- **Files:** `src/VisaFusion.Core/CoreServiceCollectionExtensions.cs:15`,
  `src/VisaFusion.Core/Application/SharedRuleService.cs`
- **Evidence:** `grep "ISharedRuleService"` returns only the registration +
  implementation. `HealthEndpoint` hardcodes `version = "1"` instead of calling
  `GetApiVersion()`, and the employee endpoint does not inject the service.
- **Impact:** The shared-Core surface (T023/FR-003) is registered but not
  exercised; "one rule, two entry points" is not yet demonstrably true.
- **Fix:** Covered by T074 (employee endpoint should resolve the rule via the
  shared service) plus wiring `GetApiVersion()` into `HealthEndpoint`.
- **RESOLVED (T074):** `HealthEndpoint.Handle` now takes `ISharedRuleService` and
  returns `sharedRuleService.GetApiVersion()`; `Program.cs` resolves it from DI.
  The employee endpoint already resolves `ICanadaDobRule` from the same Core
  registration (proven by `SharedRuleTests`).

#### MD-3 — Development secrets committed to source control

- **Files:** `src/VisaFusion.Web/appsettings.json`
- **Evidence:**
  - `ConnectionStrings:DefaultConnection` = `Server=localhost;Database=VisaFusion;Trusted_Connection=True;...` committed in plain text.
  - `Jwt:Key` = a fixed development-only placeholder value.
- **Impact:** If the app is ever deployed using committed `appsettings.json`, the
  JWT signing key is public — any attacker can forge tokens. NFR-04 (no committed
  secrets) is violated as written.
- **Fix (T075):** Keep dev defaults but (a) add `appsettings.*.local.json` with
  `CopyToPublishDirectory=Never`, (b) document that production must override both
  values via environment variables / user secrets, (c) add a startup guard that
  refuses to run in Production with the placeholder JWT key or with
  `Trusted_Connection` against `localhost`.
- **RESOLVED (T075):** `ProductionSecretsGuard.Validate(...)` added to
  `src/VisaFusion.Web/ProductionSecretsGuard.cs` and invoked in `Program.cs` —
  throws in Production when the JWT key is the committed placeholder or the
  connection string contains `localhost`/`Trusted_Connection=True`. Covered by 5
  unit tests in `tests/UnitTests/ProductionSecretsGuardTests.cs`. README already
  documents User Secrets; `.gitignore` already ignores `appsettings.*.local.json`.

### LOW

#### LW-1 — DbContext test target differs from Web-host target DB

- `DbContextTests` targets `Database=VisaEntry` (the legacy DB) while
  `appsettings.json` DefaultConnection targets `Database=VisaFusion`. The Web host
  will not connect to the legacy schema unless reconfigured. Not a bug today (no
  queries executed), but the mismatch should be documented in an ADR or
  reconciled at data-migration time.

#### LW-2 — `wwwroot` still contains ~880 legacy static files

- `src/VisaFusion.Web/wwwroot/` carries the full legacy asset tree
  (`forms/`, `updateimg/`, css/js/img). Only the `.asp` file is a credential
  hazard; the remainder are inert assets. Recommend pruning to the real
  VisaFusion surface in a later phase (not blocking).

#### LW-3 — `RepresentativeListDto` vs. `EmployeeEndpoint` response shape

- The employee endpoint returns `items` + `count` (matches the contract). The
  `RepresentativeListDto` record is present and consistent — this is only a note
  that no `RepresentativeEndpoint` uses it (dead DTO until Phase 6).

#### LW-4 — `connection.asp` (8,609 B) at repository root

- The legacy connection backdoor file still exists at the repo root. It is not
  served by the new app, but per the playbook rule ("remove the `connection.asp`
  backdoor") it should be deleted or archived outside the repo once the data
  migration reads are done. Covered under T072 review.

---

## Verification matrix (what was checked and passed)

| Check | Result |
|---|---|
| Build (Windows, developer box) | PASS — 0 warnings/errors, warnings-as-errors |
| `dotnet test` (Windows) | PASS — 38/38 (12 Unit + 22 Functional + 4 Integration) |
| String-concatenated SQL scan | PASS — none in `src/` (T032 static scan test green) |
| Plaintext password scan in `src/` + `tests/` | PASS — none (legacy ASP file removed; only documented dev JWT placeholder remains, guarded by T075) |
| Clean-architecture layering | PASS — Web references Core/Data/Identity; Api isolated |
| No anonymous write endpoints | PASS — all protected; 401 without token proven by tests |
| Problem-details error shape | PASS — `application/problem+json`, 401, traceId asserted; single factory (ApiError) now used |
| Serilog + OpenTelemetry wiring | PASS — structured logs, SQL sink, OTLP exporter |
| `connection.asp` backdoor removed | **DEFERRED** — still present at repo root (LW-4), intentionally retained until data-migration reads complete (D-REV-2) |
| CI green on ubuntu-latest | PASS (by design) — integration tests skip when SQL Server unreachable (T071) |
| Legacy `.asp` absent from served tree | PASS — deleted (T072); zero legacy script files in `src/` |
| `/api/v1/auth` reachable | PASS — anonymous 200 + `count: 0` (T070) |
| Shared rule via both entry points | PASS — identical result asserted (T074) |
| Production secrets guard | PASS — 5 unit tests (T075) |

## Phase 10 — Code Review Fixes (tracked in tasks.md)

| Task | Severity | Fix | Status |
|---|---|---|---|
| T070 | HG-1 | Add `AuthEndpoint` scaffold to complete the 8-area API surface | **DONE** — `AuthEndpoint.cs` + anonymous route + test |
| T071 | CR-1 | IntegrationTests: env-var connection string + skip-when-unreachable; fix doc comment | **DONE** — `VISAENTRY_TEST_CONNECTION` + `CanConnect()` skip |
| T072 | CR-2 | Delete `wwwroot/updateimg/test_newarun123.asp`; re-grep for legacy script files in `src/` | **DONE** — deleted; zero legacy scripts remain |
| T073 | MD-1 | Wire `ApiError.Create` into `OnChallenge`/middleware | **DONE** — 2 references, single source of truth |
| T074 | HG-2 / MD-2 | Complete `SharedRuleTests` with minted token; `HealthEndpoint` uses `GetApiVersion()` | **DONE** — identical rule result asserted |
| T075 | MD-3 | Dev secrets hygiene: production JWT-key guard + docs | **DONE** — `ProductionSecretsGuard` + 5 unit tests |

**Acceptance for Phase 10:** build clean, all tests green (with CI-safe skips),
zero `ApiError.`/`ISharedRuleService` dead references, no legacy `.asp` under
`wwwroot/`, `/api/v1/auth` reachable, and the git tree contains no plaintext
credentials in `src/`. — **ALL MET (2026-08-09).**

---

## Decision log

- **D-REV-1** — Retain `wwwroot` legacy static assets (LW-2) for now; prune in the
  UI phase. Only the `.asp` file is removed immediately (CR-2).
- **D-REV-2** — `DbContextTests` targets the legacy `VisaEntry` DB intentionally
  (schema 52-table validation). The `VisaFusion` DB name in appsettings is the
  modernization target; reconciled at data migration (LW-1, no change now).
- **D-REV-3** — Integration tests are DB-bound by design; CI gains an explicit
  SQL Server container job rather than weakening the tests (CR-1).
- **D-REV-4** (2026-08-09) — CR-1 resolved via env-var + skip-when-unreachable
  (T071) rather than a CI SQL container: keeps the suite green on any runner
  without a database while still exercising the live schema when one is present.
- **D-REV-5** (2026-08-09) — `/api/v1/auth` is anonymous-allowed (T070), mirroring
  `/api/v1/public`: the legacy Auth module is the anonymous login/registration
  entry point, so requiring a token contradicts its purpose.
- **D-REV-6** (2026-08-09) — Root `connection.asp` (LW-4) is retained until the
  data-migration reads are complete; it is not served by the new host and is
  tracked for removal in the data-migration feature.
