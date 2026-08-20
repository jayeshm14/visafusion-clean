---

description: "Dependency-ordered implementation tasks for CoreUI UI Foundation (SPEC-0009)"
---

# Tasks: CoreUI UI Foundation (SPEC-0009)

**Input**: Design documents from `/specs/009-coreui-ui-foundation/`

**Prerequisites**: plan.md (required), spec.md (required), research.md, data-model.md, contracts/, quickstart.md

**Tests**: Test tasks are included â€” the feature spec defines 14 test suites (TS-001..TS-014) and the Addendum Â§16 role-based test matrix.

**Organization**: Tasks are grouped into the 29 mandatory phases requested by the user. Each task carries the full 14-field structure (ID, phase, objective, source evidence, dependencies, affected roles, affected pages, affected components, expected files, constraints, validation, tests, KG update, docs update). Tasks are dependency-ordered; `[P]` marks parallelizable tasks.

## Format

- **Checkbox**: `- [ ]` always
- **Task ID**: T001..T075 in execution order
- **[P]**: Can run in parallel (different files, no dependencies)
- **Phase**: 1..29 (mandatory phase structure)
- **Fields**: objective / source evidence / dependencies / affected roles / affected pages / affected components / expected files / constraints / validation / tests / KG update / docs update

## Path Conventions

- Web app: `src/VisaFusion.Web/` (Razor Pages), tests: `tests/UnitTests/`, `tests/IntegrationTests/`, `tests/FunctionalTests/`
- Evidence docs: `docs/ui/`, `docs/analysis/`, `knowledge-graph/`
- Feature docs: `specs/009-coreui-ui-foundation/`

---

## Phase 1: CoreUI Dependency and Asset Foundation

**Purpose**: Vendor the CoreUI v5.6.0 static assets (CSS, JS, fonts, icons) into the repository so the app has zero runtime CDN/npm dependency.

- [x] T001 Vendor CoreUI v5.6.0 static assets (css/js/fonts) from the reference copy into `src/VisaFusion.Web/wwwroot/lib/coreui/`
  - **Phase**: 1
  - **Objective**: Copy the CoreUI free admin template's compiled CSS/JS/font assets (from `%TEMP%\opencode\coreui-free-bootstrap-admin-template` â€” source commit `d4003cd`) into `wwwroot/lib/coreui/` so the app is self-contained.
  - **Source evidence**: plan.md Phase A (Assets); research.md D-1 (vendored assets, no npm in .NET pipeline); spec.md NFR-001 (no CDN); `COREUI_DEPENDENCY_MAP.md` Â§8 (version pin v5.6.0, commit `d4003cd`); package.json pins `@coreui/coreui` ^5.9.0, `@coreui/icons` ^3.1.0, `@coreui/chartjs` ^4.2.0, `@coreui/utils` ^2.0.2, `chart.js` ^4.5.1, `simplebar` ^6.3.3.
  - **Dependencies**: none
  - **Affected roles**: all (no role-specific behavior)
  - **Affected pages**: none (assets only)
  - **Affected components**: none
  - **Expected files**: `src/VisaFusion.Web/wwwroot/lib/coreui/css/*.css`, `src/VisaFusion.Web/wwwroot/lib/coreui/js/*.js`, `src/VisaFusion.Web/wwwroot/lib/coreui/fonts/*`
  - **Implementation constraints**: Copy only needed assets â€” no demo-only content, no PRO assets, no `examples.css` (spec Â§6; `COREUI_INVENTORY.md` Â§5, Â§9, Â§11). Do not modify any business code.
  - **Validation**: `git ls-files src/VisaFusion.Web/wwwroot/lib` shows tracked assets; grep finds 0 CDN URLs; no `examples.css`/PRO artifacts present.
  - **Test requirements**: `CoreUIAssetTests` (TS-001) â€” asset presence, no CDN references, no demo/PRO content.
  - **Knowledge Graph update**: Add CoreUI asset nodes + edges to `knowledge-graph/kg.json` (FR-013/AC-013).
  - **Documentation update**: `docs/ui/COREUI_DEPENDENCY_MAP.md` Â§8 confirmed against vendored set.

- [x] T002 [P] Vendor CoreUI icon set (`cil-*`/`cif-*` SVGs) into `src/VisaFusion.Web/wwwroot/icons/`
  - **Phase**: 1
  - **Objective**: Copy the CoreUI SVG icon set (524 icons in the reference `src/assets/icons`) into `wwwroot/icons/`, restricted to the icons actually used by VisaFusion pages.
  - **Source evidence**: spec.md FR-012 (CoreUI icon system); `COREUI_INVENTORY.md` Â§5 (icon inventory); mapping Â§7 IconSet; research.md D-8 (14 canonical components incl. IconSet).
  - **Dependencies**: none
  - **Affected roles**: all
  - **Affected pages**: none (assets only)
  - **Affected components**: IconSet
  - **Expected files**: `src/VisaFusion.Web/wwwroot/icons/cil/*.svg`, `src/VisaFusion.Web/wwwroot/icons/cif/*.svg`
  - **Implementation constraints**: Do not copy the full 524-icon set without justification â€” copy only icons referenced by pages/components (spec Â§6). No PRO icons.
  - **Validation**: Icon inventory lists only used icons; `cif-*` flags present for embassy/country pages (mapping Â§7).
  - **Test requirements**: `CoreUIAssetTests` (TS-001) â€” icon set scope check.
  - **Knowledge Graph update**: IconSet node + edges to pages using icons.
  - **Documentation update**: `docs/ui/COREUI_INVENTORY.md` Â§5 icon list updated.

- [x] T003 Create `src/VisaFusion.Web/wwwroot/lib/README.md` documenting the CoreUI source and version pin
  - **Phase**: 1
  - **Objective**: Record the exact provenance of the vendored assets: CoreUI v5.6.0, source commit `d4003cd`, package versions, and the vendoring procedure.
  - **Source evidence**: research.md D-1; `COREUI_DEPENDENCY_MAP.md` Â§8; plan.md Phase A.
  - **Dependencies**: T001, T002
  - **Affected roles**: all
  - **Affected pages**: none
  - **Affected components**: none
  - **Expected files**: `src/VisaFusion.Web/wwwroot/lib/README.md`
  - **Implementation constraints**: Must match the reference copy's `package.json` pins exactly; no invented versions.
  - **Validation**: README content matches `COREUI_DEPENDENCY_MAP.md` Â§8.
  - **Test requirements**: none (documentation artifact).
  - **Knowledge Graph update**: none.
  - **Documentation update**: `wwwroot/lib/README.md` (new).

- [x] T004 Verify the vendored asset set is complete and self-contained (no CDN, no missing files)
  - **Phase**: 1
  - **Objective**: Confirm the app can render CoreUI without any external fetch: all referenced css/js/font/icon files exist locally.
  - **Source evidence**: spec.md NFR-001; research.md D-1; plan.md Phase A.
  - **Dependencies**: T001, T002
  - **Affected roles**: all
  - **Affected pages**: none
  - **Affected components**: none
  - **Expected files**: none (verification only)
  - **Implementation constraints**: Grep `.cshtml` for `https://` asset URLs â€” must be 0.
  - **Validation**: 0 CDN references; every asset referenced by the layout resolves to a committed file.
  - **Test requirements**: `CoreUIAssetTests` (TS-001).
  - **Knowledge Graph update**: none.
  - **Documentation update**: none.

- [x] T004b Standardize terminology across artifacts (C1)
  - **Phase**: 1
  - **Objective**: Standardize "NavigationGroup" (KG) vs "Navigation group" (Spec) vs "Nav group" (Matrix) terminology across all artifacts. Update KG node type from "NavigationGroup" to "NavigationGroup" (keep) but ensure all docs use consistent "Navigation Group" (two words) per Spec FR-002/AC-002. Update `ROLE_NAVIGATION_MATRIX.md` to use "Navigation Group" consistently.
  - **Source evidence**: Spec FR-002/AC-002 (8 groups); KG v2.0 (10 NavigationGroup nodes); `ROLE_NAVIGATION_MATRIX.md` Â§4 (Navigation Group); analysis finding C1.
  - **Dependencies**: T001, T002
  - **Affected roles**: all
  - **Affected pages**: none
  - **Affected components**: none
  - **Expected files**: `knowledge-graph/kg.json` (node type label), `docs/ui/ROLE_NAVIGATION_MATRIX.md`, `specs/009-coreui-ui-foundation/spec.md` (if needed)
  - **Implementation constraints**: Consistent terminology across all artifacts; KG node type stays "NavigationGroup" (camelCase for type) but label uses "Navigation Group".
  - **Validation**: All artifacts use "Navigation Group" (two words) consistently; KG node type unchanged.
  - **Test requirements**: none (terminology audit).
  - **Knowledge Graph update**: KG node labels updated.
  - **Documentation update**: `ROLE_NAVIGATION_MATRIX.md` terminology standardized.

**Checkpoint**: CoreUI assets vendored and self-contained. Phase 2 can begin.

---

## Phase 1.5: CoreUI Asset Tests (IntegrationTests)

**Purpose**: Create the CoreUI asset validation test suite (TS-001).

- [x] T004c Create `CoreUIAssetTests` in `tests/IntegrationTests/`
  - **Phase**: 1.5
  - **Objective**: Add the asset test suite verifying CoreUI assets are present in `wwwroot/`, no CDN references exist, no demo/PRO content, and icon set scope is correct.
  - **Source evidence**: spec.md TS-001; plan.md Phase E2; validation checklist CHK001-CH004.
  - **Dependencies**: T001, T002, T003, T004, T004b
  - **Affected roles**: all
  - **Affected pages**: none (asset tests)
  - **Affected components**: none
  - **Expected files**: `tests/IntegrationTests/CoreUIAssetTests.cs`
  - **Implementation constraints**: Follow existing test conventions; assertions traceable to `COREUI_DEPENDENCY_MAP.md` and `COREUI_INVENTORY.md`.
  - **Validation**: Suite passes; 0 CDN references; assets present.
  - **Test requirements**: TS-001.
  - **Knowledge Graph update**: Test node + edges to asset nodes.
  - **Documentation update**: none.

---

## Phase 2: CoreUI CSS/SCSS and JavaScript Integration

**Purpose**: Integrate CoreUI CSS (with VisaFusion design-token overrides) and JavaScript (theme, tooltips, popovers, toasts) into the app.

- [x] T005 Create `src/VisaFusion.Web/wwwroot/css/vf-coreui.css` with `--cui-*` design-token overrides (DesignTokens)
  - **Phase**: 2
  - **Objective**: Rebrand the CoreUI design tokens to VisaFusion by overriding `--cui-*` CSS variables (colors, spacing, typography, density) in a single override stylesheet.
  - **Source evidence**: spec.md FR-006 (theme system), NFR-005; research.md D-2 (token overrides); `COREUI_DESIGN_SYSTEM.md` Â§2 (tokens); data-model.md (DesignTokens component); contracts/theme-contract.md.
  - **Dependencies**: T001
  - **Affected roles**: all
  - **Affected pages**: all (via layout)
  - **Affected components**: DesignTokens, ComponentStyles
  - **Expected files**: `src/VisaFusion.Web/wwwroot/css/vf-coreui.css`
  - **Implementation constraints**: No hard-coded brand colors outside tokens; no bespoke `--vf-*` tokens (research D-2). Do not modify `theme.css`/`tokens.css` business styles in this task.
  - **Validation**: Grep pages for hard-coded colors bypassing tokens â€” 0 matches.
  - **Test requirements**: `CoreUIThemeTests` (TS-004) â€” token presence and application.
  - **Knowledge Graph update**: DesignTokens node + edge to `vf-coreui.css`.
  - **Documentation update**: `docs/ui/COREUI_DESIGN_SYSTEM.md` Â§2 token table.

- [x] T006 [P] Create `src/VisaFusion.Web/wwwroot/js/vf-coreui.js` bundling CoreUI JS behaviors (config, color-modes, tooltips, popovers, toasts, main)
  - **Phase**: 2
  - **Objective**: Port the reference copy's `src/js/` behaviors (config.js, color-modes.js, tooltips.js, popovers.js, toasts.js, main.js) into a single app JS file, adapted to VisaFusion.
  - **Source evidence**: plan.md Phase A; research.md D-1; `COREUI_INVENTORY.md` Â§9 (JS files); reference copy `src/js/` listing.
  - **Dependencies**: T001
  - **Affected roles**: all
  - **Affected pages**: all (via layout)
  - **Affected components**: ToastHost (toast wiring)
  - **Expected files**: `src/VisaFusion.Web/wwwroot/js/vf-coreui.js`
  - **Implementation constraints**: No `widgets.js`/`charts.js` demo content in this bundle (charts handled in Phase 15); no demo-only code.
  - **Validation**: JS loads without console errors on a rendered page.
  - **Test requirements**: `CoreUIShellTests` (TS-003) â€” JS asset loads.
  - **Knowledge Graph update**: JS asset node + edges.
  - **Documentation update**: `docs/ui/COREUI_INVENTORY.md` Â§9 JS inventory.

- [x] T006b Verify tooltip/popover necessity (C6)
  - **Phase**: 2
  - **Objective**: Verify if `tooltips.js` and `popovers.js` are actually needed by VisaFusion pages. Search all `.cshtml` for `data-coreui-toggle="tooltip"` and `data-coreui-toggle="popover"`; if zero matches, exclude from `vf-coreui.js` bundle to reduce payload.
  - **Source evidence**: `COREUI_DEPENDENCY_MAP.md` Â§5 (tooltips/popovers optional); `COREUI_INVENTORY.md` Â§6; plan.md Phase A3.
  - **Dependencies**: T006
  - **Affected roles**: all
  - **Affected pages**: all
  - **Affected components**: none
  - **Expected files**: none (verification; may modify `vf-coreui.js` bundle)
  - **Implementation constraints**: Only include JS that is actually used; `COREUI_DEPENDENCY_MAP.md` Â§9 lists them as optional.
  - **Validation**: Grep for tooltip/popover toggles = 0 â†’ exclude from bundle; >0 â†’ include with justification.
  - **Test requirements**: none (verification).
  - **Knowledge Graph update**: none.
  - **Documentation update**: `docs/ui/COREUI_DEPENDENCY_MAP.md` Â§9 updated with decision.

