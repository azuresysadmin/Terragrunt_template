# Import a module. See formatting of the URL below.
terraform {
  source = "../../../modules//az_vnet"
}

# Include all settings from the root terragrunt.hcl file
include {
  # find_in_parent_folders() searches up the directory tree from the current .tfvars 
  # file and returns the relative path to to the first terraform.tfvars in a parent folder 
  # or exit with an error if no such file is found.
  path = find_in_parent_folders()
}

# Define the dependencies
dependency "resource_group" {
  config_path = "../resource_group"
  mock_outputs = {
    resource_name = "mockOutput"
  }
}

# Define the locals that the configuration requires.
locals {
  # Automatically load variables from files in parent folders.
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  customer_vars    = read_terragrunt_config(find_in_parent_folders("customer.hcl"))

  # Extract out common variables for reuse
  location    = local.region_vars.locals.location
  environment = local.environment_vars.locals.environment
  contact     = local.customer_vars.locals.contact
  project     = local.customer_vars.locals.project
  suffix      = local.customer_vars.locals.suffix
  tenant_id   = local.customer_vars.locals.tenant_id

  # Resource specific inputs
  vnet_name = "vnet-${local.suffix}"
}

# Set the input variables for the resource
inputs = {
  name                = local.vnet_name
  location            = local.location
  resource_group_name = dependency.resource_group.outputs.resource_name
  address_space       = ["10.0.2.0/24"]

  tags = {
    environment = local.environment
    contact     = local.contact
    project     = local.project

  }
}