# Infrastructure as Code Templates

Reusable Terraform and Bicep modules aligned with the Three-Layer Enterprise AI Architecture.

---

## Overview

This directory contains production-ready IaC templates for deploying Azure resources following enterprise best practices. All modules are designed to integrate with Azure Landing Zones and support the Three-Layer Architecture pattern.

```
infrastructure-as-code/
├── terraform/
│   ├── modules/                 # Reusable Terraform modules
│   │   ├── networking/          # Hub-spoke, VNets, NSGs
│   │   ├── security/            # Key Vault, Defender, Sentinel
│   │   ├── data/                # Synapse, Databricks, Data Factory
│   │   ├── ai/                  # Azure OpenAI, AI Search, ML
│   │   └── compute/             # AKS, Container Apps, VMs
│   └── examples/                # Complete deployment examples
│       ├── landing-zone/
│       ├── data-platform/
│       └── ai-workload/
│
├── bicep/
│   ├── modules/                 # Reusable Bicep modules
│   │   ├── networking/
│   │   ├── security/
│   │   ├── data/
│   │   ├── ai/
│   │   └── compute/
│   └── examples/
│       ├── landing-zone/
│       ├── data-platform/
│       └── ai-workload/
│
└── README.md                    # This file
```

---

## Choosing Between Terraform and Bicep

| Consideration | Terraform | Bicep |
|---------------|-----------|-------|
| **Multi-cloud** | Yes | Azure only |
| **State management** | Required (remote backend) | None (ARM handles) |
| **Learning curve** | Moderate (HCL) | Low (ARM-like) |
| **Microsoft support** | Community + HashiCorp | First-party |
| **Enterprise adoption** | Very high | Growing |
| **Module ecosystem** | Extensive | Growing |

**Recommendation:**
- **Choose Terraform** if you have multi-cloud requirements or existing Terraform expertise
- **Choose Bicep** if Azure-only and you want native Microsoft tooling

---

## Module Design Principles

### 1. Naming Convention

All resources follow the Azure CAF naming convention:

```
{resource-type}-{workload}-{environment}-{region}-{instance}

Examples:
- vnet-hub-prod-uksouth-001
- kv-data-dev-westeurope-001
- aoai-chat-prod-eastus2-001
```

### 2. Tagging Strategy

All modules apply consistent tags:

```hcl
tags = {
  environment     = "production"
  workload        = "data-platform"
  cost-center     = "IT-12345"
  owner           = "platform-team@company.com"
  created-by      = "terraform"
  three-layer     = "layer-2"  # layer-1, layer-2, layer-3
}
```

### 3. Security by Default

- Private endpoints enabled by default
- Encryption with customer-managed keys where supported
- Diagnostic settings configured
- Network restrictions applied

### 4. Modular Composition

Modules are designed to be composed together:

```hcl
module "networking" {
  source = "./modules/networking/hub-spoke"
  ...
}

module "security" {
  source = "./modules/security/key-vault"
  vnet_id = module.networking.hub_vnet_id
  ...
}

module "data" {
  source = "./modules/data/synapse"
  vnet_id = module.networking.spoke_vnet_ids["data"]
  key_vault_id = module.security.key_vault_id
  ...
}
```

---

## Quick Start

### Terraform

```bash
# Clone the repository
git clone https://github.com/maree217/azure-enterprise-solutions-architecture.git
cd azure-enterprise-solutions-architecture/infrastructure-as-code/terraform

# Navigate to example
cd examples/landing-zone

# Initialize
terraform init

# Plan
terraform plan -var-file="production.tfvars"

# Apply
terraform apply -var-file="production.tfvars"
```

### Bicep

```bash
# Clone the repository
git clone https://github.com/maree217/azure-enterprise-solutions-architecture.git
cd azure-enterprise-solutions-architecture/infrastructure-as-code/bicep

# Navigate to example
cd examples/landing-zone

# Deploy
az deployment sub create \
  --location uksouth \
  --template-file main.bicep \
  --parameters @parameters.production.json
```

---

## Module Reference

### Networking Modules

| Module | Purpose | Layer |
|--------|---------|-------|
| `hub-spoke` | Hub-spoke network topology | Layer 3 |
| `vnet` | Virtual network with subnets | Layer 3 |
| `nsg` | Network security groups | Layer 3 |
| `private-endpoint` | Private endpoint configuration | Layer 3 |
| `firewall` | Azure Firewall deployment | Layer 3 |

### Security Modules

| Module | Purpose | Layer |
|--------|---------|-------|
| `key-vault` | Key Vault with RBAC | Layer 3 |
| `managed-identity` | User-assigned identity | Layer 3 |
| `defender` | Defender for Cloud setup | Governance |
| `sentinel` | Sentinel workspace | Governance |

### Data Modules

| Module | Purpose | Layer |
|--------|---------|-------|
| `synapse` | Synapse workspace | Layer 2 |
| `databricks` | Databricks workspace | Layer 2 |
| `data-factory` | Data Factory instance | Layer 2 |
| `storage-data-lake` | ADLS Gen2 storage | Layer 2 |
| `purview` | Microsoft Purview | Governance |

### AI Modules

