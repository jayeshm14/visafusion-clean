$kg = Get-Content "G:\Projects\VisaEntry\knowledge-graph\kg.json" -Raw | ConvertFrom-Json
$provenance = "kg-sync-2026-08-22"

# Build node ID lookup
$nodeIds = @{}
foreach ($n in $kg.nodes) { $nodeIds[$n.id] = $true }

function Add-Edge {
    param($from, $to, $type)
    $exists = $kg.edges | Where-Object { $_.from -eq $from -and $_.to -eq $to -and $_.type -eq $type }
    if (-not $exists -and $nodeIds.ContainsKey($from) -and $nodeIds.ContainsKey($to)) {
        $kg.edges += @{from=$from; to=$to; type=$type; provenance=$provenance}
        return $true
    }
    return $false
}

$added = 0

# --- CLAIM orphan fixes ---
if (Add-Edge "ROLE-adm" "CLAIM-role" "requires") { $added++; Write-Output "Added: ROLE-adm -> CLAIM-role [requires]" }
if (Add-Edge "ROLE-Guest" "CLAIM-role" "requires") { $added++; Write-Output "Added: ROLE-Guest -> CLAIM-role [requires]" }

# --- ADR-0002 orphan fix ---
if (Add-Edge "ADR-0002" "SPEC-0009" "documented_by") { $added++; Write-Output "Added: ADR-0002 -> SPEC-0009 [documented_by]" }

# --- DomainEntity -> Table reads edges ---
$deTableMap = @{
    "DE-Entry" = @("TBL-Mainentry", "TBL-EntryPassenger")
    "DE-Agent" = @("TBL-Agents")
    "DE-Invoice" = @("TBL-Invoice")
    "DE-SecurityDay" = @("TBL-Security")
    "DE-Holiday" = @("TBL-Holiday")
    "DE-SharedRuleService" = @("TBL-Status", "TBL-Mainentry")
}
foreach ($pair in $deTableMap.GetEnumerator()) {
    foreach ($tbl in $pair.Value) {
        if (Add-Edge $pair.Key $tbl "reads") { $added++; Write-Output "Added: $($pair.Key) -> $tbl [reads]" }
    }
}

# --- Column -> Table contains edges ---
$colTableMap = @{
    "COL-Mainentry-refno" = "TBL-Mainentry"
    "COL-Mainentry-agent" = "TBL-Mainentry"
    "COL-Mainentry-entrytype" = "TBL-Mainentry"
    "COL-Entry-RowVersion" = "TBL-EntryPassenger"
    "COL-Agents-agentsID" = "TBL-Agents"
    "COL-Invoice-Invoiceno" = "TBL-Invoice"
    "COL-AspNetUsers-PasswordHash" = "TBL-AspNetUsers"
    "COL-AspNetUsers-AgentId" = "TBL-AspNetUsers"
}
foreach ($pair in $colTableMap.GetEnumerator()) {
    if (Add-Edge $pair.Value $pair.Key "contains") { $added++; Write-Output "Added: $($pair.Value) -> $($pair.Key) [contains]" }
}

# --- PAGE-Public-Forms is stray (GAP-010) - add implements edge ---
if (Add-Edge "PAGE-Public-Forms" "FEAT-0007-FR001" "implements") { $added++; Write-Output "Added: PAGE-Public-Forms -> FEAT-0007-FR001 [implements]" }

Write-Output ""
Write-Output "Total added: $added"
Write-Output "Total nodes: $($kg.nodes.Count)"
Write-Output "Total edges: $($kg.edges.Count)"

# Save
$kg | ConvertTo-Json -Depth 20 | Set-Content "G:\Projects\VisaEntry\knowledge-graph\kg.json" -Encoding UTF8
Write-Output "Saved kg.json"
