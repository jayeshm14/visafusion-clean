# Research: Repository Inventory

**Feature**: SPEC-0002 — Repository Inventory
**Date**: 2026-08-06
**Branch**: `002-repository-inventory`

## Purpose

This document consolidates the research performed in Phase 0 of
`/speckit.plan` for SPEC-0002. It resolves the technical unknowns for the
inventory deliverable and documents the evidence base that the inventory
documents will be derived from.

## Method

The research was performed against the live repository state and the
live-verified findings documents. Inventory data is derived from:

- Actual repository contents (file system enumeration, file-type distribution,
  directory structure).
- Content inspection of key artifacts (connection strings, COM object
  references, include references).
- `@findings/exiting_architecture.md`, `@findings/deepanalysis.md`, and
  `@findings/modernization_plan.md` as the authoritative legacy baseline.

## Decision 1: Inventory deliverable location and structure

- **Decision**: The inventory is delivered as one markdown file per category
  under `reports/repository-inventory/`, with a `README.md` index and a
  `discrepancies.md` for repository-vs-findings discrepancies.
- **Rationale**: Matches the eight categories in the feature description,
  keeps each category independently reviewable, and separates discrepancy
  reporting per BR-002.
- **Alternatives considered**:
  - Single monolithic markdown file — rejected: harder to review per category
    and to maintain incrementally.
  - Inventory under `specs/` — rejected: the deliverable is a repository-level
    baseline, not a spec artifact.

## Decision 2: Scope boundary

- **Decision**: The inventory covers the ENTIRE repository — the legacy Classic
  ASP application plus the modernization artifacts (`library/`, `findings/`,
  `specs/`, `scripts/`, `adr/`, `knowledge-graph/`, `reports/`, `tests/`,
  `.github/`, `.opencode/`, `.specify/`).
- **Rationale**: Per clarification Q1 (user selected Option A — "entire
  repository").
- **Alternatives considered**: Legacy-only scope (rejected by user choice).

## Decision 3: Validation approach

- **Decision**: Static documentation with manual review; no automated CI
  enforcement.
- **Rationale**: Per clarification Q2 (user selected Option B). The feature
  description explicitly says "Output markdown only" and "No implementation."
- **Alternatives considered**: CI gate (rejected by user choice); reproducibility
  script without CI (not chosen).

## Repository evidence gathered

### Top-level directory structure

| Directory | Purpose |
|-----------|---------|
| `.github/` | CI workflows (incl. `ai-environment-validation.yml`) |
| `.opencode/` | Agent configuration |
| `.specify/` | Spec Kit tooling (templates, scripts, memory/constitution) |
| `.vs/`, `.vscode/` | IDE configuration |
| `ActiveX/` | COM component archive (`OSSMTP.dll`) |
| `adr/` | Architecture Decision Records (ADR-0001, ADR-0002) |
| `assets/`, `css/`, `fonts/`, `images/`, `js/`, `UI/`, `updateimg/`, `Templates/` | Static web assets and templates |
| `Demo/` | Demo pages |
| `findings/` | Live-verified legacy analysis (`exiting_architecture.md`, `deepanalysis.md`, `modernization_plan.md`) |
| `forms/`, `HTML FOLDER/`, `NewYear2006/`, `r&d/`, `udaanuma-dev/`, `_notes/`, `_vti_cnf/` | Legacy content and FrontPage artifacts |
| `knowledge-graph/` | kg.json + traceability-matrix.md (Principle IV) |
| `library/` | VisaFusion standards library (16 docs) |
| `reports/` | Generated reports (incl. `ai-environment-validation/`) |
| `scripts/` | Automation scripts (incl. `ai-environment-validation/`) |
| `specs/` | SpecKit feature specifications (SPEC-0001, SPEC-0002) |
| `tests/` | Pester tests |

### File-type distribution (root)

| Extension | Count | Notes |
|-----------|-------|-------|
| `.asp` | 585 | Legacy Classic ASP pages |
| `.htm` | 21 | Static HTML |
| `.jpg` | 18 | Images |
| `.html` | 8 | Static HTML |
| `.png` | 7 | Images |
| `.gif` | 7 | Images |
| `.zip` | 3 | Archived legacy files |
| `.db` | 2 | Database files (likely backups) |
| `.css` | 1 | `Styles.css` |
| `.js` | 1 | `datecheck.js` |
| `.sql` | 1 | `database.sql` (52-table schema) |
| `.dll` | 1 | `msoe.dll` (root) |
| `.doc` | 1 | `cargo.doc` |
| `.x3d` | 1 | `Malaysia.x3d` |
| `.json` | 1 | `opencode.json` |

### Key configuration artifacts

| Artifact | Content observed |
|----------|------------------|
| `connection.asp` | `DRIVER={SQL Server};SERVER=.;uid=sa;pwd=sa123;DATABASE=visaentry` — **plaintext credentials (security finding)** |
| `connectionold.asp`, `connectionweb.asp` | Legacy/alternate connection variants |
| `database.sql` | 52-table SQL Server schema |
| `opencode.json` | Agent configuration |

### COM object references (from `.asp` content)

| ProgID | Count | Notes |
|--------|-------|-------|
| `adodb.recordset` | 554 | ADO Recordset |
| `adodb.connection` | 4 | ADO Connection |
| `CDONTS.Newmail` | 18 | Legacy mail (CDONTS) |
| `CDO.Message` | 5 | Collaborative Data Objects |
| `CDO.Configuration` | 3 | CDO config |
| `OSSMTP.SMTPSession` | 7 | OSSMTP — `ActiveX/OSSMTP.dll` |
| `scripting.filesystemObject` | 6 | File system access |
| `MSXML2.ServerXMLHTTP` | 2 | HTTP client |

Security note: `CDONTS.Newmail`, `scripting.filesystemObject`, and plaintext
credentials are legacy security concerns; the inventory records these without
reproducing secret values (Security §12, AC-005).

## External dependencies

External dependencies are derived from the COM references above (mail servers
via CDONTS/CDO/OSSMTP, SQL Server via ADO) and legacy third-party libraries.
Full enumeration is performed in the inventory implementation phase
(`06-external-dependencies.md`, `07-com-dependencies.md`).

## Unknowns resolution

All `NEEDS CLARIFICATION` items from the plan's technical context are resolved:

- **Language/Version**: Markdown (no code language) — resolved.
- **Primary Dependencies**: None (static documentation) — resolved.
- **Storage**: N/A — deliverable is markdown files — resolved.
- **Testing**: Manual review checklist (NFR-004) — resolved.
- **Target Platform**: N/A — resolved.
- **Project Type**: Documentation deliverable — resolved.
- **Performance Goals**: N/A (not a runtime service) — resolved.
- **Constraints**: Markdown only; no implementation; no secrets — resolved.
- **Scale/Scope**: Entire repository — resolved.

No remaining unknowns.
