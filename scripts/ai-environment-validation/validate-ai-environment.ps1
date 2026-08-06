<#
.SYNOPSIS
    Validates the 12 documented engineering integrations (SPEC-0001) against the
    authoritative docs in findings/ and library/.

.DESCRIPTION
    Scans the authoritative documentation for each of the 12 integrations,
    applies the workflow-directive test (BR-002) and the spec §17 validation
    rules, and classifies each integration as validated / partial / missing /
    contradictory. Produces a dated, repeatable result.

    This file is the single implementation of the validation engine. It is
    dot-sourceable so Pester tests can import its functions.

.PARAMETER SourceDirs
    Authoritative source folders to scan (default: findings, library).

.PARAMETER OutputDir
    Directory for generated report artifacts (default: reports/ai-environment-validation).

.PARAMETER ReportOnly
    When set, only (re)generates the report from an existing result without
    re-scanning. Reserved for on-demand runs (FR-006).

.EXAMPLE
    & ./scripts/ai-environment-validation/validate-ai-environment.ps1 `
        -SourceDirs @('findings','library') -OutputDir 'reports/ai-environment-validation'
#>
[CmdletBinding()]
param(
    [string[]]$SourceDirs = @('findings', 'library'),
    [string]$OutputDir = 'reports/ai-environment-validation',
    [switch]$ReportOnly
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------
$script:RegistryPath = Join-Path $PSScriptRoot 'integrations.psd1'
$script:NormativeKeywords = @('MUST', 'SHOULD', 'REQUIRED')
$script:ImperativeVerbs = @('Use', 'Maintain', 'Create', 'Run', 'Implement', 'Ensure', 'Record', 'Define', 'Document', 'Apply')

# ---------------------------------------------------------------------------
# T005: Documentation scanning helper
# ---------------------------------------------------------------------------

<#
.SYNOPSIS
    Scans the authoritative source folders for a canonical term using
    Select-String, returning matches with file + line provenance (FR-004).
#>
function Get-DocumentationMatches {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$SourceDirs,
        [Parameter(Mandatory = $true)]
        [string]$CanonicalTerm
    )

    $root = (Get-Location).Path
    $results = @()

    foreach ($dir in $SourceDirs) {
        if (-not (Test-Path -LiteralPath $dir)) {
            Write-Warning "Source directory not found: $dir"
            continue
        }
        $files = Get-ChildItem -LiteralPath $dir -Filter '*.md' -File -Recurse -ErrorAction SilentlyContinue
        foreach ($file in $files) {
            $hits = Select-String -LiteralPath $file.FullName -Pattern $CanonicalTerm -SimpleMatch -ErrorAction SilentlyContinue
            foreach ($hit in $hits) {
                $relative = $file.FullName
                if ($file.FullName.StartsWith($root, [System.StringComparison]::OrdinalIgnoreCase)) {
                    $relative = $file.FullName.Substring($root.Length).TrimStart('\', '/')
                }
                # Normalize to forward slashes so paths match governingDoc values
                # (e.g. "library/05_GraphRAG_and_MCP.md") on all platforms.
                $relative = $relative.Replace('\', '/')
                $results += [pscustomobject]@{
                    File         = $relative
                    LineNumber   = $hit.LineNumber
                    Line         = $hit.Line.Trim()
                }
            }
        }
    }

    return $results
}

<#
.SYNOPSIS
    Tests whether a documentation line contains a workflow directive (BR-002):
    a normative keyword (MUST/SHOULD/REQUIRED) or an imperative verb.
#>
function Test-WorkflowDirective {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [string]$Line
    )

    foreach ($keyword in $script:NormativeKeywords) {
        if ($Line -match "\b$keyword\b") { return $true }
    }
    foreach ($verb in $script:ImperativeVerbs) {
        if ($Line -match "\b$verb\b") { return $true }
    }
    return $false
}

<#
.SYNOPSIS
    Tests whether a workflow directive exists for the integration (T009,
    BR-002). A directive counts when it appears on the same line as, or within
    a small window of, a canonical-term match in ANY authoritative source doc
    (spec §17(b): "a workflow directive exists" in the authoritative sources —
    not necessarily in the governing doc itself). This captures directives
    phrased on the line following a section heading (e.g., C4:
    "# 4. C4 Model" then "Maintain diagrams for:") and directives that live in
    a companion standards doc (e.g., "Maintain a Backstage software catalog"
    in library/08 while the governing doc is library/04).
#>
function Test-IntegrationDirective {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [hashtable]$Integration,
        [Parameter(Mandatory = $true)]
        [AllowEmptyCollection()]
        [object[]]$DocMatches
    )

    if ($DocMatches.Count -eq 0) {
        return $false
    }

    $window = 5
    $root = (Get-Location).Path

    # Group matches by source file so each doc is read once.
    $filesWithMatches = $DocMatches | Group-Object File
    foreach ($group in $filesWithMatches) {
        $docPath = Join-Path $root $group.Name
        if (-not (Test-Path -LiteralPath $docPath)) {
            continue
        }
        $docLines = Get-Content -LiteralPath $docPath
        # Directive lines in this doc.
        $directiveLineNumbers = @()
        for ($i = 0; $i -lt $docLines.Count; $i++) {
            if (Test-WorkflowDirective -Line $docLines[$i]) {
                $directiveLineNumbers += ($i + 1)
            }
        }
        if ($directiveLineNumbers.Count -eq 0) {
            continue
        }
        # A directive qualifies if it is on or within the window of a term match.
        foreach ($m in $group.Group) {
            foreach ($directiveLine in $directiveLineNumbers) {
                if ([Math]::Abs($directiveLine - $m.LineNumber) -le $window) {
                    return $true
                }
            }
        }
    }
    return $false
}

# ---------------------------------------------------------------------------
# T006: Status classifier (BR-002, spec §17)
# ---------------------------------------------------------------------------

<#
.SYNOPSIS
    Classifies an integration's status per spec §17:
      validated      - governing doc exists, workflow directive present,
                       principle anchored, no contradiction.
      partial        - governing doc exists but no workflow directive (name-only).
      missing        - no governing doc / no evidence found.
      contradictory  - conflicting claims across authoritative sources.
#>
function Get-IntegrationStatus {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [hashtable]$Integration,
        [Parameter(Mandatory = $true)]
        [AllowEmptyCollection()]
        [object[]]$Matches
    )

    $governingDoc = $Integration.governingDoc
    $docMatches = @($Matches | Where-Object { $_.File -eq $governingDoc })

    # Rule (a): a governing document exists in findings/ or library/.
    if ($docMatches.Count -eq 0) {
        return 'missing'
    }

    # Rule (d): no contradiction across authoritative sources (checked first —
    # a contradiction is the most severe signal and must never be masked by
    # a missing-directive result).
    # Precise pattern: the source must actively forbid or negate the practice
    # ("do not use", "must not", "not supported", "forbidden"). A listing like
    # "no forbidden dependency edges" is NOT a contradiction.
    $contradictionPattern = '(do not use|must not (use|be used)|should not (use|be used)|avoid using|is not supported|is forbidden|is prohibited|has been deprecated|no longer supported)'
    foreach ($m in $Matches) {
        if ($m.Line -match $contradictionPattern) {
            return 'contradictory'
        }
    }

    # Rule (b): a workflow directive exists (not just a name mention) - BR-002.
    # Section-aware: a directive within a window of the term match counts.
    $hasDirective = Test-IntegrationDirective -Integration $Integration -DocMatches $Matches
    if (-not $hasDirective) {
        return 'partial'
    }

    # Rule (c): a constitution principle anchors the integration (registry field).
    if ([string]::IsNullOrWhiteSpace($Integration.constitutionPrinciple)) {
        return 'partial'
    }

    return 'validated'
}

# ---------------------------------------------------------------------------
# Registry loading
# ---------------------------------------------------------------------------

<#
.SYNOPSIS
    Loads the 12-integration registry from integrations.psd1.
#>
function Get-IntegrationRegistry {
    [CmdletBinding()]
    param()

    if (-not (Test-Path -LiteralPath $script:RegistryPath)) {
        throw "Integration registry not found: $script:RegistryPath"
    }
    $data = Import-PowerShellDataFile -LiteralPath $script:RegistryPath
    return $data.integrations
}

# ---------------------------------------------------------------------------
# T013/T015: Markdown report generation (FR-002, FR-007)
# ---------------------------------------------------------------------------

<#
.SYNOPSIS
    Renders the traceability matrix (FR-002) as Markdown: one row per
    integration mapping id -> name -> governing doc -> directive -> principle
    -> status -> provenance.
#>
function Get-TraceabilityMatrixMarkdown {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [object[]]$Integrations
    )

    $lines = @(
        '| Integration | Name | Governing Document | Directive | Principle | Status |',
        '|---|---|---|---|---|---|'
    )
    foreach ($i in $Integrations) {
        $lines += '| {0} | {1} | {2} | {3} | {4} | {5} |' -f `
            $i.id, $i.name, $i.governingDoc, $i.workflowDirective,
            $i.constitutionPrinciple, $i.status
    }
    return $lines -join "`n"
}

