locals {
  project_name = "devops"
  location     = "westeurope"
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
  vnet_name            = format("hub-vnet-%s", local.base_name)
}

locals {
  # Network Configuration
  vnet_address_space = ["10.0.0.0/16"]
  network_security_groups = {
    shared = {
      name = "nsg-shared"
    }
  }

  # Calculate subnets 
  subnets = {
    snet-pe = {
      name           = "snet-pe"
      address_prefix = [cidrsubnet(local.vnet_address_space[0], 8, 1)] # 10.0.1.0/24
      delegation     = false
      nsg_key        = "shared"
    }

    snet-jumphost = {
      name           = "snet-vm"
      address_prefix = [cidrsubnet(local.vnet_address_space[0], 8, 2)] # 10.0.2.0/24
      delegation     = false
      nsg_key        = "shared"
    }
  }

  network_security_rules = {
    allowSSH = {
      name                       = "AllowSSH"
      priority                   = "110"
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      nsg_key                    = "shared"
    }
  }

  # PEERING (disabled on shared)
  enable_peering               = false
  allow_forwarded_traffic      = null
  allow_virtual_network_access = null
  hub_to_spoke_name            = null
  spoke_to_hub_name            = null
}