# ADR-003: Infrastructure as Code Tool Selection

## Status
Accepted

## Date
2024-01-15

## Context

Infrastructure as Code (IaC) is essential for:
- Reproducible deployments
- Version-controlled infrastructure
- Environment consistency
- Automated provisioning
- Compliance auditing

Multiple tools are available for Azure:
1. **Terraform** (HashiCorp)
2. **Bicep** (Microsoft)
3. **Pulumi** (Pulumi Corp)
4. **ARM Templates** (Microsoft, legacy)
5. **Azure CLI/PowerShell** (scripting)

We need to select a primary IaC tool for the enterprise architecture repository.

## Decision

We adopt a **dual-track approach**, providing both **Terraform** and **Bicep** modules:

### Primary: Terraform

```hcl
# Terraform for multi-cloud and complex scenarios
resource "azurerm_resource_group" "main" {
  name     = "rg-example"
  location = "uksouth"
}
```

**Use When:**
- Multi-cloud strategy exists or planned
- Existing Terraform expertise
- Complex state management needs
- Third-party provider integration
- Advanced module composition

### Secondary: Bicep

```bicep
// Bicep for Azure-native deployments
resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: 'rg-example'
  location: 'uksouth'
}
```

**Use When:**
- Azure-only environment
- Microsoft-first strategy
- Simpler state management preferred
- Native ARM integration needed
- Smaller team, less IaC experience

### Selection Matrix

| Criteria | Terraform | Bicep |
|----------|-----------|-------|
| Multi-cloud | Excellent | None |
| Azure features | Good (slight lag) | Excellent (same day) |
| State management | Required | None (ARM) |
| Learning curve | Moderate | Low |
| Enterprise adoption | Very high | Growing |
| Module ecosystem | Extensive | Growing |
| Microsoft support | Community + HashiCorp | First-party |
| Cost | Free (open core) | Free |

### Repository Structure

```
infrastructure-as-code/
├── terraform/
│   ├── modules/           # Reusable modules
│   └── examples/          # Complete deployments
├── bicep/
│   ├── modules/           # Reusable modules
│   └── examples/          # Complete deployments
└── README.md              # Selection guidance
```

## Consequences

### Positive

1. **Flexibility**: Clients choose based on their context
2. **Coverage**: Both major IaC approaches supported
3. **Expertise**: Teams work with familiar tools
4. **Best of Both**: Terraform power + Bicep simplicity
5. **Future-Proof**: Either can be primary

### Negative

1. **Maintenance**: Two codebases to maintain
2. **Inconsistency Risk**: Modules may diverge
3. **Documentation**: Must document both
4. **Testing**: Must test both

### Neutral

1. **Module Parity**: Aim for equivalent functionality
2. **Updates**: Track both ecosystems
3. **Training**: Support both skill sets

## Alternatives Considered

### Option A: Terraform Only

**Pros:**
- Single codebase
- Multi-cloud ready
- Largest ecosystem
- Most enterprise adoption

**Cons:**
- Excludes Bicep-first orgs
- Requires state management
- Third-party dependency

**Decision:** Rejected. Bicep is increasingly popular and native.

### Option B: Bicep Only

**Pros:**
- Single codebase
- Native Microsoft tool
- No state management
- Day-zero feature support

**Cons:**
- No multi-cloud
- Smaller ecosystem
- Less enterprise adoption currently

**Decision:** Rejected. Too limiting for multi-cloud clients.

### Option C: Pulumi

**Pros:**
- Real programming languages
- Multi-cloud
- Modern architecture

**Cons:**
- Smaller community
- Less enterprise adoption
- Additional vendor relationship
- Higher learning curve

**Decision:** Rejected. Not mainstream enough for enterprise default.

### Option D: ARM Templates Only

**Pros:**
- Native to Azure
- No external dependencies
- Full feature coverage

**Cons:**
- Verbose JSON syntax
- Difficult to maintain
- Poor developer experience
- Superseded by Bicep

**Decision:** Rejected. Bicep is the evolution of ARM.

## Implementation Guidelines

### Terraform Best Practices

```hcl
# Use remote state
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "stterraformstate"
    container_name       = "tfstate"
    key                  = "landing-zone.tfstate"
  }
}

# Version lock providers
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.70"
    }
  }
}

# Use consistent naming
resource "azurerm_resource_group" "main" {
  name     = "rg-${var.workload}-${var.environment}-${var.location}"
  location = var.location
  tags     = local.common_tags
}
```

### Bicep Best Practices

```bicep
// Use parameters for flexibility
@description('Environment name')
@allowed(['prod', 'dev', 'staging'])
param environment string

// Use variables for consistency
var resourceName = 'rg-${workload}-${environment}-${location}'

// Use modules for reusability
module network 'modules/networking/main.bicep' = {
  name: 'network-deployment'
  params: {
    environment: environment
  }
}
```

## References

- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest)
- [Bicep Documentation](https://learn.microsoft.com/azure/azure-resource-manager/bicep/)
- [Azure Verified Modules](https://azure.github.io/Azure-Verified-Modules/)
- [Terraform vs Bicep Comparison](https://learn.microsoft.com/azure/developer/terraform/comparing-terraform-and-bicep)
