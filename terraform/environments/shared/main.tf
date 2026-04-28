module "networking" {
  source                  = "../../modules/network"
  resource_group_name     = local.resource_group_name
  location                = local.location
  vnet_name               = local.vnet_name
  vnet_address_space      = local.vnet_address_space
  subnets                 = local.subnets
  network_security_rules  = local.network_security_rules
  network_security_groups = local.network_security_groups

  # Peering settings (disabled on shared)
  enable_peering               = local.enable_peering
  hub_to_spoke_name            = local.hub_to_spoke_name
  spoke_to_hub_name            = local.spoke_to_hub_name
  hub_resource_group_name      = local.resource_group_name
  hub_vnet_name                = local.vnet_name
  allow_forwarded_traffic      = local.allow_forwarded_traffic
  allow_virtual_network_access = local.allow_virtual_network_access

  tags = local.common_tags
}

module "key_vault" {
  source              = "../../modules/key_vault"
  resource_group_name = local.resource_group_name
  location            = local.location
  name                = local.key_vault_name
  sku_name            = local.key_vault_sku_name

  default_action  = local.key_vault_default_action
  bypass_services = local.key_vault_bypass_services
  allowed_ips     = local.key_vault_allowed_ips


  tags = local.common_tags
}

module "virtual_machine" {
  source              = "../../modules/virtual_machine"
  resource_group_name = local.resource_group_name
  location            = local.location
  vm_name             = local.vm_name

  create_public_ip = local.create_public_ip
  nic_name         = local.vm_nic_name
  pip_name         = local.vm_pip_name
  ip_config_name   = local.vm_ip_config_name
  subnet_id        = module.networking.subnets["snet-vm"].id
  size             = local.vm_size
  admin_username   = local.vm_admin_username
  identity_type    = local.identity_type

  os_disk = {
    caching              = local.vm_os_disk_caching
    storage_account_type = local.vm_os_disk_storage_account_type
  }

  source_image = {
    publisher = local.vm_source_image_publisher
    offer     = local.vm_source_image_offer
    sku       = local.vm_source_image_sku
    version   = local.vm_source_image_version
  }

  tags = local.common_tags
}