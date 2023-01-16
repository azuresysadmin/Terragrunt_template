#Import a module. See formatting of the URL below.
terraform {
  source = "tfr:///Azure/vnet/azurerm//?version=3.2.0"
}

#Include the path to the parent folders, so that Terragrunt can find its parent configuration .hcl files.
include {
  path = find_in_parent_folders()
}

#Define a dependency if needed, such as a resource group that the deployment should be deployed into. 
dependencies {
  paths = ["../../resource_group"]
}

dependency "resource_group" {
  config_path = "../../resource_group"

#Placeholder for resource group. More specific information can be found @ https://gaunacode.com/using-terragrunt-to-deploy-to-azure
  mock_outputs = {
    vnet_resource_group_name = "rg-terragrunt-placeholder-1"
  }
  mock_outputs_merge_with_state = true
}

#Define the locals that the configuration requires.
locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  environment      = local.environment_vars.locals.environment

  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  location    = local.region_vars.locals.location

  contact_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  contact      = local.environment_vars.locals.contact
}

#Define the mandatory/optional inputs and tags that the module requires.
inputs = {
  vnet_name           = "vnet-${local.environment}-${local.location}-1337"
  resource_group_name = dependency.resource_group.outputs.vnet_resource_group_name
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/26", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
  subnet_names        = ["Bastion-subnet", "Mgmgt", "Fix", "Abandon"]
  vnet_location       = local.location

  tags = {
    environment = local.environment
    contact     = local.contact
  }
}