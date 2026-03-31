variable "key_vault_id" {
  description = "ID of the Key Vault where the secret will be stored"
  type        = string
  nullable    = false
}

variable "secret_name" {
  type        = set(string)
  description = "Name of the secret"
}

variable "secret_value" {
  type      = map(string)
  sensitive = true
}

variable "tags" {
  description = "Tags for the resource"
  type        = map(string)
  nullable    = false
}