resource "azurerm_user_assigned_identity" "this" {
  for_each = var.name

  location            = var.location
  resource_group_name = var.resource_group_name
  name                = each.value

  tags = merge(var.tags, {
    Module = "managed_identity"
  })
}
