# Legacy Inventory

**Feature**: SPEC-0002
**Date**: 2026-08-06

## Scope

The legacy Classic ASP application surface — the 585 root `.asp` files, their
module classification, role, data access, and authentication level. This maps
to `@findings/modernization_plan.md` §3.5 (module map) and §3.6 (key workflow
pages), which are the authoritative legacy baseline.

## Entries

### Module map (from findings §3.5)

| Module | Count | Role | Data Access | Auth Level |
|--------|-------|------|-------------|------------|
| Content / update pages | 280 (incl. ~700 dated snapshots) | page | Yes | public/authenticated |
| Agent management | 52 | page | Yes | agent/admin |
| Entry / status management | 19+ | page | Yes | authenticated |
| SMS / email | 16 | page | Yes | authenticated |
| Auth / registration | 14 | page | Yes | public |
| Embassy / forms | 13 | page | Yes | public/authenticated |
| Billing / invoice | 10 | page | Yes | admin |
| Reports | 6 | page | Yes | admin |
| Admin panel | 4 | page | Yes | admin |
| Test / scratch | 16+ | utility | varies | varies |
| Other / miscellaneous | 151 | page | varies | varies |

### Key workflow pages (from findings §3.6)

| Workflow | Pages | Role | Data Access | Auth Level |
|----------|-------|------|-------------|------------|
| New entry (multi-pax, multi-country) | `makeEntry.asp`, `insertEntry.asp` | page | Yes | authenticated |
| Edit entry | `editentry.asp`, `editEntrySubmit.asp`, `editdone.asp`, `editedone.asp` | page | Yes | authenticated |
| Collection (pickup) | `collection.asp`, `collectionform.asp`, `collectionSubmit.asp`, `collectionPaxSubmit.asp`, `BulkCollection.asp`, `BulkcollectionSubmit.asp` | page | Yes | authenticated |
| Status updates | `todayAgentStatus*.asp`, `showStatus.asp`, `status.asp`, `paxStatus.asp` | page | Yes | authenticated |
| Billing | `dailybill.asp`, `invoicesubmit.asp`, `editbill.asp`, `creditnote.asp`, `creditprint.asp`, `dailyprint*.asp`, `dailyVisaFee.asp` | page | Yes | admin |
| Agent self-service | `Agent.asp`, `agentHome.asp`, `listforagents.asp`, `AgentAccount.asp`, `agentStatement*.asp`, `agentinvoice.asp`, `agentpaxStatus.asp`, `emailAgent.asp`, `sendawb*.asp`, `sendSMSToQueue.asp` | page | Yes | agent |
| Day open/close (security gate) | `securityHome.asp`, `openForDay.asp`, `closeForDay.asp`, `employee.asp` | page | Yes | admin |
| Holidays / weekly off | `holidayHome.asp`, `holiday_entry.asp`, `holidaySubmit.asp`, `holidayList.asp`, `WeeklyOffList.asp` | page | Yes | authenticated |
| Content publishing | `dailyupdate.asp`, `viewdailyupdate.asp`, `update.asp` + ~700 `updateDDMMYY.asp` snapshots | page | Yes | authenticated |
| Public site | `Default.asp`, `profile.asp`, `contactus.asp`, `queries.asp`, `embassyhome.asp`, `CountryInfo.asp`, `VisaInfo.asp`, `forms.asp`, `registration.asp` | page | Yes | public |
| Messaging | `composeEmail.asp`, `message.asp`, `mymessage.asp`, `Addtoschedular.asp` | page | Yes | authenticated |
| Task/private work | `tasks.asp`, `listtasks*.asp`, `priwork.asp`, `Tablecah.asp` | page | Yes | authenticated |

### Shared includes (data-access / layout)

| Path | Role | Data Access | Auth Level |
|------|------|-------------|------------|
| `connection.asp` | data-access (DB gateway) | Yes | n/a (included) |
| `connectionweb.asp` | data-access (alternate) | Yes | n/a (included) |
| `top.asp`, `topadmin.asp`, `topAgent.asp` | include (layout) | No | n/a (included) |
| `homeBottom.asp`, `empBottom.asp`, `adminBottom.asp` | include (layout) | No | n/a (included) |
| `left.asp` | include (layout) | No | n/a (included) |

## Notes

- **Module map** is derived from `@findings/modernization_plan.md` §3.5
  (filename-pattern census of the 585 root files) and §3.6 (key workflow pages
  verified by reading source). No new modules were invented.
- **Duplicate / stale codebases** (per findings §3.7) are NOT part of the
  migration surface: `Demo/` (548 ASP), `udaanuma-dev/` (38 ASP), `r&d/` (726
  ASP), `*_old`/`*_bak`/`*test`/`*Temp*` root files, and ~700 `updateDDMMYY.asp`
  snapshots. These are recorded here for completeness but flagged as
  archive-only.
- **Security findings** (from findings §5.4, §9.1): ~13 anonymous DB-write
  endpoints exist (e.g., `insertEntry.asp`, `execute.asp`, `openForDay.asp`,
  `closeForDay.asp`, `editbill.asp`, `deleteUser.asp`, `regsubmit.asp`,
  `usersubmit.asp`). These are recorded as findings, not remediated (spec §6).
- **`connection.asp`** is the de-facto framework (233 includes) — the single
  database connection gateway (findings §3.2).
- No repository-vs-findings discrepancies were identified for the legacy
  surface; see `discrepancies.md`.