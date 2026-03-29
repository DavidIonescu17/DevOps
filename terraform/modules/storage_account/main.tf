resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  tags = merge(var.tags,
    {
      module = "storage_account"
    }
  )
}

resource "azurerm_storage_container" "this" {
  name                  = var.container_name
  storage_account_id  = azurerm_storage_account.this.id
  container_access_type = var.container_access_type
}