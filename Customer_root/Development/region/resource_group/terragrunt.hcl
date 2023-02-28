# Configuration for the resource group module

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

  # Resource specific inputs
  resource_group_name = "RG-${local.suffix}"
}

# Import a module. See formatting of the URL below.
terraform {
  source = "../../../modules//az_resource_group"
}

# Include all settings from the root terragrunt.hcl file
include {
  # find_in_parent_folders() searches up the directory tree from the current .tfvars 
  # file and returns the relative path to to the first terraform.tfvars in a parent folder 
  # or exit with an error if no such file is found.
  path = find_in_parent_folders()
}


# Define the mandatory/optional inputs and tags that the module requires.
inputs = {
  name     = local.resource_group_name
  location = local.location

  tags = {
    environment = local.environment
    contact     = local.contact
    project     = local.project

  }
}