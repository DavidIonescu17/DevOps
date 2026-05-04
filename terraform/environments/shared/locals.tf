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

  base_name           = format("%s-%s", local.project_name, local.environment)
  resource_group_name = format("%s-rg", local.base_name)
  vnet_name           = format("hub-vnet-%s", local.base_name)
  key_vault_name      = format("kv-%s", local.base_name)
}

locals {
  # Network Configuration
  vnet_address_space = ["10.0.0.0/16"]
  network_security_groups = {
    nsg-shared = {
      name = "nsg-shared"
    }
  }

  # Calculate subnets 
  subnets = {
    snet-pe = {
      name             = "snet-pe"
      address_prefixes = [cidrsubnet(local.vnet_address_space[0], 8, 1)] # 10.0.1.0/24
      delegation       = false
    }

    snet-vm = {
      name             = "snet-vm"
      address_prefixes = [cidrsubnet(local.vnet_address_space[0], 8, 2)] # 10.0.2.0/24
      delegation       = false
    }
  }

  network_security_rules = {
    allowSSH = {
      name                       = "AllowSSH"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "${chomp(data.http.my_public_ip.response_body)}"
      destination_address_prefix = "*"
      nsg_key                    = "nsg-shared"
    }
  }

  # PEERING (disabled on shared)
  enable_peering               = false
  allow_forwarded_traffic      = null
  allow_virtual_network_access = null
  hub_to_spoke_name            = null
  spoke_to_hub_name            = null
}

locals {
  # Key Vault Configuration
  key_vault_sku_name        = "standard"
  key_vault_default_action  = "Allow"
  key_vault_bypass_services = "AzureServices"
  key_vault_allowed_ips     = ["${chomp(data.http.my_public_ip.response_body)}"] # Allow access only from the current machine's public IP
}

locals {
  # Role Assignments Configuration
  role_assignments = {
    vm_mi_kv_user = {
      principal_id   = module.virtual_machine["jumphost"].identity_principal_id
      role_definition_name = "Key Vault Secrets User"
      scope         = module.key_vault.key_vault_id
    }
  }
}

locals {
  # GitHub Actions Runner Configuration
  # The runner token is stored in Key Vault and fetched by the VM using Managed Identity
  github_runner = {
    enabled   = true
    repo_url  = "https://github.com/DavidIonescu17/DevOps.git"
    label     = format("jumphost-%s", local.environment)
    key_vault_name = local.key_vault_name
  }

  # Virtual Machines Configuration
  virtual_machines = {
    jumphost = {
      vm_name             = format("vm-jumphost-%s", local.base_name)
      create_public_ip    = true
      nic_name            = format("nic-jumphost-%s", local.base_name)
      pip_name            = format("pip-jumphost-%s", local.base_name)
      ip_config_name      = format("ipconfig-jumphost-%s", local.base_name)
      size                = "Standard_D2s_v4"
      admin_username      = "adminuser"
      identity_type       = "SystemAssigned"

      # Enable cloud-init for provisioning
      cloud_init_enabled     = true
      github_runner_config   = local.github_runner

      os_disk             = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }

      source_image        = {
        publisher = "Canonical"
        offer     = "ubuntu-24_04"
        sku       = "server"
        version   = "latest"
      }
    }
  }
}