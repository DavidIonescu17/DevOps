variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "subnets" {
  description = "Map of subnet names to their configuration"
  type = map(object({
    address_prefixes = list(string)
    subnet_delegation_config = optional(object({
      delegation_config_name    = string
      delegation_config_actions = list(string)
    }))
  }))
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  nullable    = false
}

variable "network_security_groups" {
  description = "Map of network security group names to their configuration"
  type = map(object({
    name                = string
  }))
}

variable "network_security_rules" {
  description = "Map of network security rule names to their configuration"
  type = map(object({
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    nsg_name                   = string
  }))
}

variable "spoke_to_hub_name" {
  type        = string
  description = "Name of the peering from spoke to hub"
}

variable "hub_to_spoke_name" {
  type        = string
  description = "Name of the peering from hub to spoke"
}

variable "enable_peering" {
  type        = bool
  description = "Custom variable used to determine whether to configure peering or not"
}

variable "hub_vnet_name" {
  type        = string
  description = "Name of the hub VNet"
  default     = null
}

variable "hub_resource_group_name" {
  type        = string
  description = "Name of the RG that has the hub VNet"
}

variable "allow_forwarded_traffic" {
  type        = bool
  description = "Allow forwarded traffic setting on the peering"
}

variable "allow_virtual_network_access" {
  type        = bool
  description = "Allow virtual network access setting on the peering"
}