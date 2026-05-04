variable "resource_group_name" {
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

variable "create_public_ip" {
  description = "Whether to create a public IP address for the VM"
  type        = bool
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  nullable    = false
}

variable "nic_name" {
  description = "Name of the network interface"
  type        = string
}

variable "ip_config_name" {
  description = "Name of the IP configuration for the network interface"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet to which the network interface will be connected"
  type        = string
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "size" {
  description = "Size of the virtual machine"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the virtual machine"
  type        = string
}

variable "os_disk" {
  description = "Configuration for the OS disk"
  type = object({
    caching              = string
    storage_account_type = string
  })
}

variable "source_image" {
  description = "Reference to the source image for the virtual machine"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "identity_type" {
  description = "Type of identity for the virtual machine (e.g., SystemAssigned, UserAssigned, None)"
  type        = string
}

variable "identity_ids" {
  description = "List of user-assigned identity IDs to associate with the VM (only applicable if identity_type is UserAssigned)"
  type        = list(string)
  default     = null
}

variable "cloud_init_enabled" {
  description = "Whether to enable cloud-init for VM provisioning"
  type        = bool
  default     = false
}

variable "github_runner_config" {
  description = "GitHub Actions Runner configuration (repo URL, label, Key Vault name)"
  type = object({
    enabled        = bool
    repo_url       = string
    label          = string
    key_vault_name = string
  })
  default = null
}

