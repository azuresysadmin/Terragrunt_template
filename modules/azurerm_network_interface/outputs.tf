output "private_ip_address" {
  value       = azurerm_network_interface.nic.private_ip_address
  description = "The IP address of the nic"
}

output "network_interface_id" {
  value       = azurerm_network_interface.nic.id
  description = "The ID of the NIC"
}
