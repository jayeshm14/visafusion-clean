# Data Model: Complete Data Model Migration (SPEC-0004)

**Date**: 2026-08-09 | **Spec**: [SPEC-0004](spec.md) | **Research**: [research.md](research.md)

This document defines the **target data model** produced by the migration: the
`VisaFusion` database populated from the legacy `VisaEntry` snapshot, with
reconstructed primary keys, foreign keys, and indexes (FR-003). Column-level legacy
definitions are NOT duplicated here — the authoritative column dump is
`findings/modernization_plan.md` §12 (Appendix A); the per-table disposition contract
is `library/complete_migration_plan.md` §3. This document records the migration-time
decisions: PK strategy, FK set, identity mapping, cleansing, and validation.

## 1. Target Database Overview

| Item | Value |
|------|-------|
| Target database | `VisaFusion` (new; separate from legacy `VisaEntry`) |
| Source | Legacy `VisaEntry` — static snapshot, offline window (NFR-002) |
| Tooling | EF Core migrations (target schema) + `VisaFusion.Migration` console (copy) |
| Reversibility | Pre-migration backup; restore returns target to pre-migration state (AC-008) |
| Legacy DB | Never modified; byte-identical after migration (AC-006) |

## 2. Primary Key Strategy (applied rule)

Derived from clarification Q4 (identity-first with surrogate fallback) and its
governing intent "no re-keying of referenced data":

1. **Identity column exists** → that column is the PK (values preserved).
2. **No identity column, but a natural key column is referenced by other tables**
   (per the FK map in §4) → that natural key column is the PK (values preserved).
3. **Otherwise** → a surrogate `Id` (bigint identity) key is added.

Identity columns identified from the live schema dump (`modernization_plan.md` §12):
`agents.agentsID`, `bighistory.bighistoryid`, `embassy.EmbassyID`,
`entryDetails.PaxID`, `Ledger.id`, `Mainentry.id`, `newagents.newagentsID`,
`priwork.id`, `registration.registID`, `scheduler.messageid`, `sentawb.id`,
`sentmails.id`, `subscriber.id`, `diary.ID`, `dtproperties.id`, `adcount.adcountid`.

## 3. Target Entities by Disposition

Legend: **M** = live/writable · **M-RO** = read-only/historical · **COND** = archived
until owner confirmation · **ARCH** = archived data, no live entity · **DROP** = not
migrated. Row counts are live-source values from `library/complete_migration_plan.md` §3.

### 3.1 M — live/writable entities

