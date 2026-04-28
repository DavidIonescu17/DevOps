resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  # Enhance security by enabling infrastructure encryption, which encrypts data at rest with a second layer of encryption
  infrastructure_encryption_enabled = true

  https_traffic_only_enabled = true # Enforce HTTPS to ensure data is encrypted in transit
  allow_nested_items_to_be_public = false # Disallow public access to nested items to prevent accidental exposure of data

  # Restrict access to the storage account by allowing only trusted Microsoft services to bypass the network rules, and by specifying allowed virtual network subnets
  network_rules {
    default_action = "Deny"
    bypass = "AzureServices"
    virtual_network_subnet_ids = var.allowed_subnet_ids
    ip_rules                   = var.allowed_ips
  }

  tags = merge(var.tags,
    {
      module = "storage_account"
    }
  )
}

resource "azurerm_storage_container" "this" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.this.id
  
  # Ensure the container is private to prevent unauthorized access to the data stored within it
  container_access_type = "private"
}