<#
.SYNOPSIS
    Renders the Gap Report section (BR-003) for non-validated integrations.
    Every gap names the integration, its status, and its provenance so the
    reader can locate the evidence. Never guesses — it reports what the docs
    show.
#>
function Get-GapReportMarkdown {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [object[]]$Integrations
    )

    $nonValidated = @($Integrations | Where-Object { $_.status -ne 'validated' })
    if ($nonValidated.Count -eq 0) {
        return "**No gaps found.** All 12 integrations are validated."
    }

    $lines = @(
        'The following integrations are NOT fully validated (BR-003 Gap Report):'
    )
    foreach ($i in $nonValidated) {
        $evidence = if ($i.provenance.Count -gt 0) {
            $i.provenance -join ', '
        } else {
            'no evidence found'
        }
        $lines += "- **$($i.name)** (id: $($i.id)): status **$($i.status)**. Evidence: $evidence"
    }
    return $lines -join "`n"
}

<#
.SYNOPSIS
    Generates the full Markdown validation report (report.md) including the
    traceability matrix and the Gap Report.
#>
function New-ValidationReport {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [pscustomobject]$Result
    )

    $matrix = Get-TraceabilityMatrixMarkdown -Integrations $Result.integrations
    $gaps = Get-GapReportMarkdown -Integrations $Result.integrations

    $content = @"
