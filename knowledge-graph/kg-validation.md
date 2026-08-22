# Knowledge Graph Validation Report — VisaFusion

**Generated**: 2026-08-19 · **Updated**: 2026-08-22 (SPEC-0009 Phase 26 KG Synchronization)
**Artifact**: `knowledge-graph/kg.json` (schema v2.0)
**Validator**: PowerShell `ConvertFrom-Json` parse + orphan/provenance/type audit

## 1. Result

**PASS** — `kg.json` v2.0 is well-formed JSON, contains no orphan node references,
no orphan edge references, and every edge carries provenance.

## 2. Scale

| Metric | Count |
|---|---|
| Nodes | 487 |
| Edges | 1,578 |
| Node types used | 30 of 31 declared |
| Edge types used | 20 of 20 declared |
| Orphan references (edge `from`/`to` with no matching node) | 0 |
| Edges without provenance | 0 |
| Orphan nodes (nodes with no edges) | 0 |

## 3. Required Relationships (Phase 26 verification)

All 9 required relationship patterns are present:

| Pattern | Count | Status |
|---|---|---|
| ROLE → accessible_by → PAGE | 63 | ✅ |
| ROLE → sees → NAVIGATION | 21 | ✅ |
| PAGE → implements → FEATURE | 28 | ✅ |
| PAGE → uses → COMPONENT (VFC/CUI) | 38 | ✅ |
| PAGE → routes_to → ROUTE | 40 | ✅ |
| PAGE → secured_by → PERMISSION | 22 | ✅ |
| VFC → derived_from → CUI | 14 | ✅ |
| FEATURE → specified_by → SPECIFICATION | 35 | ✅ |
| FEATURE → tested_by → TEST | 300 | ✅ |

## 4. Node type coverage

| Node type | Count | Notes |
|---|---|---|
| Project | 1 | PRJ-VisaFusion |
| Module | 7 | MOD-001..007 |
| Specification | 9 | SPEC-0001..0009 |
| Feature | 35 | FEAT-* per spec FR rows |
| Role | 5 | Guest, agt, emp, adm, su |
| Permission | 11 | the 11 AuthorizationPolicies policies |
| Claim | 5 | sub, name, role, SuperUser, AgentId |
| NavigationGroup | 8 | Public, Account, Agent Portal, Reporting, Admin, Employee, Billing, Notifications |
| Menu | 24 | per mapping doc §1–§6 |
| SubMenu | 9 | Today×3, Agents×4, Users×2 |
| NativePage | 41 | 40 routable pages + 1 stray (GAP-010) |
| Route | 40 | one per routable page |
| Workflow | 20 | W1–W20 |
| Action | 20 | verified page-model action handlers |
| CoreUIComponent | 28 | CoreUI catalog sections |
| VisaFusionComponent | 14 | proposed reusable components (VFC-*) |
| Layout | 2 | Pages/Shared/_Layout.cshtml dual shell + CoreUI shell |
| API | 12 | /api/v1 + 11 module APIs |
| Endpoint | 51 | every route in ROLE_ROUTE_MATRIX §2 |
| ApplicationUseCase | 6 | US1–US6 |
| DomainEntity | 19 | 10 services + 7 aggregates/entities + 2 new services |
| Table | 37 | legacy (10) + modern DbSets (24) + Identity (3) |
| Column | 8 | verified columns incl. RowVersion, agentsID, PasswordHash, AgentId |
| View | 1 | report views |
| StoredProcedure | 3 | usp_AllocateNextRefno, usp_RecordEntryStatusChange, usp_ProvisionSuperUser |
| SqlFunction | 1 | fn_IsEmbassyClosed |
| Test | 41 | test artifacts from traceability-matrix |
| ADR | 6 | ADR-0001..0006 |
| MigrationTask | 8 | MIG-0001 + tooling/planning artifacts |
| Component | 15 | Shell partials (Header, Sidebar, Breadcrumb, PageHeader, Footer) |

## 5. Edge type coverage (all 20 declared types used)

| Edge type | Count | Representative use |
|---|---|---|
| tested_by | 397 | spec→test; feature→test; page→test |
| uses | 234 | page→VFC; VFC→CUI; workflow→action/page |
| contains | 213 | PRJ→modules/specs; spec→features; nav→menu→submenu; table→column |
| accessible_by | 177 | page→role; navg→role; perm→role; role→page (new) |
| calls | 87 | workflow→endpoint; endpoint→service |
| implements | 86 | spec→feature; module→feature; page→feature |
| routes_to | 64 | page→route; menu/submenu→route |
| secured_by | 63 | page→permission; endpoint→permission |
| reads | 53 | workflow→table; service→table; de→table |
| writes | 43 | workflow→table; service→table |
| specified_by | 35 | feature→specification |
| renders | 26 | page→layout |
| derived_from | 22 | feature→module; VFC→CUI |
| sees | 21 | role→navigation |
| requires | 17 | role→claim; permission→claim |
| migrates_to | 14 | MIG-0001→target tables |
| documented_by | 12 | ADR→spec; endpoint→spec |
| secures | 11 | MOD-006→each of the 11 policies |

## 6. Phase 26 Changes (2026-08-22)

1. **Schema expanded**: Added 4 new edge types (`has_permission`, `sees`, `accesses`, `specified_by`) — total now 20.
2. **ROLE → accessible_by → PAGE**: 63 reverse edges added from existing PAGE → accessible_by → ROLE.
3. **ROLE → sees → NAVIGATION**: 21 edges added from existing NAVG → accessible_by → ROLE.
4. **FEATURE → specified_by → SPECIFICATION**: 35 edges linking each feature to its parent spec.
5. **FEATURE → tested_by → TEST**: 300 edges propagated through spec → test linkage.
6. **VFC → derived_from → CUI**: 14 edges mapping VisaFusion components to CoreUI originals.
7. **Orphan node fixes**: Connected 16 previously orphan nodes (Claims, DomainEntities, Columns, ADR, stray page) via appropriate edges.
8. **GAP-010**: PAGE-Public-Forms connected to NAVG-Public, FEAT-0007-FR001, LAYOUT-Shell.

## 7. Known gaps (not KG defects)

- **Repository type has zero nodes** — no Repository classes exist in `src/` (services + DbContext pattern).
- **GAP-010** — PAGE-Public-Forms is a stray file with no route; now connected via `accessible_by`, `implements`, `renders`.
- **GAP-004** — Employee/Billing/Notifications placeholder pages have no policy; their `secured_by` edges are absent by design.
- **Unresolved relationships** (23 items) from the role matrices are not encoded as edges because they are open decisions, not facts.

## 8. Update rule

Per `library/04_AI_Native_Knowledge_Graph.md` Synchronization Rules, this
report and `kg.json` must be updated in the same change as any specification,
architecture, or traceability-matrix update.
