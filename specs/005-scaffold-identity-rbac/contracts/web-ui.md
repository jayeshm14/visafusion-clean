# Web UI Contract: Auth Pages & Legacy URL Rewrite (SPEC-0005)

**Date**: 2026-08-11 | **Spec**: [SPEC-0005](../spec.md) | **API contract**:
[auth-api.md](auth-api.md)

This contract defines the Web (Razor Pages, cookie sign-in) auth surface and the legacy
`.asp` → new-route rewrite mapping (spec §14, FR-003, NFR-005).

## 1. Pages

All pages live under `/Auth/*` in `VisaFusion.Web` and use cookie authentication
(SPEC-0003 FR-010).

### 1.1 `/Auth/Login` (+ handler)

- Cookie sign-in form posting to the cookie scheme.
- On success: redirect per role-appropriate landing (adm/su → admin panel area, emp →
  employee area, agt → agent portal, guest → public landing).
- **Day-gate** (FR-018): an `emp` login rejected by the day-gate redirects back to
  `/Auth/Login?rsn=O` (no open-day row exists for today), mirroring the legacy
  `relogin.asp?rsn=` behavior. `rsn=C` is never produced (legacy dead code); the page
  renders the corresponding reason message.

### 1.2 `/Auth/AccessDenied`

- Authenticated-but-unauthorized requests land here (configured
  `AccessDeniedPath`); page already referenced by `Program.cs` but does not exist today.

### 1.3 `/Auth/Register`

- Guest-only registration page posting to the cookie scheme's registration flow; role
  fixed server-side to `guest` (FR-012, §2.2 fix).

### 1.4 `/Auth/ChangePassword`

- Authenticated page (any role) posting to the cookie-backed change-password flow.
- Outcomes mirror the legacy `changepassword.asp?flag=1|2|3` as inline messages:
  success / new ≠ confirm / wrong current password / policy violation (< 8 characters)
  (FR-019).

## 2. Legacy URL Rewrite (FR-003, NFR-005)

`LegacyUrlRewriteMiddleware` maps the documented Phase 0 entry URLs with 301 redirects
(explicit, documented mapping constant); any other `.asp` path → 404 (no wildcard
forwarding).

| Legacy URL | New route |
|------------|-----------|
| `Default.asp` | `/` |
| `authenticate.asp`, `logon.asp` | `/Auth/Login` |
| `regsub*.asp` | `/Auth/Register` |
| anything else `.asp` | `404` |

`relogin.asp?rsn=*` is not mapped — the modernized login renders the `rsn` reason
inline (`/Auth/Login?rsn=O`); old bookmarks of the mapped entry URLs resolve, unknown
legacy URLs 404.

## 3. Static Assets

- The 879 copied files under self-hosted `wwwroot` (`forms/`, `updateimg/`, `images/`,
  `css/`, `js/`, `fonts/`) render correctly (FR-004/AC-008); `_vti_cnf` metadata and
  scratch files are excluded (spec §9).

## Traceability

- FR-003/AC-007/TS-007 → §2
- FR-004/AC-008/TS-008 → §3
- FR-017 → §1.1–§1.2; FR-018 → §1.1 (day-gate); FR-019 → §1.4; FR-012 → §1.3
- AC-001/TS-001 → §1.1 (5-role login)