- [x] T006c Verify JS bundling approach (D4)
  - **Phase**: 2
  - **Objective**: Verify the single `vf-coreui.js` bundle approach works with CoreUI's module loading expectations. CoreUI template loads JS as separate modules via `scripts.pug` block scripts; bundling may break module loading order or CSP. Test that all CoreUI components (Sidebar, Dropdown, Modal, Toast, Tooltip, Popover) initialize correctly from the bundle.
  - **Source evidence**: `COREUI_INVENTORY.md` Â§6 (separate module loads); `COREUI_DEPENDENCY_MAP.md` Â§4 (page-level asset load contract); plan.md Phase A3.
  - **Dependencies**: T006, T006b
  - **Affected roles**: all
  - **Affected pages**: all
  - **Affected components**: all JS-dependent components
  - **Expected files**: none (verification; may split bundle back to separate files)
  - **Implementation constraints**: If bundling breaks CoreUI initialization, revert to separate files matching `scripts.pug` pattern.
  - **Validation**: All CoreUI components initialize without console errors; no CSP violations.
  - **Test requirements**: `CoreUIShellTests` (TS-003).
  - **Knowledge Graph update**: none.
  - **Documentation update**: `docs/ui/COREUI_DEPENDENCY_MAP.md` Â§4 updated with decision.

- [x] T007 Implement the theme system with the `visafusion-theme` persistence key and server-side light default
  - **Phase**: 2
  - **Objective**: Implement light/dark/auto theme switching using the CoreUI color-modes pattern, persisting under `visafusion-theme` (renamed from the CoreUI default key), with the server rendering light by default.
  - **Source evidence**: spec.md FR-006, NFR-005; research.md D-3; `COREUI_DESIGN_SYSTEM.md` Â§3; contracts/theme-contract.md; plan.md Phase B.
  - **Dependencies**: T006
  - **Affected roles**: all
  - **Affected pages**: all
  - **Affected components**: DesignTokens
  - **Expected files**: `src/VisaFusion.Web/wwwroot/js/vf-coreui.js` (theme init), `src/VisaFusion.Web/Pages/_Layout.cshtml` (server-side `data-coreui-theme="light"`)
  - **Implementation constraints**: Old key `coreui-free-bootstrap-admin-template-theme` must not be used; server default light; only `visafusion-theme` persisted client-side (spec Â§12).
  - **Validation**: Theme toggle persists across reload; server renders light; localStorage contains only `visafusion-theme`.
  - **Test requirements**: `CoreUIThemeTests` (TS-004).
  - **Knowledge Graph update**: Theme node + edges.
  - **Documentation update**: `docs/ui/COREUI_DESIGN_SYSTEM.md` Â§3.

- [x] T008 Wire the CoreUI CSS/JS into `src/VisaFusion.Web/Pages/_Layout.cshtml`
  - **Phase**: 2
  - **Objective**: Add the vendored CoreUI CSS, `vf-coreui.css`, and `vf-coreui.js` includes to the layout head/foot.
  - **Source evidence**: plan.md Phase B; spec.md NFR-001; contracts/ui-contract.md (shell contract).
  - **Dependencies**: T005, T006, T007
  - **Affected roles**: all
  - **Affected pages**: all
  - **Affected components**: none (layout wiring)
  - **Expected files**: `src/VisaFusion.Web/Pages/_Layout.cshtml`
  - **Implementation constraints**: Preserve existing `theme.css`/`tokens.css` includes; do not remove `vf-skip-link`; no CDN.
  - **Validation**: Page renders with CoreUI styles applied.
  - **Test requirements**: `CoreUIShellTests` (TS-003).
  - **Knowledge Graph update**: Layout node edges to asset nodes.
  - **Documentation update**: none.

- [x] T008b Create `CoreUIThemeTests` in `tests/FunctionalTests/`
  - **Phase**: 2
  - **Objective**: Add the theme test suite verifying light/dark/auto switching, `visafusion-theme` persistence key, server-side light default, and theme survival across reloads.
  - **Source evidence**: spec.md TS-007; plan.md Phase E3; `COREUI_DESIGN_SYSTEM.md` Â§3; contracts/theme-contract.md.
  - **Dependencies**: T005, T007, T008
  - **Affected roles**: all
  - **Affected pages**: all
  - **Affected components**: DesignTokens
  - **Expected files**: `tests/FunctionalTests/CoreUIThemeTests.cs`
  - **Implementation constraints**: Follow existing test conventions; verify localStorage contains only `visafusion-theme`.
  - **Validation**: Theme toggle persists; server renders light; no old key used.
  - **Test requirements**: TS-007.
  - **Knowledge Graph update**: Test node + edges to theme nodes.
  - **Documentation update**: none.

**Checkpoint**: CoreUI CSS/JS integrated. Phase 3 can begin.

---

## Phase 3: VisaFusion Application Shell

**Purpose**: Rebuild the application shell (`_Layout.cshtml`) as the CoreUI composition (Header, Sidebar, Breadcrumb, PageHeader, content, Footer) while preserving the dual-mode shell selection.

- [x] T009 Update `src/VisaFusion.Web/Pages/_Layout.cshtml` to the CoreUI shell composition preserving dual-mode selection
  - **Phase**: 3
  - **Objective**: Restructure the layout to the CoreUI composition (header, sidebar, breadcrumb, page header, content wrapper, footer) while keeping the existing dual-mode rule `useSidebar = ViewData["UseSidebar"] ?? isAuthenticated` (line 20) and the `vf-skip-link`.
  - **Source evidence**: spec.md FR-003 (shell), AC-002; research.md D-6 (dual-mode preserved); plan.md Phase B; contracts/ui-contract.md; Addendum Â§6 (composition).
  - **Dependencies**: T008
  - **Affected roles**: all
  - **Affected pages**: all
  - **Affected components**: none (shell)
  - **Expected files**: `src/VisaFusion.Web/Pages/_Layout.cshtml`
  - **Implementation constraints**: Dual-mode selection logic unchanged; anonymous pages render the standalone (no-sidebar) shell; authenticated pages render the sidebar shell; no business logic changes.
  - **Validation**: Anonymous vs authenticated rendering matches the dual-mode rule; shell composition present.
  - **Test requirements**: `CoreUIShellTests` (TS-003); shell-mode tests.
  - **Knowledge Graph update**: Shell node + edges to partials.
  - **Documentation update**: none.

- [x] T010 Create `src/VisaFusion.Web/Pages/Shared/_PageHeader.cshtml` (CoreUI page header)
  - **Phase**: 3
  - **Objective**: Create the page-header partial (title + breadcrumb slot) used by the shell composition.
  - **Source evidence**: spec.md FR-003; contracts/ui-contract.md; Addendum Â§6.
  - **Dependencies**: T009
  - **Affected roles**: all
  - **Affected pages**: all
  - **Affected components**: none (shell partial)
  - **Expected files**: `src/VisaFusion.Web/Pages/Shared/_PageHeader.cshtml`
  - **Implementation constraints**: Breadcrumb slot renders `_Breadcrumb` (implemented in Phase 8) â€” render a placeholder until then.
  - **Validation**: Page header renders on a sample page.
  - **Test requirements**: `CoreUIShellTests` (TS-003).
  - **Knowledge Graph update**: PageHeader node + edges.
  - **Documentation update**: none.

- [x] T011 [P] Create minimal `_Header.cshtml`, `_Sidebar.cshtml`, `_Breadcrumb.cshtml`, `_Footer.cshtml` partials so the shell renders
  - **Phase**: 3
  - **Objective**: Create the four shell partials in minimal form (placeholder content) so the layout renders end-to-end; full implementations land in Phases 4, 5, 8, 9.
  - **Source evidence**: plan.md Phase B; contracts/ui-contract.md; Addendum Â§6.
  - **Dependencies**: T009
  - **Affected roles**: all
  - **Affected pages**: all
  - **Affected components**: none (shell partials)
  - **Expected files**: `src/VisaFusion.Web/Pages/Shared/_Header.cshtml`, `_Sidebar.cshtml`, `_Breadcrumb.cshtml`, `_Footer.cshtml`
  - **Implementation constraints**: Minimal placeholders only â€” no invented content; footer placeholder must not include CoreUI credit links.
  - **Validation**: Layout renders with all four partials present.
  - **Test requirements**: `CoreUIShellTests` (TS-003).
  - **Knowledge Graph update**: Partial nodes + edges.
  - **Documentation update**: none.

- [ ] T012 Create `CoreUIShellTests` in `tests/UnitTests/` (or `tests/FunctionalTests/` per existing convention)
  - **Phase**: 3
  - **Objective**: Add the shell test suite covering layout composition, dual-mode selection, and partial presence.
  - **Source evidence**: spec.md TS-003; plan.md Phase E; Addendum Â§16.
  - **Dependencies**: T009, T010, T011
  - **Affected roles**: all
  - **Affected pages**: all
  - **Affected components**: none
  - **Expected files**: `tests/UnitTests/CoreUIShellTests.cs` (path per existing test convention)
  - **Implementation constraints**: Follow the existing test project conventions (naming, DI, assertions) â€” match patterns already in the repo.
  - **Validation**: New suite passes.
  - **Test requirements**: TS-003.
  - **Knowledge Graph update**: Test node + edges to shell.
  - **Documentation update**: none.

- [ ] T012b Create `CoreUIPageRenderingTests` in `tests/FunctionalTests/`
  - **Phase**: 3
  - **Objective**: Add the UI page rendering test suite verifying every native page in `COREUI_VISA_FUSION_MAPPING.md` renders with its mapped CoreUI components and preserved functional composition (AC-005).
  - **Source evidence**: spec.md TS-006; plan.md Phase E3; validation checklist CHK026.
  - **Dependencies**: T009, T010, T011, T024
  - **Affected roles**: all 5
  - **Affected pages**: all 41 native pages
  - **Affected components**: all 14 canonical components
  - **Expected files**: `tests/FunctionalTests/CoreUIPageRenderingTests.cs`
  - **Implementation constraints**: Follow existing test conventions; each page tested against its mapping row.
  - **Validation**: All 41 pages render with correct CoreUI components.
  - **Test requirements**: TS-006.
  - **Knowledge Graph update**: Test nodes + edges to page/component nodes.
  - **Documentation update**: none.

**Checkpoint**: Shell renders end-to-end. Phases 4, 5, 8, 9 can proceed (in parallel where staffed).

---

## Phase 4: Header

**Purpose**: Implement the CoreUI header (toggler, theme dropdown, avatar menu) with VisaFusion content.

- [x] T013 Implement `src/VisaFusion.Web/Pages/Shared/_Header.cshtml` (CoreUI header: toggler, theme dropdown, avatar menu)
  - **Phase**: 4
  - **Objective**: Replace the placeholder header with the CoreUI header pattern: sidebar toggler, theme dropdown, avatar dropdown showing user name + role.
  - **Source evidence**: spec.md FR-003; `COREUI_INVENTORY.md` Â§8 (header row); contracts/ui-contract.md; Addendum Â§6.
  - **Dependencies**: T011
  - **Affected roles**: all authenticated roles (agt, emp, adm, su)
  - **Affected pages**: all authenticated pages
  - **Affected components**: none (shell partial)
  - **Expected files**: `src/VisaFusion.Web/Pages/Shared/_Header.cshtml`
  - **Implementation constraints**: User name + role display preserved from the current header; no new data access; no invented menu items.
  - **Validation**: Header renders toggler, theme dropdown, avatar menu with user name + role.
  - **Test requirements**: `CoreUIShellTests` (TS-003).
  - **Knowledge Graph update**: Header node + edges.
  - **Documentation update**: none.

- [x] T014 Implement and document the role badge display rule (first role claim) in the header
  - **Phase**: 4
  - **Objective**: Define and implement the role-badge display rule for principals with multiple roles (e.g., su implies adm) â€” display the first role claim â€” and document it in `ROLE_NAVIGATION_MATRIX.md` Â§5.5.
  - **Source evidence**: `ROLE_NAVIGATION_MATRIX.md` Â§5.5 (display rule); spec.md FR-008 (su implies adm); clarify 2026-08-19.
  - **Dependencies**: T013
  - **Affected roles**: su (multi-claim principals)
  - **Affected pages**: all authenticated pages
  - **Affected components**: none (header partial)
  - **Expected files**: `src/VisaFusion.Web/Pages/Shared/_Header.cshtml`, `docs/ui/ROLE_NAVIGATION_MATRIX.md`
  - **Implementation constraints**: Display rule must be consistent; no authorization decisions in the header (constitution XV).
  - **Validation**: su principal shows the documented role badge; rule documented in the matrix.
  - **Test requirements**: `RoleAwareNavigationTests` (TS-002) â€” role display.
  - **Knowledge Graph update**: Role-badge rule node.
  - **Documentation update**: `docs/ui/ROLE_NAVIGATION_MATRIX.md` Â§5.5.

**Checkpoint**: Header complete.

---

## Phase 5: Sidebar

**Purpose**: Implement the CoreUI sidebar (brand, data-driven nav, unfoldable toggler, mobile close).

