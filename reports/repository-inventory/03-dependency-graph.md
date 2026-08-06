# Dependency Graph

**Feature**: SPEC-0002
**Date**: 2026-08-06

## Scope

Relationships between repository components and between components and
external services. Dependencies were traced via server-side includes
(`#include file=`), `response.redirect` targets, database access patterns, and
external service references (mail, HTTP).

## Entries

| Source | Target | Type | Evidence |
|--------|--------|------|----------|
| ~300 legacy pages | `connection.asp` | include | `#include file="connection.asp"` (233 refs across ASP pages) |
| ~300 legacy pages | `homeBottom.asp` | include | 305 include refs |
| ~120 legacy pages | `empBottom.asp` | include | 120 include refs |
| ~96 legacy pages | `topadmin.asp` | include | 96 include refs |
| ~91 legacy pages | `top.asp` | include | 91 include refs |
| 16 legacy pages | `adminBottom.asp` | include | 16 include refs |
| 14 legacy pages | `topAgent.asp` | include | 14 include refs |
| 8 legacy pages | `connectionweb.asp` | include | 8 include refs (alternate connection) |
| Legacy pages | `left.asp`, `emailReceipt.asp`, `myMessage.asp`, `home.asp` | include | 2 refs each |
| Legacy pages | `relogin.asp?rsn=V` / `?rsn=usb` | redirect | 82 + 55 `response.redirect` refs (session validation) |
| Legacy pages | `home.asp` | redirect | 2 redirect refs |
| 59 ASP pages | SQL Server (visaentry DB) | database | `Recordset.open "SELECT..."` / `EXEC` patterns |
| All DB pages | ADO (`adodb.recordset`/`adodb.connection`) | data-access | 554 + 4 `CreateObject` refs |
| Mail pages (addNewUser.asp, contactsendpre.asp, editdonebyagent1.asp, emailAllPending.asp, emailCriteria.asp, +) | Mail service (CDONTS/CDO/OSSMTP) | mail | `CDONTS.Newmail` (18), `CDO.Message` (5), `OSSMTP.SMTPSession` (7) |
| SendSMS.asp, SendSMSManually.asp | External HTTP endpoints | http | `MSXML2.ServerXMLHTTP` (2 refs) |
| Legacy pages | File system | filesystem | `scripting.filesystemObject` (6 refs) |
| `login.asp`, `Default.asp`, etc. | AdminLTE/Bootstrap assets | include | `css/adminlte.css`, `js/adminlte.js`, CDN references |

## Notes

- **Connection dependency**: The most-depended-on artifact is `connection.asp`
  (233 includes) — it is the single database connection gateway for the legacy
  application. `connectionweb.asp` (8 refs) is an alternate variant.
- **Session flow**: `relogin.asp` (82 + 55 refs) is the primary
  session-validation redirect target, used to enforce authentication.
- **Data access**: 59 pages execute SQL directly against the SQL Server
  database (string-concatenated queries observed — a legacy security finding
  recorded in `08-configuration-inventory.md` / findings).
- **Mail**: Mail is sent via three COM mechanisms (CDONTS, CDO, OSSMTP); see
  `07-com-dependencies.md` for details.
- **External HTTP**: SMS sending uses `MSXML2.ServerXMLHTTP` to reach external
  endpoints.
- Dependency tracing covers include, redirect, database, mail, HTTP, and
  filesystem relationships observed in the repository.