# COM Dependencies

**Feature**: SPEC-0002
**Date**: 2026-08-06

## Scope

COM/ActiveX components referenced by the legacy Classic ASP application. Data
is derived from `CreateObject("...")` references across the 585 root `.asp`
files (see `research.md`).

## Entries

| ProgID | Assembly/File | Reference Count | Purpose | Security Note |
|--------|---------------|-----------------|---------|---------------|
| `adodb.recordset` | ADO (system) | 554 | Database recordset access | Standard ADO; legacy |
| `adodb.connection` | ADO (system) | 4 | Database connection | Standard ADO; legacy |
| `CDONTS.Newmail` | CDONTS (system) | 18 | Legacy mail sending | Deprecated; removed in modern Windows |
| `CDO.Message` | CDO (system) | 5 | Mail message object | Deprecated; COM-only |
| `CDO.Configuration` | CDO (system) | 3 | Mail configuration | Deprecated; COM-only |
| `OSSMTP.SMTPSession` | `ActiveX/OSSMTP.dll` | 7 | SMTP mail sending | Windows/32-bit COM only — not portable to .NET on modern hosts |
| `scripting.filesystemObject` | Scripting (system) | 6 | File system access | Legacy; security concern (arbitrary file access) |
| `MSXML2.ServerXMLHTTP` | MSXML (system) | 2 | HTTP client (SMS sending) | Legacy; used for external HTTP |

## Notes

- **Reference counts** are the number of `CreateObject("...")` occurrences
  across the 585 root `.asp` files (from `research.md`).
- **Portability**: All COM components are Windows/32-bit and not portable to
  ASP.NET Core on modern hosts. The migration must replace them with managed
  equivalents (ADO → EF Core, CDONTS/CDO/OSSMTP → SMTP client, FileSystemObject
  → .NET file APIs, MSXML → HttpClient).
- **`ActiveX/OSSMTP.dll`** is the only archived COM binary in the repository;
  `msoe.dll` also exists at the repository root.
- **Security**: `scripting.filesystemObject` and the mail COM components are
  legacy security concerns, recorded as findings (not remediated per spec §6).
- No secrets are reproduced in this document (spec §12, AC-005).