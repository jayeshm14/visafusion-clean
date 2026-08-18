# API Contract: Content Module — dailyUpdate CMS + Holiday/Weekly-Off (SPEC-0008)

**Date**: 2026-08-18 | **Spec**: [SPEC-0008](../spec.md)

Defines the content-management endpoints (spec §15). Backs the legacy pages `dailyupdate.asp`/`viewdailyupdate.asp` (§6.9) and `holidayHome.asp`, `holiday_entry.asp`, `holiday_WebEntry.asp`, `holidaySubmit.asp`, `holidayDeleteSubmit.asp`, `WeeklyOffList.asp` (§6.8).

## General

- Base path: `/api/v1`
- Format: JSON (UTF-8)
- Auth: `AdminPanel` (`adm`/`su`) for daily-update writes; `HolidayAdmin` (`adm`/`su`) for holiday/weekly-off writes; public read is anonymous. Policy constants verified in `src/VisaFusion.Api/Authorization/AuthorizationPolicies.cs`.
- Errors: standardized problem-details JSON: `400` validation, `401`/`403` authorization, `404` not found, `409` duplicate (holiday/weekly-off).

## 1. `POST /api/v1/admin/content/daily-update` — Create/update daily-update entry (FR-010)

Policy: `AdminPanel`. Backs legacy `dailyupdate.asp` (write — the legacy anonymous write endpoint is closed, BR-003).

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `entrydate` | date | yes | entry date |
| `description` | string | yes | ≤ 8,000 chars (`dailyUpdate.Description` column limit) |
| `id` | long | no | when present, updates that entry instead of inserting (create/edit in one endpoint) |

Server behavior: upserts `dailyUpdate` (EF `ContentUpdate`); inserts when `id` is absent, updates when present. Success: `201 Created` / `200 OK`.

## 2. `DELETE /api/v1/admin/content/daily-update/{id}` — Delete daily-update entry (FR-010)

Policy: `AdminPanel`. Success: `204 No Content`; `404` when the id does not exist.

## 3. `POST /api/v1/holidays` — Create embassy holiday (FR-011)

Policy: `HolidayAdmin`. Route pre-registered in SPEC-0005 T030. Backs legacy `holidaySubmit.asp`.

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `embassyId` | int | yes | legacy `holidaylist.countryID` (holds the embassy id per `holidayList.asp:131`) |
| `holidayDate` | date | yes | the holiday date |
| `description` | string | no | optional |

Server behavior: rejects duplicate embassy+date with `409`. Success: `201 Created`. The row is immediately honored by `IHolidayService.IsEmbassyClosedAsync` (AC-007).

## 4. `DELETE /api/v1/holidays/{id}` — Delete embassy holiday (FR-011)

Policy: `HolidayAdmin`. Route pre-registered in SPEC-0005 T030. Backs legacy `holidayDeleteSubmit.asp`. Success: `204 No Content`; `404` when not found.

## 5. `POST /api/v1/holidays/weekly-off` — Create embassy weekly-off (FR-011)

Policy: `HolidayAdmin`. Follows the pre-registered `/api/v1/holidays` route family. Backs legacy `WeeklyOffList.asp`.

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `embassyId` | int | yes | `weeklyoff.embassyid` (FK `Embassy.Id`) |
| `weekday` | int | yes | 1–7, VBScript `Weekday()` numbering (1=Sunday..7=Saturday — BR-006) |
| `description` | string | no | optional |

Server behavior: rejects invalid weekday (outside 1–7) with `400`; duplicate embassy+weekday with `409`. Success: `201 Created`.

## 6. `DELETE /api/v1/holidays/weekly-off/{id}` — Delete embassy weekly-off (FR-011)

Policy: `HolidayAdmin`. Backs legacy `WeeklyOffList.asp`. Success: `204 No Content`; `404` when not found.

## 7. `GET /` (public daily-update read page) — Anonymous read (FR-010)

Razor Page under `Areas/Public/Pages/DailyUpdate.cshtml` (not an API). Backs legacy `viewdailyupdate.asp`. Renders the current and recent dated entries (date + description); anonymous; empty state shows a friendly message (never a blank table header).
