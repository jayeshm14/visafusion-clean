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

## Quality Gates

No merge if: - build fails - tests fail - security scan fails -
documentation missing - traceability incomplete
