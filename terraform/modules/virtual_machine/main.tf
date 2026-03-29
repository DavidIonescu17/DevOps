resource "azurerm_public_ip" "vm_public_ip" {
  name                = var.pip_name
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = var.allocation_method

  tags = merge(var.tags,
    {
      module = "virtual_machine"
    }
  )
}

resource "azurerm_network_interface" "vm_nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = var.ip_config_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_allocation
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }

  tags = merge(var.tags,
    {
      module = "virtual_machine"
    }
  )
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = var.vm_name
  resource_group_name   = var.rg_name
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

  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = var.admin_username
      private_key = tls_private_key.this.private_key_pem
      host        = azurerm_public_ip.vm_public_ip.ip_address
    }
  }

  tags = merge(var.tags, {
    module = "virtual_machine"
    }
  )
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}