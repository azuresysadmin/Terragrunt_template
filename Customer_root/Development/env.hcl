# Define the environment specific variables. Such as environment, subscription and backend configuration.
locals {
  environment     = "Development"

  # Backend variables
  backend_rg  = ""
  backend_sa  = ""
  backend_con = ""
}
