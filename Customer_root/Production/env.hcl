# Define the environment specific variables. Such as environment, subscription and backend configuration.
locals {
  environment     = "Production"

  # Backend variables
  backend_rg  = ""
  backend_sa  = ""
  backend_con = ""
}
