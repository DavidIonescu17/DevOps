variable "resource_group_name" {
  type        = string
  description = "Name of the reqource group"
}

variable "location" {
  type        = string
  description = "Azure location of the resources"
}

variable "tags" {
  type        = map(string)
  description = "Tags for the resources"
}

variable "name" {
  type        = string
  description = "Name of the ACR"
}
