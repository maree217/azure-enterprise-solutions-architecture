<#
.SYNOPSIS
    Master script to run a complete Azure architecture assessment extraction.

.DESCRIPTION
    This script orchestrates the execution of all extraction scripts to gather
    comprehensive data for an Azure architecture assessment.

.PARAMETER SubscriptionIds
    Array of subscription IDs to assess. If empty, assesses all accessible subscriptions.

.PARAMETER OutputPath
    Root path where all output will be saved.

.PARAMETER IncludeSecurityData
    Include security posture extraction. Default is true.

.PARAMETER IncludeCostData
    Include cost and optimization data. Default is true.

.PARAMETER TimeframeDays
    Days of historical data for cost analysis. Default is 90.

.EXAMPLE
    ./run-full-assessment.ps1 -OutputPath "./client-assessment" -SubscriptionIds @("sub1", "sub2")

.EXAMPLE
    ./run-full-assessment.ps1 -OutputPath "./assessment" -IncludeSecurityData $true -IncludeCostData $true

.NOTES
    Requires: Az, Az.ResourceGraph, Az.Security, Az.Advisor, Az.CostManagement modules
    Run time: Approximately 5-15 minutes depending on environment size
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string[]]$SubscriptionIds,

    [Parameter(Mandatory=$true)]
    [string]$OutputPath,

    [Parameter(Mandatory=$false)]
    [bool]$IncludeSecurityData = $true,

    [Parameter(Mandatory=$false)]
    [bool]$IncludeCostData = $true,

    [Parameter(Mandatory=$false)]
    [int]$TimeframeDays = 90
)

$ErrorActionPreference = "Continue"
$startTime = Get-Date

#region Banner
Write-Host @"

╔═══════════════════════════════════════════════════════════════════╗
║                                                                   ║
║          AZURE ARCHITECTURE ASSESSMENT TOOLKIT                    ║
║          Full Assessment Extraction                               ║
║                                                                   ║
║          Three-Layer Enterprise AI Architecture                   ║
║          github.com/maree217/azure-enterprise-solutions-architecture
║                                                                   ║
╚═══════════════════════════════════════════════════════════════════╝

"@ -ForegroundColor Cyan
#endregion

#region Prerequisites Check
Write-Host "Checking Prerequisites..." -ForegroundColor Yellow

$requiredModules = @("Az", "Az.ResourceGraph")
if ($IncludeSecurityData) { $requiredModules += "Az.Security" }
if ($IncludeCostData) { $requiredModules += @("Az.Advisor", "Az.CostManagement") }

$missingModules = @()
foreach ($module in $requiredModules) {
    if (-not (Get-Module -ListAvailable -Name $module)) {
        $missingModules += $module
    }
}

if ($missingModules.Count -gt 0) {
    Write-Host "Missing required modules: $($missingModules -join ', ')" -ForegroundColor Red
    Write-Host "Install with: Install-Module -Name <ModuleName> -Scope CurrentUser" -ForegroundColor Yellow
    exit 1
}

Write-Host "All required modules are available" -ForegroundColor Green
#endregion

#region Azure Connection Check
Write-Host "`nChecking Azure Connection..." -ForegroundColor Yellow

$context = Get-AzContext
if (-not $context) {
    Write-Host "Not connected to Azure. Running Connect-AzAccount..." -ForegroundColor Yellow
    Connect-AzAccount
    $context = Get-AzContext
}

Write-Host "Connected as: $($context.Account.Id)" -ForegroundColor Green
Write-Host "Tenant: $($context.Tenant.Id)" -ForegroundColor Gray
#endregion

#region Subscription Resolution
if ($SubscriptionIds) {
    $targetSubscriptions = $SubscriptionIds
    Write-Host "`nTarget Subscriptions: $($SubscriptionIds -join ', ')" -ForegroundColor White
} else {
    $targetSubscriptions = (Get-AzSubscription | Where-Object { $_.State -eq "Enabled" }).Id
    Write-Host "`nTargeting all enabled subscriptions ($($targetSubscriptions.Count) found)" -ForegroundColor White
}
#endregion

#region Create Output Structure
Write-Host "`nCreating Output Directory Structure..." -ForegroundColor Yellow

$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$assessmentPath = Join-Path $OutputPath "assessment_$timestamp"

$directories = @(
    "$assessmentPath/inventory",
    "$assessmentPath/security",
    "$assessmentPath/cost",
    "$assessmentPath/analysis",
    "$assessmentPath/reports"
)

foreach ($dir in $directories) {
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
}

Write-Host "Output path: $assessmentPath" -ForegroundColor Green
#endregion

#region Run Extractions

# 1. Resource Inventory
Write-Host "`n" + "="*60 -ForegroundColor Cyan
Write-Host "PHASE 1: Resource Inventory Extraction" -ForegroundColor Cyan
Write-Host "="*60 -ForegroundColor Cyan

