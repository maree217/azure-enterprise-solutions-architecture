# Azure Landing Zones

Enterprise-scale foundation patterns for Azure deployments.

---

## What is a Landing Zone?

A **landing zone** is a pre-configured Azure environment that provides:

- **Governance**: Management groups, policies, RBAC
- **Networking**: Hub-spoke topology, connectivity, DNS
- **Security**: Defender, Sentinel, Key Vault integration
- **Identity**: Entra ID integration, service principals
- **Cost Management**: Budgets, tagging, FinOps

> "A landing zone is not a destination - it's the foundation that enables rapid, compliant cloud adoption."

---

## Landing Zone Comparison Matrix

### Terraform vs Bicep

| Criteria | Terraform | Bicep | Winner |
|----------|-----------|-------|--------|
| **Multi-cloud support** | Yes (AWS, GCP, Azure) | Azure only | Terraform |
| **Learning curve** | Moderate (HCL syntax) | Low (ARM-like syntax) | Bicep |
| **State management** | Required (local/remote) | Not needed (ARM handles) | Bicep |
| **Drift detection** | Built-in | Via What-If | Terraform |
| **Module ecosystem** | Extensive (registry.terraform.io) | Growing (MCR) | Terraform |
| **Microsoft support** | Third-party (HashiCorp) | First-party | Bicep |
| **IDE experience** | Good (VS Code, JetBrains) | Excellent (VS Code) | Bicep |
| **Enterprise-scale modules** | CAF module (mature) | ALZ-Bicep (mature) | Tie |
| **CI/CD integration** | All platforms | All platforms | Tie |
| **Testing frameworks** | Terratest, tfsec | Pester, PSRule | Terraform |
| **Cost** | Free (OSS) + optional Cloud | Free | Tie |

### Decision Framework

```
┌─────────────────────────────────────────────────────────────┐
│                  Do you need multi-cloud?                    │
└─────────────────────────────────────────────────────────────┘
                           │
              ┌────────────┴────────────┐
              │ Yes                     │ No
              ↓                         ↓
     ┌────────────────┐       ┌─────────────────────────┐
     │   TERRAFORM    │       │ Do you have existing    │
     │                │       │ Terraform expertise?    │
     └────────────────┘       └─────────────────────────┘
                                        │
                           ┌────────────┴────────────┐
                           │ Yes                     │ No
                           ↓                         ↓
                  ┌────────────────┐       ┌────────────────┐
                  │   TERRAFORM    │       │     BICEP      │
                  │ (leverage      │       │ (tightest      │
                  │  expertise)    │       │  integration)  │
                  └────────────────┘       └────────────────┘
```

### Recommendation by Scenario

| Scenario | Recommended | Reason |
|----------|-------------|--------|
| **Azure-only, new team** | Bicep | Lowest learning curve, first-party support |
| **Azure-only, Terraform expertise** | Terraform | Leverage existing skills |
| **Multi-cloud (AWS + Azure)** | Terraform | Single toolchain |
| **Existing ARM templates** | Bicep | Easy migration path |
| **Need drift detection** | Terraform | Built-in capability |
| **Maximum Microsoft support** | Bicep | First-party product |
| **Complex module dependencies** | Terraform | Mature module system |

---

## Available Landing Zone Patterns

### Terraform-based

#### 1. Enterprise-Scale (CAF)

The official Cloud Adoption Framework landing zone for Terraform.

**Repository**: [terraform-azurerm-caf-enterprise-scale](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale)

**Features**:
- Management group hierarchy
- Hub-spoke networking
- Policy assignments
- RBAC configuration
- Diagnostic settings

**Best for**: Large enterprises, complex governance requirements

```hcl
module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "~> 5.0"

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm.connectivity
    azurerm.management   = azurerm.management
  }

  root_parent_id = data.azurerm_client_config.core.tenant_id
  root_id        = "contoso"
  root_name      = "Contoso Corporation"

  deploy_connectivity_resources = true
  deploy_management_resources   = true
}
```

#### 2. AKS Landing Zone

Kubernetes-specific landing zone with enterprise features.

