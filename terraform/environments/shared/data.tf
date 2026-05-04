data "http" "my_public_ip" {
  url = "https://ifconfig.me/ip"
}

data "azurerm_client_config" "current" {}