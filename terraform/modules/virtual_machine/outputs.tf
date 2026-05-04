output "vm_id" {
  value = azurerm_linux_virtual_machine.vm.id
}

output "public_ip_address" {
  value = var.create_public_ip ? azurerm_public_ip.vm_public_ip[0].ip_address : null
}

output "private_ip_address" {
  value = azurerm_network_interface.vm_nic.private_ip_address
}

output "nic_id" {
  value = azurerm_network_interface.vm_nic.id
}

output "identity_principal_id" {
  value = azurerm_linux_virtual_machine.vm.identity[0].principal_id
}