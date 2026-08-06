# Feature Specification: Project Modernization Baseline

**Identifier**: SPEC-0001
**Title**: Project Modernization Baseline
**Status**: Approved
**Created**: 2026-08-06
**Category**: epics
**Input**: User description: "Modernize the legacy Classic ASP VisaEntry application to ASP.NET Core VisaFusion without changing business behavior."

## 1. Identifier

- **SPEC-0001**: Project Modernization Baseline

## 2. Title

Project Modernization Baseline — VisaFusion (Royal Routes / Udaan Visa)

## 3. Objective

Establish the authoritative baseline specification for the VisaFusion modernization
program: a production-grade ASP.NET Core platform that reproduces the business behavior
of the legacy Classic ASP VisaEntry system (585 live root ASP files, 52-table SQL Server
schema, production data 2001-12-02 → 2026-04-21) without changing business behavior and
without data loss.

## 4. Business Context

The legacy VisaEntry application (branding "Royal Routes", legacy "Udaan India") is a
Classic ASP / VBScript system backed by SQL Server. It manages visa processing, agents,
billing, notifications (SMS/email), and reporting. Live-verified analysis
(`findings/modernization_plan.md`, `findings/exiting_architecture.md`,
`findings/deepanalysis.md`) documents the module map, 52-table schema, RBAC gaps (0 of 585
pages enforce role denial), anonymous write endpoints, a backdoor in `connection.asp`,
plaintext credentials, and 6,517 orphaned Mainentry→agent rows.

The modernization must preserve business behavior exactly, preserve all production data,
and eliminate the documented security and maintainability defects.

## 5. Scope

- Full-stack modernization to ASP.NET Core, EF Core, SQL Server, ASP.NET Core Identity.
- Specification-Driven Development governed by SpecKit and the VisaFusion constitution.
- Migration of all 52 business tables and production data.
- RBAC with role-based authorization on every protected surface.
- Removal of the `connection.asp` backdoor and anonymous write endpoints.
- Knowledge Graph and traceability artifacts maintained with every work item.

## 6. Out of Scope

- Deletion or semantic change of production data.
- Dropping business tables (only `dtproperties` may be removed).
- New business features not present in the legacy system.
- Migration of duplicate codebases (`Demo/`, `udaanuma-dev/`, `r&d/`, `r&d/demo/`) — these
  are archived, not migrated.

## 7. Stakeholders

- VisaFusion engineering agents (orchestrator, product, architecture, database, backend,
  frontend, QA, security, DevSecOps, documentation).
- System owners (Royal Routes / Udaan India operations).
- End users: agents, employees, administrators.
- GitHub as the single system of record.

## 8. Legacy Mapping

- 585 live root ASP files catalogued in `%TEMP%\opencode\root_asp_list.txt`.
- Module map per `findings/modernization_plan.md` §6 and §13.
- DB schema dump per `%TEMP%\opencode\schema_dump.txt` and `modernization_plan.md` appendix.
- Key legacy files: `connection.asp` (DB + helpers + backdoor), `listforagents.asp` (agent
  status view), `insertEntry.asp` (anonymous entry insert), `SendSMS.asp` (SMS gateway).

## 9. Functional Requirements

- **FR-001**: The platform MUST reproduce every legacy business rule for visa entry,
  status transitions, agent management, and billing.
- **FR-002**: The platform MUST migrate and preserve all 52 business tables and all
  production rows.
- **FR-003**: The platform MUST provide role-based access control for every protected page
  and API, denying access by default.
- **FR-004**: The platform MUST support agent identity without query-string tampering
  (`jn=` must be removed).
- **FR-005**: The platform MUST send SMS and email notifications using secured credentials.
- **FR-006**: The platform MUST report the same metrics and views as the legacy system.
- **FR-007**: The platform MUST remove the `connection.asp` backdoor and all anonymous
  write endpoints.
- **FR-008**: The platform MUST maintain a Knowledge Graph and traceability matrix that
  map every requirement to architecture, domain, database, API, UI, test, and migration.

## 10. Business Rules

- **BR-001**: Legacy behavior is the source of truth; ambiguous behavior produces a Gap
  Report, never a guess.
- **BR-002**: Only `dtproperties` may be dropped; all other business tables are preserved.
- **BR-003**: Every schema change is validated before and after and is reversible where
  practical.
- **BR-004**: No plaintext passwords, no string-concatenated SQL, no anonymous writes.

## 11. Non-functional Requirements

- **NFR-001**: Solution name VisaFusion; stack fixed: ASP.NET Core, EF Core, SQL Server,
  ASP.NET Core Identity.
- **NFR-002**: Repository must remain buildable and deployable after every task.
- **NFR-003**: Every implementation requires automated tests; every change requires
  documentation.
- **NFR-004**: Every architectural decision requires an ADR; every module requires a
  SpecKit specification.

## 12. Security

