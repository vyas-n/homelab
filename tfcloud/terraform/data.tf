# This file shows all the resources in Terraform Cloud that aren't managed by the Terraform config

data "tfe_project" "default" {
  name = "Default"
}

# ref: https://app.terraform.io/app/vyas-n/settings/varsets/varset-Yr7D8koHTJfJiGZh
data "tfe_variable_set" "cloudflare" {
  name = "Cloudflare"
}

# ref: https://app.terraform.io/app/vyas-n/settings/varsets/varset-FyFvfYvR4p3cbUfX
data "tfe_variable_set" "digitalocean" {
  name = "DigitalOcean"
}

# ref: https://app.terraform.io/app/vyas-n/settings/varsets/varset-EZNQLXLLn8JB1tXG
data "tfe_variable_set" "terraform_cloud" {
  name = "Terraform Cloud"
}

# ref: https://app.terraform.io/app/vyas-n/settings/varsets/varset-jCpd1BtgjRzih2hP
data "tfe_variable_set" "hashicorp_cloud_provider" {
  name = "HashiCorp Cloud Provider"
}

# ref: https://github.com/settings/installations/20575258
locals {
  tfc_github_app_install_id = "20575258"
}

# data "tfe_github_app_installation" "vyas_n" {
#   name = "vyas-n"
# }
