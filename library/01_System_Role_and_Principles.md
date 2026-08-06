# 01_System_Role_and_Principles

## Purpose

This document defines the deterministic operating principles for the
**VisaFusion** legacy modernization program executed using **OpenCode**.

It is the foundational specification. Every engineering activity must
conform to this document.

------------------------------------------------------------------------

# 1. Mission

Modernize the legacy application into a production-grade ASP.NET Core
platform without changing business behavior.

Objectives:

-   Preserve business logic.
-   Eliminate technical debt.
-   Improve maintainability.
-   Improve security.
-   Improve observability.
-   Improve scalability.
-   Preserve all production data.
-   Produce deterministic, repeatable engineering outcomes.

------------------------------------------------------------------------

# 2. Guiding Principles

1.  Specification First.
2.  No feature invention.
3.  Legacy behavior is the source of truth.
4.  Every change is traceable.
5.  Documentation is mandatory.
6.  Every artifact is version controlled.
7.  Security by default.
8.  Production readiness before completion.

------------------------------------------------------------------------

# 3. Deterministic Rules

Never:

-   Guess.
-   Invent requirements.
-   Delete production data.
-   Drop business tables (except `dtproperties`).
-   Introduce hidden behavior.
-   Commit undocumented changes.

Always:

-   Validate assumptions.
-   Update specifications.
-   Update documentation.
-   Update tests.
-   Preserve traceability.

------------------------------------------------------------------------

# 4. Definition of Done

A task is complete only when:

-   Specification updated.
-   Architecture updated.
-   Code implemented.
-   Database validated.
-   Tests passing.
-   Security reviewed.
-   Documentation updated.
-   Traceability verified.

------------------------------------------------------------------------

# 5. Engineering Deliverables

Every completed work item produces:

1.  Specification
2.  Architecture update
3.  Source code
4.  Database migration
5.  Tests
6.  Documentation
7.  Decision log
8.  Risk assessment
9.  Traceability matrix
10. Release notes

------------------------------------------------------------------------

# 6. VisaFusion Standards

-   Solution name: VisaFusion
-   Preserve all business tables except `dtproperties`.
-   Normalize carefully.
-   Use ASP.NET Core, EF Core, SQL Server, Identity.
-   Use GitHub as the single source of truth.
-   Follow Specification-Driven Development (SDD).

------------------------------------------------------------------------

# 7. Success Criteria

The resulting platform must be:

-   Enterprise-grade
-   Deterministic
-   Secure
-   Observable
-   Maintainable
-   Testable
-   AI-native
-   Production ready
