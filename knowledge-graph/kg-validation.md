# Knowledge Graph Validation Report — VisaFusion

**Generated**: 2026-08-19 · **Updated**: 2026-08-20 (SPEC-0009, ADR-0004, ADR-0006)
**Artifact**: `knowledge-graph/kg.json` (schema v2.0)
**Validator**: PowerShell `ConvertFrom-Json` parse + orphan/provenance/type audit (2026-08-19, 2026-08-20)

## 1. Result

**PASS** — `kg.json` v2.0 is well-formed JSON, contains no orphan node references,
and every edge carries provenance. The malformed v1.0 file (duplicate `MOD-007`
node; node objects embedded inside the `edges` array at lines 1295–1322) is
replaced.

## 2. Scale

| Metric | Count |
|---|---|
| Nodes | 485 |
| Edges | 1,110 |
| Node types used | 30 of 31 declared |
| Edge types used | 16 of 16 declared |
| Orphan references (edge `from`/`to` with no matching node) | 0 |
| Edges without provenance | 0 |

## 3. Node type coverage

| Node type | Count | Notes |
|---|---|---|
| Project | 1 | PRJ-VisaFusion |
| Module | 7 | MOD-001..007 (legacy mapping per traceability-matrix §Module→Legacy) |
| Specification | 9 | SPEC-0001..0009 (SPEC-0009 CoreUI UI Foundation added 2026-08-20) |
| Feature | 35 | FEAT-* per spec FR rows (SPEC-0001/0003/0005/0006/0007/0008) |
| Role | 5 | Guest, agt, emp, adm, su (IdentityIntegration.Roles + EffectiveRoles) |
| Permission | 11 | the 11 `AuthorizationPolicies` policies |
| Claim | 5 | sub, name, role, SuperUser, AgentId (IdentityClaims.FromUser) |
| NavigationGroup | 8 | Public, Account, Agent Portal, Reporting, Admin, Employee, Billing, Notifications |
| Menu | 24 | per mapping doc §1–§6 |
| SubMenu | 9 | Today×3, Agents×4, Users×2 |
| NativePage | 41 | 40 routable pages + 1 stray (`Pages.Forms.cshtml`, GAP-010) |
| Route | 40 | one per routable page (stray page has no route) |
| Workflow | 20 | W1–W20 (ROLE_WORKFLOW_MATRIX §1) |
| Action | 20 | verified page-model action handlers |
| CoreUIComponent | 28 | CoreUI catalog sections referenced by the mapping doc |
| VisaFusionComponent | 14 | proposed reusable components (VFC-*) |
| Layout | 2 | `Pages/Shared/_Layout.cshtml` dual shell + CoreUI shell |
| API | 12 | /api/v1 + 11 module APIs |
| Endpoint | 51 | every route in ROLE_ROUTE_MATRIX §2 (51 rows) |
| ApplicationUseCase | 6 | US1–US6 (per legacy context) |
| DomainEntity | 19 | 10 services + 7 aggregates/entities + 2 new services |
| **Repository** | **0** | **absent by design — no Repository classes exist in `src/`; the codebase uses the services + DbContext pattern. No nodes invented.** |
| Table | 37 | legacy (10) + modern DbSets (24) + Identity (3) |
| Column | 8 | verified columns incl. RowVersion, agentsID, PasswordHash, AgentId |
| View | 1 | report views (scripts 03) |
| StoredProcedure | 3 | usp_AllocateNextRefno, usp_RecordEntryStatusChange, usp_ProvisionSuperUser |
| SqlFunction | 1 | fn_IsEmbassyClosed |
| Test | 38 | test artifacts from traceability-matrix Test→Artifact maps |
| ADR | 6 | ADR-0001/0002/0003/0004/0005/0006 (0004 migration CLI, 0006 CoreUI adoption) |
| MigrationTask | 8 | MIG-0001 + tooling/planning artifacts |
| Component | 5 | Shell partials (Header, Sidebar, Breadcrumb, PageHeader, Footer) |

