# General variables
variable "location" {
  type        = string
  description = "The Azure Region to use"
}

variable "suffix" {
  type        = string
  description = "The suffix name for deployments"
}

# Taggging variables
variable "tags" {
  type        = map(string)
  description = "Default tags"
}

#Resource-specific variables: 
variable "rg_name" {
  type        = string
  description = "Resource name for the deployment, to use with prefix."
}
