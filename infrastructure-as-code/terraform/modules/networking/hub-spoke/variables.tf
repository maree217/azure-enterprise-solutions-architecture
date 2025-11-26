# Hub-Spoke Network Module - Variables

variable "location" {
  description = "Azure region for deployment"
  type        = string
  default     = "uksouth"
}

variable "environment" {
  description = "Environment name (e.g., prod, dev, staging)"
  type        = string

  validation {
    condition     = contains(["prod", "dev", "staging", "test"], var.environment)
    error_message = "Environment must be one of: prod, dev, staging, test"
  }
}

variable "hub_address_space" {
  description = "Address space for the hub virtual network"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.hub_address_space, 0))
    error_message = "Hub address space must be a valid CIDR block"
  }
}

variable "spokes" {
  description = "Map of spoke virtual networks to create"
  type = map(object({
    address_space = string
    subnets = map(object({
      address_prefix    = string
      service_endpoints = optional(list(string), [])
      delegation = optional(object({
        name    = string
        service = string
        actions = list(string)
      }))
    }))
  }))

  default = {
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
    development = {
      address_space = "10.2.0.0/16"
      subnets = {
        app = {
          address_prefix    = "10.2.1.0/24"
          service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
        }
        data = {
          address_prefix    = "10.2.2.0/24"
          service_endpoints = ["Microsoft.Storage", "Microsoft.Sql"]
        }
      }
    }
  }
}

variable "deploy_firewall" {
  description = "Deploy Azure Firewall in the hub"
  type        = bool
  default     = true
}

variable "firewall_sku" {
  description = "Azure Firewall SKU (Standard or Premium)"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.firewall_sku)
    error_message = "Firewall SKU must be Standard or Premium"
  }
}

variable "deploy_vpn_gateway" {
  description = "Deploy VPN Gateway in the hub"
  type        = bool
  default     = false
}

variable "availability_zones" {
  description = "Availability zones for zone-redundant resources"
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "create_log_analytics" {
  description = "Create Log Analytics workspace for diagnostics"
  type        = bool
  default     = true
}

variable "log_retention_days" {
  description = "Log retention period in days"
  type        = number
  default     = 90

  validation {
    condition     = var.log_retention_days >= 30 && var.log_retention_days <= 730
    error_message = "Log retention must be between 30 and 730 days"
  }
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
