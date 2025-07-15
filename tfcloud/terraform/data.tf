# This file shows all the resources in Terraform Cloud that aren't managed by the Terraform config

# Default TFC Project
data "tfe_project" "default" {
  name = "Default"
}

# ref: https://github.com/settings/installations/75993109
# TODO: dynamically retrieve this from GitHub App installation in account `vyas-n`
locals {
  tfc_github_app_install_id = "ghain-duPboA75dCWmDjRT"
}

# data "tfe_github_app_installation" "vyas_n" {
#   name = "vyas-n"
# }
