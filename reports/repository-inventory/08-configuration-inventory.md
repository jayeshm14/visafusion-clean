# Configuration Inventory

**Feature**: SPEC-0002
**Date**: 2026-08-06

## Scope

Configuration files, connection strings, and settings in the repository.
Secret values are **not** reproduced — only descriptive Value Summaries are
provided (spec §12, AC-005).

## Entries

| Artifact | Setting | Value Summary | Secret | Status |
|----------|---------|---------------|--------|--------|
| `connection.asp` | Database connection string | SQL Server driver; database `visaentry`; server `local`; **contains plaintext uid/pwd** | Yes | ACTIVE (security finding) |
| `connectionold.asp` | Legacy database connection string (alternate) | SQL Server; legacy variant of `connection.asp` | Yes | LEGACY |
| `connectionweb.asp` | Alternate database connection string | SQL Server; web variant (8 includes) | Yes | LEGACY |
| `database.sql` | Database schema definition | 52-table SQL Server schema; schema drift vs live DB recorded in findings §4.7 | No | LEGACY |
| `opencode.json` | Agent configuration | opencode agent settings | No | ACTIVE |
| `SendSMS.asp` | SMS gateway endpoint + credentials | External SMS gateway URL (http://api.messaging4u.com/india/SendingSMS.aspx); **hardcoded credentials** (findings §7) | Yes | ACTIVE (security finding) |
| `topAgent.asp` | Agent quick-login parameters | Hardcoded `logon=Y&anp=...&seckey=...` quick-login query string (findings §3.8) | Yes | ACTIVE (security finding) |

## Notes

- **Plaintext credentials**: `connection.asp` contains a plaintext SQL Server
  user ID/password pair. The actual values are **not** reproduced here per
  AC-005. This is the `connection.asp` backdoor/credential finding referenced
  in `@findings/deepanalysis.md` and the constitution.
- **Hardcoded secrets** also exist in `SendSMS.asp` (SMS gateway creds) and
  `topAgent.asp` (quick-login seckey). All are recorded as findings — not
  remediated per spec §6.
- **Status** distinguishes ACTIVE (in current use) from LEGACY (alternate/
  historical variants).
- Secret-bearing entries are flagged with `Secret = Yes` but never expose the
  value itself.
- Validation: TS-005 requires that searching for `pwd=`, `password=`, `uid=`,
  or full connection strings in the inventory documents returns no matches
  (except references to the *setting names*).