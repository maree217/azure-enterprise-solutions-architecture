// Azure OpenAI Module
// Deploys Azure OpenAI with model deployments and private endpoint

@description('Location for the Azure OpenAI resource')
param location string = resourceGroup().location

@description('Environment name')
@allowed(['prod', 'dev', 'staging', 'test'])
param environment string

@description('Base name for resources')
param baseName string = 'aoai'

@description('Azure OpenAI SKU')
@allowed(['S0'])
param sku string = 'S0'

@description('Model deployments to create')
param deployments array = [
  {
    name: 'gpt-4o'
    model: 'gpt-4o'
    version: '2024-05-13'
    capacity: 10
  }
  {
    name: 'text-embedding-3-large'
    model: 'text-embedding-3-large'
    version: '1'
    capacity: 10
  }
]

@description('Enable public network access')
param publicNetworkAccess string = 'Disabled'

@description('VNet ID for private endpoint (required if publicNetworkAccess is Disabled)')
param vnetId string = ''

@description('Subnet ID for private endpoint')
param subnetId string = ''

@description('Tags for all resources')
param tags object = {}

// Variables
var resourceName = 'oai-${baseName}-${environment}-${location}'
var privateEndpointName = 'pe-${resourceName}'
var privateDnsZoneName = 'privatelink.openai.azure.com'

var defaultTags = union(tags, {
  module: 'azure-openai'
  'three-layer': 'layer-2'
})

// Azure OpenAI Cognitive Services Account
resource openAI 'Microsoft.CognitiveServices/accounts@2023-10-01-preview' = {
  name: resourceName
  location: location
  kind: 'OpenAI'
  sku: {
    name: sku
  }
  properties: {
    customSubDomainName: resourceName
    publicNetworkAccess: publicNetworkAccess
    networkAcls: {
      defaultAction: 'Deny'
      ipRules: []
      virtualNetworkRules: []
    }
  }
  tags: defaultTags
}

// Model Deployments
resource deployment 'Microsoft.CognitiveServices/accounts/deployments@2023-10-01-preview' = [for deploy in deployments: {
  parent: openAI
  name: deploy.name
  sku: {
    name: 'Standard'
    capacity: deploy.capacity
  }
  properties: {
    model: {
      format: 'OpenAI'
      name: deploy.model
      version: deploy.version
    }
    raiPolicyName: 'Microsoft.Default'
  }
}]

// Private Endpoint (if VNet is provided)
resource privateEndpoint 'Microsoft.Network/privateEndpoints@2023-05-01' = if (!empty(subnetId)) {
  name: privateEndpointName
  location: location
  properties: {
    subnet: {
      id: subnetId
    }
    privateLinkServiceConnections: [
      {
        name: privateEndpointName
        properties: {
          privateLinkServiceId: openAI.id
          groupIds: ['account']
        }
      }
    ]
  }
  tags: defaultTags
}

// Private DNS Zone
resource privateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = if (!empty(vnetId)) {
  name: privateDnsZoneName
  location: 'global'
  tags: defaultTags
}

// VNet Link
resource vnetLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = if (!empty(vnetId)) {
  parent: privateDnsZone
  name: '${privateDnsZoneName}-link'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: vnetId
    }
  }
}

// DNS Zone Group
resource privateDnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-05-01' = if (!empty(subnetId)) {
  parent: privateEndpoint
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'openai-config'
        properties: {
          privateDnsZoneId: privateDnsZone.id
        }
      }
    ]
  }
}

// Outputs
output openAIId string = openAI.id
output openAIName string = openAI.name
output openAIEndpoint string = openAI.properties.endpoint
output deploymentNames array = [for (deploy, i) in deployments: deployment[i].name]
output privateEndpointId string = !empty(subnetId) ? privateEndpoint.id : ''