- Role-based authorization enforced on every protected surface (fixes 0/585 legacy
  role-denial gap).
- Secrets removed from source control; credentials externalized.
- No query-string identity (`jn=`), no anonymous write endpoints.
- `connection.asp` backdoor removed.
- Secrets scanning, CodeQL static analysis, Dependabot dependency scanning in CI.

## 13. Performance

- Handle production volumes: `Mainentry` 271,724 rows, `bighistory` 1,430,841,
  `StatusHistory` 1,287,261, `sentmails` 553,523, `PaxStatus` 359,338, `invoice` 271,239.
- Pagination and query optimization for large datasets; async I/O throughout.

## 14. UI Requirements

- Razor Pages for back-office UI per `library/08`.
- Accessibility and UI consistency standards per `library/10`.
- Workflows replicate the legacy agent/employee journeys.

## 15. API Contracts

- Versioned APIs (`/api/v1`) with OpenAPI/Swagger and ProblemDetails per `library/08 §4`
  and `library/10`.

## 16. Database Changes

- All 52 business tables migrated unchanged in content.
- Foreign keys introduced only where legacy data integrity allows (legacy has 0 FKs,
  2 PKs, 20 identities).
- Data-quality defects (6,517 orphaned Mainentry→agent, 100% NULL `entrytype`, empty
  `country`, junk dates 1970/2207, duplicated `statusID=508`) are documented and flagged,
  not silently dropped.

## 17. Validation Rules

- Server-side validation for all inputs (FluentValidation per `library/08 §6`).
- Business rule validation mirrors legacy checks (e.g., Canada DOB/holiday validation in
  `insertEntry.asp`).

## 18. Error Handling

- Standardized ProblemDetails responses.
- Structured logging with correlation IDs per `library/11 §4`.

## 19. Audit Requirements

- Audit logging for business actions per `library/08 §7`.
- Traceability events recorded in the Knowledge Graph.

## 20. Acceptance Criteria

- **AC-001**: The migrated platform passes a golden-file regression suite derived from
  legacy behavior.
- **AC-002**: All production data is migrated and verified (row counts match).
- **AC-003**: No anonymous write endpoint and no `jn=` identity remain.
- **AC-004**: Every requirement in this program traces through the Knowledge Graph to
  code, tests, and migration steps.

## 21. Risks

- Legacy data-quality defects may block FK introduction → Gap Reports, owner decisions.
- 1,430,841-row `bighistory` and 1,287,261-row `StatusHistory` migration performance.
- SMS gateway and OSSMTP legacy COM dependency removal.
- `invoice` table frozen since 2009-01-17 — behavior must be verified against frozen data.

## 22. Dependencies

- `library/` governance docs (01–15 + complete_migration_plan).
- `findings/` live-verified analysis reports.
- SpecKit (`specify-cli` 0.16.1.dev0) with opencode integration.
- GitHub repository `jayeshm14/visafusion`.

## 23. Test Scenarios

- Unit tests for every migrated business rule per `library/11 §2`.
- Integration tests against a migrated SQL Server database.
- API tests for all contracts.
- UI/functional regression tests replicating legacy workflows.
- Migration integrity tests (pre/post row counts, checksums).

## 24. Traceability Matrix

| Requirement | Architecture | Domain | Database | API | UI | Test | Migration |
|-------------|--------------|--------|----------|-----|----|------|-----------|
| FR-001 | ADR-0001 | Visa Processing | 52 tables | /api/v1 | Razor Pages | Golden-file suite | MIG-0001 |
| FR-002 | ADR-0001 | Persistence | all tables | — | — | Row-count tests | MIG-0001 |
| FR-003 | ADR-0001 | Identity | AspNetUsers/Roles | /api/v1/auth | All pages | Authorization tests | MIG-0001 |
| FR-004 | ADR-0001 | Identity | Agents | /api/v1/auth | Agent views | Auth tests | MIG-0001 |
| FR-005 | ADR-0001 | Notifications | sentmails | /api/v1/notify | Admin UI | Integration tests | MIG-0001 |
| FR-006 | ADR-0001 | Reporting | Views | /api/v1/reports | Report pages | Regression tests | MIG-0001 |
| FR-007 | ADR-0001 | Security | — | all | all | Security tests | — |
| FR-008 | ADR-0001 | KG | — | — | — | Traceability checks | — |

## Assumptions

- Production data integrity must be preserved exactly; migration is additive.
- The owner will decide the 10 risk items documented in `findings/modernization_plan.md`.
- GitHub is the single system of record; no other authoritative source exists.

## Clarifications

### Session 2026-08-06

- Q: Should the SpecKit-native `specs/NNN-<name>/spec.md` layout replace the category
  subfolder layout mandated in `library/03 §3`?
  → A: Yes — reconciled in ADR-0001; category folders remain for organizational
  specifications, feature specs use the SpecKit-native layout (tooling resolves via
  `.specify/feature.json`).