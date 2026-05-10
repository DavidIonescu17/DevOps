resource "azurerm_private_endpoint" "this" {
  for_each = var.private_endpoint_config

  location            = var.location
  resource_group_name = var.resource_group_name

  name      = each.value.private_endpoint_name
  subnet_id = each.value.subnet_id

  private_service_connection {
    name                           = each.value.private_service_connection_name
    private_connection_resource_id = each.value.private_connection_resource_id
    subresource_names              = each.value.subresource_names
    is_manual_connection           = each.value.is_manual_connection
  }

  private_dns_zone_group {
    name                 = each.value.private_dns_zone_group_name
    private_dns_zone_ids = each.value.private_dns_zone_ids
  }

  tags = merge(var.tags, {
    Module = "private_endpoint"
  })
}