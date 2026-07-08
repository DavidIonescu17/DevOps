variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 1
}

variable "node_vm_size" {
  description = "VM size for nodes in the default node pool"
  type        = string
  default     = "Standard_D2_v2"
}

variable "enable_auto_scaling" {
  description = "Whether to enable auto-scaling for the default node pool"
  type        = bool
  default     = false
}

variable "min_node_count" {
  description = "Minimum number of nodes for auto-scaling"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "Maximum number of nodes for auto-scaling"
  type        = number
  default     = 3
}

variable "network_plugin" {
  description = "Network plugin to use for Kubernetes networking"
  type        = string
  default     = "azure"
}

variable "network_policy" {
  description = "Network policy to use"
  type        = string
  default     = "calico"
}

variable "load_balancer_sku" {
  description = "SKU of the load balancer"
  type        = string
  default     = "standard"
}

variable "outbound_type" {
  description = "Outbound type for the cluster"
  type        = string
  default     = "loadBalancer"
}

variable "service_cidr" {
  description = "CIDR block for Kubernetes services"
  type        = string
  default     = "10.0.0.0/16"
}

variable "dns_service_ip" {
  description = "IP address for Kubernetes DNS service"
  type        = string
  default     = "10.0.0.10"
}

variable "docker_bridge_cidr" {
  description = "CIDR block for Docker bridge"
  type        = string
  default     = "172.17.0.1/16"
}

variable "enable_azure_policy" {
  description = "Whether to enable Azure Policy add-on"
  type        = bool
  default     = false
}

variable "enable_http_application_routing" {
  description = "Whether to enable HTTP application routing add-on"
  type        = bool
  default     = false
}

variable "enable_monitoring" {
  description = "Whether to enable monitoring add-on"
  type        = bool
  default     = false
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID for monitoring (required if enable_monitoring is true)"
  type        = string
  default     = null
}

variable "identity_type" {
  description = "Type of identity to use for the cluster"
  type        = string
  default     = "SystemAssigned"
}

variable "enable_aad_linux_user_group" {
  description = "Whether to enable AAD-based Linux user group"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  nullable    = false
}