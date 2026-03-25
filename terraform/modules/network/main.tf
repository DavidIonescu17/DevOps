resource "azurerm_virtual_network" "vnet" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = var.vnet_name
  address_space       = var.vnet_address_space

  tags = merge(var.tags, {
    Module = "network"
  })
}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefixes  

  delegation {
    name = each.value.delegation_config_name
    service_delegation {
      name = each.value.delegation_config_name
      actions = each.value.delegation_config_actions
    }
  }
}

resource "azurerm_network_security_group" "nsg" {
  for_each = var.network_security_groups

  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = merge(var.tags, {
    Module = "network"
  })
}

resource "azurerm_network_security_rule" "nsg_rule" {
  for_each = var.network_security_rules

  name                        = each.key
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  network_security_group_name = azurerm_network_security_group.nsg[each.value.nsg_name].name
  resource_group_name         = var.resource_group_name
}