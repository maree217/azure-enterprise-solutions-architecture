<#
.SYNOPSIS
    Extracts comprehensive Azure resource inventory using Azure Resource Graph.

.DESCRIPTION
    This script queries Azure Resource Graph to extract a complete inventory of all resources
    across specified subscriptions, including configurations, relationships, and metadata.

.PARAMETER SubscriptionIds
    Array of subscription IDs to query. If empty, queries all accessible subscriptions.

.PARAMETER OutputPath
    Path where output files will be saved.

.PARAMETER OutputFormat
    Format for output: JSON, CSV, or Both. Default is Both.

.EXAMPLE
    ./azure-inventory.ps1 -SubscriptionIds @("sub1", "sub2") -OutputPath "./output"

.NOTES
    Requires: Az.ResourceGraph module
    Permissions: Reader access to target subscriptions
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string[]]$SubscriptionIds,

    [Parameter(Mandatory=$true)]
    [string]$OutputPath,

    [Parameter(Mandatory=$false)]
    [ValidateSet("JSON", "CSV", "Both")]
    [string]$OutputFormat = "Both"
)

# Import required modules
Import-Module Az.ResourceGraph -ErrorAction Stop

# Create output directory
New-Item -ItemType Directory -Force -Path $OutputPath | Out-Null

Write-Host "Starting Azure Resource Inventory Extraction..." -ForegroundColor Cyan
Write-Host "Output Path: $OutputPath" -ForegroundColor Gray

# Set subscription context
if ($SubscriptionIds) {
    $subscriptionContext = $SubscriptionIds
    Write-Host "Targeting subscriptions: $($SubscriptionIds -join ', ')" -ForegroundColor Gray
} else {
    $subscriptionContext = (Get-AzSubscription).Id
    Write-Host "Targeting all accessible subscriptions" -ForegroundColor Gray
}

#region Resource Queries

# 1. All Resources Overview
$allResourcesQuery = @"
Resources
| project
    id,
    name,
    type,
    location,
    resourceGroup,
    subscriptionId,
    tags,
    sku,
    kind,
    properties
| order by type asc, name asc
"@

# 2. Virtual Networks
$vnetQuery = @"
Resources
| where type == 'microsoft.network/virtualnetworks'
| project
    name,
    resourceGroup,
    location,
    subscriptionId,
    addressSpace = properties.addressSpace.addressPrefixes,
    subnets = properties.subnets,
    peerings = properties.virtualNetworkPeerings,
    enableDdosProtection = properties.enableDdosProtection
"@

# 3. Storage Accounts
$storageQuery = @"
Resources
| where type == 'microsoft.storage/storageaccounts'
| project
    name,
    resourceGroup,
    location,
    subscriptionId,
    kind,
    sku = sku.name,
    accessTier = properties.accessTier,
    httpsOnly = properties.supportsHttpsTrafficOnly,
    minimumTlsVersion = properties.minimumTlsVersion,
    allowBlobPublicAccess = properties.allowBlobPublicAccess,
    networkAcls = properties.networkAcls
"@

# 4. SQL Databases
$sqlQuery = @"
Resources
| where type == 'microsoft.sql/servers/databases' or type == 'microsoft.sql/servers'
| project
    name,
    type,
    resourceGroup,
    location,
    subscriptionId,
    sku,
    properties
"@

# 5. Virtual Machines
$vmQuery = @"
Resources
| where type == 'microsoft.compute/virtualmachines'
| project
    name,
    resourceGroup,
    location,
    subscriptionId,
    vmSize = properties.hardwareProfile.vmSize,
    osType = properties.storageProfile.osDisk.osType,
    osVersion = properties.storageProfile.imageReference,
    availabilitySet = properties.availabilitySet,
    zones = zones
"@

# 6. AKS Clusters
$aksQuery = @"
Resources
| where type == 'microsoft.containerservice/managedclusters'
| project
    name,
    resourceGroup,
    location,
    subscriptionId,
    kubernetesVersion = properties.kubernetesVersion,
    nodeResourceGroup = properties.nodeResourceGroup,
    networkProfile = properties.networkProfile,
    agentPoolProfiles = properties.agentPoolProfiles
"@

# 7. App Services
$appServiceQuery = @"
Resources
| where type == 'microsoft.web/sites'
| project
    name,
    resourceGroup,
    location,
    subscriptionId,
    kind,
    sku = properties.sku,
    httpsOnly = properties.httpsOnly,
    state = properties.state,
    defaultHostName = properties.defaultHostName
"@

# 8. Key Vaults
$keyVaultQuery = @"
Resources
| where type == 'microsoft.keyvault/vaults'
| project
    name,
    resourceGroup,
    location,
    subscriptionId,
    sku = properties.sku,
    enableSoftDelete = properties.enableSoftDelete,
    enablePurgeProtection = properties.enablePurgeProtection,
    networkAcls = properties.networkAcls
"@

# 9. Azure OpenAI
$openAiQuery = @"
Resources
| where type == 'microsoft.cognitiveservices/accounts'
| where kind == 'OpenAI'
| project
    name,
    resourceGroup,
    location,
    subscriptionId,
    sku,
    properties
"@

# 10. Data Factory
$adfQuery = @"
Resources
| where type == 'microsoft.datafactory/factories'
| project
    name,
    resourceGroup,
    location,
    subscriptionId,
    properties
"@

# 11. Synapse Workspaces
$synapseQuery = @"
Resources
| where type == 'microsoft.synapse/workspaces'
| project
    name,
    resourceGroup,
    location,
    subscriptionId,
    properties