| Module | Purpose | Layer |
|--------|---------|-------|
| `azure-openai` | Azure OpenAI deployment | Layer 2 |
| `ai-search` | Azure AI Search | Layer 2 |
| `ml-workspace` | Azure ML workspace | Layer 2 |
| `cognitive-services` | AI Services account | Layer 2 |

### Compute Modules

| Module | Purpose | Layer |
|--------|---------|-------|
| `aks` | AKS cluster | Layer 1/3 |
| `container-apps` | Container Apps environment | Layer 1/3 |
| `app-service` | App Service plan + web apps | Layer 1 |
| `function-app` | Function App | Layer 1/2 |

---

## Example Deployments

### 1. Enterprise Landing Zone

Deploy a complete landing zone with hub-spoke networking:

```
examples/landing-zone/
├── main.tf
├── variables.tf
├── outputs.tf
├── production.tfvars
└── README.md
```

**Includes:**
- Management group hierarchy
- Hub VNet with Azure Firewall
- Spoke VNets (production, development)
- Key Vault for shared secrets
- Log Analytics workspace
- Azure Policy assignments

### 2. Data Platform

Deploy a modern data platform:

```
examples/data-platform/
├── main.tf
├── variables.tf
├── outputs.tf
├── production.tfvars
└── README.md
```

**Includes:**
- Data Lake (ADLS Gen2) with zones
- Synapse workspace with pools
- Data Factory with managed VNet
- Purview for governance
- Private endpoints for all services

### 3. AI Workload

Deploy an AI/ML workload:

```
examples/ai-workload/
├── main.tf
├── variables.tf
├── outputs.tf
├── production.tfvars
└── README.md
```

**Includes:**
- Azure OpenAI with deployments
- Azure AI Search
- Azure ML workspace
- Container Apps for hosting
- Private endpoints

---

## CI/CD Integration

### GitHub Actions

```yaml
# .github/workflows/terraform.yml
name: 'Terraform'

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - uses: hashicorp/setup-terraform@v2
        with:
          terraform_version: 1.5.0

      - name: Terraform Init
        run: terraform init
        working-directory: ./infrastructure-as-code/terraform/examples/landing-zone

      - name: Terraform Plan
        run: terraform plan -var-file="production.tfvars"
        working-directory: ./infrastructure-as-code/terraform/examples/landing-zone
        env:
          ARM_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
          ARM_CLIENT_SECRET: ${{ secrets.AZURE_CLIENT_SECRET }}
          ARM_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
          ARM_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
```

### Azure DevOps

```yaml
# azure-pipelines.yml
trigger:
  branches:
    include:
      - main

pool:
  vmImage: 'ubuntu-latest'

stages:
  - stage: Plan
    jobs:
      - job: TerraformPlan
        steps:
          - task: TerraformInstaller@0
            inputs:
              terraformVersion: '1.5.0'

          - task: TerraformTaskV4@4
            inputs:
              command: 'init'
              workingDirectory: '$(System.DefaultWorkingDirectory)/infrastructure-as-code/terraform/examples/landing-zone'

          - task: TerraformTaskV4@4
            inputs:
              command: 'plan'
              workingDirectory: '$(System.DefaultWorkingDirectory)/infrastructure-as-code/terraform/examples/landing-zone'
              environmentServiceNameAzureRM: 'Azure-Connection'
```

---

## State Management (Terraform)

### Remote Backend Configuration

```hcl
# backend.tf
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "stterraformstate001"
    container_name       = "tfstate"
    key                  = "landing-zone.tfstate"
  }
}
```

### State Storage Setup

```bash
# Create storage account for state
az group create --name rg-terraform-state --location uksouth

az storage account create \
  --name stterraformstate001 \
  --resource-group rg-terraform-state \
  --sku Standard_LRS \
  --kind StorageV2 \
  --min-tls-version TLS1_2

az storage container create \
  --name tfstate \
  --account-name stterraformstate001

# Enable versioning
az storage account blob-service-properties update \
  --account-name stterraformstate001 \
  --resource-group rg-terraform-state \
  --enable-versioning true
```

---

## Contributing

### Adding a New Module

1. Create module directory under appropriate category
2. Include standard files:
   - `main.tf` / `main.bicep` - Core resources
   - `variables.tf` / `variables.bicep` - Input variables
   - `outputs.tf` / `outputs.bicep` - Output values
   - `README.md` - Documentation
3. Follow naming conventions
4. Include examples
5. Add tests (optional but recommended)

### Module Documentation Template

```markdown
# Module: [Module Name]

## Purpose
[Brief description]

## Usage
[Code example]

## Inputs
| Name | Type | Required | Description |
|------|------|----------|-------------|
| var1 | string | yes | Description |

## Outputs
| Name | Description |
|------|-------------|
| output1 | Description |

## Example
[Complete example]
```

---

## References

- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest)
- [Bicep Documentation](https://learn.microsoft.com/azure/azure-resource-manager/bicep/)
- [Azure Verified Modules](https://azure.github.io/Azure-Verified-Modules/)
- [CAF Terraform Modules](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale)
- [ALZ Bicep](https://github.com/Azure/ALZ-Bicep)

---

*Azure Enterprise Solutions Architecture*
*github.com/maree217/azure-enterprise-solutions-architecture*
