
locals {
  # TODO: verify that this matches the version of terraform provided by nix
  terraform_version = "1.12.0"
}

# Default Org Settings
import {
  id = "vyas-n"
  to = tfe_organization_default_settings.vyas_n
}
resource "tfe_organization_default_settings" "vyas_n" {
  default_execution_mode = "remote"
}

# Teraform Agent pool
import {
  id = "apool-vMjgnfPpMG1yJiEx"
  to = tfe_agent_pool.homelab
}
resource "tfe_agent_pool" "homelab" {
  name         = "homelab"
}

# List of remote_exec_workspaces
locals {
  remote_workspaces = {
    digitalocean_terraform : {
      working_directory = "digitalocean/terraform"
    }
    digitalocean_nyc3_terraform : {
      working_directory = "digitalocean/nyc3/terraform"
    }
    digitalocean_nyc3_do_k8s_terraform : {
      working_directory = "digitalocean/nyc3/do-k8s/terraform"
    }
    tailscale_terraform : {
      working_directory = "tailscale/terraform"
    }
    tfcloud_terraform : {
      working_directory = "tfcloud/terraform"
    }
    homelab_terraform : {
      working_directory = "homelab/clusters/k8s/terraform"
      agent_pool_id = tfe_agent_pool.homelab.id
    }
    proxmox_terraform : {
      working_directory = "homelab/terraform"
      agent_pool_id = tfe_agent_pool.homelab.id
    }
    unifi_terraform : {
      working_directory = "unifi/terraform"
      agent_pool_id = tfe_agent_pool.homelab.id
    }
  }
}
moved {
  from = tfe_workspace.homelab_terraform
  to = tfe_workspace.remote_exec_workspace["homelab_terraform"]
}
moved {
  from = tfe_workspace.proxmox_terraform
  to = tfe_workspace.remote_exec_workspace["proxmox_terraform"]
}
moved {
  from = tfe_workspace.unifi_terraform
  to = tfe_workspace.remote_exec_workspace["unifi_terraform"]
}
resource "tfe_workspace" "remote_exec_workspace" {
  for_each = local.remote_workspaces

  name              = each.key
  working_directory = each.value["working_directory"]
  project_id        = data.tfe_project.default.id

  terraform_version     = local.terraform_version
  auto_apply            = true
  queue_all_runs        = false
  file_triggers_enabled = false

  vcs_repo {
    identifier                 = "vyas-proj/deploy"
    github_app_installation_id = local.tfc_github_app_install_id
  }
}
moved {
  from = tfe_workspace_settings.homelab_terraform
  to = tfe_workspace_settings.remote_exec_workspace["homelab_terraform"]
}
moved {
  from = tfe_workspace_settings.proxmox_terraform
  to = tfe_workspace_settings.remote_exec_workspace["proxmox_terraform"]
}
moved {
  from = tfe_workspace_settings.unifi_terraform
  to = tfe_workspace_settings.remote_exec_workspace["unifi_terraform"]
}
resource "tfe_workspace_settings" "remote_exec_workspace" {
  for_each = {
    for key, value in local.remote_workspaces :
    key => value
      if lookup(value, "agent_pool_id", "-1") != "-1"
  }
  workspace_id   = tfe_workspace.remote_exec_workspace[each.key].id
  execution_mode = "agent"
  agent_pool_id = each.value.agent_pool_id
}
# Automatically run all above workspaces when the secrets workspace is run
resource "tfe_run_trigger" "remote_exec_workspace" {
  for_each = local.remote_workspaces
  workspace_id  = tfe_workspace.remote_exec_workspace[each.key].id
  sourceable_id = tfe_workspace.secrets_terraform.id
}

# This workspace only executes locally
resource "tfe_workspace" "secrets_terraform" {
  name           = "secrets_terraform"
  project_id     = data.tfe_project.default.id
  queue_all_runs = false

  terraform_version = local.terraform_version
}
resource "tfe_workspace_settings" "secrets_terraform" {
  workspace_id   = tfe_workspace.secrets_terraform.id
  execution_mode = "local"
}

# TFE Variable Sets
resource "tfe_variable_set" "proxmox" {
  name = "Proxmox Auth"
}
import {
  id = "varset-EZNQLXLLn8JB1tXG"
  to = tfe_variable_set.tfc
}
resource "tfe_variable_set" "tfc" {
  name        = "Terraform Cloud"
  description = "This is an environment variable set that authenticates with TFC's tf provider: https://registry.terraform.io/providers/hashicorp/tfe/latest/docs"
}
import {
  id = "varset-Yr7D8koHTJfJiGZh"
  to = tfe_variable_set.cloudflare
}
resource "tfe_variable_set" "cloudflare" {
  name        = "Cloudflare"
  description = "This is an environment variable set that authenticates cloudflare's tf provider: https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs"
}
import {
  id = "varset-FyFvfYvR4p3cbUfX"
  to = tfe_variable_set.digitalocean
}
resource "tfe_variable_set" "digitalocean" {
  name        = "DigitalOcean"
  description = "This is an environment variable set that authenticates digitalocean's tf provider: https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs"
}
import {
  id = "varset-EGrhocRMyRYv9NNe"
  to = tfe_variable_set.onepass_connect_server_bedrock
}
resource "tfe_variable_set" "onepass_connect_server_bedrock" {
  name        = "1PassConnect Server Bedrock"
  description = "This is a terraform variable set that provisions the Bedrock 1PassConnect Server & Access Token: https://developer.1password.com/docs/connect/get-started"
}
import {
  id = "varset-xsjQGTWQJ5AtgCnX"
  to = tfe_variable_set.tailscale
}
resource "tfe_variable_set" "tailscale" {
  name        = "Tailscale"
  description = "This is an environment variable set that authenticates tailscale's tf provider: https://registry.terraform.io/providers/tailscale/tailscale/latest/docs"
}
import {
  id = "varset-VVsGstJS9UnDUMda"
  to = tfe_variable_set.unifi
}
resource "tfe_variable_set" "unifi" {
  name        = "Unifi Gateway"
  description = "This is an environment variable set that authenticates unifi's tf provider: https://registry.terraform.io/providers/ubiquiti-community/unifi/latest/docs"
}

# Assign Variable Sets to TFE Workspaces
resource "tfe_workspace_variable_set" "tailscale" {
  variable_set_id = tfe_variable_set.tailscale.id
  workspace_id    = tfe_workspace.remote_exec_workspace["tailscale_terraform"].id
}