| Legacy table | Rows | Target entity | PK |
|--------------|------|---------------|----|
| `Mainentry` | 271,724 | `Entry` | `id` (identity) |
| `entryDetails` | 312,655 | `EntryPassenger` | `PaxID` (identity) |
| `PaxStatus` | 359,338 | `PaxCountryStatus` | surrogate `Id` |
| `StatusHistory` | 1,287,261 | `StatusHistoryEntry` | surrogate `Id` (append-only) |
| `bighistory` | 1,430,841 | `EntryAuditLog` | `bighistoryid` (identity, append-only) |
| `sentmails` | 553,523 | `EmailLog` | `id` (identity) |
| `sentawb` | 9,355 | `AwbLog` | `id` (identity) |
| `smshistory` | 47,534 | `SmsLog` | surrogate `Id` |
| `smsQueue` | low | `SmsQueue` | surrogate `Id` |
| `agents` | 4,218 | `Agent` | `agentsID` (identity) |
| `security` | 1,461 | `SecurityDay` | surrogate `Id` |
| `masterbalance` | 1,416 | `MasterBalance` | surrogate `Id` (pending owner confirmation, §12 #11) |
| `bank` | low | `Bank` | `bankid` (natural, referenced by `Ledger`) |
| `holidaylist` | 4,272 | `Holiday` | surrogate `Id` |
| `weeklyoff` | low | `WeeklyOff` | surrogate `Id` |
| `embassy` | 242 | `Embassy` | `EmbassyID` (identity) |
| `CountryInfo` | 190 | `CountryInfo` | `CountryID` (natural) |
| `VisaInfo` | 981 | `VisaInfo` | surrogate `Id` |
| `status` | small | `Status` | `statusID` (natural, referenced) — duplicate 508 resolved (FR-005a) |
| `Category` | small | `Category` | `CategoryID` (natural, referenced) |
| `EntryType` | small | `EntryType` | `EntryTypeID` (natural, referenced) |
| `Poe` | small | `Poe` | `PoeID` (natural, referenced) |
| `Attestation` | small | `Attestation` | `AttestationID` (natural, referenced) |
| `certificate` | small | `Certificate` | `certificateID` (natural, referenced) |
| `PaxAttestation` | small | `PaxAttestation` | surrogate `Id` (junction) |
| `dailyUpdate` | — | `ContentUpdate` | surrogate `Id` |

### 3.2 M-RO — read-only/historical entities

| Legacy table | Rows | Target entity | PK |
| --- | --- | --- | --- |
| `deleteditem` | 9,909 | `DeletedItemAudit` | surrogate `Id` (audit-only) |
| `newagents` | low | `AgentStaging` | `newagentsID` (identity) |
| `Ledger` | 26,565 | `LedgerHistory` | `id` (identity) — 26,563/26,565 NULL `transdate`; historical archive |
| `invoice` | 271,239 | `Invoice` | surrogate `Id` (M-RO pre-2009; M if owner revives billing, §11 #1) |
| `invoicedetail` | 358,630 | `InvoiceDetail` | surrogate `Id` (same disposition as `invoice`) |

### 3.3 COND — archived until owner confirmation (BR-004)

| Legacy table | Target entity | PK |
| --- | --- | --- |
| `hotel` | `Hotel` (archived) | `hotelid` (natural) |
| `cab` | `Cab` (archived) | `cabid` (natural) |
| `paxhotel` | `PaxHotel` (archived) | surrogate `Id` |
| `paxCab` | `PaxCab` (archived) | surrogate `Id` |
| `scheduler` | `Scheduler` (archived) | `messageid` (identity) |
| `priwork` | `PriWork` (archived) | `id` (identity) |
| `subscriber` | `Subscriber` (archived) | `id` (identity) |

### 3.4 ARCH — archived, no live entity

| Legacy table | Target |
| --- | --- |
| `invno` | archived (superseded invoice counter) |
| `quote` | archived (dead) |
| `diary` | archived (unused) |
| `emailid`, `emaild1` | archived (unused email lists) |
| `changes`, `changesbill` | archived (change logs) |

### 3.5 DROP — not migrated (BR-001)

| Table | Basis |
| --- | --- |
| `dtproperties` | SQL Server system table |
| `country` | confirmed empty (0 rows); country list lives in `embassy`/`CountryInfo` |
| `Results` | temp copy of `agents` |
| `hits` | hit counter disabled in code |
| `adcount` | ads table, explicitly dead |

## 4. Foreign Key Map (reconstructed on target)

Derived from documented legacy relationships (`findings/modernization_plan.md` §6
module map; `library/complete_migration_plan.md` §3). No FK is invented where the
legacy never had the relationship.

> **FK map verified against the live `VisaEntry` database on 2026-08-09**
> (`findings/gap-0001-fk-validity.md`). Relationships marked **DEFER** cannot be
> enforced on the target because the legacy data violates them (sentinel `0` values
> with no lookup row, or orphaned references) and no cleansing rule beyond FR-005
> a–d was approved. Per the deterministic rule, no data is changed and no constraint
> is forced; the column and index are kept, the FK constraint is omitted, and the
> relationship is recorded in the migration report `deferredForeignKeys` section.

| FK (child → parent) | Notes |
| --- | --- |
| `EntryPassenger.refno` → `Entry.refno` | passenger belongs to entry; **KEEP** (0 orphans, `Entry.refno` unique) |
| `PaxCountryStatus.refno` → `Entry.refno` | status row belongs to entry; **KEEP** (0 orphans) |
| `PaxCountryStatus.PaxID` → `EntryPassenger.PaxID` | status row belongs to passenger; **DEFER** (1 orphan) |
| `PaxCountryStatus.statusID` → `Status.statusID` | status lookup; **KEEP** (0 orphans) |
| `StatusHistoryEntry.PaxID` → `EntryPassenger.PaxID` | append-only history; **DEFER** (2,465 orphans) |
| `StatusHistoryEntry.StatusID` → `Status.statusID` | append-only history; **KEEP** (0 orphans) |
| `Entry.agent` → `Agent.agentsID` | **nullable** — 6,517 orphans migrate with NULL (FR-005c); **KEEP** |
| `EmailLog.agentsid` → `Agent.agentsID` | **DEFER** (9,661 orphans) |
| `AwbLog.agentsid` → `Agent.agentsID` | **DEFER** (404 orphans) |
| `SmsLog.agentID` → `Agent.agentsID` | **DEFER** (2,259 orphans) |
| `SmsQueue.agentID` → `Agent.agentsID` | **KEEP** (0 orphans) |
| `MasterBalance.agentid` → `Agent.agentsID` | **DEFER** (117 orphans) |
| `LedgerHistory.agentID` → `Agent.agentsID` | **DEFER** (525 orphans) |
| `InvoiceDetail.invoiceno` → `Invoice.invoiceno` | **KEEP** (0 orphans, `Invoice.invoiceno` unique) |
| `LedgerHistory.bank` → `Bank.bankid` | **DEFER** (2 orphans) |
| `PaxAttestation.PaxID` → `EntryPassenger.PaxID` | junction; **KEEP** (0 orphans) |
| `PaxAttestation.AttestationID` → `Attestation.AttestationID` | junction; **KEEP** (0 orphans) |
| `PaxAttestation.CertificateID` → `Certificate.certificateID` | junction; **KEEP** (0 orphans) |
| `Entry.category` → `Category.CategoryID` | **DEFER** (271,692 sentinel-0 rows) |
| `Entry.attestation` → `Attestation.AttestationID` | **DEFER** (30,176 sentinel-0 rows) |
| `Entry.poe` → `Poe.PoeID` | **DEFER** (3 sentinel-0 rows) |
| `Entry.status` → `Status.statusID` | **DEFER** (3 sentinel-0 rows) |
| `Entry.entrytype` → `EntryType.EntryTypeID` | **KEEP** (100% NULL, nullable FK) |
| `PaxCountryStatus.category` → `Category.CategoryID` | **DEFER** (2,755 sentinel-0 rows) |
| `PaxCountryStatus.entrytype` → `EntryType.EntryTypeID` | **DEFER** (67 sentinel-0 rows) |
| `VisaInfo.categoryID` → `Category.CategoryID` | **KEEP** (0 orphans) |
| `WeeklyOff.embassyid` → `Embassy.EmbassyID` | **KEEP** (0 orphans) |

**CountryID references** (`PaxCountryStatus.CountryID`, `StatusHistoryEntry.CountryID`,
`PaxAttestation.CountryID`, `Holiday.countryID`, `VisaInfo.countryID`): the legacy
`country` table is empty and dropped; the country concept lives in `CountryInfo`/
`embassy`. The exact target reference for these columns is **NEEDS CLARIFICATION** —
recorded as a gap for the implementation phase (do not invent a mapping).

## 5. Identity Mapping (FR-004)

| Legacy source | Rows | Target | Role | Dedup priority |
| --- | --- | --- | --- | --- |
| `agents` | 4,218 | `AspNetUsers` + `Agent` | `agt` | 1 (highest) |
| `registration` | 43 | `AspNetUsers` | `guest` | 2 |
| `Udaan_users` | 2,365 | `AspNetUsers` + `AspNetUserRoles` | `su`/`adm`/`emp`/`agt` | 3 |

- Passwords hashed on import (BR-002); never plaintext (AC-004).
- First-source-wins on duplicate username/email (clarification #003); skipped
  duplicates listed in the migration report.
- `Udaan_users` privilege → Identity role mapping per SPEC-0003 data-model.md §2;
  `agt` rows link to `Agent.agentsID` (fixes never-set `session("agentid")`).

## 6. Cleansing Rules (FR-005, each gated by recorded business sign-off)

| Rule | Table | Action |
| --- | --- | --- |
| (a) | `status` | resolve `statusID=508` duplicate description to a single value |
| (b) | `Mainentry.entrytype` | default the 100%-NULL column |
| (c) | `Mainentry.agent` | 6,517 orphans → NULL agent, flagged in report |
| (d) | `Mainentry` dates | clamp junk dates (1970/2207) to valid range |

All other values migrated verbatim (FR-002). Cleansing actions are recorded per table
in the migration report (FR-007).

## 7. State Transitions

- **Append-only tables** (`StatusHistory`, `bighistory`, `sentmails`, `smshistory`):
  migrated without alteration, deletion, or reordering (FR-006, BR-003); no
  UPDATE/DELETE on migrated audit rows.
- No business state transitions are defined by this feature (module features own the
  entry/status lifecycle).

## 8. Data Volume / Scale

- Largest tables: `bighistory` 1.4M, `StatusHistory` 1.3M, `sentmails` 553K,
  `invoicedetail` 358K, `PaxStatus` 359K, `entryDetails` 313K, `Mainentry` 272K,
  `invoice` 271K rows.
- Batch copy (SqlBulkCopy) ordered by FK dependency; indexes added after bulk load;
  target: full migration + validation < 4 hours (NFR-002).

## 9. Traceability

| Spec requirement | Data model element |
| --- | --- |
| FR-001 (52-table disposition) | §3 per-disposition entity tables |
| FR-002 (verbatim preservation) | §5 (only approved cleansing) |
| FR-003 (PK/FK/index reconstruction) | §2, §4 |
| FR-004 (identity import, hashed) | §4 Identity Mapping |
| FR-005 (cleansing rules) | §5 |
| FR-006 (append-only audit) | §6 |
| FR-007 (migration report) | `contracts/migration-report.schema.json` |
| FR-008 (legacy untouched) | §1 |
| FR-009 (validation) | `quickstart.md` §Validation |
| BR-001 (no business drop) | §3.5 |
| BR-004 (COND archived) | §3.3 |