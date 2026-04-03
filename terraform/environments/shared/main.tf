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