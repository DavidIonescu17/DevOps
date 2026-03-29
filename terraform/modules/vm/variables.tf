variable "rg_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "pip_name" {
  description = "Name of the public IP address of the VM"
  type        = string
}

variable "allocation_method" {
  description = "Allocation method for the public IP address (Static or Dynamic)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  nullable    = false
}