- [x] T015 Implement `src/VisaFusion.Web/Pages/Shared/_Sidebar.cshtml` (CoreUI sidebar: brand, data-driven nav, unfoldable toggler, mobile close)
  - **Phase**: 5
  - **Objective**: Replace the placeholder sidebar with the CoreUI sidebar pattern: brand, nav container, unfoldable toggler, mobile close button. Nav content is rendered from the `RoleAwareNavigation` service (Phase 6) â€” render a placeholder nav until then.
  - **Source evidence**: spec.md FR-003; `COREUI_INVENTORY.md` Â§8 (sidebar row); contracts/ui-contract.md; Addendum Â§6.
  - **Dependencies**: T011
  - **Affected roles**: all authenticated roles
  - **Affected pages**: all authenticated pages
  - **Affected components**: none (shell partial)
  - **Expected files**: `src/VisaFusion.Web/Pages/Shared/_Sidebar.cshtml`
  - **Implementation constraints**: No hard-coded nav tree in the partial (spec FR-003; Addendum Â§5); no authorization logic in the partial.
  - **Validation**: Sidebar renders brand + CoreUI behaviors; nav placeholder until Phase 6.
  - **Test requirements**: `CoreUIShellTests` (TS-003).
  - **Knowledge Graph update**: Sidebar node + edges.
  - **Documentation update**: none.

**Checkpoint**: Sidebar complete (nav content lands in Phase 6).

---

## Phase 6: Role-Aware Navigation

**Purpose**: Centralize navigation in a `RoleAwareNavigation` service exposing the 8 navigation groups with per-role visibility.

- [x] T016 Create the `RoleAwareNavigation` service in `src/VisaFusion.Web/` (nav model: 8 groups, per-role visibility)
  - **Phase**: 6
  - **Objective**: Implement the centralized navigation service exposing exactly 8 groups (Public, Account, Agent Portal, Reporting, Admin, Employee, Billing, Notifications) with per-role menu visibility per `ROLE_NAVIGATION_MATRIX.md` Â§4.
  - **Source evidence**: spec.md FR-003, AC-002; `ROLE_NAVIGATION_MATRIX.md` Â§4 (8 groups); research.md D-4; data-model.md (RoleAwareNavigation); Addendum Â§5; clarify 2026-08-19 (8 groups, not 10).
  - **Dependencies**: T015
  - **Affected roles**: all 5 (Guest, agt, emp, adm, su)
  - **Affected pages**: all
  - **Affected components**: RoleAwareNavigation
  - **Expected files**: `src/VisaFusion.Web/Services/RoleAwareNavigation.cs` (path per existing service convention)
  - **Implementation constraints**: Exactly 8 groups; visibility driven by role config, not authorization checks (constitution XV); no invented menus â€” every menu/route must exist in the matrix. **Must render full Admin menu (Agents, Users, Holidays, Content Update, Security Day) for adm/su roles** (ROLE_NAVIGATION_MATRIX.md Â§5.2).
  - **Validation**: Service returns the 8 groups; per-role menu sets match the matrix; **full Admin menu (5 modules) renders for adm/su**.
  - **Test requirements**: `RoleAwareNavigationTests` (TS-002).
  - **Knowledge Graph update**: RoleAwareNavigation node + edges to roles, pages, menus (FR-013).
  - **Documentation update**: none.

- [ ] T016b Document Navigation service location decision (C7)
  - **Phase**: 6
  - **Objective**: Document in an ADR or `research.md` why the `RoleAwareNavigation` service lives in `VisaFusion.Web` (presentation layer) rather than `VisaFusion.Core` (shared kernel), given that navigation structure is presentation-only per Constitution Principle IV.
  - **Source evidence**: plan.md Phase B2; Constitution Principle IV (CoreUI governs presentation only); Addendum Â§5.
  - **Dependencies**: T016
  - **Affected roles**: all
  - **Affected pages**: none
  - **Affected components**: RoleAwareNavigation
  - **Expected files**: `specs/009-coreui-ui-foundation/research.md` (updated) or `/adr/` ADR file
  - **Implementation constraints**: Decision must be documented with rationale; navigation is presentation-only, not business logic.
  - **Validation**: Decision documented with clear rationale.
  - **Test requirements**: none (documentation).
  - **Knowledge Graph update**: Decision node.
  - **Documentation update**: `research.md` or ADR.

- [x] T017 Wire `_Sidebar.cshtml` to render nav from `RoleAwareNavigation`
  - **Phase**: 6
  - **Objective**: Replace the Phase 5 placeholder nav with rendering driven by the `RoleAwareNavigation` service.
  - **Source evidence**: spec.md FR-003; Addendum Â§5; research.md D-4.
  - **Dependencies**: T016
  - **Affected roles**: all 5
  - **Affected pages**: all
  - **Affected components**: RoleAwareNavigation, Sidebar
  - **Expected files**: `src/VisaFusion.Web/Pages/Shared/_Sidebar.cshtml`
  - **Implementation constraints**: 0 per-page nav sections remain (grep `@section SidebarNav` = 0); no hard-coded nav.
  - **Validation**: Sidebar renders role-appropriate nav for each role.
  - **Test requirements**: `RoleAwareNavigationTests` (TS-002).
  - **Knowledge Graph update**: Sidebarâ†’RoleAwareNavigation edge.
  - **Documentation update**: none.

- [ ] T018 Create `RoleAwareNavigationTests` in `tests/UnitTests/`
  - **Phase**: 6
  - **Objective**: Add the navigation test suite: 8 groups, per-role visibility, menu/submenu correctness, no orphan links.
  - **Source evidence**: spec.md TS-002; Addendum Â§16; `ROLE_NAVIGATION_MATRIX.md` Â§4.
  - **Dependencies**: T016
  - **Affected roles**: all 5
  - **Affected pages**: none (service tests)
  - **Affected components**: RoleAwareNavigation
  - **Expected files**: `tests/UnitTests/RoleAwareNavigationTests.cs`
  - **Implementation constraints**: Follow existing test conventions; every assertion traceable to the matrix.
  - **Validation**: Suite passes; group count = 8.
  - **Test requirements**: TS-002.
  - **Knowledge Graph update**: Test node + edges.
  - **Documentation update**: none.

