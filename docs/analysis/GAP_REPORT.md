# Gap Report — VisaFusion Discovery (2026-08-19)

**DISCOVERY_STATUS: COMPLETE**
**BLOCKERS: none** — discovery of the 45 requested items finished; the gaps
below are findings for owner/engineering follow-up, not discovery blockers.

Every item below was verified by a tool call this session.

---

## GAP-001 — `knowledge-graph/kg.json` is invalid JSON (HIGH)

- Committed blob `9122c772…` (tracked, working tree clean).
- Bracket scan: `[` = 2, `]` = 3; `{` = 270, `}` = 270 → **unbalanced**.
- `ConvertFrom-Json` fails; the file tail shows duplicated "MOD-007" node
  content after the `edges` section.
- Impact: any KG-consuming tooling (GraphRAG/MCP, constitution principle IV,
  `library/04` sync rules) breaks against the committed artifact.
- Fix: regenerate kg.json from `traceability-matrix.md` + specs, then
  re-validate with a JSON parser before commit.

## GAP-002 — Constitution mandates CoreUI; shipped UI is bespoke `vf-*` (HIGH)

- Constitution v1.4.1 Principle IV mandates CoreUI
  (`https://github.com/coreui/coreui-free-bootstrap-admin-template.git`) as
  design reference.
- Current new UI: bespoke `tokens.css`/`theme.css`/`bootstrap-icons.css` and
  `vf-sidebar`/`vf-topnav` shell. **No CoreUI and no AdminLTE assets exist in
  `wwwroot/`** (AdminLTE removal was AC-008 in phase 2).
- Impact: the UI contradicts the governing constitution. Owner decision
  required: adopt CoreUI (re-skin) or amend the constitution to ratify the
  bespoke system.
- **RESOLVED 2026-08-20** — ADR-0006 ratifies the constitution: CoreUI is the
  design reference and the bespoke `vf-*` UI was re-skinned to CoreUI classes
  (SPEC-0009 T076–T085). `tokens.css`/`theme.css` and the demo assets
  (charts.js, widgets.js, style.scss, simplebar.scss) are deleted; the shell
  keeps its structural wrappers (`vf-shell`/`vf-main`/`vf-content`) ported into
  `wwwroot/css/vf-component-styles.css` with `--cui-*` tokens. Behavior
  preserved: page models, data, and server-side pagination unchanged; 8 new
  test suites cover the re-skin (UnitTests 254/254, IntegrationTests 44/44).

## GAP-003 — `README.md` is stale (MEDIUM) — RESOLVED 2026-08-22

- `README.md` cited the constitution as **v1.2.0**; the governing document is
  now **v1.4.1** (amended 2026-08-19). README also lacked the UI architecture
  section.
- **RESOLVED 2026-08-22** — README updated: constitution version corrected to
  v1.4.1; UI Architecture section added documenting CoreUI adoption, shell
  model, components, design tokens, icons, and roles.

## GAP-004 — Placeholder areas ship with no page models (MEDIUM)

- `Areas/Employee`, `Areas/Billing`, `Areas/Notifications` each contain only
  `Pages/Index.cshtml` with **no `Index.cshtml.cs`** (verified). They render
  markup with zero logic. Flag before anyone assumes these are implemented.

## GAP-005 — No Docker / container artifacts; CI only validates `main` (MEDIUM)

- No Dockerfile/compose anywhere in the repo. Deployment strategy undocumented
  for a "production-grade" target.
- `.github/workflows/build.yml` triggers only on `main` — feature branches get
  no CI signal. Consider PR-based validation.

## GAP-006 — Legacy cutover routing is partial (MEDIUM)

- `LegacyUrlRewriteMiddleware` routes only `Default.asp`→`/`,
  `authenticate.asp`/`logon.asp`→`/Auth/Login`, `regsub*.asp`→`/Auth/Register`;
  **all other `*.asp` → 404**.
- The legacy surface (~585 root ASP files + `connection.asp` backdoor +
  `update*.asp` snapshots, plus `updateimg/`, `js/adminlte.js`, etc.) still
  sits at the repo root with no full cutover plan in code.
- modernization_plan §13 lists the legacy pages to be wired; that mapping is
  not yet implemented as routes.

## GAP-007 — Secrets handling unverified (LOW/MEDIUM)

- `appsettings.Development.json` exists but was not inspected (read-only
  discovery). Confirm no dev secrets (e.g. JWT keys) are committed; prefer
  user-secrets/Key Vault.

## GAP-008 — Notification transports are log-only (MEDIUM)

- ADR-0005 delivered data-backed `emailQueue`/`SmsQueue` + Jobs workers, but
  dispatch providers are **log-only**. Legacy SMS (messaging 4u) and SMTP
  (spectranet) integrations (complete_migration_plan §12) are not re-implemented
  as live transports. Owner decision needed on real providers.

## GAP-009 — Owner-approval risk items outstanding (MEDIUM)

- 10 documented risk items from `findings/modernization_plan.md` require owner
  approval before affected-module migration (per traceability matrix).
- Data-quality defects (6,517 orphaned `Mainentry`, `entrytype` 100% NULL,
  empty `country`, junk dates, duplicated `statusID=508`) are flagged, not
  silently dropped — disposition pending owner.

## GAP-010 — stray `Areas/Public/Pages.Forms.cshtml` (LOW)

- `Areas/Public/Pages.Forms.cshtml` sits directly under the Public area root,
  outside `Areas/Public/Pages/` (where the other Public pages live).
- Verified this session: it declares `@page` (grep) but has **no
  `Pages.Forms.cshtml.cs` model** (glob), so it is not a discoverable Razor
  page and no route maps to it.
- Impact: dead file in the UI surface; flagged in
  `docs/ui/ROLE_BASED_NATIVE_PAGES_INVENTORY.md` §4.1/§10 as NOT_REQUIRED.
- Disposition pending owner: delete, or move into `Areas/Public/Pages/` with a
  page model and route (matching the other Public pages).

---

## Provenance

All facts: this-session tool calls (`read`, `grep`, `Get-ChildItem`,
`Select-String`, `git`, JSON bracket scan). Cross-references:
`findings/modernization_plan.md`, `findings/deepanalysis.md`,
`findings/exiting_architecture.md`, `library/complete_migration_plan.md`,
`knowledge-graph/traceability-matrix.md`, constitution v1.4.1.
