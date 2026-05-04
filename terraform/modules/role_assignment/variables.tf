variable "role_config" {
  description = "Map of role assignment names to their configuration"
  type = map(object({
    scope              = string
    role_definition_name = string
    principal_id       = string
  }))
}