- [ ] T018b Resolve Public pages navigation exposure (owner decision)
  - **Phase**: 6
  - **Objective**: Obtain owner decision on whether the 9 Public pages (Home, Visa Info, Embassy, Country Info, Daily Update, Queries, Contact, Subscribe, Register) get a top-nav menu in the shell or remain URL-only reachable. Document decision in `ROLE_NAVIGATION_MATRIX.md` Â§5.1 and update `RoleAwareNavigation` service accordingly.
  - **Source evidence**: `ROLE_NAVIGATION_MATRIX.md` Â§5.1 (unresolved #1); spec.md FR-003; Addendum Â§5.
  - **Dependencies**: T016
  - **Affected roles**: Guest
  - **Affected pages**: 9 Public pages (per mapping Â§1)
  - **Affected components**: RoleAwareNavigation
  - **Expected files**: `docs/ui/ROLE_NAVIGATION_MATRIX.md` (updated Â§5.1), `src/VisaFusion.Web/Services/RoleAwareNavigation.cs` (if menu added)
  - **Implementation constraints**: Decision must be documented; if menu added, must follow centralized nav model (no hard-coded per-page nav).
  - **Validation**: Owner decision recorded; Public pages either have nav entry or documented as URL-only.
  - **Test requirements**: `RoleAwareNavigationTests` (TS-002) â€” verify decision implemented.
  - **Knowledge Graph update**: Decision node + edges.
  - **Documentation update**: `ROLE_NAVIGATION_MATRIX.md` Â§5.1.

**Checkpoint**: Navigation centralized and tested. Phases 7 and 8 can proceed.

---

## Phase 7: Menus and Submenus

**Purpose**: Complete the menu and submenu data (Reporting Today/Daily, Admin Agents/Users) in the navigation model.

- [x] T019 Add menu and submenu data to the navigation model (Reporting Today/Daily, Admin Agents/Users)
  - **Phase**: 7
  - **Objective**: Populate the submenu groups (Reporting: Today, Daily; Admin: Agents, Users) with their children per `ROLE_NAVIGATION_MATRIX.md` Â§4.
  - **Source evidence**: spec.md FR-003; `ROLE_NAVIGATION_MATRIX.md` Â§4 (submenu column); clarify 2026-08-19.
  - **Dependencies**: T016
  - **Affected roles**: agt, adm, su
  - **Affected pages**: Reporting and Admin pages
  - **Affected components**: RoleAwareNavigation
  - **Expected files**: `src/VisaFusion.Web/Services/RoleAwareNavigation.cs`
  - **Implementation constraints**: Submenu children must match the matrix exactly; no invented submenus.
  - **Validation**: Submenu groups render with correct children per role.
  - **Test requirements**: `RoleAwareNavigationTests` (TS-002).
  - **Knowledge Graph update**: Menu/submenu nodes + edges.
  - **Documentation update**: none.

- [ ] T020 Add menu/submenu visibility tests to `RoleAwareNavigationTests`
  - **Phase**: 7
  - **Objective**: Extend the nav test suite with submenu visibility rules (submenu never visible to a role that cannot see its parent).
  - **Source evidence**: spec.md TS-002; `ROLE_NAVIGATION_MATRIX.md` Â§4.
  - **Dependencies**: T019
  - **Affected roles**: all 5
  - **Affected pages**: none
  - **Affected components**: RoleAwareNavigation
  - **Expected files**: `tests/UnitTests/RoleAwareNavigationTests.cs`
  - **Implementation constraints**: Follow existing test conventions.
  - **Validation**: Suite passes.
  - **Test requirements**: TS-002.
  - **Knowledge Graph update**: none.
  - **Documentation update**: none.

**Checkpoint**: Menus and submenus complete.

---

## Phase 8: Breadcrumbs

**Purpose**: Derive breadcrumbs from the role-specific navigation hierarchy (Role â†’ Module â†’ Feature â†’ Page).

- [x] T021 Create the breadcrumb service deriving breadcrumbs from the navigation hierarchy
  - **Phase**: 8
  - **Objective**: Implement a service that derives breadcrumb trails from the `RoleAwareNavigation` hierarchy (Role â†’ Module â†’ Feature â†’ Page), not from URL segments.
  - **Source evidence**: spec.md FR-003; Addendum Â§12; research.md D-5; contracts/ui-contract.md.
  - **Dependencies**: T016
  - **Affected roles**: all 5
  - **Affected pages**: all
  - **Affected components**: RoleAwareNavigation, Breadcrumb
  - **Expected files**: `src/VisaFusion.Web/Services/BreadcrumbService.cs` (path per existing convention)
  - **Implementation constraints**: Breadcrumbs must follow the nav hierarchy; no URL-segment derivation (Addendum Â§12).
  - **Validation**: Breadcrumb trail matches the nav hierarchy for sample pages.
  - **Test requirements**: `RoleAwareNavigationTests` (TS-002) â€” breadcrumb derivation.
  - **Knowledge Graph update**: Breadcrumb node + edges.
  - **Documentation update**: none.

- [x] T022 Implement `_Breadcrumb.cshtml` and wire it into the layout/page header
  - **Phase**: 8
  - **Objective**: Replace the Phase 3 placeholder breadcrumb with the real partial rendering the service-derived trail.
  - **Source evidence**: spec.md FR-003; Addendum Â§12; contracts/ui-contract.md.
  - **Dependencies**: T021
  - **Affected roles**: all 5
  - **Affected pages**: all
  - **Affected components**: Breadcrumb, PageHeader
  - **Expected files**: `src/VisaFusion.Web/Pages/Shared/_Breadcrumb.cshtml`
  - **Implementation constraints**: Consistent hierarchy and styling across all migrated pages.
  - **Validation**: Breadcrumbs render consistently on Agent, Reporting, Admin, Public pages.
  - **Test requirements**: `CoreUIShellTests` (TS-003).
  - **Knowledge Graph update**: Breadcrumb partial node.
  - **Documentation update**: none.

**Checkpoint**: Breadcrumbs complete.

---

## Phase 9: Footer

**Purpose**: Implement the VisaFusion footer (no CoreUI credit links).

- [x] T023 Implement `src/VisaFusion.Web/Pages/Shared/_Footer.cshtml` with VisaFusion branding
  - **Phase**: 9
  - **Objective**: Replace the Phase 3 placeholder footer with the final VisaFusion footer; ensure 0 CoreUI credit links.
  - **Source evidence**: `COREUI_INVENTORY.md` Â§8 (footer row); spec.md FR-003; contracts/ui-contract.md.
  - **Dependencies**: T011
  - **Affected roles**: all
  - **Affected pages**: all
  - **Affected components**: none (shell partial)
  - **Expected files**: `src/VisaFusion.Web/Pages/Shared/_Footer.cshtml`
  - **Implementation constraints**: No `coreui.io`/credit links; VisaFusion branding only.
  - **Validation**: Grep footer for `coreui.io` â€” 0 matches.
  - **Test requirements**: `CoreUIShellTests` (TS-003).
  - **Knowledge Graph update**: Footer node.
  - **Documentation update**: none.

**Checkpoint**: Footer complete.

---

## Phase 10: Reusable CoreUI-Based VisaFusion Components

**Purpose**: Create the 14 canonical reusable components as single implementations.

- [X] T024 Create the canonical component partials in `src/VisaFusion.Web/Components/` (DataTable, FormCard, AuthCard, ErrorPage, InfoPage, PublicLanding, PublicQueryForm, ConfirmModal, ToastHost)
  - **Phase**: 10
  - **Objective**: Create the reusable component partials (9 of the 14 canonical components that are partials; RoleAwareNavigation, RoleDashboard, DesignTokens, ComponentStyles, IconSet are covered by other tasks) with one implementation each.
  - **Source evidence**: spec.md FR-007 (14 canonical components); research.md D-8; data-model.md (component catalog); contracts/ui-contract.md; mapping Â§1â€“Â§7.
  - **Dependencies**: T008
  - **Affected roles**: all 5
  - **Affected pages**: all (consumed by pages)
  - **Affected components**: DataTable, FormCard, AuthCard, ErrorPage, InfoPage, PublicLanding, PublicQueryForm, ConfirmModal, ToastHost
  - **Expected files**: `src/VisaFusion.Web/Components/_DataTable.cshtml`, `_FormCard.cshtml`, `_AuthCard.cshtml`, `_ErrorPage.cshtml`, `_InfoPage.cshtml`, `_PublicLanding.cshtml`, `_PublicQueryForm.cshtml`, `_ConfirmModal.cshtml`, `_ToastHost.cshtml`
  - **Implementation constraints**: One canonical implementation per component (constitution XIV); no per-role component copies; components must support role-aware behavior via config, not duplication (Addendum Â§9).
  - **Validation**: 14/14 components exist; 0 duplicated implementations (grep).
  - **Test requirements**: `CoreUIShellTests` (TS-003) â€” component presence.
  - **Knowledge Graph update**: Component nodes + edges (FR-013).
  - **Documentation update**: `docs/ui/COREUI_VISA_FUSION_MAPPING.md` component rows.

- [X] T024b Create `src/VisaFusion.Web/Components/_RoleDashboard.cshtml` (RoleDashboard component)
  - **Phase**: 10
  - **Objective**: Create the canonical RoleDashboard component partial for role-specific landing/dashboard card layouts (KPI cards, charts, progress). This is the **single definition** of the RoleDashboard component; Phases 14â€“15 (T032â€“T038) **consume** this component.
  - **Source evidence**: spec.md FR-007 (RoleDashboard); research.md D-8; data-model.md (component catalog); plan.md Phase C1; mapping Â§1â€“Â§7.
  - **Dependencies**: T008
  - **Affected roles**: agt, emp, adm, su
  - **Affected pages**: all role landing/dashboard pages
  - **Affected components**: RoleDashboard
  - **Expected files**: `src/VisaFusion.Web/Components/_RoleDashboard.cshtml`
  - **Implementation constraints**: One canonical implementation (constitution XIV); supports role-aware behavior via config (cards, charts, progress) not duplication (Addendum Â§9); uses CoreUI Cards Â§3.1, Progress Â§3.4, Charts Â§7.1 patterns.
  - **Validation**: Component renders CoreUI dashboard patterns; consumed by T032â€“T038.
  - **Test requirements**: `CoreUIShellTests` (TS-003) â€” component presence.
  - **Knowledge Graph update**: RoleDashboard component node + edges (FR-013).
  - **Documentation update**: `docs/ui/COREUI_VISA_FUSION_MAPPING.md` component rows.

- [X] T025 [P] Create `src/VisaFusion.Web/wwwroot/css/vf-component-styles.css` (ComponentStyles)
  - **Phase**: 10
  - **Objective**: Create the component-level stylesheet for the canonical components (consistent spacing, density, presentation) layered on the design tokens.
  - **Source evidence**: spec.md FR-007; research.md D-2; data-model.md (ComponentStyles); contracts/theme-contract.md.
  - **Dependencies**: T005
  - **Affected roles**: all
  - **Affected pages**: all
  - **Affected components**: ComponentStyles
  - **Expected files**: `src/VisaFusion.Web/wwwroot/css/vf-component-styles.css`
  - **Implementation constraints**: Uses `--cui-*` tokens only; no hard-coded colors.
  - **Validation**: Component styles apply consistently.
  - **Test requirements**: `CoreUIThemeTests` (TS-004).
  - **Knowledge Graph update**: ComponentStyles node.
  - **Documentation update**: `docs/ui/COREUI_DESIGN_SYSTEM.md` Â§9.

- [X] T026 Run a component consistency audit (no duplicated implementations, no unmapped components)
  - **Phase**: 10
  - **Objective**: Verify the 14 canonical components each have exactly one implementation and a CoreUI equivalent (CHK-GATE-002).
  - **Source evidence**: spec.md FR-007; mapping Â§1â€“Â§7; validation checklist CHK-GATE-002.
  - **Dependencies**: T024, T025
  - **Affected roles**: all
  - **Affected pages**: all
  - **Affected components**: all 14
  - **Expected files**: none (audit)
  - **Implementation constraints**: Grep for duplicate partial names; cross-check against the mapping doc.
  - **Validation**: 14/14 components, 0 duplicates, 0 unmapped.
  - **Test requirements**: `CoreUIAssetTests` (TS-001) â€” component inventory.
  - **Knowledge Graph update**: none.
  - **Documentation update**: `docs/ui/COREUI_VISA_FUSION_MAPPING.md` statuses.

**Checkpoint**: Component library complete. Phases 11â€“21 can proceed (in parallel where staffed).

---

## Phase 11: Authentication Layouts

**Purpose**: Re-skin the 4 auth pages (Login, Register, ChangePassword, AccessDenied) on the CoreUI standalone `pages` layout with behavior unchanged.

- [ ] T027 Create the CoreUI standalone `pages` layout for authentication pages
  - **Phase**: 11
  - **Objective**: Create a minimal standalone layout (no sidebar) using the CoreUI `pages` pattern for the auth pages.
  - **Source evidence**: spec.md FR-004 (auth pages); `COREUI_INVENTORY.md` Â§8 (auth layout row); contracts/ui-contract.md; plan.md Phase D.
  - **Dependencies**: T008, T024 (AuthCard)
  - **Affected roles**: Guest, all authenticated roles (password change)
  - **Affected pages**: Login, Register, ChangePassword, AccessDenied
  - **Affected components**: AuthCard
  - **Expected files**: `src/VisaFusion.Web/Pages/Auth/_AuthLayout.cshtml` (path per existing convention)
  - **Implementation constraints**: No sidebar; CoreUI `pages` pattern; no business logic.
  - **Validation**: Auth pages render on the standalone layout.
  - **Test requirements**: `AuthLoginTests`, `RegisterPageTests`, `ChangePasswordPageTests`, `AccessDeniedPageTests` (pre-existing, must pass unchanged).
  - **Knowledge Graph update**: Auth layout node + edges.
  - **Documentation update**: none.

- [ ] T028 Re-skin Login, Register, ChangePassword, AccessDenied with the AuthCard component
  - **Phase**: 11
  - **Objective**: Apply the AuthCard component to the 4 auth pages; behavior (day-gate `rsn=O`, redirects, validation) must remain unchanged.
  - **Source evidence**: spec.md FR-004, FR-009; mapping Â§2 (auth pages); clarify 2026-08-19.
  - **Dependencies**: T027
  - **Affected roles**: Guest, all authenticated roles
  - **Affected pages**: `/Auth/Login`, `/Auth/Register`, `/Auth/ChangePassword`, `/Auth/AccessDenied`
  - **Affected components**: AuthCard
  - **Expected files**: `src/VisaFusion.Web/Pages/Auth/Login.cshtml`, `Register.cshtml`, `ChangePassword.cshtml`, `AccessDenied.cshtml`
  - **Implementation constraints**: Page models (`*.cshtml.cs`) unchanged; day-gate and `LocalRedirect(returnUrl or "/")` preserved (spec FR-009).
  - **Validation**: All 4 auth pages render CoreUI; auth behavior tests pass unchanged.
  - **Test requirements**: `AuthLoginTests`, `RegisterPageTests`, `ChangePasswordPageTests`, `AccessDeniedPageTests`.
  - **Knowledge Graph update**: Auth page nodes + edges.
  - **Documentation update**: `docs/ui/COREUI_VISA_FUSION_MAPPING.md` Â§2 statuses.

**Checkpoint**: Auth pages re-skinned.

---

## Phase 12: Authorization-Aware UI

**Purpose**: Ensure UI visibility is role-config-driven and server-side authorization is untouched.

- [ ] T029 Audit presentation code for authorization logic (UI visibility must come from role config, not authorization checks)
  - **Phase**: 12
  - **Objective**: Grep all `.cshtml`/components for authorization decisions; confirm 0 authorization logic in presentation code; visibility driven by the role config in `RoleAwareNavigation`.
  - **Source evidence**: constitution XV; Addendum Â§10; spec.md AC-009.
  - **Dependencies**: T016
  - **Affected roles**: all 5
  - **Affected pages**: all
  - **Affected components**: all
  - **Expected files**: none (audit; fix files if violations found)
  - **Implementation constraints**: No authorization decisions in nav/component code; menu hiding must not grant/deny access.
  - **Validation**: Grep shows 0 authorization logic in presentation; all protected pages retain `[Authorize(Policy=â€¦)]`.
  - **Test requirements**: `AgentPortalRbacTests`, `EntriesRbacTests`, `SecuredWriteRoutesTests` (pre-existing, unchanged).
  - **Knowledge Graph update**: none.
  - **Documentation update**: none.

- [ ] T030 Verify all protected pages retain their server-side authorization attributes
  - **Phase**: 12
  - **Objective**: Cross-check `[Authorize` attributes on all page models against `ROLE_PAGE_PERMISSION_MATRIX.md` Â§4; fix any page that lost its attribute.
  - **Source evidence**: `ROLE_PAGE_PERMISSION_MATRIX.md` Â§4; spec.md AC-009; Addendum Â§10.
  - **Dependencies**: T029
  - **Affected roles**: all 5
  - **Affected pages**: all protected pages
  - **Affected components**: none
  - **Expected files**: none (fix page models if violations found)
  - **Implementation constraints**: 0 pages missing their policy; no policy changes.
  - **Validation**: Attribute inventory matches the matrix 100%.
  - **Test requirements**: All RBAC suites (pre-existing, unchanged).
  - **Knowledge Graph update**: none.
  - **Documentation update**: none.

- [ ] T030b Create `CoreUIAuthorizationTests` in `tests/IntegrationTests/`
  - **Phase**: 12
  - **Objective**: Add the authorization test suite verifying every protected page and API retains its policy; UI visibility never grants/denies access (TS-004, AC-009).
  - **Source evidence**: spec.md TS-004, AC-009; constitution XV; Addendum Â§10; validation checklist CHK042.
  - **Dependencies**: T029, T030
  - **Affected roles**: all 5
  - **Affected pages**: all protected pages
  - **Affected components**: none
  - **Expected files**: `tests/IntegrationTests/CoreUIAuthorizationTests.cs`
  - **Implementation constraints**: Follow existing test conventions; test all 11 policies against all roles.
  - **Validation**: All RBAC assertions pass; UI visibility â‰  authorization verified.
  - **Test requirements**: TS-004.
  - **Knowledge Graph update**: Test node + edges to policy/page nodes.
  - **Documentation update**: none.

**Checkpoint**: Authorization-aware UI verified.

---

## Phase 13: Error Pages

**Purpose**: Re-skin error pages with the ErrorPage component.

- [ ] T031 Re-skin error pages (404/500/access-denied) with the ErrorPage component
  - **Phase**: 13
  - **Objective**: Apply the ErrorPage component to the app's error pages; error semantics unchanged.
  - **Source evidence**: spec.md FR-007 (ErrorPage); mapping Â§3 (error pages); contracts/ui-contract.md.
  - **Dependencies**: T024
  - **Affected roles**: all
  - **Affected pages**: error pages (404, 500, access denied)
  - **Affected components**: ErrorPage
  - **Expected files**: error page `.cshtml` files under `src/VisaFusion.Web/Pages/` (per existing convention)
  - **Implementation constraints**: Error status codes and handling unchanged; CoreUI presentation only.
  - **Validation**: Error pages render CoreUI; error behavior tests pass.
  - **Test requirements**: `SecurityDayPagesTests` (pre-existing, unchanged).
  - **Knowledge Graph update**: Error page nodes.
  - **Documentation update**: `docs/ui/COREUI_VISA_FUSION_MAPPING.md` Â§3 statuses.

**Checkpoint**: Error pages re-skinned.

---

## Phase 14: Role-Specific Landing Pages

**Purpose**: Re-skin the role-specific landing pages (no generic dashboard replacement).

- [X] T032 [P] Re-skin the Public landing page with the PublicLanding component
  - **Phase**: 14
  - **Objective**: Apply the PublicLanding component to the public landing page; content/data unchanged.
  - **Source evidence**: spec.md FR-005; mapping Â§1 (public); Addendum Â§7; clarify 2026-08-19.
  - **Dependencies**: T024
  - **Affected roles**: Guest
  - **Affected pages**: public landing (root `/`)
  - **Affected components**: PublicLanding
  - **Expected files**: public landing `.cshtml` under `src/VisaFusion.Web/Pages/`
  - **Implementation constraints**: Landing content/data unchanged; CoreUI presentation only.
  - **Validation**: Public landing renders CoreUI with existing content.
  - **Test requirements**: `WebLoginPageTests` (pre-existing, unchanged).
  - **Knowledge Graph update**: Landing page node.
  - **Documentation update**: `docs/ui/COREUI_VISA_FUSION_MAPPING.md` Â§1 statuses.

- [X] T033 [P] Re-skin the Agent landing page (`/Agent/Index`)
  - **Phase**: 14
  - **Objective**: Apply CoreUI presentation to the Agent landing page; role-specific landing preserved (Addendum Â§7).
  - **Source evidence**: spec.md FR-005; Addendum Â§7; mapping Â§4 (agent).
  - **Dependencies**: T024
  - **Affected roles**: agt
  - **Affected pages**: `/Agent/Index`
  - **Affected components**: RoleDashboard
  - **Expected files**: `src/VisaFusion.Web/Areas/Agent/Pages/Index.cshtml`
  - **Implementation constraints**: Landing data unchanged; no generic dashboard replacement.
  - **Validation**: Agent lands on `/Agent/Index` with existing data in CoreUI presentation.
  - **Test requirements**: `AgentPortalRbacTests` (pre-existing, unchanged).
  - **Knowledge Graph update**: Landing page node.
  - **Documentation update**: `docs/ui/COREUI_VISA_FUSION_MAPPING.md` Â§4 statuses.

- [X] T034 [P] Re-skin the Reporting landing page (`/Reporting/Index`)
  - **Phase**: 14
  - **Objective**: Apply CoreUI presentation to the Reporting landing page; role-specific landing preserved.
  - **Source evidence**: spec.md FR-005; Addendum Â§7; mapping Â§5 (reporting).
  - **Dependencies**: T024
  - **Affected roles**: agt, adm, su
  - **Affected pages**: `/Reporting/Index`
  - **Affected components**: RoleDashboard
  - **Expected files**: `src/VisaFusion.Web/Areas/Reporting/Pages/Index.cshtml`
  - **Implementation constraints**: Landing data unchanged.
  - **Validation**: Reporting landing renders CoreUI with existing data.
  - **Test requirements**: `ReportSchemaTests` (pre-existing, unchanged).
  - **Knowledge Graph update**: Landing page node.
  - **Documentation update**: `docs/ui/COREUI_VISA_FUSION_MAPPING.md` Â§5 statuses.

- [X] T035 [P] Re-skin the Admin landing page (`/Admin/Index`)
  - **Phase**: 14
  - **Objective**: Apply CoreUI presentation to the Admin landing page; role-specific landing preserved.
  - **Source evidence**: spec.md FR-005; Addendum Â§7; mapping Â§6 (admin).
  - **Dependencies**: T024
  - **Affected roles**: adm, su
  - **Affected pages**: `/Admin/Index`
  - **Affected components**: RoleDashboard
  - **Expected files**: `src/VisaFusion.Web/Areas/Admin/Pages/Index.cshtml`
  - **Implementation constraints**: Landing data unchanged.
  - **Validation**: Admin landing renders CoreUI with existing data.
  - **Test requirements**: `AdminPortalRbacTests` (pre-existing, unchanged).
  - **Knowledge Graph update**: Landing page node.
  - **Documentation update**: `docs/ui/COREUI_VISA_FUSION_MAPPING.md` Â§6 statuses.

**Checkpoint**: All role landings re-skinned.

---

## Phase 15: Role-Specific Dashboards

**Purpose**: Re-skin the role dashboards with CoreUI cards/charts; charts limited to the 5 approved surfaces.

- [X] T036 Re-skin the Agent dashboard (`/Agent/Index`) with CoreUI cards and charts
  - **Phase**: 15
  - **Objective**: Apply CoreUI card/chart presentation to the Agent dashboard; existing data sources unchanged.
  - **Source evidence**: spec.md FR-005; mapping Â§4; clarify 2026-08-19 (Agent Index is a chart surface).
  - **Dependencies**: T033
  - **Affected roles**: agt
  - **Affected pages**: `/Agent/Index`
  - **Affected components**: RoleDashboard
  - **Expected files**: `src/VisaFusion.Web/Areas/Agent/Pages/Index.cshtml`
  - **Implementation constraints**: Data sources unchanged; chart surface approved.
  - **Validation**: Dashboard renders cards + charts with existing data.
  - **Test requirements**: `AgentPortalRbacTests` (pre-existing, unchanged).
  - **Knowledge Graph update**: Dashboard node.
  - **Documentation update**: `docs/ui/COREUI_VISA_FUSION_MAPPING.md` Â§4.

- [X] T037 Re-skin the Reporting dashboard (`/Reporting/Index`) with CoreUI cards and charts
  - **Phase**: 15
  - **Objective**: Apply CoreUI card/chart presentation to the Reporting dashboard; existing data unchanged.
  - **Source evidence**: spec.md FR-005; mapping Â§5; clarify 2026-08-19 (Reporting Index is a chart surface).
  - **Dependencies**: T034
  - **Affected roles**: agt, adm, su
  - **Affected pages**: `/Reporting/Index`
  - **Affected components**: RoleDashboard
  - **Expected files**: `src/VisaFusion.Web/Areas/Reporting/Pages/Index.cshtml`
  - **Implementation constraints**: Data sources unchanged.
  - **Validation**: Dashboard renders cards + charts with existing data.
  - **Test requirements**: `ReportSchemaTests` (pre-existing, unchanged).
  - **Knowledge Graph update**: Dashboard node.
  - **Documentation update**: `docs/ui/COREUI_VISA_FUSION_MAPPING.md` Â§5.

- [X] T038 [P] Re-skin the Admin dashboard (`/Admin/Index`) with CoreUI cards
  - **Phase**: 15
  - **Objective**: Apply CoreUI card presentation to the Admin dashboard; existing data unchanged.
  - **Source evidence**: spec.md FR-005; mapping Â§6.
  - **Dependencies**: T035
  - **Affected roles**: adm, su
  - **Affected pages**: `/Admin/Index`
  - **Affected components**: RoleDashboard
  - **Expected files**: `src/VisaFusion.Web/Areas/Admin/Pages/Index.cshtml`
  - **Implementation constraints**: Data sources unchanged; no charts on this surface (not in the 5 approved).
  - **Validation**: Dashboard renders cards with existing data.
  - **Test requirements**: `AdminPortalRbacTests` (pre-existing, unchanged).
  - **Knowledge Graph update**: Dashboard node.
  - **Documentation update**: `docs/ui/COREUI_VISA_FUSION_MAPPING.md` Â§6.

- [ ] T039 Integrate chart.js + @coreui/chartjs on the 5 approved chart surfaces (Agent Index, Agent Statement, Reporting Index, DailyVisaFee, DailyBill)
  - **Phase**: 15
  - **Objective**: Vendor and wire the chart assets (`chart.js` ^4.5.1, `@coreui/chartjs` ^4.2.0) and render charts only on the 5 approved surfaces.
  - **Source evidence**: spec.md Â§13 (5 chart surfaces); clarify 2026-08-19; package.json pins; `COREUI_INVENTORY.md` Â§9 (charts.js).
  - **Dependencies**: T036, T037
  - **Affected roles**: agt, adm, su
  - **Affected pages**: `/Agent/Index`, `/Agent/Statement`, `/Reporting/Index`, `/Reporting/DailyVisaFee`, `/Reporting/DailyBill`
  - **Affected components**: RoleDashboard
  - **Expected files**: `src/VisaFusion.Web/wwwroot/lib/coreui/js/chart.*`, chart partials on the 5 pages
  - **Implementation constraints**: Chart assets loaded only on the 5 surfaces (grep check); chart data from existing page models only. **Must exclude `charts.js`/`widgets.js` demo content from Phase A3** â€” only use `main.js` pattern for production chart integration.
  - **Validation**: Charts render on the 5 surfaces; 0 chart includes elsewhere; grep for `charts.js`/`widgets.js` in page includes = 0.
  - **Test requirements**: `ReportSchemaTests` (pre-existing, unchanged).
  - **Knowledge Graph update**: Chart nodes + edges.
- **Documentation update**: `docs/ui/COREUI_DEPENDENCY_MAP.md` chart entries.

> **T039 — DEFERRED (2026-08-20)**: not implemented. The feature constraint
> ("do not invent charts; only verified existing VisaFusion data") blocks this
> task: a repo-wide grep for `canvas`/`chart` in `src/VisaFusion.Web/Areas` and
> `src/VisaFusion.Web/Pages` returned zero matches — no existing page exposes
> chart data. Wiring chart.js without a verified data source would invent
> charts. The `_RoleDashboard` component already renders `<canvas>` containers
> when `Charts` is populated, so the integration point exists; T039 can be
> re-opened when a chart data source is approved. See decision log.

**Checkpoint**: Dashboards complete.

---

## Phase 16: Role-Specific Native Pages

**Purpose**: Re-skin the role-specific native pages per the mapping; BLOCKED/NOT_REQUIRED pages untouched.

- [ ] T040 [P] Re-skin Agent pages (Entries, Statement, Account) with CoreUI components
  - **Phase**: 16
  - **Objective**: Apply CoreUI presentation to the Agent area pages per mapping Â§4; page models unchanged.
  - **Source evidence**: mapping Â§4 (agent pages); spec.md FR-005; `ROLE_PAGE_PERMISSION_MATRIX.md` Â§4.
  - **Dependencies**: T024
  - **Affected roles**: agt
  - **Affected pages**: `/Agent/Entries`, `/Agent/Statement`, `/Agent/Account` (per mapping)
  - **Affected components**: DataTable, FormCard, RoleDashboard
  - **Expected files**: `src/VisaFusion.Web/Areas/Agent/Pages/*.cshtml`
  - **Implementation constraints**: Page models unchanged; data/columns unchanged; CoreUI presentation only.
  - **Validation**: Agent pages render CoreUI with existing data.
  - **Test requirements**: `AgentPortalRbacTests`, `EntriesRbacTests` (pre-existing, unchanged).
  - **Knowledge Graph update**: Page nodes + edges.
  - **Documentation update**: `docs/ui/COREUI_VISA_FUSION_MAPPING.md` Â§4 statuses.

- [ ] T041 [P] Re-skin Reporting pages (DailyVisaFee, DailyBill, DailyUpdate, and remaining reporting pages) with CoreUI components
  - **Phase**: 16
  - **Objective**: Apply CoreUI presentation to the Reporting area pages per mapping Â§5; page models unchanged.
  - **Source evidence**: mapping Â§5 (reporting pages); spec.md FR-005.
  - **Dependencies**: T024
  - **Affected roles**: agt, adm, su
  - **Affected pages**: `/Reporting/DailyVisaFee`, `/Reporting/DailyBill`, `/Reporting/DailyUpdate`, remaining reporting pages (per mapping)
  - **Affected components**: DataTable, FormCard
  - **Expected files**: `src/VisaFusion.Web/Areas/Reporting/Pages/*.cshtml`
  - **Implementation constraints**: Page models unchanged; report data/columns unchanged.
  - **Validation**: Reporting pages render CoreUI with existing data.
  - **Test requirements**: `ReportSchemaTests`, `ReportParameterizedSqlTests` (pre-existing, unchanged).
  - **Knowledge Graph update**: Page nodes + edges.
  - **Documentation update**: `docs/ui/COREUI_VISA_FUSION_MAPPING.md` Â§5 statuses.

- [ ] T042 [P] Re-skin Admin pages (Agents, Users, Holidays, ContentUpdate) with CoreUI components
  - **Phase**: 16
  - **Objective**: Apply CoreUI presentation to the Admin area pages per mapping Â§6; page models unchanged.
  - **Source evidence**: mapping Â§6 (admin pages); spec.md FR-005.
  - **Dependencies**: T024
  - **Affected roles**: adm, su
  - **Affected pages**: `/Admin/Agents`, `/Admin/Users`, `/Admin/Holidays`, `/Admin/ContentUpdate` (per mapping)
  - **Affected components**: DataTable, FormCard, ConfirmModal
  - **Expected files**: `src/VisaFusion.Web/Areas/Admin/Pages/*.cshtml`
  - **Implementation constraints**: Page models unchanged; CRUD behavior unchanged.
  - **Validation**: Admin pages render CoreUI with existing data.
  - **Test requirements**: `AdminPortalRbacTests`, `HolidayCrudEndpointTests` (pre-existing, unchanged).
  - **Knowledge Graph update**: Page nodes + edges.
  - **Documentation update**: `docs/ui/COREUI_VISA_FUSION_MAPPING.md` Â§6 statuses.

- [ ] T043 [P] Re-skin Public pages (Queries, DailyUpdate public) with CoreUI components
  - **Phase**: 16
  - **Objective**: Apply CoreUI presentation to the public pages per mapping Â§1; page models unchanged.
  - **Source evidence**: mapping Â§1 (public pages); spec.md FR-005.
  - **Dependencies**: T024
  - **Affected roles**: Guest
  - **Affected pages**: `/Queries`, public DailyUpdate (per mapping)
  - **Affected components**: PublicQueryForm, FormCard
  - **Expected files**: `src/VisaFusion.Web/Areas/Public/Pages/*.cshtml`
  - **Implementation constraints**: Page models unchanged; anonymous write endpoints unchanged (rate limits intact).
  - **Validation**: Public pages render CoreUI with existing behavior.
  - **Test requirements**: `QueriesEndpointTests`, `QueriesValidationTests` (pre-existing, unchanged).
  - **Knowledge Graph update**: Page nodes + edges.
  - **Documentation update**: `docs/ui/COREUI_VISA_FUSION_MAPPING.md` Â§1 statuses.

- [ ] T044 Re-skin the Notifications placeholder (GAP-004 PARTIAL)
  - **Phase**: 16
  - **Objective**: Apply CoreUI presentation to the Notifications placeholder page (the only PARTIAL re-skin per GAP-004).
  - **Source evidence**: GAP-004 (Notifications PARTIAL); clarify 2026-08-19; mapping Â§7.
  - **Dependencies**: T024
  - **Affected roles**: agt, adm, su
  - **Affected pages**: Notifications placeholder
  - **Affected components**: InfoPage
  - **Expected files**: Notifications placeholder `.cshtml`
  - **Implementation constraints**: Placeholder content unchanged; CoreUI presentation only.
  - **Validation**: Notifications placeholder renders CoreUI.
  - **Test requirements**: `NotificationsEndpointTests` (pre-existing, unchanged).
  - **Knowledge Graph update**: Page node.
  - **Documentation update**: `docs/ui/COREUI_VISA_FUSION_MAPPING.md` Â§7 statuses.

- [ ] T045 Verify Employee/Billing (BLOCKED) and stray Forms (NOT_REQUIRED) pages are untouched
  - **Phase**: 16
  - **Objective**: Confirm 0 changes to the BLOCKED (Employee, Billing) and NOT_REQUIRED (stray Forms) pages.
  - **Source evidence**: GAP-004 (Employee/Billing BLOCKED); GAP-010 (Forms NOT_REQUIRED); clarify 2026-08-19; validation checklist CHK-GATE-001.
  - **Dependencies**: T040, T041, T042, T043, T044
  - **Affected roles**: emp, agt, adm, su
  - **Affected pages**: Employee area, Billing area, stray Forms page
  - **Affected components**: none
  - **Expected files**: none (verification only)
  - **Implementation constraints**: Git diff of these paths must be empty.
  - **Validation**: `git diff` on Employee/Billing/Forms paths = empty.
  - **Test requirements**: none (verification).
  - **Knowledge Graph update**: none.
  - **Documentation update**: `docs/ui/COREUI_VISA_FUSION_MAPPING.md` statuses confirmed.

**Checkpoint**: All native pages dispositioned (41/41 accounted).

---

## Phase 17: Forms

**Purpose**: Re-skin forms with the FormCard component and CoreUI validation presentation; validation semantics unchanged.

- [ ] T046 Re-skin forms with FormCard + CoreUI validation presentation (`.is-invalid`/`.invalid-feedback`)
  - **Phase**: 17
  - **Objective**: Apply the FormCard component and CoreUI validation styling to all form pages (Agent Account, Admin Agents Create/Edit, Users Create, ContentUpdate, Public forms).
  - **Source evidence**: spec.md Â§17 (form validation presentation); mapping Â§7 (FormCard); contracts/ui-contract.md.
  - **Dependencies**: T024
  - **Affected roles**: all 5
  - **Affected pages**: all form pages (per mapping)
  - **Affected components**: FormCard
  - **Expected files**: form `.cshtml` files across areas
  - **Implementation constraints**: Validation rules unchanged; only presentation changes; consistent form layout.
  - **Validation**: Forms render CoreUI validation messages; validation suites pass unchanged.
  - **Test requirements**: `ValidationTests`, `QueriesValidationTests`, `EntryPassengerValidationTests` (pre-existing, unchanged).
  - **Knowledge Graph update**: Form page nodes.
  - **Documentation update**: `docs/ui/COREUI_VISA_FUSION_MAPPING.md` form rows.

- [ ] T047 Verify form validation semantics are preserved (run validation suites)
  - **Phase**: 17
  - **Objective**: Run the validation test suites and confirm 0 changes to validation behavior.
  - **Source evidence**: spec.md Â§17; validation checklist CHK044/CHK045.
  - **Dependencies**: T046
  - **Affected roles**: all 5
  - **Affected pages**: all form pages
  - **Affected components**: FormCard
  - **Expected files**: none (verification)
  - **Implementation constraints**: 0 modifications to validation logic.
  - **Validation**: All validation suites pass unchanged.
  - **Test requirements**: `ValidationTests`, `QueriesValidationTests`, `EntryPassengerValidationTests`.
  - **Knowledge Graph update**: none.
  - **Documentation update**: none.

**Checkpoint**: Forms complete.

---

## Phase 18: Tables

**Purpose**: Re-skin tables with the DataTable component; data/columns unchanged.

- [ ] T048 Re-skin tables with the DataTable component (columns, pagination, badges, row actions)
  - **Phase**: 18
  - **Objective**: Apply the DataTable component to all table pages (Agent Entries/Statement, Reporting Ã—7, Admin Agents/Users/Holidays, Public DailyUpdate).
  - **Source evidence**: spec.md FR-007 (DataTable); mapping Â§7; contracts/ui-contract.md.
  - **Dependencies**: T024
  - **Affected roles**: all 5
  - **Affected pages**: all table pages (per mapping)
  - **Affected components**: DataTable
  - **Expected files**: table `.cshtml` files across areas
  - **Implementation constraints**: Columns/data unchanged; pagination preserved; CoreUI styling only.
  - **Validation**: Tables render CoreUI with existing columns/data and pagination.
  - **Test requirements**: `ReportSchemaTests`, `ReportParameterizedSqlTests` (pre-existing, unchanged).
  - **Knowledge Graph update**: Table page nodes.
  - **Documentation update**: `docs/ui/COREUI_VISA_FUSION_MAPPING.md` table rows.

- [ ] T049 Verify table data/columns unchanged (run report schema tests)
  - **Phase**: 18
  - **Objective**: Run the report schema/parameterized-SQL suites and confirm 0 changes to table data semantics.
  - **Source evidence**: spec.md Â§18; validation checklist CHK046/CHK047.
  - **Dependencies**: T048
  - **Affected roles**: all 5
  - **Affected pages**: all table pages
  - **Affected components**: DataTable
  - **Expected files**: none (verification)
  - **Implementation constraints**: 0 modifications to report queries or schemas.
  - **Validation**: Report suites pass unchanged.
  - **Test requirements**: `ReportSchemaTests`, `ReportParameterizedSqlTests`.
  - **Knowledge Graph update**: none.
  - **Documentation update**: none.

**Checkpoint**: Tables complete.

---

## Phase 19: Cards and Data Presentation

**Purpose**: Re-skin cards and data presentation with CoreUI.

- [ ] T050 Re-skin cards and data presentation (stat cards, info cards) with CoreUI
  - **Phase**: 19
  - **Objective**: Apply CoreUI card presentation to stat/info card surfaces across dashboards and pages; data unchanged.
  - **Source evidence**: spec.md FR-005; mapping Â§7; `COREUI_DESIGN_SYSTEM.md` Â§9 (cards).
  - **Dependencies**: T024
  - **Affected roles**: all 5
  - **Affected pages**: dashboards and card-bearing pages
  - **Affected components**: RoleDashboard
  - **Expected files**: card markup in affected `.cshtml` files
  - **Implementation constraints**: Data values unchanged; CoreUI card styling only.
  - **Validation**: Cards render CoreUI with existing data.
  - **Test requirements**: `CoreUIShellTests` (TS-003).
  - **Knowledge Graph update**: none.
  - **Documentation update**: `docs/ui/COREUI_DESIGN_SYSTEM.md` Â§9.

**Checkpoint**: Cards complete.

---

## Phase 20: Feedback Components

**Purpose**: Implement and wire the ToastHost and ConfirmModal feedback components.

- [ ] T051 Implement the ToastHost and ConfirmModal components
  - **Phase**: 20
  - **Objective**: Complete the ToastHost (toast notifications) and ConfirmModal (confirmation dialogs) components using CoreUI toast/modal patterns.
  - **Source evidence**: spec.md FR-007 (ToastHost, ConfirmModal); `COREUI_INVENTORY.md` Â§9 (toasts.js); contracts/ui-contract.md.
  - **Dependencies**: T024
  - **Affected roles**: all 5
  - **Affected pages**: pages using toasts/confirmations
  - **Affected components**: ToastHost, ConfirmModal
  - **Expected files**: `src/VisaFusion.Web/Components/_ToastHost.cshtml`, `_ConfirmModal.cshtml`
  - **Implementation constraints**: CoreUI toast/modal patterns; no invented feedback behavior.
  - **Validation**: Components render CoreUI toasts/modals.
  - **Test requirements**: `CoreUIShellTests` (TS-003).
  - **Knowledge Graph update**: Component nodes.
  - **Documentation update**: `docs/ui/COREUI_VISA_FUSION_MAPPING.md` component rows.

- [ ] T052 Wire toasts/confirmations into the pages that use them
  - **Phase**: 20
  - **Objective**: Connect ToastHost/ConfirmModal to the pages that already show toasts/confirmations (e.g., Admin CRUD confirmations); behavior unchanged.
  - **Source evidence**: mapping Â§7; spec.md FR-007.
  - **Dependencies**: T051
  - **Affected roles**: adm, su, agt
  - **Affected pages**: pages with existing toast/confirm behavior (per mapping)
  - **Affected components**: ToastHost, ConfirmModal
  - **Expected files**: affected `.cshtml` files
  - **Implementation constraints**: Existing confirmation/toast semantics unchanged.
  - **Validation**: Toasts/confirmations render CoreUI with existing behavior.
  - **Test requirements**: `HolidayCrudEndpointTests` (pre-existing, unchanged).
  - **Knowledge Graph update**: none.
  - **Documentation update**: none.

**Checkpoint**: Feedback components complete.

---

## Phase 21: Icons

**Purpose**: Replace bootstrap-icons with CoreUI icons; correct ARIA handling.

- [ ] T053 Replace `bootstrap-icons` with CoreUI `cil-*`/`cif-*` SVGs and remove `bootstrap-icons.css`
  - **Phase**: 21
  - **Objective**: Swap all icon references from bootstrap-icons to CoreUI SVGs; remove the `bootstrap-icons.css` include and file.
  - **Source evidence**: spec.md FR-012; mapping Â§7 (IconSet); `COREUI_INVENTORY.md` Â§5; validation checklist CHK050.
  - **Dependencies**: T002
  - **Affected roles**: all 5
  - **Affected pages**: all pages using icons
  - **Affected components**: IconSet
  - **Expected files**: `src/VisaFusion.Web/wwwroot/css/bootstrap-icons.css` (removed), affected `.cshtml` files, `_Layout.cshtml`
  - **Implementation constraints**: 0 bootstrap-icons references remain; `cif-*` flags on embassy/country pages.
  - **Validation**: Grep `bootstrap-icons` = 0; icons render.
  - **Test requirements**: `CoreUIAssetTests` (TS-001).
  - **Knowledge Graph update**: IconSet node edges updated.
  - **Documentation update**: `docs/ui/COREUI_INVENTORY.md` Â§5.

- [ ] T054 Apply ARIA handling to icons (decorative `aria-hidden="true"`, meaningful `role="img"`/`aria-label`)
  - **Phase**: 21
  - **Objective**: Ensure decorative icons are hidden from assistive tech and meaningful icons are labeled.
  - **Source evidence**: `COREUI_DESIGN_SYSTEM.md` Â§7 (icon accessibility); spec.md AC-011.
  - **Dependencies**: T053
  - **Affected roles**: all
  - **Affected pages**: all pages using icons
  - **Affected components**: IconSet
  - **Expected files**: affected `.cshtml` files
  - **Implementation constraints**: Matches the design-system Â§7 accessibility behavior.
  - **Validation**: Markup audit shows correct ARIA on all icons.
  - **Test requirements**: `CoreUIAccessibilityTests` (TS-005).
  - **Knowledge Graph update**: none.
  - **Documentation update**: none.

**Checkpoint**: Icons complete.

---

## Phase 22: Responsive Behavior

**Purpose**: Validate and fix responsive behavior at all breakpoints.

- [ ] T055 Create `CoreUIResponsiveTests` in `tests/FunctionalTests/`
  - **Phase**: 22
  - **Objective**: Add the responsive test suite covering desktop, tablet, and mobile breakpoints for migrated surfaces.
  - **Source evidence**: spec.md AC-012, TS-006; `COREUI_DESIGN_SYSTEM.md` Â§6; validation checklist CHK052.
  - **Dependencies**: T009
  - **Affected roles**: all 5
  - **Affected pages**: all migrated surfaces
  - **Affected components**: all
  - **Expected files**: `tests/FunctionalTests/CoreUIResponsiveTests.cs`
  - **Implementation constraints**: Follow existing test conventions. **Must explicitly validate**: table horizontal scroll (`.table-responsive`), card stacking (2-upâ†’4-up at `col-sm-6`â†’`col-xl-3`), sidebar collapse/unfoldable narrow mode, mobile close button (`d-lg-none`), toolbar hidden on small (`d-none.d-md-block`), search button labels hidden (`d-none.d-sm-block`).
  - **Validation**: Suite passes; all explicit checks pass.
  - **Test requirements**: TS-006.
  - **Knowledge Graph update**: Test node.
  - **Documentation update**: none.

- [ ] T056 Fix responsive issues found (tables scroll, cards stack, sidebar collapse)
  - **Phase**: 22
  - **Objective**: Resolve any responsive failures (`.table-responsive`, card stacking, sidebar collapse) across surfaces.
  - **Source evidence**: spec.md AC-012; `COREUI_DESIGN_SYSTEM.md` Â§6.
  - **Dependencies**: T055
  - **Affected roles**: all 5
  - **Affected pages**: surfaces with failures
  - **Affected components**: DataTable, Sidebar, RoleDashboard
  - **Expected files**: affected `.cshtml`/`.css` files
  - **Implementation constraints**: Presentation-only fixes; no behavior change.
  - **Validation**: All breakpoints usable on all surfaces; explicit checks from T055 pass.
  - **Test requirements**: `CoreUIResponsiveTests` (TS-006).
  - **Knowledge Graph update**: none.
  - **Documentation update**: none.

**Checkpoint**: Responsive behavior validated.

---

## Phase 23: Accessibility

**Purpose**: Validate and fix accessibility (WCAG-AA) across migrated surfaces.

- [ ] T057 Create `CoreUIAccessibilityTests` in `tests/FunctionalTests/`
  - **Phase**: 23
  - **Objective**: Add the accessibility test suite covering keyboard navigation, focus handling, labels, ARIA, and the retained `vf-skip-link`.
  - **Source evidence**: spec.md AC-011, TS-005; `COREUI_DESIGN_SYSTEM.md` Â§7; validation checklist CHK054.
  - **Dependencies**: T009
  - **Affected roles**: all
  - **Affected pages**: all migrated surfaces
  - **Affected components**: all
  - **Expected files**: `tests/FunctionalTests/CoreUIAccessibilityTests.cs`
  - **Implementation constraints**: Follow existing test conventions. **Must explicitly validate**: contrast ratios (WCAG-AA), focus-visible rings (Bootstrap 5 baseline), skip-link retention (`vf-skip-link`), ARIA on dynamic elements (toasts, modals, dropdowns), form labels (`<label class="form-label">` paired with inputs), button labels (`aria-label` on icon-only buttons), progress semantics (`role="progressbar"`), dropdown semantics (`aria-expanded`, `aria-haspopup`), breadcrumb semantics (`nav[aria-label="breadcrumb"]`), modal semantics (`tabindex="-1"`, `aria-labelledby`, `aria-hidden`), tab roles (`role="tablist"`/`tab`/`tabpanel`), tooltip init for dynamic elements (`coreui.Tooltip`).
  - **Validation**: Suite passes; all explicit checks pass.
  - **Test requirements**: TS-005.
  - **Knowledge Graph update**: Test node.
  - **Documentation update**: none.

- [ ] T058 Fix accessibility issues found (keyboard traps, missing labels, broken focus, ARIA)
  - **Phase**: 23
  - **Objective**: Resolve any accessibility failures; ensure `vf-skip-link` retained.
  - **Source evidence**: spec.md AC-011; `COREUI_DESIGN_SYSTEM.md` Â§7.
  - **Dependencies**: T057
  - **Affected roles**: all
  - **Affected pages**: surfaces with failures
  - **Affected components**: all
  - **Expected files**: affected `.cshtml` files
  - **Implementation constraints**: Presentation-only fixes; WCAG-AA baseline met or improved.
  - **Validation**: All a11y checks pass; explicit checks from T057 pass.
  - **Test requirements**: `CoreUIAccessibilityTests` (TS-005).
  - **Knowledge Graph update**: none.
  - **Documentation update**: none.

**Checkpoint**: Accessibility validated.

---

## Phase 24: Security Validation

**Purpose**: Run the security suites and verify forensic artifacts and anonymous-write invariants.

- [ ] T059 Run the security test suites (secrets, SQL concatenation, backdoor isolation, spot checks)
  - **Phase**: 24
  - **Objective**: Execute `ProductionSecretsGuardTests`, `NoStringConcatenatedSqlTests`, `BackdoorAndIsolationTests`, `SecuritySpotCheckTests` â€” all must pass unchanged.
  - **Source evidence**: spec.md Â§12, AC-009; validation checklist CHK056.
  - **Dependencies**: T028
  - **Affected roles**: all
  - **Affected pages**: all
  - **Affected components**: none
  - **Expected files**: none (verification)
  - **Implementation constraints**: 0 modifications to security suites.
  - **Validation**: All security suites pass unchanged.
  - **Test requirements**: `ProductionSecretsGuardTests`, `NoStringConcatenatedSqlTests`, `BackdoorAndIsolationTests`, `SecuritySpotCheckTests`.
  - **Knowledge Graph update**: none.
  - **Documentation update**: none.

- [ ] T060 Verify legacy forensic artifacts are byte-identical and the backdoor parameters are inert
  - **Phase**: 24
  - **Objective**: Grep for the forensic literals (`Udaan_users`, `udaanuma-dev`, `r&d`, `udaanappraj123guruadm`, `udaan12345functiondisplaymarquee`) and confirm they are byte-identical and functionally inert.
  - **Source evidence**: constitution XXIV; spec.md BR-006; validation checklist CHK057.
  - **Dependencies**: T059
  - **Affected roles**: all
  - **Affected pages**: all
  - **Affected components**: none
  - **Expected files**: none (verification)
  - **Implementation constraints**: Literals byte-identical; no insecure behavior re-enabled.
  - **Validation**: Grep confirms literals present and inert.
  - **Test requirements**: `BackdoorAndIsolationTests`.
  - **Knowledge Graph update**: none.
  - **Documentation update**: none.

- [ ] T061 Verify no new anonymous writes and no client-side data beyond the theme preference
  - **Phase**: 24
  - **Objective**: Confirm exactly 2 anonymous writes (public register, public queries) with rate limits intact, and only `visafusion-theme` persisted client-side.
  - **Source evidence**: spec.md Â§12; `ROLE_ROUTE_MATRIX.md` Â§2; clarify 2026-08-19; validation checklist CHK043/CHK058.
  - **Dependencies**: T059
  - **Affected roles**: Guest
  - **Affected pages**: `/Auth/Register`, `/Queries`
  - **Affected components**: none
  - **Expected files**: none (verification)
  - **Implementation constraints**: 0 new anonymous writes; rate limits intact.
  - **Validation**: Grep `Program.cs` shows exactly 2 anonymous endpoints; localStorage audit shows only `visafusion-theme`.
  - **Test requirements**: `RateLimitTests`, `QueriesEndpointTests`, `RegistrationEscalationTests`.
  - **Knowledge Graph update**: none.
  - **Documentation update**: none.

- [ ] T061b Create `CoreUIApiRouteTests` in `tests/IntegrationTests/`
  - **Phase**: 24
  - **Objective**: Add the API route test suite verifying all 51 API routes respond identically before/after re-skin (route, method, policy, status) (TS-005, AC-009).
  - **Source evidence**: spec.md TS-005, AC-009; `ROLE_ROUTE_MATRIX.md` Â§2; plan.md Phase E.
  - **Dependencies**: T059, T060, T061
  - **Affected roles**: all 5
  - **Affected pages**: none (API tests)
  - **Affected components**: none
  - **Expected files**: `tests/IntegrationTests/CoreUIApiRouteTests.cs`
  - **Implementation constraints**: Follow existing test conventions; test all 51 routes Ã— 5 roles.
  - **Validation**: All 51 routes respond identically pre/post re-skin.
  - **Test requirements**: TS-005.
  - **Knowledge Graph update**: Test node + edges to API/endpoint nodes.
  - **Documentation update**: none.

- [ ] T061c Create `CoreUIDatabaseTests` in `tests/IntegrationTests/`
  - **Phase**: 24
  - **Objective**: Add the database schema test suite verifying schema and data are byte-identical before/after re-skin (TS-013, AC-014).
  - **Source evidence**: spec.md TS-013, AC-014; constitution VI-VIII; validation checklist CHK061.
  - **Dependencies**: T059, T060, T061
  - **Affected roles**: all
  - **Affected pages**: none (DB tests)
  - **Affected components**: none
  - **Expected files**: `tests/IntegrationTests/CoreUIDatabaseTests.cs`
  - **Implementation constraints**: Follow existing test conventions; compare schema snapshots.
  - **Validation**: Schema/data byte-identical; 0 migrations.
  - **Test requirements**: TS-013.
  - **Knowledge Graph update**: Test node + edges to table nodes.
  - **Documentation update**: none.

**Checkpoint**: Security validated.

---

## Phase 25: Regression Testing

**Purpose**: Full regression net â€” all pre-existing tests pass with 0 modifications; role-based test matrix executed.

- [ ] T062 Run the full test suite (UnitTests, IntegrationTests, FunctionalTests) with 0 modifications to pre-existing tests
  - **Phase**: 25
  - **Objective**: Execute the complete test suite; confirm 100% of pre-existing tests pass with 0 modifications.
  - **Source evidence**: spec.md AC-015, TS-010; validation checklist CHK063.
  - **Dependencies**: all implementation phases (T001â€“T061)
  - **Affected roles**: all 5
  - **Affected pages**: all
  - **Affected components**: all
  - **Expected files**: none (verification)
  - **Implementation constraints**: 0 modifications to pre-existing tests; no unrelated refactoring (constitution XXI).
  - **Validation**: Full suite green; pass counts match baseline.
  - **Test requirements**: all pre-existing suites.
  - **Knowledge Graph update**: none.
  - **Documentation update**: none.

- [ ] T063 Execute the role-based test matrix (Addendum Â§16) for all 5 roles
  - **Phase**: 25
  - **Objective**: Execute the Addendum Â§16 matrix per role (login, landing, nav, menus, submenu, page access, unauthorized, actions, forms, validation, APIs, reports, logout) and record results.
  - **Source evidence**: Addendum Â§16; spec.md AC-016; validation checklist CHK066.
  - **Dependencies**: T062
  - **Affected roles**: all 5
  - **Affected pages**: all
  - **Affected components**: all
  - **Expected files**: completed matrix record (e.g., `specs/009-coreui-ui-foundation/role-test-matrix.md`)
  - **Implementation constraints**: All matrix cells pass for all 5 roles.
  - **Validation**: Matrix 100% green.
  - **Test requirements**: TS-011..TS-014 (role-based suites).
  - **Knowledge Graph update**: none.
  - **Documentation update**: role-test-matrix record.

- [ ] T063b Create `CoreUIVisualTests` in `tests/FunctionalTests/`
  - **Phase**: 25
  - **Objective**: Add the visual validation test suite for role-based visual validation per Addendum Â§17 â€” for each role: login, landing page, header, sidebar, menus, submenu, breadcrumbs, native pages, actions, responsive behavior, unauthorized pages, logout (TS-012, AC-016).
  - **Source evidence**: spec.md TS-012, AC-016; Addendum Â§17; validation checklist CHK052, CHK054.
  - **Dependencies**: T062, T063
  - **Affected roles**: all 5
  - **Affected pages**: all
  - **Affected components**: all
  - **Expected files**: `tests/FunctionalTests/CoreUIVisualTests.cs`
  - **Implementation constraints**: Follow existing test conventions; validate all 5 roles (not only administrator).
  - **Validation**: Visual validation passes for all 5 roles.
  - **Test requirements**: TS-012.
  - **Knowledge Graph update**: Test node + edges to role/page nodes.
  - **Documentation update**: none.

**Checkpoint**: Regression net green.

---

## Phase 26: Knowledge Graph Synchronization

**Purpose**: Update the Knowledge Graph and traceability matrix; reconcile the 8-group navigation model.

- [ ] T064 Update `knowledge-graph/kg.json` with CoreUI integration nodes/edges (FR-013/AC-013)
  - **Phase**: 26
  - **Objective**: Add CoreUI component/layout/asset nodes and edges to pages, features, and tests; reconcile the navigation model to the 8-group centralized model (KG currently records NavigationGroup=10 from descriptive labels).
  - **Source evidence**: spec.md FR-013/AC-013; Addendum Â§14; validation checklist CHK067; clarify 2026-08-19 (8 groups).
  - **Dependencies**: T062
  - **Affected roles**: all
  - **Affected pages**: all
  - **Affected components**: all
  - **Expected files**: `knowledge-graph/kg.json`
  - **Implementation constraints**: Full provenance on every edge; 0 orphan refs; navigation groups reconciled to 8.
  - **Validation**: KG validation passes (0 orphan refs, 0 edges without provenance).
  - **Test requirements**: KG validation script.
  - **Knowledge Graph update**: this task.
  - **Documentation update**: none.

- [ ] T065 Update `knowledge-graph/traceability-matrix.md` (Role â†’ Permission â†’ Navigation â†’ Page â†’ Feature â†’ Spec â†’ Use Case â†’ API â†’ Database â†’ Test)
  - **Phase**: 26
  - **Objective**: Add CoreUI rows to the traceability matrix; confirm no orphan page/permission/nav/API.
  - **Source evidence**: Addendum Â§15; validation checklist CHK068.
  - **Dependencies**: T064
  - **Affected roles**: all
  - **Affected pages**: all
  - **Affected components**: all
  - **Expected files**: `knowledge-graph/traceability-matrix.md`
  - **Implementation constraints**: Complete traceability; no orphans.
  - **Validation**: Matrix complete.
  - **Test requirements**: none.
  - **Knowledge Graph update**: this task.
  - **Documentation update**: traceability-matrix.md.

- [ ] T066 Run KG validation (0 orphan refs, 0 edges without provenance)
  - **Phase**: 26
  - **Objective**: Execute the KG validation and fix any violations.
  - **Source evidence**: validation checklist CHK067; Addendum Â§14.
  - **Dependencies**: T064
  - **Affected roles**: all
  - **Affected pages**: all
  - **Affected components**: all
  - **Expected files**: `knowledge-graph/kg-validation.md` (updated)
  - **Implementation constraints**: 0 orphans, 0 unprovenanced edges.
  - **Validation**: Validation report green.
  - **Test requirements**: KG validation script.
  - **Knowledge Graph update**: this task.
  - **Documentation update**: kg-validation.md.

**Checkpoint**: KG synchronized.

---

## Phase 27: Documentation

**Purpose**: Update all documentation to reflect the delivered state.

- [ ] T067 Update `docs/ui/*` to reflect the delivered state (mapping statuses, matrices, inventory, dependency map, design system)
  - **Phase**: 27
  - **Objective**: Synchronize `COREUI_VISA_FUSION_MAPPING.md` (41/41 statuses), `ROLE_*_MATRIX.md`, `COREUI_INVENTORY.md`, `COREUI_DEPENDENCY_MAP.md`, `COREUI_DESIGN_SYSTEM.md` with the delivered state.
  - **Source evidence**: validation checklist CHK071; constitution XIX.
  - **Dependencies**: T062
  - **Affected roles**: all
  - **Affected pages**: all
  - **Affected components**: all
  - **Expected files**: `docs/ui/*.md`
  - **Implementation constraints**: Docs must match delivered state exactly; no stale statuses. **Must also review `library/Role-Based Native Pages Architecture Addendum.md` for any updates needed** (D2).
  - **Validation**: Docs diff shows synchronized statuses; Addendum reviewed.
  - **Test requirements**: none.
  - **Knowledge Graph update**: none.
  - **Documentation update**: this task.

- [ ] T068 Record the ADR for the GAP-002 adoption decision
  - **Phase**: 27
  - **Objective**: Write the ADR documenting the GAP-002 decision (adopt CoreUI as the UI design system).
  - **Source evidence**: constitution XIII; plan.md Phase F3; validation checklist CHK072.
  - **Dependencies**: T067
  - **Affected roles**: all
  - **Affected pages**: none
  - **Affected components**: none
  - **Expected files**: `/adr/` ADR file (per existing ADR convention)
  - **Implementation constraints**: Follow the existing ADR format in the repo.
  - **Validation**: ADR present and consistent with the decision.
  - **Test requirements**: none.
  - **Knowledge Graph update**: ADR node.
  - **Documentation update**: this task.

- [ ] T069 Update README, `docs/analysis/UI_BASELINE.md`, and `docs/analysis/GAP_REPORT.md` (GAP-002 resolved, GAP-003 stale-README fixed)
  - **Phase**: 27
  - **Objective**: Mark GAP-002 resolved, fix the stale-README GAP-003, and synchronize UI_BASELINE with the delivered UI.
  - **Source evidence**: validation checklist CHK073; GAP_REPORT.md.
  - **Dependencies**: T067
  - **Affected roles**: all
  - **Affected pages**: none
  - **Affected components**: none
  - **Expected files**: `README.md`, `docs/analysis/UI_BASELINE.md`, `docs/analysis/GAP_REPORT.md`
  - **Implementation constraints**: No stale contradictions with delivered state.
  - **Validation**: Docs diff shows GAP-002 resolved, README current.
  - **Test requirements**: none.
  - **Knowledge Graph update**: none.
  - **Documentation update**: this task.

- [ ] T070 Complete the spec traceability matrix (Â§24) â€” every FR/AC traceable to artifact + test
  - **Phase**: 27
  - **Objective**: Fill the spec Â§24 traceability matrix confirming 100% traceability of FRs/ACs to delivered artifacts and tests.
  - **Source evidence**: spec.md Â§24; validation checklist CHK069; constitution XIII.
  - **Dependencies**: T062
  - **Affected roles**: all
  - **Affected pages**: all
  - **Affected components**: all
  - **Expected files**: `specs/009-coreui-ui-foundation/spec.md` (Â§24)
  - **Implementation constraints**: 100% traceability.
  - **Validation**: Matrix complete.
  - **Test requirements**: none.
  - **Knowledge Graph update**: none.
  - **Documentation update**: this task.

**Checkpoint**: Documentation synchronized.

---

## Phase 28: GitHub/CI Validation

**Purpose**: Deliver via PR with green CI and traceable history.

- [ ] T071 Open the feature PR with green CI and review evidence
  - **Phase**: 28
  - **Objective**: Open the PR for `009-coreui-ui-foundation`; CI must be green; review evidence recorded.
  - **Source evidence**: constitution XX; validation checklist CHK074.
  - **Dependencies**: T062
  - **Affected roles**: all
  - **Affected pages**: all
  - **Affected components**: all
  - **Expected files**: PR (GitHub)
  - **Implementation constraints**: CI green; review completed.
  - **Validation**: PR open/merged with green CI and review.
  - **Test requirements**: CI pipeline.
  - **Knowledge Graph update**: none.
  - **Documentation update**: PR description.

- [ ] T072 Verify commit history is traceable (phase commits, no secrets, no unrelated changes)
  - **Phase**: 28
  - **Objective**: Review the commit list for traceability (phases Aâ€“F), scan for secrets, confirm no unrelated changes.
  - **Source evidence**: validation checklist CHK075; constitution XX.
  - **Dependencies**: T071
  - **Affected roles**: all
  - **Affected pages**: none
  - **Affected components**: none
  - **Expected files**: none (verification)
  - **Implementation constraints**: 0 secrets; traceable commits.
  - **Validation**: Commit log traceable; secret scan clean.
  - **Test requirements**: secret scan.
  - **Knowledge Graph update**: none.
  - **Documentation update**: none.

**Checkpoint**: GitHub/CI validated.

---

## Phase 29: Final Convergence

**Purpose**: Final validation â€” quickstart scenarios, preservation gate, clean build, rollback, deployment smoke test.

- [ ] T073 Run the quickstart validation scenarios V1â€“V11
  - **Phase**: 29
  - **Objective**: Execute all 11 validation scenarios from `quickstart.md` and record results.
  - **Source evidence**: `specs/009-coreui-ui-foundation/quickstart.md` (V1â€“V11); validation checklist CHK-GATE-001/002.
  - **Dependencies**: T062
  - **Affected roles**: all 5
  - **Affected pages**: all
  - **Affected components**: all
  - **Expected files**: completed scenario record
  - **Implementation constraints**: All scenarios pass.
  - **Validation**: V1â€“V11 green.
  - **Test requirements**: quickstart scenarios.
  - **Knowledge Graph update**: none.
  - **Documentation update**: scenario record.

- [ ] T074 Walk the Addendum Â§18 preservation gate (15 items) and record results
  - **Phase**: 29
  - **Objective**: Walk all 15 preservation-gate items (roles, permissions, pages, navigation, landing pages, workflows, routes, APIs, role-aware nav/breadcrumbs, migrated pages, role-based tests, KG, SpecKit, traceability) and record completion.
  - **Source evidence**: Addendum Â§18; validation checklist CHK-GATE-003.
  - **Dependencies**: T073
  - **Affected roles**: all 5
  - **Affected pages**: all
  - **Affected components**: all
  - **Expected files**: completed gate record
  - **Implementation constraints**: All 15 items satisfied.
  - **Validation**: Gate 15/15.
  - **Test requirements**: none.
  - **Knowledge Graph update**: none.
  - **Documentation update**: gate record.

- [ ] T075 Final convergence: clean build (no new warnings), rollback dry-run, deployment smoke test
  - **Phase**: 29
  - **Objective**: Confirm clean build with no new warnings; dry-run the plan's rollback steps; run the post-deployment smoke test for all 5 roles.
  - **Source evidence**: plan.md Rollback Considerations; validation checklist CHK076â€“CHK080.
  - **Dependencies**: T074
  - **Affected roles**: all 5
  - **Affected pages**: all
  - **Affected components**: all
  - **Expected files**: none (verification)
  - **Implementation constraints**: Rollback restores pre-feature UI byte-identically; no DB/API rollback needed.
  - **Validation**: Build clean; rollback dry-run green; smoke test green for all roles.
  - **Test requirements**: full suite (final run).
  - **Knowledge Graph update**: none.
  - **Documentation update**: release notes.

**Checkpoint**: Feature complete â€” CoreUI integration validated end-to-end.

---

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1 (Assets)**: No dependencies â€” can start immediately.
- **Phase 2 (CSS/JS)**: Depends on Phase 1.
- **Phase 3 (Shell)**: Depends on Phase 2.
- **Phases 4, 5, 8, 9 (Header, Sidebar, Breadcrumb, Footer)**: Depend on Phase 3 (shell partials); can proceed in parallel once Phase 3 completes.
- **Phase 6 (Role-aware navigation)**: Depends on Phase 5 (sidebar partial).
- **Phase 7 (Menus/submenus)**: Depends on Phase 6.
- **Phase 8 (Breadcrumbs)**: Depends on Phase 6 (nav hierarchy).
- **Phase 10 (Components)**: Depends on Phase 2 (assets wired).
- **Phases 11â€“21 (Auth, Authorization, Errors, Landings, Dashboards, Native pages, Forms, Tables, Cards, Feedback, Icons)**: Depend on Phase 10 (components); can proceed in parallel where staffed.
- **Phase 15 (Dashboards)**: Depends on Phase 14 (landings) for the dashboard pages.
- **Phase 16 (Native pages)**: Depends on Phase 10; T045 (untouched verification) depends on T040â€“T044.
- **Phase 22 (Responsive)**: Depends on Phase 3 (shell).
- **Phase 23 (Accessibility)**: Depends on Phase 3 (shell).
- **Phase 24 (Security)**: Depends on Phase 11 (auth pages re-skinned).
- **Phase 25 (Regression)**: Depends on ALL implementation phases (T001â€“T061).
- **Phase 26 (KG)**: Depends on Phase 25.
- **Phase 27 (Docs)**: Depends on Phase 25.
- **Phase 28 (GitHub/CI)**: Depends on Phase 25.
- **Phase 29 (Convergence)**: Depends on Phases 25â€“28.

### Critical Path

T001 â†’ T005/T006 â†’ T008 â†’ T009 â†’ T011 â†’ T015 â†’ T016 â†’ T019 â†’ T021 â†’ T022 â†’ (T024) â†’ T046 â†’ T047 â†’ T062 â†’ T063 â†’ T064 â†’ T066 â†’ T073 â†’ T074 â†’ T075

### Parallel Opportunities

- **T001 âˆ¥ T002** (asset vendoring, different directories)
- **T005 âˆ¥ T006** (CSS vs JS, different files)
- **T013 âˆ¥ T015 âˆ¥ T023** (Header, Sidebar, Footer partials â€” different files)
- **T032 âˆ¥ T033 âˆ¥ T034 âˆ¥ T035** (4 landing pages â€” different files)
- **T036 âˆ¥ T038** (Agent/Admin dashboards) then T039 (charts) after T036/T037
- **T040 âˆ¥ T041 âˆ¥ T042 âˆ¥ T043 âˆ¥ T044** (5 native-page groups â€” different areas)
- **T046 âˆ¥ T048 âˆ¥ T050 âˆ¥ T051** (Forms, Tables, Cards, Feedback â€” different files)
- **T053 âˆ¥ T055 âˆ¥ T057** (Icons, Responsive tests, A11y tests â€” different files)
- **T064 âˆ¥ T067** (KG update and docs â€” different files) after Phase 25

### Within Each Phase

- Assets before integration (Phase 1 â†’ 2)
- Shell before partials (Phase 3 â†’ 4/5/8/9)
- Service before rendering (Phase 6: T016 â†’ T017)
- Components before page re-skin (Phase 10 â†’ 11â€“21)
- Implementation before validation (Phases 1â€“24 â†’ 25â€“29)

---

## Implementation Strategy

### MVP First (Phases 1â€“3 + 6)

1. Complete Phase 1 (assets) + Phase 2 (CSS/JS) + Phase 3 (shell).
2. Complete Phase 6 (role-aware navigation) â€” the core behavioral change.
3. **STOP and VALIDATE**: shell renders for all 5 roles with correct nav.
4. Deploy/demo if ready.

### Incremental Delivery

1. Phases 1â€“3 â†’ shell renders (MVP).
2. Phases 4â€“9 â†’ shell complete (header, sidebar, nav, menus, breadcrumbs, footer).
3. Phase 10 â†’ component library.
4. Phases 11â€“21 â†’ page re-skin per area (auth â†’ landings â†’ dashboards â†’ native pages â†’ forms/tables/cards/feedback/icons).
5. Phases 22â€“24 â†’ quality gates (responsive, a11y, security).
6. Phases 25â€“29 â†’ regression, KG, docs, CI, convergence.

### Parallel Team Strategy

With multiple developers:

1. Team completes Phases 1â€“3 together.
2. Developer A: Phases 4â€“9 (shell partials + nav).
3. Developer B: Phase 10 (components) after Phase 2.
4. Developer C: Phases 11â€“13 (auth, authorization, errors) after Phase 10.
5. Developers split Phases 14â€“21 by area (Agent / Reporting / Admin / Public).
6. Team converges on Phases 22â€“29.

---

## Notes

- `[P]` tasks = different files, no dependencies.
- Every task traces to spec/plan/research/mapping evidence â€” no invented functionality.
- BLOCKED (Employee, Billing) and NOT_REQUIRED (stray Forms) pages must remain untouched (T045).
- No business, API, or database changes in any task (constitution Vâ€“VIII).
- Commit after each task or logical group.
- Stop at any checkpoint to validate independently.
- Final completion requires CHK-GATE-001/002/003 from `checklists/validation.md`.

---

## Phase 30: Convergence

**Purpose**: Remaining work identified by `/speckit.converge` (2026-08-20) — code-verified gaps between SPEC-0009 intent (spec.md, plan.md, tasks.md, constitution) and the current codebase state. Ordered CRITICAL/HIGH first. Completing these closes the feature; a follow-up converge run should report no remaining items.

- [ ] T076 Record the ADR for the GAP-002 CoreUI adoption decision under `/adr` per constitution XIII and spec §19 (missing)
- [ ] T077 Remove the bespoke `tokens.css`/`theme.css` references from `_Layout.cshtml` and `_AuthLayout.cshtml` and delete the files from `wwwroot/css/` per FR-012/AC-001 and plan Phase A5 (contradicts)
- [ ] T078 Re-skin the remaining native pages onto the canonical CoreUI components per `docs/ui/COREUI_VISA_FUSION_MAPPING.md` (Admin Agents/Users/Holidays/ContentUpdate/SecurityDay, Agent Account/Entries/Statement/Statuses, Reporting DailyBill/DailyVisaFee/Pending/TodayCollection/TodaySubmission/TodayTransaction, Public DailyUpdate/Queries, Notifications placeholder) per FR-004/AC-005 (missing)
- [ ] T079 Remove the 19 per-page `@section SidebarNav` hard-coded nav trees so navigation renders only from `RoleAwareNavigation` per FR-003/NFR-002 and T017 (contradicts)
- [ ] T080 Create the 8 missing CoreUI test suites per plan Phase E and spec TS-001/002/003/005/006/008/009/012/013: `RoleAwareNavigationTests`, `CoreUIShellTests`, `CoreUIPageRenderingTests`, `CoreUIResponsiveTests`, `CoreUIAccessibilityTests`, `CoreUIApiRouteTests`, `CoreUIDatabaseTests`, `CoreUIVisualTests` (missing)
- [ ] T081 Complete the shell composition: wire `_PageHeader`/`_Breadcrumb` into `_Layout.cshtml` (currently commented out / never rendered) and render the sidebar via the canonical `_Sidebar.cshtml` partial instead of the inlined duplicate per FR-003/AC-004, Addendum §12, and plan Phase B (partial)
- [ ] T082 Complete the Knowledge Graph synchronization: reconcile `kg.json` to the 8-group navigation model, add the traceability-matrix rows, and run KG validation per FR-013/AC-013 and T064–T066 (partial)
- [ ] T083 Synchronize documentation: mark GAP-002 resolved in `docs/analysis/GAP_REPORT.md`, update `docs/analysis/UI_BASELINE.md` to the CoreUI state, and update `docs/ui/*` mapping statuses per constitution XIX and T067/T069 (partial)
- [ ] T084 Record the Public-pages URL-only navigation decision in `docs/ui/ROLE_NAVIGATION_MATRIX.md` §5.1 (the code implements URL-only but the matrix still lists the decision as open) per T018b (partial)
- [ ] T085 Review/remove the unrequested demo assets vendored into `wwwroot/lib/coreui/js/` (`charts.js`, `widgets.js`) and `wwwroot/lib/coreui/css/*.scss` per plan Phase A1 asset-scope constraint (unrequested)
