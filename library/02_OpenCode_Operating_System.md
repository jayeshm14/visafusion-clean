# 02_OpenCode_Operating_System

## Purpose

This document defines the deterministic operating model for **OpenCode**
during the VisaFusion modernization program.

------------------------------------------------------------------------

# 1. Operating Philosophy

OpenCode acts as an engineering execution platform rather than a code
generator.

Execution order is fixed:

1.  Intake
2.  Specification
3.  Architecture
4.  Knowledge Graph Update
5.  Domain Modeling
6.  Database Design
7.  API Contracts
8.  UI Design
9.  Implementation
10. Testing
11. Validation
12. Documentation
13. Review
14. Release

No stage may be skipped.

------------------------------------------------------------------------

# 2. Inputs

Required inputs before implementation:

-   Approved specification
-   Business rules
-   Existing architecture
-   Legacy source mapping
-   Database schema
-   Acceptance criteria
-   Constraints
-   Risks

If any required input is missing:

-   Stop implementation.
-   Produce a gap report.
-   Request clarification.
-   Do not invent behavior.

------------------------------------------------------------------------

# 3. Outputs

Every completed task produces:

-   Updated specification
-   Updated architecture
-   Updated knowledge graph
-   Updated code
-   Updated tests
-   Updated documentation
-   Migration notes
-   Validation report
-   Traceability matrix

------------------------------------------------------------------------

# 4. Repository Structure

``` text
/docs
/specs
/adr
/architecture
/src
/tests
/scripts
/database
/deployment
```

------------------------------------------------------------------------

# 5. Engineering Workflow

For every feature or migration:

1.  Create/Update specification.
2.  Identify impacted modules.
3.  Update dependency graph.
4.  Update knowledge graph.
5.  Design database changes.
6.  Implement application layer.
7.  Implement infrastructure.
8.  Implement API.
9.  Implement UI.
10. Execute automated tests.
11. Review security.
12. Update documentation.
13. Create release notes.

------------------------------------------------------------------------

# 6. AI Collaboration Rules

The AI assistant must:

-   Never overwrite approved specifications.
-   Never remove traceability.
-   Never generate placeholder production code.
-   Explain deviations.
-   Keep implementation synchronized with documentation.

------------------------------------------------------------------------

# 7. Deterministic Validation

Before marking work complete verify:

-   Build succeeds
-   Tests pass
-   Specifications match implementation
-   Database migrations are reversible
-   Security review completed
-   Documentation updated
-   No undocumented behavior introduced

------------------------------------------------------------------------

# 8. Production Readiness Checklist

-   Configuration externalized
-   Secrets removed from source
-   Logging enabled
-   Health checks enabled
-   Error handling standardized
-   CI pipeline green
-   Rollback documented

This operating model governs every engineering task executed by OpenCode
for the VisaFusion modernization effort.
