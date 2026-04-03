locals {
  project_name = "devops"
  location     = "polandcentral"
  environment  = "shared"

  common_tags = {
    Environment = local.environment
    Project     = local.project_name
    ManagedBy   = "Terraform"
    Owner       = "david"
    OwnerEmail  = "david.ionescu1@stud.ubbcluj.ro"
  }

  # Naming Conventions
  # Resource names will follow the pattern: <project>-<environment>-<resource_type>
  # Example: devops-shared-vnet, devops-shared-nsg, etc.

  base_name            = format("%s-%s", local.project_name, local.environment)
  resource_group_name  = format("%s-rg", local.base_name)
  storage_account_name = format("%s%sstatestorage", local.project_name, local.environment)
}

locals {
  # Storage Account for Terraform State configuration
  container_name           = "terraform"
  container_access_type    = "private"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}