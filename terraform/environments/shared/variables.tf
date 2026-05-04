variable "tenant_id" {
  description = "Tenant ID where resources will be created"
  type        = string
  nullable    = false
}

variable "subscription_id" {
  description = "Subscription ID where resources will be created"
  type        = string
  nullable    = false
}

variable "gh_runner_token" {
  description = "The github runner token to allow the VM to register as a self-hosted runner in GitHub Actions"
  type        = string
  sensitive   = true
  nullable    = false
}