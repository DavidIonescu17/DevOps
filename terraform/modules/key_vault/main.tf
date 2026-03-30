resource "azurerm_key_vault" "this" {
  name                        = var.name
  resource_group_name         = var.rg_name
  location                    = var.location
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = var.sku_name
  soft_delete_retention_days  = var.soft_delete_retention_days
  purge_protection_enabled    = var.purge_protection_enabled
  enabled_for_disk_encryption = var.enabled_for_disk_encryption
  rbac_authorization_enabled  = var.rbac_authorization_enabled

  network_acls {
    default_action = var.default_action
    bypass         = var.bypass_services
    ip_rules       = var.allowed_ips
  }

  tags = merge(var.tags,
    {
      module = "key_vault"
    }
  )
}