output "virtual_network_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "Output ID of the deployed Resource"
}

output "virtual_network_name" {
  value       = azurerm_virtual_network.vnet.name
  description = "The name of the vnet"
}
