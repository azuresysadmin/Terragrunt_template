# General variables
variable "location" {
  type        = string
  description = "The Azure Region to use"
}

variable "tags" {
  type        = map(string)
  description = "Default tags"
}

# Resource-specific variables: 
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group for the deployment"

}

variable "nsg_name" {
  type        = string
  description = "Name of the resource deployment, i.e vnet/rg/kv"
}

variable "nsg_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  description = "The values for the NSG rule. Base it upon RDP (3389) or SSH (22) and associate your own IP as source IP"
}
