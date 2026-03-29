# Data source to retrieve information about the current Azure client configuration, such as subscription ID, tenant ID, and client ID.
data "azurerm_client_config" "current" {}