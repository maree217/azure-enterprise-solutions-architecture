<#
.SYNOPSIS
    Extracts security posture data from Microsoft Defender for Cloud.

.DESCRIPTION
    This script extracts security assessments, recommendations, alerts, and compliance
    data from Microsoft Defender for Cloud across specified subscriptions.

.PARAMETER SubscriptionIds
    Array of subscription IDs to query.

.PARAMETER OutputPath
    Path where output files will be saved.

.EXAMPLE
    ./security-export.ps1 -SubscriptionIds @("sub1") -OutputPath "./security-data"

.NOTES
    Requires: Az.Security module
    Permissions: Security Reader role
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string[]]$SubscriptionIds,

    [Parameter(Mandatory=$true)]
    [string]$OutputPath
)

# Import required modules
Import-Module Az.Security -ErrorAction Stop

# Create output directory
New-Item -ItemType Directory -Force -Path $OutputPath | Out-Null

Write-Host "Starting Security Posture Extraction..." -ForegroundColor Cyan

# Get subscriptions
if ($SubscriptionIds) {
    $subscriptions = $SubscriptionIds
} else {
    $subscriptions = (Get-AzSubscription).Id
}

$allSecurityData = @{
    extractionDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    subscriptions = @()
}

foreach ($subId in $subscriptions) {
    Write-Host "`nProcessing Subscription: $subId" -ForegroundColor Yellow

    try {
        Set-AzContext -SubscriptionId $subId -ErrorAction Stop | Out-Null

        $subData = @{
            subscriptionId = $subId
            secureScore = @{}
            assessments = @()
            alerts = @()
            complianceResults = @()
            recommendations = @()
        }

        # 1. Get Secure Score
        Write-Host "  Extracting Secure Score..." -ForegroundColor Gray
        try {
            $secureScore = Get-AzSecuritySecureScore
            $subData.secureScore = @{
                currentScore = $secureScore.CurrentScore
                maxScore = $secureScore.MaxScore
                percentage = [math]::Round(($secureScore.CurrentScore / $secureScore.MaxScore) * 100, 2)
            }
            Write-Host "    Secure Score: $($subData.secureScore.percentage)%" -ForegroundColor Green
        }
        catch {
            Write-Host "    Could not retrieve Secure Score: $($_.Exception.Message)" -ForegroundColor Red
        }

        # 2. Get Security Assessments
        Write-Host "  Extracting Security Assessments..." -ForegroundColor Gray
        try {
            $assessments = Get-AzSecurityAssessment
            $subData.assessments = $assessments | ForEach-Object {
                @{
                    name = $_.DisplayName
                    resourceId = $_.Id
                    status = $_.Status.Code
                    description = $_.Status.Description
                    severity = $_.Metadata.Severity
                    category = $_.Metadata.Category
                }
            }
            Write-Host "    Found $($assessments.Count) assessments" -ForegroundColor Green
        }
        catch {
            Write-Host "    Could not retrieve assessments: $($_.Exception.Message)" -ForegroundColor Red
        }

        # 3. Get Security Alerts
        Write-Host "  Extracting Security Alerts..." -ForegroundColor Gray
        try {
            $alerts = Get-AzSecurityAlert
            $subData.alerts = $alerts | ForEach-Object {
                @{
                    alertName = $_.AlertDisplayName
                    severity = $_.Severity
                    status = $_.Status
                    description = $_.Description
                    timeGenerated = $_.TimeGeneratedUtc
                    compromisedEntity = $_.CompromisedEntity
                    remediationSteps = $_.RemediationSteps
                }
            }
            Write-Host "    Found $($alerts.Count) alerts" -ForegroundColor $(if ($alerts.Count -gt 0) { "Yellow" } else { "Green" })
        }
        catch {
            Write-Host "    Could not retrieve alerts: $($_.Exception.Message)" -ForegroundColor Red
        }

        # 4. Get Compliance Results
        Write-Host "  Extracting Compliance Data..." -ForegroundColor Gray
        try {
            $compliance = Get-AzSecurityRegulatoryComplianceStandard
            $subData.complianceResults = $compliance | ForEach-Object {
                @{
                    standardName = $_.Name
                    state = $_.State
                    passedControls = $_.PassedControls
                    failedControls = $_.FailedControls
                    skippedControls = $_.SkippedControls
                }
            }
            Write-Host "    Found $($compliance.Count) compliance standards" -ForegroundColor Green
        }
        catch {
            Write-Host "    Could not retrieve compliance: $($_.Exception.Message)" -ForegroundColor Red
        }

        # 5. Get Recommendations (via Resource Graph for richer data)
        Write-Host "  Extracting Recommendations..." -ForegroundColor Gray
        try {
            $recQuery = @"
securityresources
| where type == 'microsoft.security/assessments'
| extend status = properties.status.code
| extend displayName = properties.displayName
| extend severity = properties.metadata.severity
| extend category = properties.metadata.category
| project displayName, status, severity, category, resourceId = id
"@
            $recommendations = Search-AzGraph -Query $recQuery -Subscription $subId -First 1000
            $subData.recommendations = $recommendations | ForEach-Object {
                @{
                    displayName = $_.displayName
                    status = $_.status
                    severity = $_.severity
                    category = $_.category
                    resourceId = $_.resourceId
                }
            }
            Write-Host "    Found $($recommendations.Count) recommendations" -ForegroundColor Green
        }
        catch {
            Write-Host "    Could not retrieve recommendations: $($_.Exception.Message)" -ForegroundColor Red
        }

        $allSecurityData.subscriptions += $subData
    }
    catch {
        Write-Host "  Error processing subscription: $($_.Exception.Message)" -ForegroundColor Red
    }
}

