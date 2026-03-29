resource "azurerm_role_assignment" "this" {
  for_each = var.role_config

  scope                = each.value.scope
  role_definition_id   = each.value.role_definition_id
  principal_id         = each.value.principal_id
}