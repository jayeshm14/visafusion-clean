# External Dependencies

**Feature**: SPEC-0002
**Date**: 2026-08-06

## Scope

External libraries, services, and systems the application depends on. This is
derived from `@findings/modernization_plan.md` Â§7 (verified in source) and the
COM reference analysis in `research.md`.

## Entries

| Name | Type | Used By | License | Security Note |
|------|------|---------|---------|---------------|
| SMS gateway (`http://api.messaging4u.com/india/SendingSMS.aspx`) | service | `SendSMS.asp` | UNKNOWN | Defunct/low-reliability; hardcoded creds; **HTTP not HTTPS** (security finding) |
| SMTP relay (`relay.spectranet.com:25`) | service | CDO (`contactsendpre.asp`), OSSMTP (`addNewUser.asp`) | UNKNOWN | Legacy relay; may be dead; port 25 often blocked |
| `udaanindia.com`, `www.udaanindia.com` | service | topNav, `topAgent.asp` | UNKNOWN | Old brand domain links (broken branding â€” site now Royal Routes) |
| `chat/Default.asp`, `chat/Clientdefault.asp` | service | `authenticate.asp:48`, `topAgent.asp:70` | UNKNOWN | **Folder does not exist** â†’ broken links (findings Â§9.3) |
| VFS Global / embassy / consulate sites | service | content pages | UNKNOWN | External content links; verify liveness |
| `cdn.jsdelivr.net` (bootstrap-icons, bootstrap 5.3.7, popper) | library | AdminLTE 4 pages (`Administrator.asp`, `Agent.asp`, `Default.asp`, etc.) | MIT (bootstrap-icons) | Requires internet at runtime; consider self-hosting for intranet reliability |
| 57 embassy forms in `forms/` | data | `forms.asp` | UNKNOWN | Static downloads â€” copy as-is |
| Microsoft SQL Server (VisaEntry DB) | service | all DB pages via `connection.asp` | Commercial | Plaintext user ID/password in connection string (finding - see 08-configuration-inventory.md) |
| Mail services (CDONTS/CDO/OSSMTP) | service | mail pages | Microsoft/OSSMTP | COM-only; deprecated (see 07-com-dependencies.md) |

## Notes

- **Risk posture**: All external service dependencies carry a security or
  reliability risk, recorded as findings â€” none are remediated per spec Â§6.
- **Runtime dependency**: The AdminLTE 4 / Bootstrap 5.3.7 / Bootstrap Icons
  assets are partially self-hosted (`css/`, `js/`, `fonts/`) but bootstrap-icons
  is also loaded from a CDN, requiring internet at runtime.
- **Data migration note**: The 57 embassy forms in `forms/` are static
  downloads to be copied as-is during migration.
- No secrets or full connection values are reproduced in this document
  (spec Â§12, AC-005).