"@

# 12. Resource Groups
$rgQuery = @"
ResourceContainers
| where type == 'microsoft.resources/subscriptions/resourcegroups'
| project
    name,
    location,
    subscriptionId,
    tags
"@

# 13. Subscriptions
$subQuery = @"
ResourceContainers
| where type == 'microsoft.resources/subscriptions'
| project
    name,
    subscriptionId,
    properties
"@

# 14. Network Security Groups
$nsgQuery = @"
Resources
| where type == 'microsoft.network/networksecuritygroups'
| project
    name,
    resourceGroup,
    location,
    subscriptionId,
    securityRules = properties.securityRules,
    defaultSecurityRules = properties.defaultSecurityRules
"@

# 15. Public IPs
$publicIpQuery = @"
Resources
| where type == 'microsoft.network/publicipaddresses'
| project
    name,
    resourceGroup,
    location,
    subscriptionId,
    ipAddress = properties.ipAddress,
    publicIPAllocationMethod = properties.publicIPAllocationMethod,
    associatedResource = properties.ipConfiguration.id
"@

#endregion

#region Execute Queries

function Invoke-ResourceGraphQuery {
    param(
        [string]$Query,
        [string]$QueryName,
        [string[]]$Subscriptions
    )

    Write-Host "  Executing: $QueryName..." -ForegroundColor Yellow

    try {
        $results = Search-AzGraph -Query $Query -Subscription $Subscriptions -First 5000
        Write-Host "    Found $($results.Count) resources" -ForegroundColor Green
        return $results
    }
    catch {
        Write-Host "    Error: $($_.Exception.Message)" -ForegroundColor Red
        return @()
    }
}

$queries = @{
    "all-resources" = $allResourcesQuery
    "virtual-networks" = $vnetQuery
    "storage-accounts" = $storageQuery
    "sql-databases" = $sqlQuery
    "virtual-machines" = $vmQuery
    "aks-clusters" = $aksQuery
    "app-services" = $appServiceQuery
    "key-vaults" = $keyVaultQuery
    "azure-openai" = $openAiQuery
    "data-factories" = $adfQuery
    "synapse-workspaces" = $synapseQuery
    "resource-groups" = $rgQuery
    "subscriptions" = $subQuery
    "network-security-groups" = $nsgQuery
    "public-ips" = $publicIpQuery
}

$allResults = @{}

foreach ($queryItem in $queries.GetEnumerator()) {
    $results = Invoke-ResourceGraphQuery `
        -Query $queryItem.Value `
        -QueryName $queryItem.Key `
        -Subscriptions $subscriptionContext

    $allResults[$queryItem.Key] = $results

    # Save individual results
    if ($OutputFormat -eq "JSON" -or $OutputFormat -eq "Both") {
        $results | ConvertTo-Json -Depth 10 | Out-File "$OutputPath/$($queryItem.Key).json"
    }
    if ($OutputFormat -eq "CSV" -or $OutputFormat -eq "Both") {
        $results | Export-Csv "$OutputPath/$($queryItem.Key).csv" -NoTypeInformation
    }
}

#endregion

#region Generate Summary

Write-Host "`nGenerating Summary Report..." -ForegroundColor Cyan

$summary = @{
    extractionDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    subscriptionsScanned = $subscriptionContext.Count
    totalResources = $allResults["all-resources"].Count
    resourcesByType = $allResults["all-resources"] | Group-Object type | Select-Object Name, Count | Sort-Object Count -Descending
    resourcesByLocation = $allResults["all-resources"] | Group-Object location | Select-Object Name, Count | Sort-Object Count -Descending
    resourcesBySubscription = $allResults["all-resources"] | Group-Object subscriptionId | Select-Object Name, Count | Sort-Object Count -Descending
    highlights = @{
        virtualNetworks = $allResults["virtual-networks"].Count
        storageAccounts = $allResults["storage-accounts"].Count
        virtualMachines = $allResults["virtual-machines"].Count
        aksClusters = $allResults["aks-clusters"].Count
        keyVaults = $allResults["key-vaults"].Count
        sqlDatabases = $allResults["sql-databases"].Count
        appServices = $allResults["app-services"].Count
        publicIps = $allResults["public-ips"].Count
    }
}

$summary | ConvertTo-Json -Depth 10 | Out-File "$OutputPath/extraction-summary.json"

#endregion

#region Console Output

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "EXTRACTION COMPLETE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Total Resources: $($summary.totalResources)" -ForegroundColor White
Write-Host "Subscriptions Scanned: $($summary.subscriptionsScanned)" -ForegroundColor White
Write-Host "`nResource Highlights:" -ForegroundColor Yellow
Write-Host "  Virtual Networks: $($summary.highlights.virtualNetworks)"
Write-Host "  Storage Accounts: $($summary.highlights.storageAccounts)"
Write-Host "  Virtual Machines: $($summary.highlights.virtualMachines)"
Write-Host "  AKS Clusters: $($summary.highlights.aksClusters)"
Write-Host "  Key Vaults: $($summary.highlights.keyVaults)"
Write-Host "  SQL Databases: $($summary.highlights.sqlDatabases)"
Write-Host "  App Services: $($summary.highlights.appServices)"
Write-Host "  Public IPs: $($summary.highlights.publicIps)"
Write-Host "`nOutput saved to: $OutputPath" -ForegroundColor Green

#endregion
