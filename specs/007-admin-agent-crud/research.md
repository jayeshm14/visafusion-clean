# Research: SPEC-0007 Agent/Admin Management, Security-Day Gate, Public Site, and Professional UI Theme

**Date**: 2026-08-17 | **Spec**: [spec.md](spec.md) | **Plan**: [plan.md](plan.md)

All technical-context unknowns were resolved during `/speckit.clarify` (5 questions) and verified against the live codebase this session. This document records the consolidated decisions in Decision / Rationale / Alternatives format.

## R-001 Agent lifecycle: deactivate blocks login, data preserved, reversible

- **Decision**: Deactivation blocks the agent's login and portal access while preserving all business data; reactivation restores login (FR-004, FR-022, AC-016).
- **Rationale**: Constitution data-preservation principle ("preserve all production data") plus security-by-default (a deactivated agent must not keep reading their portal). Reversible lifecycle avoids irreversible admin mistakes.
- **Alternatives considered**: (B) hide-from-lists only — rejected: leaves a deactivated agent with live portal access; (C) deactivate + delete linked account — rejected: destroys identity data; (D) hard-delete unreferenced — rejected: inconsistent with the preserve-everything principle.

## R-002 Agent creation is a single atomic operation (record + `agt` login)

- **Decision**: Creating an agent provisions the agent record and its linked `agt` login together in one operation (FR-001, BR-009, AC-017).
- **Rationale**: The target requires every `agt` user to link to an `Agent.agentsID` (fixes the legacy never-set `session("agentid")`, complete_migration_plan §4.2 line 180). Atomic creation avoids orphan agent records with no login.
- **Alternatives considered**: (B) separate steps — rejected: creates a window of unlinked records; (C) always independent — rejected: contradicts the §4.2 linkage requirement.

## R-003 Theme layout: sidebar + topbar shell, bespoke styling

- **Decision**: Admin/agent surfaces use a sidebar + topbar shell layout — AdminLTE-style structure with fully bespoke Bootstrap 5.3.7 styling (spec §14, session 2026-08-17).
- **Rationale**: The constitution bans AdminLTE's code, not its layout; the legacy shell pages already trained staff on this structure, minimizing retraining while the custom design tokens deliver the professional identity.
- **Alternatives considered**: (B) top-nav only — rejected: loses the familiar navigation structure; (C) defer to UI design — rejected: the layout decision drives the shared layout and every page's acceptance.

## R-004 Public site parity: functional + content parity under the new theme

- **Decision**: Public pages render the same pages, content, and behavior as legacy under the new theme, with known legacy defects fixed (e.g., the AdminLTE demo dropdown on `Default.asp`, §9.2) (FR-010, AC-006).
- **Rationale**: Pixel-perfect replication would conflict with item 9's theme replacement and with the required demo-dropdown removal.
- **Alternatives considered**: (B) pixel-for-pixel — rejected: conflicts with the theme work; (C) content-only — rejected: leaves broken legacy behavior in place.

## R-005 User deletion is deactivation

- **Decision**: User account deletion is implemented as deactivation — login blocked, row and audit references preserved, reversible (FR-023, AC-018). Deactivating an `su` target requires `su` (FR-007).
- **Rationale**: Consistent with R-001 and the constitution's data-preservation principle; audit history (`bighistory.UpdatedBy` strings) stays interpretable.
- **Alternatives considered**: (B) hard-delete (legacy behavior) — rejected: deletes production data; (C) hard-delete when no audit history — rejected: inconsistent and still deletes data.

## R-006 DP-001: `UserManagement` policy corrected to `adm,emp`

- **Decision**: Correct `AuthorizationPolicies.UserManagement` from `adm,su` to `adm,emp` (AuthorizationPolicies.cs line 47). `su` continues to pass via the inherited `adm` role claim (`IdentityClaims.EffectiveRoles`, lines 36-54).
- **Rationale**: The §4.2 matrix (complete_migration_plan.md line 150: "adm/emp only, **not** su-creation") and SPEC-0007 §15 both require `adm,emp`; the existing `adm,su` set excludes `emp` and contradicts the matrix. The matrix is the source of truth.
- **Alternatives considered**: keep `adm,su` and log a deviation — rejected: the matrix is unambiguous and the fix is a one-line correction.

## R-007 Deactivation flag mapping: reuse legacy `agents.Active`

- **Decision**: Map FR-004 deactivation to the existing `agents.Active` column (`Agent.Active`, `string?`) rather than adding a new column. **Convention resolved from legacy source**: `'Y'` = active, `'N'` = inactive — verified via `addnewagents.asp:57` (`rs("active")="Y"` on create), `editdoneagent1.asp:54-57` (`IF request("Active")="Y"` → `'Y'` else `'N'`), `connection.asp:39` (`where Active = 'Y'`). T003 still confirms no anomalous values exist in live `VisaEntry` data; if anomalies are found, produce a gap report (constitution no-assumption rule) before mapping.
- **Rationale**: Data preservation and minimal schema churn — the column already exists and is migrated (SPEC-0004, `Agent` entity).
- **Alternatives considered**: new `IsActive` bit column — rejected: duplicates an existing column; hard-delete — rejected: violates data preservation.

## R-008 Security-day open/close: extend the existing gate service

- **Decision**: Add `OpenDayAsync`/`CloseDayAsync` to the existing `ISecurityGateService` (VisaFusion.Core, single-source rule G7). `OpenDayAsync` inserts a `SecurityDay` row (`Date1`, `Openingtime`, `Openby`); `CloseDayAsync` sets `Closingtime`/`Closedby` on the open row. The existing `EvaluateAsync` (emp-login gate) is unchanged.
- **Rationale**: The gate rule already lives in Core (SPEC-0005 T018); open/close are the write side of the same rule and must share the single source. Legacy behavior: `openForDay.asp` INSERT/DELETE `security`, `closeForDay.asp` UPDATE `security` (deepanalysis §2.4 findings 10-11).
- **Alternatives considered**: separate service — rejected: splits one business rule across two surfaces.

## R-009 Design-token system structure

- **Decision**: A `tokens.css` file of CSS custom properties (colors, typography, spacing, radii) consumed by `theme.css` and all pages; tokens are the single source of visual truth (FR-014, AC-009). WCAG-AA contrast (>= 4.5:1) is enforced at token definition time.
- **Rationale**: CSS custom properties are the lowest-friction token mechanism for a Razor Pages app with self-hosted assets; contrast enforcement at definition time makes AC-010 achievable.
- **Alternatives considered**: Sass/SCSS variables — rejected: adds a build step; design-token JSON + build pipeline — rejected: overkill for this app size.

## R-010 Public site page inventory

- **Decision**: In-scope public pages (spec §8, modernization_plan §6.12): home (`Default.asp`), guest profile (`profile.asp`), contact (`contactus.asp`/`contact.asp`/`contactsendpre.asp`), queries (`queries.asp`/`getqueries.asp`/`querieDetail.asp`), embassy home (`embassyhome.asp`), country info (`CountryInfo.asp`), visa info (`VisaInfo.asp`), forms (`forms.asp` — self-hosted downloads), registration (reuses SPEC-0005 Register flow), subscribe (`subscribe.asp`). The ~700 `updateDDMMYY.asp` static snapshot pages are content migration, out of scope.
- **Rationale**: R-004 parity definition; the demo-dropdown defect on `Default.asp` is removed (AC-006).
- **Alternatives considered**: subset of pages — rejected: "public site parity" means the §6.12 set.