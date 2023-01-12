include {
  path = find_in_parent_folders()
}

inputs = {
  rg_name = "PLACEHOLDER"
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  environment      = local.environment_vars.locals.environment

  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  location    = local.region_vars.locals.location

  contact_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  contact      = local.environment_vars.locals.contact
}