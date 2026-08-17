# Data Model: SPEC-0007 Agent/Admin Management, Security-Day Gate, Public Site, and Professional UI Theme

**Date**: 2026-08-17 | **Spec**: [spec.md](spec.md) | **Plan**: [plan.md](plan.md) | **Research**: [research.md](research.md)

No new business tables are introduced (spec §16). This feature operates on the already-migrated `Agent`, `SecurityDay`, and `AspNetUsers` entities and adds lifecycle semantics.

## 1. Agent (existing entity, `agents` table)

Source: `src/VisaFusion.Data/Persistence/Entities/Agent.cs` (SPEC-0004, M). PK `Id` = legacy `agentsID` identity, values preserved.

| Field | Type | Notes |
|---|---|---|
| `Id` | int | PK, legacy `agentsID` |
| `Description`, `Companyname`, `Complexname` | string? | business identity |
| `Street1`, `Street2`, `Area`, `City`, `Pincode` | string? | address |
| `Phoneno`, `Faxno`, `Emailid`, `Smsno` | string? | contact |
| `Directorname`, `DirectorPH`, `AcMgrPH`, `VisaInchargeName`, `VisaInchargePH` | string? | people |
| `Acno`, `Payment` | string? | financial |
| `Active` | string? | **deactivation flag** — convention verified from legacy source: `'Y'` = active, `'N'` = inactive (R-007; `addnewagents.asp:57`, `editdoneagent1.asp:54-57`, `connection.asp:39`) |
| `TAAI`, `TAFI`, `Membership`, `IATA` | string? | memberships |
| `Creationdate` | DateTime? | created |
| `Enteredby` | string? | creator |

### Lifecycle (FR-004, FR-022, AC-016)

```text
Active ──deactivate (adm/su)──▶ Deactivated
  ▲                                │
  └────────reactivate (adm/su)─────┘
```

- Deactivate: set `Active` to the inactive convention **and lock the linked `AspNetUsers` login account in the Identity store** (authentication rejected) — both updated atomically by the service operation (spec §12 F6-mechanism); nothing is deleted.
- Reactivate: restore `Active` and unlock the linked login — atomically.
- Deactivation never deletes the row or any business data (entries, ledger).

## 2. SecurityDay (existing entity, `security` table)

Source: `src/VisaFusion.Data/Persistence/Entities/SecurityDay.cs` (SPEC-0004, M). Surrogate `Id` (bigint identity).

| Field | Type | Notes |
|---|---|---|
| `Id` | long | surrogate PK |
| `Date1` | DateTime? | the working day |
| `Openingtime` | DateTime? | set by open |
| `Openby` | string? | actor username |
| `Closingtime` | DateTime? | set by close; NULL = day open |
| `Closedby` | string? | actor username |

### State transitions (FR-008, BR-002, BR-003)

```text
(no row) ──open (adm/su)──▶ Open (Closingtime IS NULL)
   ▲                            │
   └──────close (adm/su)────────┘
```

- Open: insert row for today with `Openingtime`/`Openby` (legacy `openForDay.asp` INSERT).
- Close: set `Closingtime`/`Closedby` on the open row (legacy `closeForDay.asp` UPDATE).
- Gate rule unchanged: `emp` login allowed only when a row exists with `Closingtime IS NULL` (SPEC-0005 T018, `SecurityGateService.EvaluateAsync`).

## 3. AspNetUsers + Agent link (existing, SPEC-0005)

- `agt` users carry a claim-bound `AgentId` (`IdentityClaims.AgentIdClaimType`), never re-derived from a query string (BR-007, AC-013).
- Agent creation provisions the `Agent` row and the linked `agt` login atomically (BR-009, AC-017).
- User deactivation is the deletion mechanism (FR-023, AC-018): linked login locked, row and audit references preserved, reversible (same Identity-store lock mechanism as agent deactivation).

## 4. Validation rules (spec §17)

- Agent fields: required name (`Companyname` or `Description`), valid contact details.
- User creation: role must be in the whitelist (`adm`, `emp`, `agt`, `guest`); `su` rejected on `POST /api/v1/admin/users`.
- Public forms: required fields, length limits, rate limits.

## 5. Data integrity constraints

- No data deletion anywhere in this feature (constitution G3).
- `Entry.agent` → `Agent.agentsID` nullable FK (6,517 orphans migrate NULL, SPEC-0004) — deactivation must not break this reference.
- All schema-affecting changes reversible; the only anticipated change is the `Active` value convention (R-007), verified against live data first.