resource "azurerm_resource_group" "rg01" {
  name     = var.rg_name
  location = var.location

  tags = {
    environment = var.environment
    contact     = var.contact
  }
}
