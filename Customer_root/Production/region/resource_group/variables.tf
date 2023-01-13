variable "location" {
  type        = string
  description = "The Azure Region to use"
}

variable "environment" {
  type        = string
  description = "Environment of the deployment, i.e dev/prod"

}

variable "contact" {
  type        = string
  description = "Owner of the deployment, i.e john.doe@internet.com"

}

variable "rg_name" {
  type        = string
  description = "The name to use for the development"

}
