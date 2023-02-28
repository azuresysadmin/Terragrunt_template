output "network_security_group_id" {
  value       = azurerm_network_security_group.nsg.id
  description = "The ID of the NIC"
}