# AI Environment Validation Report

**Run date**: $($Result.runDate)
**Source directories**: $($Result.sourceDirs -join ', ')
**Overall**: $($Result.summary.validated)/12 validated — $($Result.summary.partial) partial, $($Result.summary.missing) missing, $($Result.summary.contradictory) contradictory
**Result**: $(if ($Result.passed) { 'PASS' } else { 'FAIL' })

## Summary

| Status | Count |
|--------|-------|
| validated | $($Result.summary.validated) |
| partial | $($Result.summary.partial) |
| missing | $($Result.summary.missing) |
| contradictory | $($Result.summary.contradictory) |

## Traceability Matrix

$matrix

## Gap Report

$gaps

## Provenance

Per-integration evidence (source file + line) is recorded in the
`summary.json` artifact (machine-readable).
"@

    return $content
}

<#
.SYNOPSIS
    Writes report.md and summary.json to the output directory (FR-007).
#>
function Write-ValidationArtifacts {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [pscustomobject]$Result,
        [Parameter(Mandatory = $true)]
        [string]$OutputDir
    )

    if (-not (Test-Path -LiteralPath $OutputDir)) {
        $null = New-Item -ItemType Directory -Path $OutputDir -Force
    }

    $report = New-ValidationReport -Result $Result
    $reportPath = Join-Path $OutputDir 'report.md'
    Set-Content -LiteralPath $reportPath -Value $report -Encoding UTF8

    $summaryPath = Join-Path $OutputDir 'summary.json'
    $json = $Result | ConvertTo-Json -Depth 6
    Set-Content -LiteralPath $summaryPath -Value $json -Encoding UTF8

    return [pscustomobject]@{
        reportPath = $reportPath
        summaryPath = $summaryPath
    }
}

# ---------------------------------------------------------------------------
# Main orchestration (extended in later phases)
# ---------------------------------------------------------------------------

