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

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet"
}


variable "nic_name" {
  type        = string
  description = "Name of the resource deployment, i.e vnet/rg/kv"
}

variable "private_ip_address_allocation" {
  type        = string
  description = "Should the IP address be static or dynamic"
}

variable "public_ip_address_id" {
  type        = string
  description = "The public IP that should be allocated to the NIC"
}
