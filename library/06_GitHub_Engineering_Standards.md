# 06_GitHub_Engineering_Standards

## Purpose

Define GitHub as the single engineering system of record.

## Repository Standards

-   trunk/main protected
-   feature branches
-   pull requests required
-   CODEOWNERS
-   branch protection
-   signed commits where applicable

## Branch Naming

feature/ bugfix/ hotfix/ migration/ refactor/ security/ docs/

## Commit Convention

feat: fix: docs: refactor: perf: test: migration: security: ci: build:

## Pull Request Checklist

-   Linked specification
-   Linked issue
-   Architecture impact
-   Database impact
-   Test evidence
-   Security review
-   Rollback plan
-   Documentation updated

## GitHub Actions

Pipeline stages: Restore Build Lint Unit Tests Integration Tests
Security Scan Coverage Package Deploy

## Security Tooling

-   **CodeQL** runs as a static analysis step in the Security Scan stage
    to detect vulnerabilities and code-quality defects before merge.
-   **Dependabot** monitors dependencies and opens automated pull
    requests for known vulnerable or outdated packages.
-   Dependabot alerts and CodeQL findings must be resolved or explicitly
    risk-accepted before release.

## Docs-as-Code

Documentation is treated as code:

-   Stored in the repository and version controlled.
-   Reviewed through pull requests with the same checklist as code.
-   Built and validated in CI (links, structure, and required sections).
-   Linted for consistency and completeness.
-   Published from the repository as the single source of truth.

No documentation change bypasses the pull request workflow.

## Quality Gates

No merge if: - build fails - tests fail - security scan fails -
documentation missing - traceability incomplete
