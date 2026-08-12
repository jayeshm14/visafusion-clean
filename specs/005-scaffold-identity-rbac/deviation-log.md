# Deviation Log — SPEC-0005

**Purpose**: Records every deliberate deviation from the plan/spec baseline
(plan.md "Constitution Check" gate V states "no new packages, no architectural
deviation" — this log is where the two package additions and the verified data
interpretation are recorded, per the traceability principle). Each entry cites
the task, the deviation, and the reason.

| # | Task | Deviation | Decision / Reason |
|---|------|-----------|-------------------|
| 1 | T011 | New package `Microsoft.AspNetCore.Authentication.JwtBearer` 8.0.20 in `src/VisaFusion.Api/VisaFusion.Api.csproj` | `VisaFusion.Api` is a class library (no own `Program.cs`, FR-002) but hosts the login endpoint that mints the JWT. `JwtSecurityTokenHandler`/`System.IdentityModel.Tokens.Jwt` is NOT part of the .NET 8 shared framework (verified 2026-08-11). Version aligned with the Web host's existing JwtBearer 8.0.20 reference (T002 package-alignment precedent). |
| 2 | T007 | Test-only package `Microsoft.EntityFrameworkCore.InMemory` 8.0.20 in `tests/FunctionalTests/VisaFusion.FunctionalTests.csproj` | The 5-role login functional test requires a hermetic identity store (plan mandates a hermetic `WebApplicationFactory`, no live SQL). EF InMemory is the standard in-memory EF backing store; the factory swaps `VisaFusionIdentityDbContext` to it. Test project only; version aligned with EF Core 8.0.20. |
| 3 | T015 | Legacy `active` NULL semantics: only explicit `'N'` means inactive | `active` is `varchar(1)`; the legacy login never checks it (`authenticate.asp`), and the only filter in the codebase is `where Active = 'Y'` (dropdown population). Locking NULL rows would change login behavior for 1436 `Udaan_users` (incl. 47 adm / 9 emp) and all 43 registration accounts. Rule implemented in `IdentityActive.IsInactive`; verified live 2026-08-11; documented in data-model.md §4.3. |
| 4 | T011 | GET `/api/v1/auth` representative stub superseded | The anonymous GET auth stub (SPEC-0003 T064/T070) is replaced by the POST login/logout contract (contracts/auth-api.md §1–2). `ApiSurfaceTests.Auth_Get_Stub_Is_Superseded_By_The_Post_Contract` now asserts 404. |

*Log format: [#] [Task] — [Deviation] — [Decision/Reason]*