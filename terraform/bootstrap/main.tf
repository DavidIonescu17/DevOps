resource "azurerm_resource_group" "shared_resource_group" {
  name     = local.resource_group_name
  location = local.location

  tags = local.common_tags
}

module "storage_account" {
  source = "../modules/storage_account"

  name                     = local.storage_account_name
  rg_name                  = azurerm_resource_group.shared_resource_group.name
  location                 = azurerm_resource_group.shared_resource_group.location
  account_tier             = local.account_tier
  account_replication_type = local.account_replication_type
  container_name           = local.container_name
  container_access_type    = local.container_access_type

  tags = local.common_tags
}