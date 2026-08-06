# Repository Inventory

**Feature**: SPEC-0002
**Date**: 2026-08-06

## Scope

Complete listing of the VisaEntry repository contents (entire repository,
including the legacy Classic ASP application and modernization artifacts) with
their purpose. This covers top-level directories and files. Detailed legacy
page enumeration is in `05-legacy-inventory.md`; configuration files are in
`08-configuration-inventory.md`.

## Entries

### Top-level directories

| Path | Type | Category | Purpose | Source |
|------|------|----------|---------|--------|
| `.github/` | DIRECTORY | tooling | CI workflows (incl. `ai-environment-validation.yml`) | REPOSITORY |
| `.opencode/` | DIRECTORY | tooling | Agent configuration | REPOSITORY |
| `.specify/` | DIRECTORY | tooling | Spec Kit tooling (templates, scripts, memory/constitution) | REPOSITORY |
| `.vs/` | DIRECTORY | tooling | Visual Studio IDE configuration | REPOSITORY |
| `.vscode/` | DIRECTORY | tooling | VS Code IDE configuration | REPOSITORY |
| `ActiveX/` | DIRECTORY | legacy | COM component archive (`OSSMTP.dll`) | REPOSITORY |
| `adr/` | DIRECTORY | documentation | Architecture Decision Records (ADR-0001, ADR-0002) | REPOSITORY |
| `assets/` | DIRECTORY | asset | Static assets | REPOSITORY |
| `css/` | DIRECTORY | asset | Cascading style sheets | REPOSITORY |
| `Demo/` | DIRECTORY | legacy | Demo pages | REPOSITORY |
| `findings/` | DIRECTORY | documentation | Live-verified legacy analysis (exiting_architecture.md, deepanalysis.md, modernization_plan.md) | REPOSITORY |
| `fonts/` | DIRECTORY | asset | Font files | REPOSITORY |
| `forms/` | DIRECTORY | legacy | Legacy form pages | REPOSITORY |
| `HTML FOLDER/` | DIRECTORY | legacy | Legacy HTML content | REPOSITORY |
| `images/` | DIRECTORY | asset | Image files | REPOSITORY |
| `js/` | DIRECTORY | asset | JavaScript files | REPOSITORY |
| `knowledge-graph/` | DIRECTORY | documentation | Knowledge Graph (kg.json + traceability-matrix.md) | REPOSITORY |
| `library/` | DIRECTORY | documentation | VisaFusion standards library (16 docs) | REPOSITORY |
| `NewYear2006/` | DIRECTORY | legacy | Legacy seasonal content | REPOSITORY |
| `r&d/` | DIRECTORY | legacy | Research and development content | REPOSITORY |
| `reports/` | DIRECTORY | documentation | Generated reports (incl. ai-environment-validation/) | REPOSITORY |
| `scripts/` | DIRECTORY | tooling | Automation scripts (incl. ai-environment-validation/) | REPOSITORY |
| `specs/` | DIRECTORY | documentation | SpecKit feature specifications (SPEC-0001, SPEC-0002) | REPOSITORY |
| `Templates/` | DIRECTORY | asset | Templates | REPOSITORY |
| `tests/` | DIRECTORY | tooling | Pester tests | REPOSITORY |
| `udaanuma-dev/` | DIRECTORY | legacy | Legacy development content | REPOSITORY |
| `UI/` | DIRECTORY | asset | UI assets | REPOSITORY |
| `updateimg/` | DIRECTORY | asset | Update image assets | REPOSITORY |
| `_notes/` | DIRECTORY | legacy | Legacy metadata | REPOSITORY |
| `_vti_cnf/` | DIRECTORY | legacy | FrontPage version-control metadata | REPOSITORY |

### Top-level files (by group)

| Path | Type | Category | Purpose | Source |
|------|------|----------|---------|--------|
| `*.asp` (585 files) | FILE | legacy | Legacy Classic ASP application pages | REPOSITORY |
| `*.htm` (21 files) | FILE | legacy | Static HTML pages | REPOSITORY |
| `*.html` (8 files) | FILE | legacy | Static HTML pages | REPOSITORY |
| `*.jpg` (18 files) | FILE | asset | Image files | REPOSITORY |
| `*.png` (7 files) | FILE | asset | Image files | REPOSITORY |
| `*.gif` (7 files) | FILE | asset | Image files | REPOSITORY |
| `*.zip` (3 files) | FILE | legacy | Archived legacy files (e.g., editdonebyagent1.zip) | REPOSITORY |
| `*.db` (Thumbs.db) | FILE | asset | Windows thumbnail cache | REPOSITORY |
| `*.css` (Styles.css) | FILE | asset | Site stylesheet | REPOSITORY |
| `*.js` (datecheck.js) | FILE | asset | Client-side date validation | REPOSITORY |
| `*.sql` (database.sql) | FILE | data | SQL Server schema (52-table) | REPOSITORY |
| `*.dll` (msoe.dll) | FILE | legacy | Legacy binary (referenced by legacy pages) | REPOSITORY |
| `*.doc` (cargo.doc) | FILE | legacy | Legacy document | REPOSITORY |
| `*.x3d` (Malaysia.x3d) | FILE | asset | 3D content file | REPOSITORY |
| `opencode.json` | FILE | tooling | Agent configuration | REPOSITORY |
| `.gitignore` | FILE | tooling | Git ignore rules | REPOSITORY |
| `.DS_Store`, `._DS_Store`, `._Thumbs.db`, `._udaanuma-dev` | FILE | asset | macOS/Finder metadata files | REPOSITORY |
| `alger`, `ALGERIA`, `azer` | FILE | legacy | Extensionless legacy data files | REPOSITORY |
| `conditionalHeaders` | FILE | legacy | Extensionless header data | REPOSITORY |
| `databaseInstructions` | FILE | data | Database setup instructions | REPOSITORY |
| `newpic` | FILE | legacy | Extensionless image data | REPOSITORY |
| `paginationFormula` | FILE | legacy | Extensionless pagination data | REPOSITORY |
| `sessionCheck` | FILE | legacy | Extensionless session-check data | REPOSITORY |
| `Udaan_logo` | FILE | asset | Logo image data (extensionless) | REPOSITORY |
| `visa come`, `visa come 2`, `visa come2`, `visa come3` | FILE | legacy | Extensionless visa content files | REPOSITORY |

## Notes

- The 585 `.asp` files are enumerated in detail in `05-legacy-inventory.md`.
- Files without extensions (`sessionCheck`, `conditionalHeaders`, etc.) are
  recorded as legacy data artifacts; their classification is based on filename
  and context (spec §18: unclassified items are recorded, not omitted).
- macOS/Finder metadata files (`.DS_Store`, `._*`, `Thumbs.db`) are repository
  noise but are recorded for completeness per the contract (C-005: every entry
  traces to a real artifact).
- This inventory is a snapshot of branch `002-repository-inventory` @ `701b35d`
  (see README.md).