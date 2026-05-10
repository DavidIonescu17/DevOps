variable "pass_rotation_days" {
  description = "How often to rotate the passwords"
  type        = string
}

variable "random_password_config" {
  description = "Random password to use for PSQL Server, JWT, etc."
  type = map(object({
    length           = number
    special          = bool
    override_special = string
  }))
}