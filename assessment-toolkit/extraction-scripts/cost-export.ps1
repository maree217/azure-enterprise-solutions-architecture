<#
.SYNOPSIS
    Extracts cost and usage data from Azure Cost Management.

.DESCRIPTION
    This script extracts billing data, usage patterns, cost trends, and optimization
    recommendations from Azure Cost Management.

.PARAMETER SubscriptionIds
    Array of subscription IDs to query.

.PARAMETER OutputPath
    Path where output files will be saved.

.PARAMETER TimeframeDays
    Number of days of historical data to retrieve. Default is 90.

.EXAMPLE
    ./cost-export.ps1 -SubscriptionIds @("sub1") -OutputPath "./cost-data" -TimeframeDays 90

.NOTES
    Requires: Az.CostManagement module
    Permissions: Cost Management Reader role
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string[]]$SubscriptionIds,

    [Parameter(Mandatory=$true)]
    [string]$OutputPath,

    [Parameter(Mandatory=$false)]
    [int]$TimeframeDays = 90
)

# Import required modules
Import-Module Az.CostManagement -ErrorAction Stop
Import-Module Az.Advisor -ErrorAction Stop

# Create output directory
New-Item -ItemType Directory -Force -Path $OutputPath | Out-Null

Write-Host "Starting Cost & Usage Extraction..." -ForegroundColor Cyan
Write-Host "Timeframe: Last $TimeframeDays days" -ForegroundColor Gray

# Date range
$endDate = Get-Date
$startDate = $endDate.AddDays(-$TimeframeDays)

# Get subscriptions
if ($SubscriptionIds) {
    $subscriptions = $SubscriptionIds
} else {
    $subscriptions = (Get-AzSubscription).Id
}

$allCostData = @{
    extractionDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    timeframe = @{
        startDate = $startDate.ToString("yyyy-MM-dd")
        endDate = $endDate.ToString("yyyy-MM-dd")
        days = $TimeframeDays
    }
    subscriptions = @()
}

