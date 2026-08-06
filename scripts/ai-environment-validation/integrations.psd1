# integrations.psd1 — 12-Integration Registry (SPEC-0001)
#
# Source of truth for the AI Environment Validation feature. Each entry maps a
# documented engineering integration to its canonical search terms, primary
# governing document, and anchoring constitution principle.
#
# Per data-model.md, the Integration entity fields are:
#   id, name, canonicalTerm[], governingDoc, constitutionPrinciple
# The workflowDirective and status fields are computed at run time by
# validate-ai-environment.ps1 (BR-002, spec §17) and are NOT stored here.
#
# Governing docs are the authoritative sources in findings/ and library/.
# Constitution principles are from .specify/memory/constitution.md (v1.2.0).

@{
    integrations = @(
        @{
            id                   = 'graphrag'
            name                 = 'GraphRAG'
            canonicalTerm        = @('GraphRAG')
            governingDoc         = 'library/05_GraphRAG_and_MCP.md'
            constitutionPrinciple = 'IV'
        },
        @{
            id                   = 'mcp'
            name                 = 'Model Context Protocol (MCP)'
            canonicalTerm        = @('MCP', 'Model Context Protocol')
            governingDoc         = 'library/05_GraphRAG_and_MCP.md'
            constitutionPrinciple = 'IV'
        },
        @{
            id                   = 'adr'
            name                 = 'Architecture Decision Records (ADRs)'
            canonicalTerm        = @('ADR', 'Architecture Decision Record')
            governingDoc         = 'library/07_DDD_CleanArchitecture_C4_ADR.md'
            constitutionPrinciple = 'IV'
        },
        @{
            id                   = 'c4'
            name                 = 'C4 Model Diagrams'
            canonicalTerm        = @('C4')
            governingDoc         = 'library/07_DDD_CleanArchitecture_C4_ADR.md'
            constitutionPrinciple = 'IV'
        },
        @{
            id                   = 'ddd'
            name                 = 'Domain-Driven Design (DDD)'
            canonicalTerm        = @('DDD', 'Domain-Driven Design')
            governingDoc         = 'library/07_DDD_CleanArchitecture_C4_ADR.md'
            constitutionPrinciple = 'IV'
        },
        @{
            id                   = 'event-storming'
            name                 = 'Event Storming'
            canonicalTerm        = @('Event Storming')
            governingDoc         = 'library/07_DDD_CleanArchitecture_C4_ADR.md'
            constitutionPrinciple = 'IV'
        },
        @{
            id                   = 'docs-as-code'
            name                 = 'Docs-as-Code'
            canonicalTerm        = @('Docs-as-Code')
            governingDoc         = 'library/06_GitHub_Engineering_Standards.md'
            constitutionPrinciple = 'V'
        },
        @{
            id                   = 'backstage'
            name                 = 'Backstage Software Catalog'
            canonicalTerm        = @('Backstage')
            governingDoc         = 'library/04_AI_Native_Knowledge_Graph.md'
            constitutionPrinciple = 'IV'
        },
        @{
            id                   = 'opentelemetry'
            name                 = 'OpenTelemetry'
            canonicalTerm        = @('OpenTelemetry')
            governingDoc         = 'library/11_Testing_Observability_DevSecOps.md'
            constitutionPrinciple = 'V'
        },
        @{
            id                   = 'codeql'
            name                 = 'CodeQL'
            canonicalTerm        = @('CodeQL')
            governingDoc         = 'library/06_GitHub_Engineering_Standards.md'
            constitutionPrinciple = 'V'
        },
        @{
            id                   = 'dependabot'
            name                 = 'Dependabot'
            canonicalTerm        = @('Dependabot')
            governingDoc         = 'library/06_GitHub_Engineering_Standards.md'
            constitutionPrinciple = 'V'
        },
        @{
            id                   = 'ndepend'
            name                 = 'NDepend'
            canonicalTerm        = @('NDepend')
            governingDoc         = 'library/07_DDD_CleanArchitecture_C4_ADR.md'
            constitutionPrinciple = 'IV'
        }
    )
}