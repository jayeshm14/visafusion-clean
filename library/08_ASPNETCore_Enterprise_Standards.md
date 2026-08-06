# 08_ASPNETCore_Enterprise_Standards

# Purpose

Define deterministic engineering standards for building the VisaFusion
platform using ASP.NET Core.

------------------------------------------------------------------------

# 1. Platform Standards

-   .NET 9 (or approved LTS version)
-   ASP.NET Core
-   C#
-   Razor Pages for back-office UI
-   Web API for integrations
-   EF Core
-   ASP.NET Core Identity

------------------------------------------------------------------------

# 2. Solution Structure

``` text
src/
  VisaFusion.Domain
  VisaFusion.Application
  VisaFusion.Infrastructure
  VisaFusion.Persistence
  VisaFusion.Identity
  VisaFusion.Api
  VisaFusion.Web
  VisaFusion.Shared
tests/
  UnitTests
  IntegrationTests
  FunctionalTests
```

------------------------------------------------------------------------

# 3. Layer Responsibilities

## Presentation

-   Razor Pages
-   API Controllers
-   Authentication
-   Authorization
-   View Models

## Application

-   Use Cases
-   Commands
-   Queries
-   Validation
-   DTO Mapping

## Domain

-   Entities
-   Value Objects
-   Domain Services
-   Domain Events
-   Specifications

## Infrastructure

-   EF Core
-   External Services
-   Email
-   SMS
-   File Storage
-   Logging

------------------------------------------------------------------------

# 4. API Standards

-   Versioned APIs (`/api/v1`)
-   OpenAPI/Swagger
-   ProblemDetails for errors
-   Consistent request/response contracts
-   Idempotent operations where applicable
-   Server-side validation

------------------------------------------------------------------------

# 5. Security Standards

-   ASP.NET Core Identity
-   Role-based authorization
-   Policy-based authorization
-   HTTPS only
-   CSRF protection for UI
-   Secure cookies
-   Secrets outside source control

------------------------------------------------------------------------

# 6. Validation

Use centralized validation.

Requirements: - FluentValidation - Model validation - Domain
validation - Business rule validation

Never duplicate validation logic.

------------------------------------------------------------------------

# 7. Logging & Observability

-   Structured logging
-   Correlation IDs
-   Request logging
-   Health checks
-   Exception middleware
-   Audit logging for business actions
-   OpenTelemetry instrumentation for distributed tracing and metrics

------------------------------------------------------------------------

# 8. Performance

-   Async I/O
-   Response compression
-   Output caching where appropriate
-   Database query optimization
-   Pagination for large datasets

------------------------------------------------------------------------

# 9. Background Processing

Use Hosted Services for: - SMS queue - Email queue - Scheduled reports -
Maintenance tasks

Business logic remains in the Application layer.

------------------------------------------------------------------------

# 10. Testing

Minimum expectations: - Unit tests - Integration tests - API tests -
Authorization tests - Regression tests for migrated behavior

------------------------------------------------------------------------

# 11. Coding Standards

-   Nullable reference types enabled
-   Dependency Injection
-   Constructor injection
-   No static business state
-   No SQL in UI
-   No framework dependencies in Domain

------------------------------------------------------------------------

# 12. Definition of Done

A feature is complete only when: - Architecture unchanged or updated
intentionally - Specifications implemented - APIs documented - Tests
passing - Security reviewed - Logging added - Documentation updated -
Traceability maintained

# 13. Developer Portal & Software Catalog

Maintain a **Backstage** software catalog as the developer portal for
the VisaFusion platform.

-   Every service, API, and component is registered as a catalog entity.
-   Each entity records ownership, metadata, dependencies, and
    documentation links.
-   The catalog is defined as code (catalog-info.yaml) and version
    controlled.
-   The catalog reflects the Knowledge Graph and architecture documents
    as the single source of truth.
-   AI agents and engineers discover services and their ownership
    through the catalog before making changes.

This document establishes deterministic ASP.NET Core engineering
standards for VisaFusion.
