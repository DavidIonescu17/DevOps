output "subnet_ids" {
  description = "Map of subnet IDs (non-delegated)"
  value = {
    for k, v in azurerm_subnet.subnets : k => v.id
  }
}

output "vnet_id" {
  value       = azurerm_virtual_network.this.id
  description = "ID of the Virtual Network"
}


output "delegated_subnet_ids" {
  description = "Map of subnet IDs (delegated"
  value = {
    for k, v in azurerm_subnet.subnets_with_delegation : k => v.id
  }
}