# Output variables for Resource Group module
output "resource_group_name" {
  value       = azurerm_resource_group.resource_group.name
  description = "Output name of the deployed Resource Group"
}
