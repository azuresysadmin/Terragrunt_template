output "vnet_resource_group_name" {
  value      = var.rg_name
  depends_on = [azurerm_resource_group.rg01]

}
