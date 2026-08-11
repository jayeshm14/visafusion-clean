# Data Model: Identity Consolidation, RBAC & Employee Day-Gate (SPEC-0005)

**Date**: 2026-08-11 | **Spec**: [SPEC-0005](spec.md)

This feature does not introduce a new business schema. It integrates the existing
identity store (created by the SPEC-0004 migration tool) into the running host, extends
it idempotently with the standard Identity auxiliary tables, and reads one business
table (`security`) for the employee day-gate. All tables below are documented per their
role in this feature.

## 1. Identity Store (target `VisaFusion` database — migration-tool DDL + this feature)

### 1.1 `AspNetUsers` (mapped by `VisaFusionUser`, `VisaFusionIdentityDbContext`)

Created by `IdentityImporter.EnsureIdentitySchemaAsync` (SPEC-0004 T040, verified
`IdentityImporter.cs` lines 130–176); extended columns map to
`VisaFusion.Identity.IdentityIntegration.VisaFusionUser`.

| Column | Type | Notes |
|--------|------|-------|
| `Id` | nvarchar(450) PK | GUID string |
| `UserName` / `NormalizedUserName` | nvarchar(256) | imported legacy username |
| `Email` / `NormalizedEmail` | nvarchar(256) | |
| `EmailConfirmed` | bit | 0 on import |
| `PasswordHash` | nvarchar(max) | PBKDF2 hash of the stored legacy password value (never plaintext — BR-002) |
| `SecurityStamp` / `ConcurrencyStamp` | nvarchar(max) | |
| `PhoneNumber` / `PhoneNumberConfirmed` | nvarchar(max) / bit | |
| `TwoFactorEnabled` | bit | 0 |
| `LockoutEnd` | datetimeoffset | past date for inactive accounts (this feature: `active`→lockout alignment, FR-009) |
| `LockoutEnabled` | bit | **`!active`** after alignment (currently hardcoded `1` — verified `IdentityImporter.cs` line 188) |
| `AccessFailedCount` | int | 0 |
| `LegacyUdaanUserId` | int? | source link |
| `LegacyRegistrationId` | int? | source link |
| `AgentId` | int? | bound at import (FR-007); surfaced as a claim, never re-derived from query string |

### 1.2 `AspNetRoles` (seeded)

| Column | Type | Notes |
|--------|------|-------|
| `Id` | nvarchar(450) PK | role name |
| `Name` / `NormalizedName` | nvarchar(256) | `su`, `adm`, `emp`, `agt`, `guest` (BR-001, verified seeded rows) |
| `ConcurrencyStamp` | nvarchar(max) | |

### 1.3 `AspNetUserRoles`, `AspNetUserClaims`, `AspNetRoleClaims`, `AspNetUserLogins`, `AspNetUserTokens`

Standard ASP.NET Core Identity schema. The three core tables exist (migration DDL);
this feature extends the DDL idempotently with the four auxiliary tables
(`AspNetUserClaims`, `AspNetRoleClaims`, `AspNetUserLogins`, `AspNetUserTokens`) the
runtime store uses (spec §16). `AspNetUserClaims` carries the `AgentId` and
`SuperUser` claims minted at login (FR-007/FR-008).

## 2. Read-Only Business Data for the Day-Gate

### 2.1 `security` (mapped by `SecurityDay`, `VisaEntryDbContext` — SPEC-0004 §3.1)

Read-only; never written by this feature (constitution Principle III). The day-gate
evaluation on `ISecurityGateService` queries it for today.

| Column | Type | Day-gate use |
|--------|------|--------------|
| `Date1` | datetime | compared to today (day match) |
| `Openingtime` | datetime | day opened |
| `Openby` | nvarchar | |
| `Closingtime` | datetime | **null = open day** (`authenticate.asp` line 68: `closingtime is null`) |
| `Closedby` | nvarchar | |

Day-gate evaluation (verified `authenticate.asp` lines 62–79):
- A `security` row for today **with `closingtime is null`** → day open → `emp` login succeeds.
- No matching row for today (no row at all, or only rows with a closing time set) →
  `rsn=O` (day not opened) — the only rejection the legacy produces.

Note: the legacy `elseif` branch (`rsAdm("closingtime")<>""`) is unreachable given the
`closingtime is null` WHERE clause (`NULL <> ""` is falsy in VBScript), so `rsn=C` is
**never produced** (dead code, `authenticate.asp` line 72; FR-018 as clarified
2026-08-11). The modernized evaluation reproduces the observable outcomes only:
`rsn=O` rejection or success.

## 3. Validation Rules (from spec §17 / FRs)

- **Roles**: server-side enum `adm`/`emp`/`agt`/`guest` only; `su` is never settable
  through a standard endpoint (FR-013 — enforced when the User-management module lands;
  the endpoint is deferred, spec §15).
- **Registration** (public, guest-only): required fields, unique username/email, role
  fixed to `guest` server-side (FR-012, §2.2 fix), password meets the policy (minimum 8
  characters, no forced complexity).
- **Change-password** (FR-019): current password must verify; new ≠ confirm →
  validation error; new password must meet the policy (minimum 8 characters, no forced
  complexity); new password stored hashed via `UserManager.ChangePasswordAsync` — no
  lowercasing, no plaintext.
- **Day-gate** (FR-018): applies to `emp` logins only; `rsn=O` rejection / success
  outcomes as above (`rsn=C` never produced).
- **Lockout** (FR-009): inactive legacy accounts (`active = false`) are locked out
  (`LockoutEnabled = true` + past `LockoutEnd`) and cannot sign in.

## 4. State Transitions

### 4.1 Login (per principal role)

```
unauthenticated
  └─ credentials valid?
       ├─ no  → rejected (relogin, legacy rsn=B equivalent)
       └─ yes ── role = emp? ── no → authenticated (adm/su → AdminPanel; agt → Agent portal; guest → public)
                    │
                    └─ yes → day-gate:
                              ├─ open day (security row, closingtime null) → authenticated
                              └─ no open-day row for today (no row, or only closed rows) → rejected rsn=O
```

### 4.2 Change-password (FR-019)

```
authenticated
  ├─ current password wrong → 400 (Web: inline error; legacy flag=3 equivalent)
  ├─ new ≠ confirm          → 400 (legacy flag=2 equivalent)
  ├─ policy violation (< 8 chars) → 400 (validation error)
  └─ valid                  → 204 (Web: inline success; legacy flag=1 equivalent)
```

### 4.3 Account lockout (import alignment)

```
active = true  → LockoutEnabled = false → can sign in
active = false → LockoutEnabled = true  + LockoutEnd (past) → blocked at sign-in
```

## 5. Relationships

- `AspNetUserRoles.UserId → AspNetUsers.Id` (FK, ON DELETE CASCADE)
- `AspNetUserRoles.RoleId → AspNetRoles.Id` (FK, ON DELETE CASCADE)
- `AspNetUsers.AgentId → agents.agentsID` (logical; bound at import, FR-007)
- `AspNetUsers.LegacyUdaanUserId → Udaan_users` (logical source link)
- `AspNetUsers.LegacyRegistrationId → registration.registID` (logical source link)
- `SecurityDay` has no FKs in this feature (read-only, legacy table)

## 6. Traceability

- `AspNetUsers` + lockout → FR-005/FR-006/FR-009, §24 (rows FR-005/FR-006/FR-009)
- `AspNetUserClaims` (AgentId/SuperUser) → FR-007/FR-008
- Identity auxiliary tables → §16, FR-017
- `security`/`SecurityDay` → FR-018, spec §24 row FR-018
- Password hash storage → FR-019 (change-password), FR-006 (import)
