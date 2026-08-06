# Data Model: AI Environment Validation

**Date**: 2026-08-06 | **Spec**: [spec.md](spec.md) | **Plan**: [plan.md](plan.md)

This feature is a governance/validation workflow, not a business module, so it
has no business database model. The "data" is the validation model consumed by
the script, the CI gate, and the Knowledge Graph. No database changes are made
(Constitution Principle III).

## Entities

### Integration

The 12 documented engineering integrations under validation.

| Field | Type | Description |
|-------|------|-------------|
| `id` | string | Canonical identifier (e.g., `graphrag`, `mcp`, `adr`, `c4`, `ddd`, `event-storming`, `docs-as-code`, `backstage`, `opentelemetry`, `codeql`, `dependabot`, `ndepend`) |
| `name` | string | Display name (e.g., "GraphRAG") |
| `canonicalTerm` | string[] | Search terms used to scan `findings/` and `library/` |
| `governingDoc` | string | Primary governing document (e.g., `library/05_GraphRAG_and_MCP.md`) |
| `workflowDirective` | boolean | Whether a workflow directive (not just a name mention) exists (BR-002) |
| `constitutionPrinciple` | string | Constitution principle that anchors the integration (e.g., "IV") |
| `status` | enum | `validated` / `partial` / `missing` / `contradictory` (FR-005) |
| `provenance` | string[] | Source file + line evidence for each finding (FR-004) |

### 2. ValidationResult

The dated result of one validation run.

| Field | Type | Description |
|-------|------|-------------|
| `runDate` | string (ISO 8601) | Date/time of the run |
| `integrations` | Integration[] | Per-integration status |
| `summary` | object | Aggregate counts by status |
| `passed` | boolean | True when all 12 integrations are `validated` |

### 3. Report artifacts

| Artifact | Format | Purpose |
|----------|--------|---------|
| `report.md` | Markdown | Human-readable validation report (FR-007) |
| `summary.json` | JSON | Machine-readable summary consumed by CI gate and Knowledge Graph (FR-007) |

## Validation rules (from spec §17)

An integration is `validated` only when ALL hold:
- (a) a governing document exists in `findings/` or `library/`;
- (b) a workflow directive exists (not just a name mention) — BR-002;
- (c) a constitution principle anchors the integration;
- (d) no contradiction exists across the authoritative sources.

## State transitions

- `missing` → `validated` when a governing doc + workflow directive is added.
- `partial` → `validated` when the missing evidence (workflow directive or
  principle anchor) is added.
- `contradictory` → `validated` when the contradiction is resolved.
- Any non-`validated` status fails the CI gate (blocks merge).

## Scale assumptions

- 12 integrations; ~20 authoritative docs (17 `library/` + 3 `findings/`).
- One report directory; one report per run (overwritten on re-run).