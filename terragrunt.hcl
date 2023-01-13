#This is an initial template for Terragrunt that should and will be re-used for different projects.
#More information about the wrapper can be found at: https://github.com/gruntwork-io/terragrunt

# Generate Azure providers and refer to the current subscription idea for the Terragrunt child configuration
generate "versions" {
  path      = "versions_override.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    terraform {
      required_providers {
        azurerm = {
          source = "hashicorp/azurerm"
          version = "=3.3.0"
        }
      }
    }

    provider "azurerm" {
        features {}
        subscription_id = "${local.subscription_id}"
    }
EOF
}

#Configure the remote state backend. Terragrunt will store a backend.tf in the directory from where you initiate the build.
remote_state {
  backend = "azurerm"
  config = {
    subscription_id      = local.subscription_id
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    resource_group_name  = local.backend_resource_group_name
    storage_account_name = local.backend_storage_account_name
    container_name       = local.backend_container_name
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# Force Terraform to keep trying to acquire a lock for
# up to 20 minutes if someone else already has the lock
terraform {
  extra_arguments "retry_lock" {
    commands = get_terraform_commands_that_need_locking()

    arguments = [
      "-lock-timeout=20m"
    ]
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
  local.region_vars.locals,
  local.environment_vars.locals
)

#Locals variables
locals {
  #Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  #Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  location        = local.region_vars.locals.location
  environment     = local.environment_vars.locals.environment
  subscription_id = local.environment_vars.locals.subscription_id
  contact         = local.environment_vars.locals.contact

  backend_resource_group_name  = local.environment_vars.locals.backend_rg
  backend_storage_account_name = local.environment_vars.locals.backend_sa
  backend_container_name       = local.environment_vars.locals.backend_con
}