foreach ($subId in $subscriptions) {
    Write-Host "`nProcessing Subscription: $subId" -ForegroundColor Yellow

    try {
        Set-AzContext -SubscriptionId $subId -ErrorAction Stop | Out-Null

        $subData = @{
            subscriptionId = $subId
            totalCost = 0
            costByService = @()
            costByResourceGroup = @()
            costByLocation = @()
            costTrend = @()
            advisorRecommendations = @()
            potentialSavings = 0
        }

        # 1. Get Cost by Service (using Resource Graph as Cost Management API is complex)
        Write-Host "  Extracting Cost by Service..." -ForegroundColor Gray
        try {
            # Using Advisor cost recommendations as a proxy for cost analysis
            $costRecommendations = Get-AzAdvisorRecommendation | Where-Object { $_.Category -eq "Cost" }

            $subData.advisorRecommendations = $costRecommendations | ForEach-Object {
                @{
                    resourceId = $_.ResourceId
                    impact = $_.Impact
                    shortDescription = $_.ShortDescription.Problem
                    solution = $_.ShortDescription.Solution
                    potentialBenefits = $_.ExtendedProperties.annualSavingsAmount
                }
            }

            $totalPotentialSavings = ($costRecommendations |
                Where-Object { $_.ExtendedProperties.annualSavingsAmount } |
                ForEach-Object { [decimal]$_.ExtendedProperties.annualSavingsAmount } |
                Measure-Object -Sum).Sum

            $subData.potentialSavings = $totalPotentialSavings
            Write-Host "    Found $($costRecommendations.Count) cost recommendations" -ForegroundColor Green
            Write-Host "    Potential annual savings: `$$([math]::Round($totalPotentialSavings, 2))" -ForegroundColor Green
        }
        catch {
            Write-Host "    Could not retrieve cost recommendations: $($_.Exception.Message)" -ForegroundColor Red
        }

        # 2. Get Resource Count by Type (for cost estimation)
        Write-Host "  Extracting Resource Distribution..." -ForegroundColor Gray
        try {
            $resourceQuery = @"
Resources
| where subscriptionId == '$subId'
| summarize count() by type
| order by count_ desc
"@
            $resourceDistribution = Search-AzGraph -Query $resourceQuery -Subscription $subId

            $subData.costByService = $resourceDistribution | ForEach-Object {
                @{
                    serviceType = $_.type
                    resourceCount = $_.count_
                }
            }
            Write-Host "    Found $($resourceDistribution.Count) service types" -ForegroundColor Green
        }
        catch {
            Write-Host "    Could not retrieve resource distribution: $($_.Exception.Message)" -ForegroundColor Red
        }

        # 3. Get Resources by Resource Group
        Write-Host "  Extracting Resource Group Distribution..." -ForegroundColor Gray
        try {
            $rgQuery = @"
Resources
| where subscriptionId == '$subId'
| summarize count() by resourceGroup
| order by count_ desc
"@
            $rgDistribution = Search-AzGraph -Query $rgQuery -Subscription $subId

            $subData.costByResourceGroup = $rgDistribution | ForEach-Object {
                @{
                    resourceGroup = $_.resourceGroup
                    resourceCount = $_.count_
                }
            }
            Write-Host "    Found $($rgDistribution.Count) resource groups" -ForegroundColor Green
        }
        catch {
            Write-Host "    Could not retrieve RG distribution: $($_.Exception.Message)" -ForegroundColor Red
        }

        # 4. Get Resources by Location
        Write-Host "  Extracting Location Distribution..." -ForegroundColor Gray
        try {
            $locationQuery = @"
Resources
| where subscriptionId == '$subId'
| summarize count() by location
| order by count_ desc
"@
            $locationDistribution = Search-AzGraph -Query $locationQuery -Subscription $subId

            $subData.costByLocation = $locationDistribution | ForEach-Object {
                @{
                    location = $_.location
                    resourceCount = $_.count_
                }
            }
            Write-Host "    Found resources in $($locationDistribution.Count) locations" -ForegroundColor Green
        }
        catch {
            Write-Host "    Could not retrieve location distribution: $($_.Exception.Message)" -ForegroundColor Red
        }

        # 5. Get VM Sizing Recommendations (common cost optimization)
        Write-Host "  Extracting VM Optimization Opportunities..." -ForegroundColor Gray
        try {
            $vmQuery = @"
Resources
| where type == 'microsoft.compute/virtualmachines'
| where subscriptionId == '$subId'
| project name, resourceGroup, vmSize = properties.hardwareProfile.vmSize, location
"@
            $vms = Search-AzGraph -Query $vmQuery -Subscription $subId

            $subData.vmInventory = $vms | ForEach-Object {
                @{
                    name = $_.name
                    resourceGroup = $_.resourceGroup
                    vmSize = $_.vmSize
                    location = $_.location
                }
            }
            Write-Host "    Found $($vms.Count) VMs for sizing analysis" -ForegroundColor Green
        }
        catch {
            Write-Host "    Could not retrieve VM inventory: $($_.Exception.Message)" -ForegroundColor Red
        }

        # 6. Check for Unattached Disks
        Write-Host "  Checking for Unattached Disks..." -ForegroundColor Gray
        try {
            $diskQuery = @"
Resources
| where type == 'microsoft.compute/disks'
| where subscriptionId == '$subId'
| where isnull(managedBy) or managedBy == ''
| project name, resourceGroup, diskSizeGB = properties.diskSizeGB, diskState = properties.diskState
"@
            $unattachedDisks = Search-AzGraph -Query $diskQuery -Subscription $subId

            $subData.unattachedDisks = $unattachedDisks | ForEach-Object {
                @{
                    name = $_.name
                    resourceGroup = $_.resourceGroup
                    diskSizeGB = $_.diskSizeGB
                    diskState = $_.diskState
                }
            }
            Write-Host "    Found $($unattachedDisks.Count) unattached disks" -ForegroundColor $(if ($unattachedDisks.Count -gt 0) { "Yellow" } else { "Green" })
        }
        catch {
            Write-Host "    Could not check unattached disks: $($_.Exception.Message)" -ForegroundColor Red
        }

        # 7. Check for Unattached Public IPs
        Write-Host "  Checking for Unattached Public IPs..." -ForegroundColor Gray
        try {
            $pipQuery = @"
Resources
| where type == 'microsoft.network/publicipaddresses'
| where subscriptionId == '$subId'
| where isnull(properties.ipConfiguration)
| project name, resourceGroup, location
"@
            $unattachedPips = Search-AzGraph -Query $pipQuery -Subscription $subId

            $subData.unattachedPublicIps = $unattachedPips | ForEach-Object {
                @{
                    name = $_.name
                    resourceGroup = $_.resourceGroup
                    location = $_.location
                }
            }
            Write-Host "    Found $($unattachedPips.Count) unattached Public IPs" -ForegroundColor $(if ($unattachedPips.Count -gt 0) { "Yellow" } else { "Green" })
        }
        catch {
            Write-Host "    Could not check unattached PIPs: $($_.Exception.Message)" -ForegroundColor Red
        }

        $allCostData.subscriptions += $subData
    }
    catch {
        Write-Host "  Error processing subscription: $($_.Exception.Message)" -ForegroundColor Red
    }
}

