# Repository Baseline — VisaFusion

**Scope**: Read-only discovery of `G:\Projects\VisaEntry` (2026-08-19).
**Method**: every factual claim below was verified by a tool call this session
(`read` / `grep` / PowerShell). Nothing is inferred from prior sessions.
**Status**: COMPLETE (see `GAP_REPORT.md` for caveats).

---

## 1. Repository identity and VCS state

- Root: `G:\Projects\VisaEntry`; git repo, default branch `master` (only branch
  exists locally and on the remote; PR #1 "Master" was closed as accidental).
- Remote: `jayeshm14/visafusion-clean`.
- Working tree clean at discovery time; no uncommitted changes.
- `.codegraph/` index present — codegraph available for symbol queries.

## 2. Solution structure

`VisaFusion.sln` contains **7 source projects** and **3 test projects**, all
`net8.0`:

| Project | Role |
|---|---|
| `src/VisaFusion.Core` | Domain rules/services (e.g. `SharedRuleService`, `CanadaDobRule`, `StatusService`, `BillingService`) |
| `src/VisaFusion.Data` | EF Core persistence, entities, migrations, data-backed services |
| `src/VisaFusion.Identity` | ASP.NET Core Identity integration (`IdentityIntegration`, role constants) |
| `src/VisaFusion.Api` | Class library (FrameworkReference to `Microsoft.AspNetCore.App`); contracts, minimal API endpoints |
| `src/VisaFusion.Web` | Razor Pages host (the single ASP.NET Core host) |
| `src/VisaFusion.Jobs` | Background worker services (email/SMS queue workers) |
| `src/VisaFusion.Migration` | Console executable; legacy-to-new migration tooling (ADR-0003/0004) |
| `tests/UnitTests` | 29 xUnit test files |
| `tests/IntegrationTests` | 29 xUnit test files |
| `tests/FunctionalTests` | 38 xUnit test files (incl. PublicSiteParityTests) + PowerShell AI-environment validation suite |

`Directory.Build.props`: `TreatWarningsAsErrors=true`, version `0.1.0`,
`net8.0` across all projects.

`Directory.Build.targets` (SPEC-0003 T017 cross-cutting constants):
- `VisaFusionOtelServiceName` = `VisaFusion.Web` (OpenTelemetry, NFR-006)
- `VisaFusionSerilogSqlTable` = `Logs` (Serilog SQL sink, NFR-006)
- `VisaFusionSerilogFile` = `logs/visafusion-.log` (Serilog file sink, NFR-006)

`nuget.config`: `nuget.org` primary feed + **VS Offline Packages** fallback.

`.editorconfig`: `root = true`, CRLF, UTF-8, file-scoped namespaces.

## 3. Package matrix (verified from csproj)

- EF Core `Microsoft.EntityFrameworkCore.SqlServer` + `Design` **8.0.20**
- `Microsoft.AspNetCore.Identity.EntityFrameworkCore` + `.Stores` **8.0.20**
- `Microsoft.AspNetCore.Authentication.JwtBearer` **8.0.20**
- Serilog: `Serilog.AspNetCore` **10.0.0**, `Serilog.Sinks.File` **7.0.0**,
  `Serilog.Sinks.MSSqlServer` **10.0.0**
- OpenTelemetry **1.17.0** (`Console`, `Extensions.Hosting`,
  `Instrumentation.AspNetCore`)
- `Microsoft.Extensions.DependencyInjection.Abstractions` **8.0.2**
- Config: `Microsoft.Extensions.Configuration.Json` **8.0.0**,
  `.EnvironmentVariables` **8.0.0** (used by `VisaEntryDbContextFactory`)
- Tests: `xunit` 2.5.3, `xunit.runner.visualstudio` 2.5.3,
  `Microsoft.NET.Test.Sdk` 17.8.0, `Microsoft.AspNetCore.Mvc.Testing` 8.0.20,
  `Microsoft.EntityFrameworkCore.InMemory` 8.0.20,
  `Microsoft.EntityFrameworkCore.SqlServer` 8.0.20, `coverlet.collector` 6.0.0

## 4. Continuous integration

- `.github/workflows/build.yml` — triggers on push/PR to `main`; dotnet 8.0.x;
  restore → build → test; warnings-as-errors.
- `.github/workflows/ai-environment-validation.yml` — AI environment validation
  gate (ADR-0002; Pester-based checks per SPEC-0001-AIENV).
- **No Docker / container artifacts exist anywhere in the repo** — the
  containerization/deployment strategy is undocumented (see GAP_REPORT GAP-005).

## 5. Architecture decision records

`adr/`:
- ADR-0001 — Target Architecture and Specs Layout
- ADR-0002 — AI Environment Validation Gate Architecture
- ADR-0003 — Migration Tooling as a Dedicated Console Project (VisaFusion.Migration)
- ADR-0004 — Migration CLI: Out-of-Order Step Fails Fast with Logged Exit 1
- ADR-0005 — New `emailQueue` Table + Data-Backed Notification Services

## 6. Repository layout (top-level)

Source-of-truth directories (new platform): `src/`, `tests/`, `specs/`,
`adr/`, `library/`, `findings/`, `knowledge-graph/`, `reports/`, `scripts/`,
`dbBackup/`, `.github/`, `.specify/`.

Legacy assets retained at root alongside the new code (see `UI_BASELINE.md`
§6): `ActiveX/`, `assets/`, `css/`, `Demo/`, `fonts/`, `forms/`, `HTML FOLDER/`,
`images/`, `js/`, `NewYear2006/`, `r&d/`, `Templates/`, `udaanuma-dev/`,
`UI/`, `updateimg/`, `_notes/`, `_vti_cnf/`, plus ~585 root `*.asp` pages and
`update*.asp` snapshots.

## 7. Configuration files verified

- `appsettings.json` (Web): DB `VisaFusion` (legacy `VisaEntry` read-only);
  Jwt Issuer `VisaFusion` / Audience `VisaFusion.Api`; Notifications
  `OfficeEmail` = `usbhardwaj@udaanindia.com`; RateLimiting `Queries` 5 per
  3600 s.
- `appsettings.Development.json` (Web) exists; contents not inspected this
  session (secrets handling unverified — see GAP_REPORT GAP-007).
