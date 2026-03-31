resource "azurerm_container_registry" "this" {
  resource_group_name = var.resource_group_name
  location            = var.location

  name                          = var.name
  sku                           = "Premium"
  public_network_access_enabled = "true"

  tags = merge(var.tags, {
    Module = "azure_container_registry"
  })
}