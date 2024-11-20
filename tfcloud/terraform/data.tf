# This file shows all the resources in Terraform Cloud that aren't managed by the Terraform config

# Default TFC Project
data "tfe_project" "default" {
  name = "Default"
}

# TFC Variable Sets (Managed in the <repo root>/secrets/terraform workspace)
data "tfe_variable_set" "cloudflare" {
  name = "Cloudflare"
}

data "tfe_variable_set" "digitalocean" {
  name = "DigitalOcean"
}

data "tfe_variable_set" "terraform_cloud" {
  name = "Terraform Cloud"
}

data "tfe_variable_set" "onepass_connect_server_bedrock" {
  name = "1PassConnect Server Bedrock"
}

# ref: https://github.com/settings/installations/20575258
locals {
  tfc_github_app_install_id = "ghain-XfWNdXrCExNPnYD6"
}

# data "tfe_github_app_installation" "vyas_n" {
#   name = "vyas-n"
# }