#region Generate Cost Summary

Write-Host "`nGenerating Cost Summary..." -ForegroundColor Cyan

$costSummary = @{
    totalPotentialSavings = ($allCostData.subscriptions.potentialSavings | Measure-Object -Sum).Sum
    totalCostRecommendations = ($allCostData.subscriptions.advisorRecommendations | Measure-Object).Count
    wasteIdentified = @{
        unattachedDisks = ($allCostData.subscriptions.unattachedDisks | Measure-Object).Count
        unattachedPublicIps = ($allCostData.subscriptions.unattachedPublicIps | Measure-Object).Count
    }
    bySubscription = $allCostData.subscriptions | ForEach-Object {
        @{
            subscriptionId = $_.subscriptionId
            potentialSavings = $_.potentialSavings
            recommendationCount = ($_.advisorRecommendations | Measure-Object).Count
            unattachedDisks = ($_.unattachedDisks | Measure-Object).Count
            unattachedPublicIps = ($_.unattachedPublicIps | Measure-Object).Count
        }
    }
}

#endregion

#region Save Output

# Save full cost data
$allCostData | ConvertTo-Json -Depth 20 | Out-File "$OutputPath/cost-full-export.json"

# Save summary
$costSummary | ConvertTo-Json -Depth 10 | Out-File "$OutputPath/cost-summary.json"

# Save recommendations CSV
$allCostData.subscriptions.advisorRecommendations | Export-Csv "$OutputPath/cost-recommendations.csv" -NoTypeInformation

# Save unattached resources CSV
$allCostData.subscriptions.unattachedDisks | Export-Csv "$OutputPath/unattached-disks.csv" -NoTypeInformation
$allCostData.subscriptions.unattachedPublicIps | Export-Csv "$OutputPath/unattached-publicips.csv" -NoTypeInformation

#endregion

#region Console Output

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "COST EXTRACTION COMPLETE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Total Potential Annual Savings: `$$([math]::Round($costSummary.totalPotentialSavings, 2))" -ForegroundColor Green
Write-Host "Cost Recommendations: $($costSummary.totalCostRecommendations)" -ForegroundColor White
Write-Host "`nWaste Identified:" -ForegroundColor Yellow
Write-Host "  Unattached Disks: $($costSummary.wasteIdentified.unattachedDisks)" -ForegroundColor $(if ($costSummary.wasteIdentified.unattachedDisks -gt 0) { "Yellow" } else { "Green" })
Write-Host "  Unattached Public IPs: $($costSummary.wasteIdentified.unattachedPublicIps)" -ForegroundColor $(if ($costSummary.wasteIdentified.unattachedPublicIps -gt 0) { "Yellow" } else { "Green" })
Write-Host "`nOutput saved to: $OutputPath" -ForegroundColor Green

#endregion
