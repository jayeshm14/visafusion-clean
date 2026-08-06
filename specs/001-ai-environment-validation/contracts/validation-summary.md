# Contracts: AI Environment Validation

**Date**: 2026-08-06 | **Spec**: [spec.md](../spec.md) | **Data model**: [data-model.md](../data-model.md)

This feature exposes one machine-readable contract: the JSON summary produced
by the validation run (`summary.json`). It is consumed by the CI gate (pass/fail
decision) and by the Knowledge Graph update step (status ingestion).

## `summary.json` — Validation Summary (v1)

The schema below is the contract. Producers MUST emit exactly this shape;
consumers MUST NOT depend on additional undocumented fields.

```json
{
  "$schema": "contracts/validation-summary.v1.schema.json",
  "version": 1,
  "runDate": "2026-08-06T12:00:00Z",
  "sourceDirs": ["findings", "library"],
  "passed": true,
  "summary": {
    "validated": 12,
    "partial": 0,
    "missing": 0,
    "contradictory": 0
  },
  "integrations": [
    {
      "id": "graphrag",
      "name": "GraphRAG",
      "governingDoc": "library/05_GraphRAG_and_MCP.md",
      "workflowDirective": true,
      "constitutionPrinciple": "IV",
      "status": "validated",
      "provenance": [
        "library/05_GraphRAG_and_MCP.md:7"
      ]
    }
  ]
}
```

### Field definitions

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `version` | integer | yes | Schema version (currently `1`) |
| `runDate` | string (ISO 8601) | yes | Date/time of the run |
| `sourceDirs` | string[] | yes | Authoritative source folders scanned |
| `passed` | boolean | yes | `true` iff every integration is `validated` |
| `summary.validated` | integer | yes | Count of `validated` integrations |
| `summary.partial` | integer | yes | Count of `partial` integrations |
| `summary.missing` | integer | yes | Count of `missing` integrations |
| `summary.contradictory` | integer | yes | Count of `contradictory` integrations |
| `integrations[]` | array | yes | Per-integration results (exactly 12 entries) |
| `integrations[].id` | string | yes | Canonical integration identifier |
| `integrations[].name` | string | yes | Display name |
| `integrations[].governingDoc` | string | yes | Primary governing document |
| `integrations[].workflowDirective` | boolean | yes | Workflow directive present (BR-002) |
| `integrations[].constitutionPrinciple` | string | yes | Anchoring constitution principle |
| `integrations[].status` | enum | yes | `validated` / `partial` / `missing` / `contradictory` |
| `integrations[].provenance` | string[] | yes | Source file + line evidence |

### Status contract

- `status = validated` iff all four validation rules (spec §17) hold.
- `passed = true` iff all 12 integrations are `validated`.
- CI gate: merge is blocked when `passed` is `false`.

### Versioning

- Changes to field names, types, or required-ness are breaking and require a
  schema version bump (`version: 2`) plus an ADR.
- Additive, optional fields are non-breaking; bump the minor by documenting
  the addition in this file.