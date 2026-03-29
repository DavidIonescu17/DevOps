variable "rg_name" {
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

variable "soft_delete_retention_days" {

  type        = number
  description = "Number of days to retain deleted Key Vaults (default is 90)"
  default     = 90
}

variable "purge_protection_enabled" {
  type        = bool
  description = "Whether purge protection is enabled for the Key Vault (default is false)"
  default     = false
}

variable "enabled_for_disk_encryption" {
  type        = bool
  description = "Whether the Key Vault is enabled for disk encryption (default is false)"
  default     = false
}

variable "rbac_authorization_enabled" {
  type        = bool
  description = "Whether RBAC authorization is enabled for the Key Vault"
}

variable "default_action" {
  type        = string
  description = "Default action for network ACLs (Allow or Deny)"
}

variable "bypass_services" {
  type        = list(string)
  description = "List of services to bypass for network ACLs (e.g., AzureServices)"
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