#region Generate Security Summary

Write-Host "`nGenerating Security Summary..." -ForegroundColor Cyan

$securitySummary = @{
    overallFindings = @{
        totalAssessments = ($allSecurityData.subscriptions.assessments | Measure-Object).Count
        unhealthyAssessments = ($allSecurityData.subscriptions.assessments | Where-Object { $_.status -eq "Unhealthy" } | Measure-Object).Count
        totalAlerts = ($allSecurityData.subscriptions.alerts | Measure-Object).Count
        highSeverityAlerts = ($allSecurityData.subscriptions.alerts | Where-Object { $_.severity -eq "High" } | Measure-Object).Count
    }
    bySubscription = $allSecurityData.subscriptions | ForEach-Object {
        @{
            subscriptionId = $_.subscriptionId
            secureScorePercentage = $_.secureScore.percentage
            unhealthyCount = ($_.assessments | Where-Object { $_.status -eq "Unhealthy" } | Measure-Object).Count
            alertCount = ($_.alerts | Measure-Object).Count
        }
    }
    topIssues = $allSecurityData.subscriptions.assessments |
        Where-Object { $_.status -eq "Unhealthy" -and $_.severity -eq "High" } |
        Group-Object name |
        Select-Object Name, Count |
        Sort-Object Count -Descending |
        Select-Object -First 10
}

#endregion

#region Save Output

# Save full security data
$allSecurityData | ConvertTo-Json -Depth 20 | Out-File "$OutputPath/security-full-export.json"

# Save summary
$securitySummary | ConvertTo-Json -Depth 10 | Out-File "$OutputPath/security-summary.json"

# Save assessments CSV
$allSecurityData.subscriptions.assessments | Export-Csv "$OutputPath/security-assessments.csv" -NoTypeInformation

# Save alerts CSV
$allSecurityData.subscriptions.alerts | Export-Csv "$OutputPath/security-alerts.csv" -NoTypeInformation

#endregion

#region Console Output

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "SECURITY EXTRACTION COMPLETE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Total Assessments: $($securitySummary.overallFindings.totalAssessments)" -ForegroundColor White
Write-Host "Unhealthy Assessments: $($securitySummary.overallFindings.unhealthyAssessments)" -ForegroundColor $(if ($securitySummary.overallFindings.unhealthyAssessments -gt 0) { "Yellow" } else { "Green" })
Write-Host "Total Alerts: $($securitySummary.overallFindings.totalAlerts)" -ForegroundColor $(if ($securitySummary.overallFindings.totalAlerts -gt 0) { "Yellow" } else { "Green" })
Write-Host "High Severity Alerts: $($securitySummary.overallFindings.highSeverityAlerts)" -ForegroundColor $(if ($securitySummary.overallFindings.highSeverityAlerts -gt 0) { "Red" } else { "Green" })

if ($securitySummary.topIssues.Count -gt 0) {
    Write-Host "`nTop Security Issues:" -ForegroundColor Yellow
    $securitySummary.topIssues | ForEach-Object {
        Write-Host "  - $($_.Name) ($($_.Count) occurrences)" -ForegroundColor White
    }
}

Write-Host "`nOutput saved to: $OutputPath" -ForegroundColor Green

#endregion
