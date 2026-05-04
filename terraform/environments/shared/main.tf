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

module "managed_identity" {
  source              = "../../modules/managed_identity"
  resource_group_name = local.resource_group_name
  location            = local.location
  name                = local.managed_identities

  tags = local.common_tags
}

module "role_assignment" {
  source      = "../../modules/role_assignment"
  role_config = local.role_assignments

  depends_on = [module.key_vault, module.managed_identity]
}

module "virtual_machine" {
  for_each = local.virtual_machines

  source              = "../../modules/virtual_machine"
  resource_group_name = local.resource_group_name
  location            = local.location

  vm_name = each.value.vm_name

  create_public_ip = each.value.create_public_ip
  nic_name         = each.value.nic_name
  pip_name         = each.value.pip_name
  ip_config_name   = each.value.ip_config_name
  subnet_id        = module.networking.subnet_ids["snet-vm"]
  size             = each.value.size
  admin_username   = each.value.admin_username
  identity_type    = each.value.identity_type

  # Cloud-init provisioning
  cloud_init_enabled   = each.value.cloud_init_enabled
  github_runner_config = each.value.github_runner_config

  os_disk = {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
  }

  source_image = {
    publisher = each.value.source_image.publisher
    offer     = each.value.source_image.offer
    sku       = each.value.source_image.sku
    version   = each.value.source_image.version
  }

  tags = local.common_tags

  depends_on = [ module.managed_identity, module.key_vault, module.networking, module.role_assignment ]
}