$scriptPath = $PSScriptRoot
& "$scriptPath/azure-inventory.ps1" `
    -SubscriptionIds $targetSubscriptions `
    -OutputPath "$assessmentPath/inventory" `
    -OutputFormat "Both"

# 2. Security Posture
if ($IncludeSecurityData) {
    Write-Host "`n" + "="*60 -ForegroundColor Cyan
    Write-Host "PHASE 2: Security Posture Extraction" -ForegroundColor Cyan
    Write-Host "="*60 -ForegroundColor Cyan

    & "$scriptPath/security-export.ps1" `
        -SubscriptionIds $targetSubscriptions `
        -OutputPath "$assessmentPath/security"
}

# 3. Cost Analysis
if ($IncludeCostData) {
    Write-Host "`n" + "="*60 -ForegroundColor Cyan
    Write-Host "PHASE 3: Cost & Optimization Extraction" -ForegroundColor Cyan
    Write-Host "="*60 -ForegroundColor Cyan

    & "$scriptPath/cost-export.ps1" `
        -SubscriptionIds $targetSubscriptions `
        -OutputPath "$assessmentPath/cost" `
        -TimeframeDays $TimeframeDays
}

#endregion

#region Generate Master Summary
Write-Host "`n" + "="*60 -ForegroundColor Cyan
Write-Host "Generating Master Assessment Summary" -ForegroundColor Cyan
Write-Host "="*60 -ForegroundColor Cyan

$masterSummary = @{
    assessmentInfo = @{
        timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        subscriptionsAssessed = $targetSubscriptions.Count
        subscriptionIds = $targetSubscriptions
        extractionDuration = ((Get-Date) - $startTime).TotalMinutes
        toolkitVersion = "1.0.0"
        framework = "Three-Layer Enterprise AI Architecture"
    }
    dataSources = @{
        inventoryExtracted = Test-Path "$assessmentPath/inventory/extraction-summary.json"
        securityExtracted = Test-Path "$assessmentPath/security/security-summary.json"
        costExtracted = Test-Path "$assessmentPath/cost/cost-summary.json"
    }
}

# Load sub-summaries if available
if ($masterSummary.dataSources.inventoryExtracted) {
    $inventorySummary = Get-Content "$assessmentPath/inventory/extraction-summary.json" | ConvertFrom-Json
    $masterSummary.inventory = @{
        totalResources = $inventorySummary.totalResources
        topResourceTypes = ($inventorySummary.resourcesByType | Select-Object -First 5)
    }
}

if ($masterSummary.dataSources.securityExtracted) {
    $securitySummary = Get-Content "$assessmentPath/security/security-summary.json" | ConvertFrom-Json
    $masterSummary.security = @{
        unhealthyAssessments = $securitySummary.overallFindings.unhealthyAssessments
        totalAlerts = $securitySummary.overallFindings.totalAlerts
        highSeverityAlerts = $securitySummary.overallFindings.highSeverityAlerts
    }
}

if ($masterSummary.dataSources.costExtracted) {
    $costSummary = Get-Content "$assessmentPath/cost/cost-summary.json" | ConvertFrom-Json
    $masterSummary.cost = @{
        potentialAnnualSavings = $costSummary.totalPotentialSavings
        costRecommendations = $costSummary.totalCostRecommendations
        wasteIdentified = $costSummary.wasteIdentified
    }
}

$masterSummary | ConvertTo-Json -Depth 10 | Out-File "$assessmentPath/assessment-summary.json"

#endregion

#region Final Report
$endTime = Get-Date
$duration = $endTime - $startTime

Write-Host "`n" -ForegroundColor White
Write-Host "╔═══════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                   ASSESSMENT EXTRACTION COMPLETE                  ║" -ForegroundColor Green
Write-Host "╚═══════════════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "  Duration: $([math]::Round($duration.TotalMinutes, 2)) minutes" -ForegroundColor White
Write-Host "  Output Location: $assessmentPath" -ForegroundColor White
Write-Host ""
Write-Host "  Summary:" -ForegroundColor Yellow

if ($masterSummary.inventory) {
    Write-Host "    - Total Resources: $($masterSummary.inventory.totalResources)" -ForegroundColor White
}
if ($masterSummary.security) {
    Write-Host "    - Security Issues: $($masterSummary.security.unhealthyAssessments) unhealthy" -ForegroundColor $(if ($masterSummary.security.unhealthyAssessments -gt 0) { "Yellow" } else { "Green" })
    Write-Host "    - Active Alerts: $($masterSummary.security.totalAlerts)" -ForegroundColor $(if ($masterSummary.security.totalAlerts -gt 0) { "Yellow" } else { "Green" })
}
if ($masterSummary.cost) {
    Write-Host "    - Potential Savings: `$$([math]::Round($masterSummary.cost.potentialAnnualSavings, 2))/year" -ForegroundColor Green
}

Write-Host ""
Write-Host "  Next Steps:" -ForegroundColor Yellow
Write-Host "    1. Review assessment-summary.json for high-level findings" -ForegroundColor White
Write-Host "    2. Analyze detailed exports in /inventory, /security, /cost" -ForegroundColor White
Write-Host "    3. Use analysis templates to score against WAF pillars" -ForegroundColor White
Write-Host "    4. Generate client deliverables using templates" -ForegroundColor White
Write-Host ""
Write-Host "  Documentation: github.com/maree217/azure-enterprise-solutions-architecture" -ForegroundColor Gray
Write-Host ""

#endregion

# Return path for pipeline integration
return $assessmentPath
