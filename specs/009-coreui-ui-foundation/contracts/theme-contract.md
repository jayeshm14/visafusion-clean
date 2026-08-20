# Theme Contract: CoreUI Theme System for VisaFusion (SPEC-0009)

**Date**: 2026-08-19 | **Spec**: [SPEC-0009](../spec.md) | **Research**: [research.md](../research.md) D-7

## 1. Theme states

`data-coreui-theme` attribute on `<html>` ∈ {`light`, `dark`, `auto`}.

| State | Behavior |
|---|---|
| `light` | Light mode (server default) |
| `dark` | Dark mode via `--cui-*` token swap |
| `auto` | Follows `prefers-color-scheme`; resolves to light or dark |

## 2. Persistence

- Key: `visafusion-theme` (localStorage) — **renamed** from the CoreUI
  default `coreui-free-bootstrap-admin-template-theme` (spec FR-006; spec §21
  collision risk).
- `config.js` accepts `?theme=light|dark|auto` URL param → persists to the
  key (adopted from `COREUI_DESIGN_SYSTEM.md` §3).
- `color-modes.js` reads stored value, else `prefers-color-scheme`; sets
  `data-coreui-theme`; dispatches `ColorSchemeChange`; syncs the active
  dropdown item and header icon.

## 3. Server-side default

`_Layout.cshtml` renders `<html lang="en" data-coreui-theme="light">`
server-side; `color-modes.js` upgrades to stored/system preference on load
(spec NFR-005; `COREUI_DESIGN_SYSTEM.md` §3).

## 4. Tokens

VisaFusion rebrand of `--cui-*` tokens via `vf-coreui.css` (research D-2;
`COREUI_DESIGN_SYSTEM.md` §2). Chart theming reads computed token values at
runtime (`coreui.Utils.getStyle('--cui-primary')`) and re-renders on
`ColorSchemeChange` (`COREUI_DESIGN_SYSTEM.md` §2.3).

## 5. Contract rules

- No user data stored client-side beyond the theme preference (spec §12).
- Theme switching is local to the browser — no API calls (spec §15).
- Accessibility: both modes meet the WCAG-AA contrast baseline
  (`COREUI_DESIGN_SYSTEM.md` §7).