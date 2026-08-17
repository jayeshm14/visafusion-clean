# UI Contract: Professional Theme, Design Tokens, WCAG-AA, UTF-8 (SPEC-0007)

**Date**: 2026-08-17 | **Spec**: [SPEC-0007](../spec.md) | **Research**: [research.md](../research.md) R-003/R-009

This contract defines the UI surface delivered by this feature (spec §14; FR-013..016, AC-008..011). It replaces the AdminLTE shell with a bespoke Bootstrap 5.3.7 theme.

## 1. Layout shell (R-003)

- Admin and agent surfaces use a **sidebar + topbar** shell: left navigation sidebar, top bar with user identity/role, content area.
- Public and auth surfaces use a top-nav layout.
- The shared layout lives in `src/VisaFusion.Web/Pages/Shared/_Layout.cshtml` (currently a minimal placeholder — replaced by this feature).
- AdminLTE assets (`wwwroot/css/adminlte*.css`, `wwwroot/js/adminlte*.js`) are **removed**; no rendered page may reference them (AC-008).

## 2. Design-token system (FR-014, AC-009)

`wwwroot/css/tokens.css` — CSS custom properties, the single source of visual truth:

| Token group | Examples |
|---|---|
| Color | `--vf-color-primary`, `--vf-color-bg`, `--vf-color-text`, `--vf-color-danger`, `--vf-color-success` |
| Typography | `--vf-font-family`, `--vf-font-size-base`, `--vf-font-size-sm`, `--vf-font-size-lg` |
| Spacing | `--vf-space-1`..`--vf-space-6` |
| Radii | `--vf-radius-sm`, `--vf-radius-md`, `--vf-radius-lg` |

- `theme.css` consumes the tokens; pages never hard-code colors/spacing.
- Contrast ≥ 4.5:1 enforced at token definition time (AC-010).

## 3. WCAG-AA baseline (FR-015, AC-010)

- Contrast ≥ 4.5:1 for normal text, ≥ 3:1 for large text/UI components.
- Visible focus indicators on all interactive elements.
- Full keyboard navigation (sidebar, forms, tables).
- All form controls labeled; error messages associated with controls.
- Automated checks (e.g., axe-core) run against every rendered page.

## 4. UTF-8 (FR-016, AC-011)

- Every page declares `<meta charset="utf-8">`; every API response declares `charset=utf-8`.
- Fixes the legacy iso-8859-1 encoding (modernization_plan §8.1).

## 5. Page inventory

| Area | Pages | Legacy source |
|---|---|---|
| Admin | agent list/detail/create/edit, user management, security-day | `viewagent.asp`, `addnewagents.asp`, `editagent.asp`, `addNewUser.asp`, `securityHome.asp` |
| Agent | portal home, own entries, own statuses, own statement, own account | `agentHome.asp`, `listforagents.asp`, `agentpaxStatus.asp`, `agentStatement*`, `AgentAccount.asp` |
| Public | home, contact, queries, embassy, country info, visa info, forms, subscribe, registration | `Default.asp`, `contactus.asp`, `queries.asp`, `embassyhome.asp`, `CountryInfo.asp`, `VisaInfo.asp`, `forms.asp`, `subscribe.asp`, `registration.asp` |

- Public home (`Default.asp` parity) must **not** include the AdminLTE demo dropdown (AC-006, §9.2).
- The ~700 `updateDDMMYY.asp` static snapshot pages are content migration, out of scope.