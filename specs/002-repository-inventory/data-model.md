# Data Model: Repository Inventory

**Feature**: SPEC-0002 — Repository Inventory
**Date**: 2026-08-06

## Purpose

Defines the data model for the inventory documentation deliverable. This is a
documentation data model — it defines the structure and attributes of the
inventory documents, not a database schema. No database changes are made
(§16 of the spec).

## Entities

### 1. Repository Artifact

Represents a physical file or directory in the repository.

| Field | Type | Description |
|-------|------|-------------|
| Path | string | Repository-relative path (e.g., `connection.asp`) |
| Type | enum | FILE or DIRECTORY |
| Category | enum | legacy, asset, tooling, documentation, configuration, data, script |
| Purpose | string | What the artifact is used for |
| Source | enum | REPOSITORY, FINDING, or BOTH |

**Relationships**:
- A Repository Artifact MAY be referenced by a Technology (detected via extension/content).
- A Repository Artifact MAY be a Legacy Page (if `.asp`).
- A Repository Artifact MAY be a Configuration Item (if config).

### 2. Technology

Represents a technology, language, or framework detected in the repository.

| Field | Type | Description |
|-------|------|-------------|
| Name | string | Technology name (e.g., "Classic ASP / VBScript") |
| Category | enum | language, framework, database, web, scripting, protocol |
| Evidence | list<string> | Files/extensions/content proving presence |
| Confidence | enum | HIGH, MEDIUM, LOW |
| Status | enum | ACTIVE, LEGACY, DEPRECATED |

**Relationships**:
- Detected FROM one or more Repository Artifacts.
- MAY be associated with External Dependencies or COM Components.

### 3. Dependency

Represents a relationship between repository components or between a component
and an external service.

| Field | Type | Description |
|-------|------|-------------|
| Source | string | Source artifact or component |
| Target | string | Target artifact, component, or service |
| Type | enum | include, data-access, mail, http, filesystem, database |
| Evidence | string | Where the relationship was observed |

**Relationships**:
- A Dependency connects two Repository Artifacts or a Repository Artifact and
  an External Service.

### 4. Legacy Page

Represents a legacy Classic ASP page or module.

| Field | Type | Description |
|-------|------|-------------|
| Path | string | Repository path (e.g., `login.asp`) |
| Module | string | Legacy module (from `@findings/modernization_plan.md` §6 module map) |
| Role | enum | page, include, data-access, utility |
| Data Access | boolean | Whether it accesses the database |
| Auth Level | enum | public, authenticated, admin, agent |

**Relationships**:
- A Legacy Page IS A Repository Artifact.
- Maps to a Module from the findings.

### 5. External Dependency

Represents a third-party library, service, or system the application depends on.

| Field | Type | Description |
|-------|------|-------------|
| Name | string | Dependency name (e.g., "Microsoft SQL Server") |
| Type | enum | service, library, protocol |
| Used By | list<string> | Artifacts that reference it |
| License | string | License if known (or UNKNOWN) |
| Security Note | string | Any security concern (without secrets) |

**Relationships**:
- Used by one or more Repository Artifacts.
- MAY map to a COM Component (if COM-based).

### 6. COM Component

Represents a COM/ActiveX component referenced by the legacy application.

| Field | Type | Description |
|-------|------|-------------|
| ProgID | string | e.g., `adodb.recordset` |
| Assembly/File | string | Underlying binary if known (e.g., `OSSMTP.dll`) |
| Reference Count | integer | Number of references across `.asp` files |
| Purpose | string | What it provides |
| Security Note | string | Legacy/security concern (no secrets) |

**Relationships**:
- Referenced by one or more Legacy Pages.
- MAY be archived under `ActiveX/`.

### 7. Configuration Item

Represents a configuration file, connection string, or setting.

| Field | Type | Description |
|-------|------|-------------|
| Artifact | string | Config file path (e.g., `connection.asp`) |
| Setting | string | Setting name (e.g., database connection string) |
| Value Summary | string | Description of the value WITHOUT secrets (e.g., "SQL Server, database=visaentry, server=local") |
| Secret | boolean | Whether the value contains secrets |
| Status | enum | ACTIVE, LEGACY, SUSPECTED-BACKDOOR |

**Relationships**:
- A Configuration Item IS A Repository Artifact.

## Validation rules (from spec §17)

- Each inventory category is validated against the actual repository contents.
- The inventory is cross-checked against the findings documents.
- Any listed artifact exists in the repository or is explicitly marked as a
  documented finding.
- Configuration Items with secrets never reproduce the secret value (AC-005).

## State transitions

Not applicable — this is a static documentation deliverable with no runtime
state.

## Data volume assumptions

- ~600 root files (585 `.asp` + others).
- 52-table SQL Server schema (documented, not modified).
- 8 distinct COM ProgIDs referenced.
- 16 library documents, 2 ADRs, 3 findings documents.
