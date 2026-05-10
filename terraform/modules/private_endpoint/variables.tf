variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Location where private endpoints will be deployed"
  type        = string
}

variable "private_endpoint_config" {
  description = "Configuration for private endpoints"
  type = map(object({
    private_endpoint_name           = string
    subnet_id                       = string
    private_connection_resource_id  = string
    private_service_connection_name = string
    subresource_names               = list(string)
    is_manual_connection            = bool

    private_dns_zone_group_name = string
    private_dns_zone_ids        = list(string)
  }))
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
  nullable    = false
}
