# Hub-Spoke Network Module
# Deploys a hub virtual network with Azure Firewall and peered spoke networks

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.70.0"
    }
  }
}

# -----------------------------------------------------------------------------
# Local Variables
# -----------------------------------------------------------------------------

locals {
  hub_name = "vnet-hub-${var.environment}-${var.location}-001"

  hub_subnets = {
    AzureFirewallSubnet = {
      address_prefix = cidrsubnet(var.hub_address_space, 2, 0) # /26
    }
    GatewaySubnet = {
      address_prefix = cidrsubnet(var.hub_address_space, 3, 2) # /27
    }
    AzureBastionSubnet = {
      address_prefix = cidrsubnet(var.hub_address_space, 3, 3) # /27
    }
    ManagementSubnet = {
      address_prefix = cidrsubnet(var.hub_address_space, 2, 2) # /26
    }
  }

  common_tags = merge(var.tags, {
    module      = "hub-spoke"
    three-layer = "layer-3"
  })
}

# -----------------------------------------------------------------------------
# Resource Group
# -----------------------------------------------------------------------------

resource "azurerm_resource_group" "hub" {
  name     = "rg-hub-networking-${var.environment}-${var.location}"
  location = var.location
  tags     = local.common_tags
}

# -----------------------------------------------------------------------------
# Hub Virtual Network
# -----------------------------------------------------------------------------

resource "azurerm_virtual_network" "hub" {
  name                = local.hub_name
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  address_space       = [var.hub_address_space]

  tags = local.common_tags
}

resource "azurerm_subnet" "hub_subnets" {
  for_each = local.hub_subnets

  name                 = each.key
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [each.value.address_prefix]
}

# -----------------------------------------------------------------------------
# Spoke Virtual Networks
# -----------------------------------------------------------------------------

resource "azurerm_resource_group" "spoke" {
  for_each = var.spokes

  name     = "rg-spoke-${each.key}-${var.environment}-${var.location}"
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_virtual_network" "spoke" {
  for_each = var.spokes

  name                = "vnet-spoke-${each.key}-${var.environment}-${var.location}-001"
  location            = azurerm_resource_group.spoke[each.key].location
  resource_group_name = azurerm_resource_group.spoke[each.key].name
  address_space       = [each.value.address_space]

  tags = merge(local.common_tags, {
    spoke-name = each.key
  })
}

resource "azurerm_subnet" "spoke_subnets" {
  for_each = { for item in flatten([
    for spoke_name, spoke in var.spokes : [
      for subnet_name, subnet in spoke.subnets : {
        key          = "${spoke_name}-${subnet_name}"
        spoke_name   = spoke_name
        subnet_name  = subnet_name
        subnet_config = subnet
      }
    ]
  ]) : item.key => item }

  name                 = each.value.subnet_name
  resource_group_name  = azurerm_resource_group.spoke[each.value.spoke_name].name
  virtual_network_name = azurerm_virtual_network.spoke[each.value.spoke_name].name
  address_prefixes     = [each.value.subnet_config.address_prefix]

  dynamic "delegation" {
    for_each = each.value.subnet_config.delegation != null ? [each.value.subnet_config.delegation] : []
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service
        actions = delegation.value.actions
      }
    }
  }

  service_endpoints = each.value.subnet_config.service_endpoints
}

# -----------------------------------------------------------------------------
# VNet Peerings
# -----------------------------------------------------------------------------

resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  for_each = var.spokes

  name                         = "peer-hub-to-${each.key}"
  resource_group_name          = azurerm_resource_group.hub.name
  virtual_network_name         = azurerm_virtual_network.hub.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke[each.key].id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = var.deploy_vpn_gateway
}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  for_each = var.spokes

  name                         = "peer-${each.key}-to-hub"
  resource_group_name          = azurerm_resource_group.spoke[each.key].name
  virtual_network_name         = azurerm_virtual_network.spoke[each.key].name
  remote_virtual_network_id    = azurerm_virtual_network.hub.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = var.deploy_vpn_gateway
}

# -----------------------------------------------------------------------------
# Azure Firewall
# -----------------------------------------------------------------------------

resource "azurerm_public_ip" "firewall" {
  count = var.deploy_firewall ? 1 : 0

  name                = "pip-fw-${var.environment}-${var.location}-001"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = var.availability_zones

  tags = local.common_tags
}

resource "azurerm_firewall_policy" "main" {
  count = var.deploy_firewall ? 1 : 0

  name                = "afwp-${var.environment}-${var.location}-001"
  resource_group_name = azurerm_resource_group.hub.name
  location            = azurerm_resource_group.hub.location
  sku                 = var.firewall_sku

  dns {
    proxy_enabled = true
  }

  threat_intelligence_mode = "Deny"

  tags = local.common_tags
}

resource "azurerm_firewall" "main" {
  count = var.deploy_firewall ? 1 : 0

  name                = "afw-hub-${var.environment}-${var.location}-001"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  sku_name            = "AZFW_VNet"
  sku_tier            = var.firewall_sku
  firewall_policy_id  = azurerm_firewall_policy.main[0].id
  zones               = var.availability_zones

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.hub_subnets["AzureFirewallSubnet"].id
    public_ip_address_id = azurerm_public_ip.firewall[0].id
  }

  tags = local.common_tags
}

# -----------------------------------------------------------------------------
# Route Tables
# -----------------------------------------------------------------------------

resource "azurerm_route_table" "spoke" {
  for_each = var.deploy_firewall ? var.spokes : {}

  name                          = "rt-spoke-${each.key}-${var.environment}"
  location                      = azurerm_resource_group.hub.location
  resource_group_name           = azurerm_resource_group.spoke[each.key].name
  disable_bgp_route_propagation = false

  route {
    name                   = "default-to-firewall"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.main[0].ip_configuration[0].private_ip_address
  }

  tags = local.common_tags
}

# -----------------------------------------------------------------------------
# Network Security Groups
# -----------------------------------------------------------------------------

resource "azurerm_network_security_group" "management" {
  name                = "nsg-management-${var.environment}-${var.location}"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name

  security_rule {
    name                       = "AllowBastionInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["22", "3389"]
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "DenyAllInbound"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = local.common_tags
}

resource "azurerm_subnet_network_security_group_association" "management" {
  subnet_id                 = azurerm_subnet.hub_subnets["ManagementSubnet"].id
  network_security_group_id = azurerm_network_security_group.management.id
}

# -----------------------------------------------------------------------------
# Log Analytics (for diagnostics)
# -----------------------------------------------------------------------------

resource "azurerm_log_analytics_workspace" "hub" {
  count = var.create_log_analytics ? 1 : 0

  name                = "log-hub-${var.environment}-${var.location}-001"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_retention_days

  tags = local.common_tags
}

# -----------------------------------------------------------------------------
# Diagnostic Settings
# -----------------------------------------------------------------------------

resource "azurerm_monitor_diagnostic_setting" "firewall" {
  count = var.deploy_firewall && var.create_log_analytics ? 1 : 0

  name                       = "diag-firewall"
  target_resource_id         = azurerm_firewall.main[0].id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.hub[0].id

  enabled_log {
    category = "AzureFirewallApplicationRule"
  }

  enabled_log {
    category = "AzureFirewallNetworkRule"
  }

  enabled_log {
    category = "AzureFirewallDnsProxy"
  }

  metric {
    category = "AllMetrics"
  }
}
