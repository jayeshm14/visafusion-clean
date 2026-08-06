# 09_SQLServer_Data_Engineering

# Purpose

Define deterministic SQL Server engineering standards for the VisaFusion
modernization program.

------------------------------------------------------------------------

# 1. Objectives

-   Preserve all production data.
-   Improve integrity and performance.
-   Normalize carefully without changing business behavior.
-   Support repeatable deployments through version-controlled
    migrations.

------------------------------------------------------------------------

# 2. Database Principles

-   Production data is authoritative.
-   Do not drop business tables.
-   Only `dtproperties` may be removed.
-   Legacy tables not used by the new application become **Archive** or
    **ReadOnly**, not deleted.
-   Every schema change must be reversible.

------------------------------------------------------------------------

# 3. Naming Standards

Tables: - Singular business entities where practical for new objects. -
Existing legacy table names remain until migrated.

Objects: - `usp_` for stored procedures - `fn_` for scalar/table-valued
functions - `vw_` for views

------------------------------------------------------------------------

# 4. Normalization Rules

Target 3NF unless a documented performance exception exists.

Reference data shall use foreign keys for: - Country - Embassy -
Status - Category - Visa Type - Entry Type - POE - Certificate -
Attestation

Denormalization requires an ADR.

------------------------------------------------------------------------

# 5. Constraints

Use:

-   Primary Keys
-   Foreign Keys
-   Unique Constraints
-   Check Constraints
-   Default Constraints

Do not disable constraints permanently.

------------------------------------------------------------------------

# 6. Indexing

Create indexes based on workload.

Typical candidates:

-   RefNo
-   AgentId
-   StatusId
-   PassportNo
-   CreatedOn
-   ModifiedOn

Review execution plans before adding indexes.

------------------------------------------------------------------------

# 7. Stored Procedures

Use procedures for:

-   Bulk updates
-   Reporting
-   Dashboard aggregation
-   Batch processing
-   Scheduled operations

Business rules remain primarily in the application layer.

------------------------------------------------------------------------

# 8. SQL Functions

Functions may encapsulate reusable calculations such as:

-   Business day
-   Holiday checks
-   Outstanding balance
-   Application age
-   Status display

Functions must be deterministic where possible.

------------------------------------------------------------------------

# 9. Views

Create views for read models and reporting.

Examples:

-   Pending applications
-   Daily collections
-   Agent summaries
-   Invoice summaries
-   Audit reports

Views do not replace domain logic.

------------------------------------------------------------------------

# 10. Auditing

Business tables should support:

-   CreatedOn
-   CreatedBy
-   ModifiedOn
-   ModifiedBy
-   RowVersion

History tables remain append-only.

------------------------------------------------------------------------

# 11. Migrations

Every migration must include:

-   Forward script
-   Rollback script
-   Data validation
-   Row-count verification
-   Post-deployment checks

Never edit previously applied migrations.

------------------------------------------------------------------------

# 12. Data Quality

Validate before enabling foreign keys:

-   Orphan records
-   Duplicate reference values
-   Invalid dates
-   Missing lookup values
-   Corrupted numeric data

Quarantine exceptions instead of guessing corrections.

------------------------------------------------------------------------

# 13. Performance

-   Parameterized queries
-   Appropriate transaction scope
-   Pagination for large datasets
-   Statistics maintenance
-   Index maintenance
-   Backup verification

------------------------------------------------------------------------

# 14. Definition of Done

Database work is complete only when:

-   Schema validated
-   Constraints enabled
-   Indexes reviewed
-   Migrations tested
-   Rollback verified
-   Documentation updated
-   Traceability maintained

This document establishes deterministic SQL Server data engineering
standards for VisaFusion.
