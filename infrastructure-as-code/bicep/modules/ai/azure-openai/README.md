# Azure OpenAI Module (Bicep)

Deploys Azure OpenAI with model deployments and optional private endpoint.

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    AZURE OPENAI DEPLOYMENT                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │               AZURE OPENAI SERVICE                          │ │
│  │                                                             │ │
│  │  ┌─────────────────┐  ┌─────────────────┐                  │ │
│  │  │   GPT-4o        │  │  Embedding      │                  │ │
│  │  │   Deployment    │  │  Deployment     │                  │ │
│  │  └─────────────────┘  └─────────────────┘                  │ │
│  │                                                             │ │
│  └────────────────────────────────────────────────────────────┘ │
│                           │                                      │
│  ┌────────────────────────▼───────────────────────────────────┐ │
│  │              PRIVATE ENDPOINT                               │ │
│  │  • Private DNS Zone: privatelink.openai.azure.com          │ │
│  │  • VNet Integration                                         │ │
│  └────────────────────────────────────────────────────────────┘ │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

## Usage

### Basic Deployment

```bicep
module openai 'modules/ai/azure-openai/main.bicep' = {
  name: 'azure-openai'
  params: {
    location: 'eastus2'
    environment: 'prod'
    baseName: 'chat'
    publicNetworkAccess: 'Enabled'
    deployments: [
      {
        name: 'gpt-4o'
        model: 'gpt-4o'
        version: '2024-05-13'
        capacity: 10
      }
    ]
    tags: {
      workload: 'ai-chat'
      'cost-center': 'AI-001'
    }
  }
}
```

### With Private Endpoint

```bicep
module openai 'modules/ai/azure-openai/main.bicep' = {
  name: 'azure-openai'
  params: {
    location: 'eastus2'
    environment: 'prod'
    baseName: 'chat'
    publicNetworkAccess: 'Disabled'
    vnetId: vnet.id
    subnetId: subnet.id
    deployments: [
      {
        name: 'gpt-4o'
        model: 'gpt-4o'
        version: '2024-05-13'
        capacity: 20
      }
      {
        name: 'text-embedding-3-large'
        model: 'text-embedding-3-large'
        version: '1'
        capacity: 50
      }
    ]
    tags: {
      workload: 'ai-chat'
    }
  }
}
```

## Parameters

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| location | string | No | resourceGroup().location | Azure region |
| environment | string | Yes | - | Environment (prod, dev, staging, test) |
| baseName | string | No | 'aoai' | Base name for resources |
| sku | string | No | 'S0' | Azure OpenAI SKU |
| deployments | array | No | [gpt-4o, embeddings] | Model deployments |
| publicNetworkAccess | string | No | 'Disabled' | Public access setting |
| vnetId | string | No | '' | VNet ID for private DNS |
| subnetId | string | No | '' | Subnet ID for private endpoint |
| tags | object | No | {} | Resource tags |

## Outputs

| Name | Type | Description |
|------|------|-------------|
| openAIId | string | Azure OpenAI resource ID |
| openAIName | string | Azure OpenAI resource name |
| openAIEndpoint | string | Azure OpenAI endpoint URL |
| deploymentNames | array | Names of model deployments |
| privateEndpointId | string | Private endpoint ID (if created) |

## Deployment

```bash
# Create resource group
az group create --name rg-openai-prod --location eastus2

# Deploy module
az deployment group create \
  --resource-group rg-openai-prod \
  --template-file main.bicep \
  --parameters environment=prod baseName=chat
```

## Three-Layer Mapping

This module supports **Layer 2: Organizational Intelligence**:

| Component | Purpose |
|-----------|---------|
| Azure OpenAI | LLM capabilities for RAG, chat, summarization |
| Model Deployments | GPT-4o for generation, embeddings for search |
| Private Endpoint | Secure connectivity from other services |

## Integration Examples

### RAG Pattern

```bicep
// Deploy OpenAI
module openai 'modules/ai/azure-openai/main.bicep' = { ... }

// Deploy AI Search
module search 'modules/ai/ai-search/main.bicep' = {
  params: {
    openAIEndpoint: openai.outputs.openAIEndpoint
    embeddingDeployment: 'text-embedding-3-large'
  }
}

// Deploy Container App for API
module api 'modules/compute/container-apps/main.bicep' = {
  params: {
    openAIEndpoint: openai.outputs.openAIEndpoint
    searchEndpoint: search.outputs.searchEndpoint
  }
}
```
