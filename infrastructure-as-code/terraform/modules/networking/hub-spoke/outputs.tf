# Hub-Spoke Network Module - Outputs

output "hub_vnet_id" {
  description = "ID of the hub virtual network"
  value       = azurerm_virtual_network.hub.id
}

output "hub_vnet_name" {
  description = "Name of the hub virtual network"
  value       = azurerm_virtual_network.hub.name
}

output "hub_resource_group_name" {
  description = "Name of the hub resource group"
  value       = azurerm_resource_group.hub.name
}

output "hub_subnets" {
  description = "Map of hub subnet IDs"
  value = {
    for name, subnet in azurerm_subnet.hub_subnets : name => subnet.id
  }
}

output "spoke_vnet_ids" {
  description = "Map of spoke virtual network IDs"
  value = {
    for name, vnet in azurerm_virtual_network.spoke : name => vnet.id
  }
}

output "spoke_vnet_names" {
  description = "Map of spoke virtual network names"
  value = {
    for name, vnet in azurerm_virtual_network.spoke : name => vnet.name
  }
}

output "spoke_resource_group_names" {
  description = "Map of spoke resource group names"
  value = {
    for name, rg in azurerm_resource_group.spoke : name => rg.name
  }
}

output "spoke_subnets" {
  description = "Map of spoke subnet IDs"
  value = {
    for key, subnet in azurerm_subnet.spoke_subnets : key => subnet.id
  }
}

output "firewall_private_ip" {
  description = "Private IP address of the Azure Firewall"
  value       = var.deploy_firewall ? azurerm_firewall.main[0].ip_configuration[0].private_ip_address : null
}

output "firewall_public_ip" {
  description = "Public IP address of the Azure Firewall"
  value       = var.deploy_firewall ? azurerm_public_ip.firewall[0].ip_address : null
}

output "firewall_id" {
  description = "ID of the Azure Firewall"
  value       = var.deploy_firewall ? azurerm_firewall.main[0].id : null
}

output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics workspace"
  value       = var.create_log_analytics ? azurerm_log_analytics_workspace.hub[0].id : null
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace"
  value       = var.create_log_analytics ? azurerm_log_analytics_workspace.hub[0].name : null
}
