variable "private_dns_zone" {
  description = "Set of private dns zones"
  type        = set(string) # unique domain names
}

variable "resource_group_name" {
  description = "Name of RG"
  type        = string
}

variable "private_dns_zone_link" {
  description = "Private DNS Zone link to VNets"
  type = map(object({
    name                  = string
    resource_group_name   = string
    private_dns_zone_name = string
    virtual_network_id    = string
    registration_enabled  = bool
  }))
}

variable "tags" {
  description = "Tags for dns resources"
  type        = map(string)
  nullable    = false
}