**Repository**: [AKS-Landing-Zone-Accelerator](https://github.com/Azure/AKS-Landing-Zone-Accelerator)

**Features**:
- AKS cluster with best practices
- Network policies
- GitOps integration
- Monitoring and logging
- Private cluster option

**Best for**: Kubernetes-first organizations

#### 3. Data Landing Zone

Analytics and data platform foundation.

**Repository**: [data-landing-zone](https://github.com/Azure/data-landing-zone)

**Features**:
- Synapse/Databricks integration
- Data Lake structure
- Purview integration
- Network isolation
- RBAC for data

**Best for**: Data platform modernization

### Bicep-based

#### 1. ALZ-Bicep

Official Azure Landing Zones implementation in Bicep.

**Repository**: [ALZ-Bicep](https://github.com/Azure/ALZ-Bicep)

**Features**:
- Modular architecture
- Easy customization
- What-If deployment preview
- ARM compatibility
- Orchestration templates

**Best for**: Azure-native teams, ARM expertise

```bicep
targetScope = 'managementGroup'

module managementGroups 'managementGroups/managementGroups.bicep' = {
  name: 'managementGroups'
  params: {
    parTopLevelManagementGroupPrefix: 'contoso'
    parTopLevelManagementGroupDisplayName: 'Contoso Corporation'
  }
}
```

#### 2. Container Apps Landing Zone

Serverless container landing zone.

**Repository**: [aca-landing-zone-accelerator](https://github.com/Azure/aca-landing-zone-accelerator)

**Features**:
- Container Apps environment
- Dapr integration
- KEDA scaling
- Managed certificates
- Internal/external ingress

**Best for**: Serverless container workloads

#### 3. App Service Landing Zone

PaaS web application foundation.

**Repository**: [appservice-landing-zone-accelerator](https://github.com/Azure/appservice-landing-zone-accelerator)

**Features**:
- App Service Environment (ASE)
- Private endpoints
- CI/CD integration
- SSL/TLS configuration
- Auto-scaling

**Best for**: Traditional web applications

### Hybrid

#### Mission LZ

Secure, compliant landing zone for regulated industries.

**Repository**: [missionlz](https://github.com/Azure/missionlz)

**Features**:
- SCCA compliance
- IL4/IL5 ready
- Zero trust networking
- Air-gapped deployment option
- Government cloud support

**Best for**: Government, defense, highly regulated industries

---

## Architecture Patterns

### Standard Enterprise Pattern

```
┌─────────────────────────────────────────────────────────────┐
│                    Tenant Root Group                         │
└─────────────────────────────────────────────────────────────┘
                              │
    ┌─────────────────────────┴─────────────────────────┐
    │                                                    │
    ↓                                                    ↓
┌──────────────────┐                        ┌──────────────────┐
│    Platform      │                        │   Landing Zones  │
│  (Shared Svcs)   │                        │   (Workloads)    │
└──────────────────┘                        └──────────────────┘
    │                                            │
    ├── Identity                                 ├── Corp
    │   └── Entra ID, PIM                        │   └── Internal workloads
    │                                            │
    ├── Management                               ├── Online
    │   └── Monitor, Automation                  │   └── Internet-facing
    │                                            │
    └── Connectivity                             └── Sandbox
        └── Hub, Firewall, Gateway                   └── Dev/Test
```

### Network Topology

```
                         ┌──────────────────┐
                         │   On-Premises    │
                         │                  │
                         └────────┬─────────┘
                                  │ ExpressRoute/VPN
                                  │
                         ┌────────┴─────────┐
                         │    Hub VNet      │
                         │  ┌────────────┐  │
                         │  │ Azure      │  │
                         │  │ Firewall   │  │
                         │  └────────────┘  │
                         │  ┌────────────┐  │
                         │  │ Bastion    │  │
                         │  └────────────┘  │
                         │  ┌────────────┐  │
                         │  │ Gateway    │  │
                         │  └────────────┘  │
                         └────────┬─────────┘
                                  │
         ┌───────────┬────────────┼────────────┬───────────┐
         │           │            │            │           │
         ↓           ↓            ↓            ↓           ↓
    ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐
    │ Prod    │ │ Dev     │ │ Data    │ │ AI/ML   │ │ DMZ     │
    │ Spoke   │ │ Spoke   │ │ Spoke   │ │ Spoke   │ │ Spoke   │
    └─────────┘ └─────────┘ └─────────┘ └─────────┘ └─────────┘
```

---

## Implementation Guide

### Phase 1: Foundation (Week 1-2)

1. **Management Group Hierarchy**
   - Create root management group
   - Define platform/landing zone structure
   - Assign baseline policies

2. **Identity Foundation**
   - Configure Entra ID
   - Set up PIM
   - Create break-glass accounts
   - Define RBAC roles

### Phase 2: Networking (Week 3-4)

1. **Hub Deployment**
   - Deploy hub VNet
   - Configure Azure Firewall
   - Set up Bastion
   - Configure VPN/ExpressRoute Gateway

2. **DNS Configuration**
   - Create Private DNS Zones
   - Configure DNS forwarding
   - Set up Private Link DNS

### Phase 3: Security (Week 5-6)

1. **Security Services**
   - Enable Defender for Cloud
   - Configure Sentinel
   - Deploy Key Vault
   - Set up diagnostic logging

2. **Compliance**
   - Apply Azure Policies
   - Configure Blueprints
   - Set up compliance reporting

### Phase 4: Workload Zones (Week 7-8)

1. **Spoke Deployment**
   - Deploy spoke VNet templates
   - Configure peering
   - Set up NSGs
   - Enable Private Link

2. **Subscription Vending**
   - Create subscription templates
   - Automate provisioning
   - Define naming conventions

---

## Directory Structure

```
landing-zones/
├── README.md                          # This file
├── terraform/
│   ├── enterprise-scale/              # CAF Enterprise-Scale module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── examples/
│   ├── aks-lz/                        # AKS Landing Zone
│   ├── app-service-lz/                # App Service Landing Zone
│   └── data-management-zone/          # Data Landing Zone
├── bicep/
│   ├── alz-bicep/                     # ALZ-Bicep modules
│   │   ├── managementGroups/
│   │   ├── policyAssignments/
│   │   ├── hubNetworking/
│   │   └── orchestration/
│   ├── container-apps-lz/             # Container Apps LZ
│   └── integration-services/          # Integration LZ
└── hybrid/
    └── missionlz/                     # SCCA-compliant LZ
```

---

## Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| **Policy Compliance** | 100% | Azure Policy compliance score |
| **Security Score** | >90% | Defender for Cloud |
| **Time to Provision** | <1 day | Subscription vending automation |
| **Cost Attribution** | 100% | Resource tagging compliance |
| **Network Latency** | <10ms | Between spokes via hub |

---

## Key Resources

### Official Repositories

| Repository | Stars | IaC | Purpose |
|------------|-------|-----|---------|
| [Enterprise-Scale](https://github.com/Azure/Enterprise-Scale) | 1,888 | Guidance | Reference architecture |
| [terraform-azurerm-caf-enterprise-scale](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale) | 943 | Terraform | CAF Terraform module |
| [ALZ-Bicep](https://github.com/Azure/ALZ-Bicep) | 853 | Bicep | Official Bicep implementation |
| [AKS-Landing-Zone-Accelerator](https://github.com/Azure/AKS-Landing-Zone-Accelerator) | 270 | Both | AKS-specific LZ |
| [data-landing-zone](https://github.com/Azure/data-landing-zone) | 172 | Bicep | Data platform LZ |

### Documentation

- [CAF Ready - Landing Zones](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/)
- [Azure Landing Zones Overview](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-areas)
- [Enterprise-Scale Architecture](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/architecture)

---

## Next Steps

1. Choose your IaC tool (Terraform or Bicep)
2. Select landing zone pattern based on requirements
3. Review examples in the appropriate subdirectory
4. Deploy foundation following the implementation guide
5. Proceed to [Layer 2: Organizational Intelligence](../three-layer-overlay/layer-2-data-intelligence/) once stable