## 4. Edge type coverage (all 16 declared types used)

| Edge type | Count | Representative use |
|---|---|---|
| contains | 204 | PRJ→modules/specs; spec→features; nav→menu→submenu; API→endpoints; module→pages; shell→partials |
| uses | 193 | page→VFC; VFC→CUI; workflow→action/page; use case→service; spec→ADR; partial→service |
| tested_by | 83 | spec→test; page→test |
| accessible_by | 114 | permission→role; nav group→role; page→role |
| secured_by | 63 | page→permission; endpoint→permission |
| calls | 87 | workflow→endpoint; endpoint→service; service→stored proc |
| implements | 76 | spec→feature; module→feature; page→feature/spec; migration→spec |
| routes_to | 64 | page→route; menu/submenu→route |
| reads | 44 | workflow→table; service→table; module→table; proc/function→table |
| writes | 43 | workflow→table; service→table; proc→table |
| renders | 26 | page→layout |
| migrates_to | 14 | MIG-0001→target tables |
| secures | 11 | MOD-006→each of the 11 policies |
| requires | 9 | role→claim; permission→claim; su→adm |
| documented_by | 8 | ADR→spec; migration artifact→spec |
| derived_from | 8 | feature→module (legacy lineage) |
| documented_by | 8 | ADR→spec; migration artifact→spec |
| secures | 11 | MOD-006→each of the 11 policies |

## 5. Provenance

Every edge carries a `provenance` field naming the source document and the
verification date (2026-08-19). Sources: `traceability-matrix.md`,
`docs/ui/COREUI_VISA_FUSION_MAPPING.md`, the four `ROLE_*_MATRIX.md` docs,
`AuthorizationPolicies.cs`, `IdentityClaims.cs`, `Program.cs` (lines 340–819),
`VisaEntryDbContext.cs`, and `kg.json` v1.0 (for carried-forward nodes/edges).

## 6. Legacy v1.0 defects fixed

1. Duplicate `MOD-007` node (appeared once in `nodes` and again inside `edges`).
2. Node objects embedded in the `edges` array (lines 1295–1322) — now proper
   edge objects.
3. Non-declared edge types (`references`, `owns`, `generates`, `tests`,
   `validates`, `replaces`, `redirects_to`, `backed_by`, `blocking`, `amends`,
   `records`, `affects`, `documents`) replaced with the 16 declared types.
4. Non-declared node types (`Requirement`, `Domain Entity`, `Page`, `Test Case`,
   `Job`, `Risk`, `CodeQL Finding`, `Dependabot Alert`, `NDepend Rule`,
   `Trace Span`, `Catalog Entity`) mapped onto the 31 declared types.

## 7. Known gaps surfaced by the graph (not KG defects)

- **Repository type has zero nodes** — no Repository classes exist in `src/`
  (services + DbContext pattern). Recorded here so the type is not mistaken for
  an omission.
- **GAP-002** — CoreUI adoption vs bespoke `vf-*` shell gates every
  VFC→CUI `uses` edge (re-skin pending owner decision). **RESOLVED 2026-08-20** —
  ADR-0006 ratifies CoreUI as the design reference; the re-skin is complete
  (SPEC-0009 T076–T085) and the VFC→CUI `uses` edges are now grounded.
- **GAP-004** — Employee/Billing/Notifications placeholder pages have no
  policy and no spec; their `secured_by` edges are absent by design.
- **GAP-010** — `PAGE-Public-Forms` is a stray file with no route; it has no
  `routes_to` edge.
- **Unresolved relationships** (23 items) from the role matrices are not
  encoded as edges because they are open decisions, not facts.

## 8. Update rule

Per `library/04_AI_Native_Knowledge_Graph.md` Synchronization Rules, this
report and `kg.json` must be updated in the same change as any specification,
architecture, or traceability-matrix update.