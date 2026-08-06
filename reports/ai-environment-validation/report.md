# AI Environment Validation Report

**Run date**: 2026-08-06T17:18:32.7636423Z
**Source directories**: findings, library
**Overall**: 12/12 validated â€” 0 partial, 0 missing, 0 contradictory
**Result**: PASS

## Summary

| Status | Count |
|--------|-------|
| validated | 12 |
| partial | 0 |
| missing | 0 |
| contradictory | 0 |

## Traceability Matrix

| Integration | Name | Governing Document | Directive | Principle | Status |
|---|---|---|---|---|---|
| graphrag | GraphRAG | library/05_GraphRAG_and_MCP.md | True | IV | validated |
| mcp | Model Context Protocol (MCP) | library/05_GraphRAG_and_MCP.md | True | IV | validated |
| adr | Architecture Decision Records (ADRs) | library/07_DDD_CleanArchitecture_C4_ADR.md | True | IV | validated |
| c4 | C4 Model Diagrams | library/07_DDD_CleanArchitecture_C4_ADR.md | True | IV | validated |
| ddd | Domain-Driven Design (DDD) | library/07_DDD_CleanArchitecture_C4_ADR.md | True | IV | validated |
| event-storming | Event Storming | library/07_DDD_CleanArchitecture_C4_ADR.md | True | IV | validated |
| docs-as-code | Docs-as-Code | library/06_GitHub_Engineering_Standards.md | True | V | validated |
| backstage | Backstage Software Catalog | library/04_AI_Native_Knowledge_Graph.md | True | IV | validated |
| opentelemetry | OpenTelemetry | library/11_Testing_Observability_DevSecOps.md | True | V | validated |
| codeql | CodeQL | library/06_GitHub_Engineering_Standards.md | True | V | validated |
| dependabot | Dependabot | library/06_GitHub_Engineering_Standards.md | True | V | validated |
| ndepend | NDepend | library/07_DDD_CleanArchitecture_C4_ADR.md | True | IV | validated |

## Gap Report

**No gaps found.** All 12 integrations are validated.

## Provenance

Per-integration evidence (source file + line) is recorded in the
summary.json artifact (machine-readable).
