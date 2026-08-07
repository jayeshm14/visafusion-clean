# Data Model: Target Architecture (SPEC-0003)

**Date**: 2026-08-06 | **Spec**: [SPEC-0003](../003-target-architecture/spec.md)

This feature is **architecture scaffolding only** — it introduces **no new database
objects and no schema changes** (spec §16). The data model below documents (a) the
existing `VisaEntry` database surface the Data project will reference, and (b) the
identity/entity integration points the scaffolding must establish. Full entity
definitions live in the module feature specs and the Data Remediation feature.

## 1. Database Surface (existing `VisaEntry` — reference only)

The EF Core model is bootstrapped from the **live** schema (not `database.sql` demo
script, which has confirmed drift — `deepanalysis.md` §4.7). Key tables the Data project
must scaffold, per `library/complete_migration_plan.md` §3:

| Table | Rows (live) | Disposition | Target entity |
|-------|------------|-------------|---------------|
| `Mainentry` | 271,724 | M | `Entry` |
| `entryDetails` | 312,655 | M | `EntryPassenger` |
| `PaxStatus` | 359,338 | M | `PaxCountryStatus` |
| `StatusHistory` | 1,287,261 | M (append-only) | `StatusHistoryEntry` |
| `bighistory` | 1,430,841 | M (append-only) | `EntryAuditLog` |
| `sentmails` | 553,523 | M | `EmailLog` |
| `smshistory` | 47,534 | M | `SmsLog` |
| `smsQueue` | low | M | `SmsQueue` |
| `agents` | 4,218 | M | `Agent` |
| `Udaan_users` | 2,365 | M | `AspNetUsers` source |
| `registration` | 43 | M | `AspNetUsers` (guest) source |
| `security` | 1,461 | M | `SecurityDay` |
| `holidaylist` | 4,272 | M | `Holiday` |
| `weeklyoff` | low | M | `WeeklyOff` |
| `embassy` | 242 | M | `Embassy` |
| `CountryInfo` | 190 | M | `CountryInfo` |
| `VisaInfo` | 981 | M | `VisaInfo` |
| `status` | small | M (508 duplicate to fix in Data Remediation) | `Status` |
| `invoice` | 271,239 | M-RO (pre-2009) | `Invoice` |
| `invoicedetail` | 358,630 | M-RO | `InvoiceDetail` |
| `Ledger` | 26,565 | M-RO | `LedgerHistory` |

Full 52-table disposition is in `library/complete_migration_plan.md` §3. This feature
scaffolds the DbContext surface; remediation (cleansing, FKs, indexes, dead-table drops)
is the Data Remediation feature.

## 2. Identity Integration Points

ASP.NET Core Identity stores map to the three legacy identity sources (migration plan §7):

| Legacy source | Role | External key kept | Notes |
|---------------|------|-------------------|-------|
| `Udaan_users` (`su`,`adm`,`emp`) | `su`/`adm`/`emp` | `LegacyUdaanUserId` | Password hashed on import; `LockoutEnabled = !active` |
| `Udaan_users` (`agt` rows) | `agt` | `LegacyUdaanUserId` + `AgentId → agents.agentsID` | Fixes never-set `session("agentid")` |
| `registration` | `guest` | `LegacyRegistrationId` | Password hashed on import |

Store implementation is the Identity Consolidation feature; this feature establishes the
Identity project and its integration point (spec FR-007).

## 3. Scaffolding Entities (created by this feature)

No business tables are created. The only artifacts the Data project introduces are EF
Core configuration/migration scaffolding files; any `__EFMigrationsHistory` table is the
standard EF Core tooling artifact (not a business table).

## 4. Validation Rules

- All query input validated and parameterized; no raw string SQL (spec §17).
- Business validation lives in Core and is shared by Web and Api (spec §17, FR-003).
- No secrets in any entity or configuration artifact (spec §12).

## 5. State Transitions

None defined in this feature — state transitions belong to the module features
(entry lifecycle, status transitions). The architecture must preserve the append-only
nature of `StatusHistory`/`bighistory`/`sentmails`/`smshistory` (spec §19).

## 6. Data Volume / Scale

- History tables up to 1.4M rows (`bighistory`) — supported via indexes added in the
  Data Remediation feature (spec §13).
- Background queues must not block request handling (spec §13).

## Traceability

| Spec requirement | Data model element |
|------------------|--------------------|
| FR-006 (DbContext over `VisaEntry`) | §1 database surface |
| FR-007 (Identity integration) | §2 identity integration points |
| NFR-002 (52-table + history volume) | §1, §6 |
| BR-003 (no business table drop) | §3 (no new tables; no drops) |
