resource "azurerm_private_dns_zone" "this" {
  for_each = var.private_dns_zone

  name                = each.value
  resource_group_name = var.resource_group_name

  tags = merge(var.tags, {
    Module = "Private DNS Zone"
  })
}

# Create links between Private DNS Zones and Virtual Networks to enable name resolution for resources in the VNets
resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = var.private_dns_zone_link

  name                  = each.value.name
  resource_group_name   = each.value.resource_group_name
  private_dns_zone_name = each.value.private_dns_zone_name
  virtual_network_id    = each.value.virtual_network_id
  registration_enabled  = each.value.registration_enabled

  tags = merge(var.tags, {
    Module = "Private DNS Zone"
  })

  depends_on = [azurerm_private_dns_zone.this]
}