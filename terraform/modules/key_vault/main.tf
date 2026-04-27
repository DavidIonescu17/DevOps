resource "azurerm_key_vault" "this" {
  name                        = var.name
  resource_group_name         = var.rg_name
  location                    = var.location
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  
  # "standard" or "premium"
  sku_name                    = var.sku_name
  
  soft_delete_retention_days  = 90
  purge_protection_enabled    = true # Required to prevent accidental deletion of the vault and its contents
  rbac_authorization_enabled  = true # Azure RBAC is the recommended authorization method for Key Vault, and it is required for Managed Identities to work with the vault

   # Allow Key Vault to be used for disk encryption, which is a common use case for vaults in shared environments
  enabled_for_disk_encryption = true

  network_acls {
    default_action = var.default_action
    bypass         = [var.bypass_services]
    ip_rules       = var.allowed_ips
  }

  lifecycle {
    # Prevent Terraform from accidentally destroying the vault
    # if a name change or something else triggers a replacement
    prevent_destroy = true
  }

  tags = merge(var.tags,
    {
      module = "key_vault"
    }
  )
}