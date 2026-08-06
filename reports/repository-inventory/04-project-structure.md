# Project Structure

**Feature**: SPEC-0002
**Date**: 2026-08-06

## Scope

The physical and logical structure of the repository — top-level directories,
their contents, and how they group logically (legacy application, assets,
tooling, documentation, data).

## Entries

| Directory | Purpose | Contents (summary) | Group |
|-----------|---------|--------------------|-------|
| Root (`/`) | Legacy Classic ASP application root | 585 `.asp` pages + static content (see 01-repository-inventory.md) | LEGACY |
| `Demo/` | Demo copies of legacy pages | 1,423 files (ASP + assets) | LEGACY |
| `r&d/` | Research and development content | 2,898 files (ASP, HTM, assets) | LEGACY |
| `udaanuma-dev/` | Legacy "Udaan" site development content | 919 files (HTM, ASP, assets) | LEGACY |
| `updateimg/` | Image asset archive | 568 files (gif, jpg, png) | ASSET |
| `_vti_cnf/` | FrontPage version-control metadata | 420 metadata files | LEGACY |
| `images/` | Image assets | 196 files | ASSET |
| `forms/` | Visa application forms (PDF) | 102 files (PDF forms per country) | LEGACY |
| `assets/` | Static assets | 34 files | ASSET |
| `NewYear2006/` | Legacy seasonal content | 15 files | LEGACY |
| `_notes/` | Legacy metadata files | 23 `.mno` files | LEGACY |
| `.specify/` | Spec Kit tooling | 20 files (templates, scripts, memory) | TOOLING |
| `.vs/` | Visual Studio configuration | 26 files | TOOLING |
| `.opencode/` | Agent configuration | 12 files | TOOLING |
| `specs/` | SpecKit feature specifications | 18 files (SPEC-0001, SPEC-0002 + design artifacts) | DOCUMENTATION |
| `library/` | VisaFusion standards library | 17 files (16 standards docs + migration plan) | DOCUMENTATION |
| `adr/` | Architecture Decision Records | 2 files (ADR-0001, ADR-0002) | DOCUMENTATION |
| `findings/` | Live-verified legacy analysis | 3 files (exiting_architecture, deepanalysis, modernization_plan) | DOCUMENTATION |
| `knowledge-graph/` | Knowledge Graph | 2 files (kg.json, traceability-matrix.md) | DOCUMENTATION |
| `reports/` | Generated reports | 7 files (ai-environment-validation + this inventory) | DOCUMENTATION |
| `tests/` | Pester tests | 1 file (validate-ai-environment.Tests.ps1) | TOOLING |
| `scripts/` | Automation scripts | 2 files (validate-ai-environment.ps1, integrations.psd1) | TOOLING |
| `.github/` | CI workflows | 1 file (ai-environment-validation.yml) | TOOLING |
| `ActiveX/` | COM component archive | 1 file (OSSMTP.dll) | LEGACY |
| `css/` | Stylesheets | 9 files (adminlte.css variants, bootstrap-icons.css) | ASSET |
| `js/` | JavaScript | 4 files (adminlte.js + maps) | ASSET |
| `fonts/` | Font files | 1 file | ASSET |
| `UI/` | UI assets | 3 files | ASSET |
| `Templates/` | Templates | 0 files (empty) | ASSET |
| `HTML FOLDER/` | Legacy HTML content | 2 files | LEGACY |
| `.vscode/` | VS Code configuration | 1 file | TOOLING |

## Notes

- **Logical grouping** of the repository:
  - **LEGACY**: Root ASP application, `Demo/`, `r&d/`, `udaanuma-dev/`,
    `NewYear2006/`, `forms/`, `_vti_cnf/`, `_notes/`, `ActiveX/`, `HTML FOLDER/`
  - **ASSET**: `assets/`, `css/`, `js/`, `fonts/`, `images/`, `updateimg/`,
    `UI/`, `Templates/` (empty)
  - **TOOLING**: `.github/`, `.opencode/`, `.specify/`, `.vs/`, `.vscode/`,
    `scripts/`, `tests/`
  - **DOCUMENTATION**: `library/`, `findings/`, `specs/`, `adr/`,
    `knowledge-graph/`, `reports/`
- The legacy application is at the repository root; subdirectories contain
  demo/development copies (`Demo/`, `r&d/`, `udaanuma-dev/`) and asset
  archives (`updateimg/`, `images/`).
- `Templates/` is empty (0 files) — recorded for completeness per the
  "record, don't omit" rule (spec §18).
- `_vti_cnf/` is FrontPage metadata produced by legacy tooling; it mirrors the
  root ASP pages.