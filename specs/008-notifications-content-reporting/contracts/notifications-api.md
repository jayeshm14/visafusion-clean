# API Contract: Notifications Module — SMS/Email Queues (SPEC-0008)

**Date**: 2026-08-18 | **Spec**: [SPEC-0008](../spec.md)

Defines the notification endpoints (spec §15) and the background-worker drain contract. Backs the legacy pages `SendSMS.asp`, `SendSMSManually.asp`, `SendSMSToQueue.asp`, `SendSMStoQueue.asp`, `sendSMSToQueue.asp`, `contactsendpre.asp`, `emailAgent.asp`, `composeEmail.asp` (`@findings/modernization_plan.md` §6.7).

## General

- Base path: `/api/v1`
- Format: JSON (UTF-8)
- Auth: `emp`/`adm`/`su` (JWT bearer; `AuthorizationPolicies` — policy set per endpoint below). Anonymous callers receive `401`/`403` (FR-009).
- Errors: standardized problem-details JSON: `400` validation, `401`/`403` authorization, `404` not found.
- v1 runs **enqueue-and-log mode** (owner Q1:C, 2026-08-18): enqueue persists the queue row and returns immediately; no vendor send occurs until a dispatch provider is configured. The audit trail is always written (BR-001).

## 1. `POST /api/v1/notifications/sms` — Enqueue SMS (FR-001)

Policy: `EntryOperations` (`emp`/`adm`/`su`). Backs legacy `SendSMS*`/`SendSMSToQueue.asp`.

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `mobile` | string | yes | recipient; valid format |
| `message` | string | yes | length-limited |
| `refno` | int | no | optional entry reference |
| `agentId` | int | no | optional agent context |

Server behavior: validates, inserts a `smsQueue` row, returns immediately. Success: `202 Accepted` (enqueued). Never blocks on dispatch (NFR-001).

## 2. `POST /api/v1/notifications/email` — Enqueue email (FR-002)

Policy: `EntryOperations` (`emp`/`adm`/`su`). Backs legacy `emailAgent.asp`/`composeEmail.asp` external-email path.

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `to` | string | yes | recipient email; valid |
| `subject` | string | yes | length-limited |
| `body` | string | yes | length-limited |
| `refno` | int | no | optional entry reference |
| `agentId` | int | no | optional agent context |

Server behavior: validates, inserts an `emailQueue` row (research D-1), returns immediately. Success: `202 Accepted`.

## 3. `GET /api/v1/notifications/sms-history` — SMS audit read (FR-004)

Policy: `EntryOperations` (`emp`/`adm`/`su`). Reads `smshistory` (EF `SmsLog`).

Response rows: `cellno`, `refno`, `agentId`, `paxname`, `status`, `message`, `sentby`, `sentdate` (the full legacy audit field set). Supports `?dateFrom=&dateTo=&agentId=` filters (all optional, validated).

## 4. `GET /api/v1/notifications/email-history` — Email audit read (FR-005)

Policy: `EntryOperations` (`emp`/`adm`/`su`). Reads `sentmails` (EF `EmailLog`).

Response rows: `id`, `agentsid`, `date`, `toemail`, `awb`. Supports the same optional filters as SMS history.

## 5. Worker drain contract (FR-003, FR-006) — internal, not HTTP

- Poller: `SmsQueueWorker`/`EmailQueueWorker` (`VisaFusion.Jobs`) poll their queue table on an interval.
- Batch: bounded batch (`Take(n)`, n from configuration; default 100).
- Transaction (research D-3): read batch → dispatch via provider → write audit row (`smshistory`/`sentmails`) → delete queue row → commit.
- Dispatch provider: `ISmsDispatchProvider`/`IEmailDispatchProvider` — v1 default **log-only provider** (owner Q1:C); a vendor provider is registered by configuration only.
- Failure: each failed dispatch writes its audit row with `status = failed` and is retried (3 attempts, exponential backoff, idempotent per message — NFR-005); never silently swallowed (FR-006). Failure is visible in the audit log and in OpenTelemetry counters (NFR-003).
- Isolation: a worker fault never affects request handling (spec §18).
