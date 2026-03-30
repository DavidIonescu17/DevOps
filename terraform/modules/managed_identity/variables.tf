variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "name" {
  description = "Name of the managed identity"
  type        = set(string)
}

variable "tags" {
  description = "Tags to apply to the managed identity"
  type        = map(string)
  nullable    = false
}
