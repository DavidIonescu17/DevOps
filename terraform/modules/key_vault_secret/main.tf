resource "azurerm_key_vault_secret" "this" {
  for_each = var.secret_name

  name         = each.key
  value        = var.secret_value[each.key]
  key_vault_id = var.key_vault_id

  tags = merge(var.tags, {
    Module = "key_vault_secret"
  })
}