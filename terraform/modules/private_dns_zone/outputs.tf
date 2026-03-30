output "private_dns_zone_id" {
  description = "IDs of the Private DNS Zones"
  value = {
    for k, v in azurerm_private_dns_zone.this : k => v.id
  }
}