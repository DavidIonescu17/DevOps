resource "azurerm_public_ip" "vm_public_ip" {
  # Create a public IP address only if the VM is a jump host or it needs to be accessed directly from the internet
  count = var.create_public_ip ? 1 : 0
  name                = var.pip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static" # in order to ensure the IP address doesn't change when the VM is restarted

  tags = merge(var.tags,
    {
      module = "virtual_machine"
    }
  )
}

resource "azurerm_network_interface" "vm_nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.ip_config_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"

    # Associate the public IP address with the NIC if it was created
    public_ip_address_id          = var.create_public_ip ? azurerm_public_ip.vm_public_ip[0].id : null
  }

  tags = merge(var.tags,
    {
      module = "virtual_machine"
    }
  )
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = var.vm_name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.vm_nic.id]

  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.this.public_key_openssh
  }

  os_disk {
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = var.source_image.publisher
    offer     = var.source_image.offer
    sku       = var.source_image.sku
    version   = var.source_image.version
  }

  identity {
    type = var.identity_type
  }

  # Cloud-init custom data for provisioning
  custom_data = var.cloud_init_enabled && var.github_runner_config != null ? base64encode(
    templatefile("${path.module}/cloud-init.yaml", {
      admin_username   = var.admin_username
      ssh_public_key   = tls_private_key.this.public_key_openssh
      runner_label     = var.github_runner_config.label
      github_repo_url  = var.github_runner_config.repo_url
      key_vault_name   = var.github_runner_config.key_vault_name
    })
  ) : null

  tags = merge(var.tags, {
    module = "virtual_machine"
    }
  )
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}