function Invoke-Validation {
    [CmdletBinding()]
    param(
        [string[]]$SourceDirs,
        [string]$OutputDir
    )

    $registry = Get-IntegrationRegistry
    $runDate = (Get-Date).ToUniversalTime().ToString('o')

    $integrations = @()
    foreach ($integration in $registry) {
        $allMatches = @()
        foreach ($term in $integration.canonicalTerm) {
            $allMatches += Get-DocumentationMatches -SourceDirs $SourceDirs -CanonicalTerm $term
        }
        $status = Get-IntegrationStatus -Integration $integration -Matches $allMatches
        $hasDirective = Test-IntegrationDirective -Integration $integration -DocMatches $allMatches
        # T011: deterministic provenance — deduplicate and sort by file then line.
        $provenance = @($allMatches |
            ForEach-Object { "$($_.File):$($_.LineNumber)" } |
            Sort-Object -Unique)
        $integrations += [pscustomobject]@{
            id                    = $integration.id
            name                  = $integration.name
            governingDoc          = $integration.governingDoc
            workflowDirective     = $hasDirective
            constitutionPrinciple = $integration.constitutionPrinciple
            status                = $status
            provenance            = $provenance
        }
    }

    $summary = @{
        validated     = @($integrations | Where-Object { $_.status -eq 'validated' }).Count
        partial       = @($integrations | Where-Object { $_.status -eq 'partial' }).Count
        missing       = @($integrations | Where-Object { $_.status -eq 'missing' }).Count
        contradictory = @($integrations | Where-Object { $_.status -eq 'contradictory' }).Count
    }
    $passed = ($summary.validated -eq $integrations.Count)

    $result = [pscustomobject]@{
        '$schema'   = 'contracts/validation-summary.v1.schema.json'
        version     = 1
        runDate     = $runDate
        sourceDirs  = $SourceDirs
        passed      = $passed
        summary     = $summary
        integrations = $integrations
    }

    # T013-T015: write report artifacts (FR-007) — version-controlled.
    $null = Write-ValidationArtifacts -Result $result -OutputDir $OutputDir

    return $result
}

<#
.SYNOPSIS
    Loads a previously written summary.json and regenerates the report.md
    from it without re-scanning the sources (on-demand ReportOnly mode,
    FR-006). The passed flag is preserved from the stored result.
#>
function Restore-ResultFromSummary {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$OutputDir
    )

    $summaryPath = Join-Path $OutputDir 'summary.json'
    if (-not (Test-Path -LiteralPath $summaryPath)) {
        throw "No existing summary.json found at $summaryPath. Run a full validation first."
    }
    $raw = Get-Content -LiteralPath $summaryPath -Raw
    $stored = $raw | ConvertFrom-Json

    # Rebuild the result object in the same shape produced by Invoke-Validation.
    $result = [pscustomobject]@{
        '$schema'   = if ($stored.'$schema') { $stored.'$schema' } else { 'contracts/validation-summary.v1.schema.json' }
        version     = if ($null -eq $stored.version) { 1 } else { $stored.version }
        runDate     = $stored.runDate
        sourceDirs  = @($stored.sourceDirs)
        passed      = [bool]$stored.passed
        summary     = @{
            validated     = [int]$stored.summary.validated
            partial       = [int]$stored.summary.partial
            missing       = [int]$stored.summary.missing
            contradictory = [int]$stored.summary.contradictory
        }
        integrations = @(
            $stored.integrations | ForEach-Object {
                [pscustomobject]@{
                    id                    = $_.id
                    name                  = $_.name
                    governingDoc          = $_.governingDoc
                    workflowDirective     = [bool]$_.workflowDirective
                    constitutionPrinciple = $_.constitutionPrinciple
                    status                = $_.status
                    provenance            = @($_.provenance)
                }
            }
        )
    }
    return $result
}

# Run only when invoked as a script (not when dot-sourced for tests).
if ($MyInvocation.InvocationName -ne '.') {
    if ($ReportOnly) {
        $result = Restore-ResultFromSummary -OutputDir $OutputDir
    } else {
        $result = Invoke-Validation -SourceDirs $SourceDirs -OutputDir $OutputDir
    }
    $result | ConvertTo-Json -Depth 6
    # Explicit exit code: 0 = passed, 1 = not passed (FR-005, CI gate).
    if ($result.passed) {
        exit 0
    } else {
        exit 1
    }
}