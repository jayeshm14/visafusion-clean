# Technology Inventory

**Feature**: SPEC-0002
**Date**: 2026-08-06

## Scope

Technologies, languages, and frameworks detected in the repository, with
evidence of their presence. Detection is based on file extensions, file
content, and referenced libraries.

## Entries

| Name | Category | Evidence | Confidence | Status |
|------|----------|----------|------------|--------|
| Classic ASP / VBScript | language | 585 root `.asp` files; `language="vbscript"` and `Option Explicit` in page content | HIGH | LEGACY |
| Microsoft SQL Server | database | `connection.asp` uses `DRIVER={SQL Server};...DATABASE=visaentry`; `database.sql` (52-table schema) | HIGH | LEGACY |
| ADO (ActiveX Data Objects) | scripting | `adodb.recordset` (554 refs), `adodb.connection` (4 refs) | HIGH | LEGACY |
| HTML | web | 21 `.htm` + 8 `.html` files | HIGH | LEGACY |
| CSS | web | `Styles.css`, `css/` directory (adminlte.css, bootstrap-icons.css) | HIGH | ACTIVE |
| JavaScript | scripting | `datecheck.js`, `js/` directory (adminlte.js) | HIGH | ACTIVE |
| AdminLTE | framework | `css/adminlte.css`, `js/adminlte.js` referenced in Administrator.asp, agent.asp | HIGH | ACTIVE |
| Bootstrap Icons | framework | `css/bootstrap-icons.css` (v1.10.5); CDN reference `bootstrap-icons@1.11.0` in Administrator.asp | HIGH | ACTIVE |
| Bootstrap 5 | framework | PopperJS/Bootstrap 5 plugin references in Administrator.asp | MEDIUM | ACTIVE |
| CDONTS (Collaborative Data Objects for NT Server) | scripting | `CDONTS.Newmail` (18 refs) | HIGH | LEGACY |
| CDO (Collaborative Data Objects) | scripting | `CDO.Message` (5), `CDO.Configuration` (3) | HIGH | LEGACY |
| OSSMTP | scripting | `OSSMTP.SMTPSession` (7 refs); `ActiveX/OSSMTP.dll` | HIGH | LEGACY |
| MSXML2 | scripting | `MSXML2.ServerXMLHTTP` (2 refs) | HIGH | LEGACY |
| Windows Scripting Host / FileSystemObject | scripting | `scripting.filesystemObject` (6 refs) | HIGH | LEGACY |
| X3D | web | `Malaysia.x3d` | MEDIUM | LEGACY |
| PowerShell | tooling | `scripts/` (validate-ai-environment.ps1, integrations.psd1) | HIGH | ACTIVE |
| Pester | testing | `tests/` Pester test files | HIGH | ACTIVE |
| Markdown | documentation | `library/`, `findings/`, `specs/`, `reports/` markdown docs | HIGH | ACTIVE |
| JSON | data | `opencode.json`, `kg.json`, `summary.json` | HIGH | ACTIVE |

## Notes

- **Confidence** reflects the strength of evidence: HIGH = direct file/content
  evidence; MEDIUM = inferred from references.
- **Status** distinguishes LEGACY (Classic ASP-era) from ACTIVE (modernization
  tooling) technologies.
- The legacy application is built on Classic ASP/VBScript with SQL Server and
  ADO data access, using CDONTS/CDO/OSSMTP for mail and MSXML for HTTP.
- The modernization tooling (PowerShell, Pester, Markdown, JSON) is part of the
  repository's engineering environment, not the legacy application.
- Detection method: file-extension enumeration plus content inspection of key
  artifacts (connection strings, COM references, library references).