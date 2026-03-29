variable "rg_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "name" {
  description = "Name of the storage account"
  type        = string
}

variable "account_tier" {
  description = "The account tier of the storage account (Standard or Premium)"
  type        = string
}

variable "account_replication_type" {
  description = "The replication type of the storage account (LRS, GRS, RAGRS, ZRS)"
  type        = string
}

variable "container_name" {
  description = "Name of the storage container"
  type        = string
}

variable "container_access_type" {
  description = "The access type of the storage container (private, blob, or container)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  nullable    = false
}
