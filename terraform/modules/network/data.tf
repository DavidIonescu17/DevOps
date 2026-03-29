data "azurerm_virtual_network" "hub" {
  count               = var.enable_peering ? 1 : 0
  name                = var.hub_vnet_name
  resource_group_name = var.hub_resource_group_name
}