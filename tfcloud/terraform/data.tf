# This file shows all the resources in Terraform Cloud that aren't managed by the Terraform config

# Default TFC Project
data "tfe_project" "default" {
  name = "Default"
}

# ref: https://github.com/settings/installations/20575258
locals {
  tfc_github_app_install_id = "ghain-EfRbKi6QDumqrW5A"
}

# data "tfe_github_app_installation" "vyas_n" {
#   name = "vyas-n"
# }
