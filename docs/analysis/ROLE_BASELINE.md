# Role / Authorization Baseline — VisaFusion

**Scope**: Read-only discovery (2026-08-19). Every claim verified this session.
**Sources**: `src/VisaFusion.Identity/IdentityIntegration.cs`,
`src/VisaFusion.Api/Authorization/AuthorizationPolicies.cs`,
`src/VisaFusion.Api/Contracts/RegisterRequest.cs`,
`src/VisaFusion.Web/Program.cs` (partial), `appsettings.json` (Web),
`src/VisaFusion.Data/Application/{EntryService,SecurityGateService}.cs`.

---

## 1. Identity stack

- ASP.NET Core Identity backed by EF Core, stored in the new `VisaFusion` DB
  (`AspNetUsers`, `AspNetRoles`, etc.).
- Two authentication schemes coexist: **cookie** (browser) and
  **JwtBearer** (API). JWT issuer `VisaFusion`, audience `VisaFusion.Api`
  (verified in Web `appsettings.json`).
- Passwords handled by Identity's `PasswordHasher` — no plaintext anywhere in
  the new platform. Identity is never passed via query string: the agent's
  identity is resolved from an `AgentId` claim, not URL parameters.

## 2. Roles (verified constants in `IdentityIntegration.cs`)

| Constant | Value | Legacy source |
|---|---|---|
| `Roles.SuperUser` | `su` | `Udaan_users.privilege` |
| `Roles.Admin` | `adm` | `Udaan_users.privilege` |
| `Roles.Employee` | `emp` | `Udaan_users.privilege` (carried verbatim, see `SecurityGateService`) |
| `Roles.Agent` | `agt` | `Udaan_users.privilege` |
| `Roles.Guest` | `guest` | default for new self-registrations |

- **Registration is fixed server-side to `guest`**: `RegisterRequest.cs` states a
  privileged role in the payload is ignored (defense against privilege
  escalation).
- Legacy privilege ranking in `EntryService.cs`: `su`=1, `adm`=2, `emp`=3,
  `agt`=4.
- `IdentityImporter.cs` (Migration) maps legacy `Udaan_users.privilege` →
  Identity roles (`su`→`su`; `adm`/`admin`→`adm`; …).

## 3. Claims

`IdentityClaims` (in Api/Authorization):
- `AgentId` claim — binds an Identity user to the legacy `Agents` table for
  agent-context operations (AgentSelf/AgentLedger).
- `SuperUser` claim — super-user capability marker (SuperUserOnly policy).

## 4. Policies (11, verified in `AuthorizationPolicies.cs`)

`EntryOperations`, `AgentSelf`, `AgentLedger`, `BillingOperations`, `Search`,
`UserManagement`, `HolidayAdmin`, `SecurityGate`, `PasswordSelf`,
`AdminPanel`, `SuperUserOnly`.

Enforcement points verified:
- `Admin` area pages → `AdminPanel` (agents/users/holidays/content-update/
  security-day administration; `UserManagement`/`HolidayAdmin`/`SecurityGate`
  where page-specific).
- `Agent` area → `AgentSelf` via shared `AgentPortalPageModel`.
- `Reporting` area → `EntryOperations` via shared `ReportingPageModel`.
- `Auth` area → `Login`, `Register`, `ChangePassword`, `AccessDenied`.

## 5. Rate limiting

`RateLimiting:Queries` = 5 per 3600 s (fixed window) in Web `appsettings.json`
— throttles public query endpoints.

## 6. Legacy URL → auth routing (`LegacyUrlRewriteMiddleware`)

- `Default.asp` → `/`
- `authenticate.asp`, `logon.asp` → `/Auth/Login`
- `regsub*.asp` → `/Auth/Register`
- any other `*.asp` → 404 (explicitly **not** routed to a legacy page; full
  legacy page coverage is an open gap — see GAP_REPORT GAP-006)

## 7. Known security posture notes (new platform)

- No string-concatenated SQL in the new codebase (EF Core parameterized LINQ;
  owner-supplied stored procedures called via parameterized commands in
  `specs/004`/`specs/006` scripts).
- No anonymous write endpoints in the new platform (verified endpoints are
  policy-guarded; public pages are read-only query surfaces).
- The legacy `connection.asp` backdoor (flagged in findings) exists only as a
  legacy root file; it is not part of the new application (see GAP_REPORT
  GAP-006 on cutover).
