output "subnet_ids" {
  description = "Map of subnet IDs (non-delegated)"
  value = {
    for k, v in azurerm_subnet.subnet : k => v.id
  }
}

output "vnet_id" {
  value       = azurerm_virtual_network.this.id
  description = "ID of the Virtual Network"
}
