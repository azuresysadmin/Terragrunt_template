variable "network_interface_id" {
  type        = string
  description = "The ID of your NIC that should be associated with the rule"
}

variable "network_security_group_id" {
  type        = string
  description = "The ID of your NSG that should be associated with the rule"
}
