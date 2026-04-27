variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "name" {
  type        = string
  description = "Name of the Key Vault"
}

variable "sku_name" {
  type        = string
  description = "SKU name for the Key Vault (e.g., standard, premium)"
}

variable "default_action" {
  type        = string
  description = "Default action for network ACLs (Allow or Deny)"
}

variable "bypass_services" {
  type        = list(string)
  description = "List of services to bypass the network settings (e.g., AzureServices)"
}

variable "allowed_ips" {
  type        = list(string)
  description = "List of IP addresses or CIDR ranges allowed to access the Key Vault"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  nullable    = false
}
