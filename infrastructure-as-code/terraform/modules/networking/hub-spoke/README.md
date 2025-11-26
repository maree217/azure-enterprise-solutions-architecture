# Hub-Spoke Network Module

Deploys an enterprise hub-spoke network topology with Azure Firewall, ready for landing zone integration.

## Architecture

```
                     ┌─────────────────────────────────────┐
                     │            HUB VNET                 │
                     │          10.0.0.0/16                │
                     │                                     │
                     │  ┌───────────────────────────────┐  │
                     │  │      Azure Firewall           │  │
                     │  │      10.0.0.0/26              │  │
                     │  └───────────────────────────────┘  │
                     │  ┌───────────────────────────────┐  │
                     │  │      Gateway Subnet           │  │
                     │  │      10.0.0.64/27             │  │
                     │  └───────────────────────────────┘  │
                     │  ┌───────────────────────────────┐  │
                     │  │      Bastion Subnet           │  │
                     │  │      10.0.0.96/27             │  │
                     │  └───────────────────────────────┘  │
                     │  ┌───────────────────────────────┐  │
                     │  │      Management Subnet        │  │
                     │  │      10.0.0.128/26            │  │
                     │  └───────────────────────────────┘  │
                     └─────────────┬───────────────────────┘
                                   │
                     ┌─────────────┴─────────────┐
                     │         Peering           │
        ┌────────────┴────────────┐    ┌────────┴───────────┐
        │                         │    │                    │
        ▼                         ▼    ▼                    ▼
┌───────────────────┐    ┌───────────────────┐    ┌───────────────────┐
│   SPOKE: PROD     │    │   SPOKE: DEV      │    │   SPOKE: DATA     │
│   10.1.0.0/16     │    │   10.2.0.0/16     │    │   10.3.0.0/16     │
└───────────────────┘    └───────────────────┘    └───────────────────┘
```

## Usage

### Basic Example

```hcl
module "hub_spoke" {
  source = "./modules/networking/hub-spoke"

  location           = "uksouth"
  environment        = "prod"
  hub_address_space  = "10.0.0.0/16"
  deploy_firewall    = true
  firewall_sku       = "Standard"

  spokes = {
    production = {
      address_space = "10.1.0.0/16"
      subnets = {
        app = {
          address_prefix    = "10.1.1.0/24"
          service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
        }
        data = {
          address_prefix    = "10.1.2.0/24"
          service_endpoints = ["Microsoft.Storage", "Microsoft.Sql"]
        }
        private-endpoints = {
          address_prefix = "10.1.3.0/24"
        }
      }
    }
  }

  tags = {
    environment  = "production"
    cost-center  = "IT-12345"
    three-layer  = "layer-3"
  }
}
```

### With Delegated Subnets

```hcl
module "hub_spoke" {
  source = "./modules/networking/hub-spoke"

  location           = "uksouth"
  environment        = "prod"
  hub_address_space  = "10.0.0.0/16"

  spokes = {
    production = {
      address_space = "10.1.0.0/16"
      subnets = {
        app = {
          address_prefix    = "10.1.1.0/24"
          service_endpoints = ["Microsoft.Storage"]
        }
        aks = {
          address_prefix = "10.1.4.0/22"
        }
        container-apps = {
          address_prefix = "10.1.8.0/23"
          delegation = {
            name    = "delegation"
            service = "Microsoft.App/environments"
            actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
          }
        }
      }
    }
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| location | Azure region | string | "uksouth" | no |
| environment | Environment name | string | - | yes |
| hub_address_space | Hub VNet CIDR | string | "10.0.0.0/16" | no |
| spokes | Spoke VNet configurations | map(object) | {} | no |
| deploy_firewall | Deploy Azure Firewall | bool | true | no |
| firewall_sku | Firewall SKU | string | "Standard" | no |
| deploy_vpn_gateway | Deploy VPN Gateway | bool | false | no |
| availability_zones | AZs for zone-redundant resources | list(string) | ["1","2","3"] | no |
| create_log_analytics | Create Log Analytics | bool | true | no |
| log_retention_days | Log retention period | number | 90 | no |
| tags | Resource tags | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| hub_vnet_id | Hub VNet resource ID |
| hub_vnet_name | Hub VNet name |
| hub_resource_group_name | Hub resource group name |
| hub_subnets | Map of hub subnet IDs |
| spoke_vnet_ids | Map of spoke VNet IDs |
| spoke_vnet_names | Map of spoke VNet names |
| spoke_subnets | Map of spoke subnet IDs |
| firewall_private_ip | Firewall private IP |
| firewall_public_ip | Firewall public IP |
| log_analytics_workspace_id | Log Analytics workspace ID |

## Features

- **Hub VNet** with pre-configured subnets for Firewall, Gateway, Bastion, Management
- **Spoke VNets** with customizable subnets and delegations
- **Azure Firewall** (optional) with Standard or Premium SKU
- **VNet Peering** between hub and all spokes
- **Route Tables** directing traffic through firewall
- **NSGs** with default deny rules
- **Log Analytics** for diagnostics
- **Diagnostic Settings** for all resources

## Three-Layer Mapping

This module supports **Layer 3: Infrastructure & Operations** of the Three-Layer Architecture:

| Component | Resources |
|-----------|-----------|
| Orchestration | VNet peering, route tables |
| Security | Azure Firewall, NSGs |
| Observability | Log Analytics, diagnostics |
