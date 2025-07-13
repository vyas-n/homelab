
locals {
  # TODO: verify that this matches the version of terraform provided by nix
  terraform_version = "1.12.0"
}

# Default Org Settings
resource "tfe_organization_default_settings" "vyas_n" {
  default_execution_mode = "remote"
}

# Teraform Agent pool
resource "tfe_agent_pool" "homelab" {
  name = "homelab"
}

# List of remote_exec_workspaces
locals {
  remote_workspaces = {
    digitalocean : {
      working_directory = "digitalocean/terraform"
    }
    digitalocean_nyc3 : {
      working_directory = "digitalocean/nyc3/terraform"
    }
    k8s_digitalocean : {
      working_directory = "k8s/digitalocean/terraform"
    }
    tailscale : {
      working_directory = "tailscale/terraform"
    }
    tfcloud : {
      working_directory = "tfcloud/terraform"
    }
    k8s_homezone : {
      working_directory = "k8s/homezone/terraform"
      agent_pool_id     = tfe_agent_pool.homelab.id
    }
    proxmox : {
      working_directory = "proxmox/terraform"
      agent_pool_id     = tfe_agent_pool.homelab.id
    }
    unifi : {
      working_directory = "unifi/terraform"
      agent_pool_id     = tfe_agent_pool.homelab.id
    }
  }
}
resource "tfe_workspace" "remote_exec_workspace" {
  for_each = local.remote_workspaces

  name              = each.key
  working_directory = each.value["working_directory"]
  project_id        = data.tfe_project.default.id

  terraform_version      = local.terraform_version
  auto_apply             = true
  queue_all_runs         = false
  file_triggers_enabled  = false
  auto_apply_run_trigger = true

  vcs_repo {
    identifier                 = "vyas-proj/deploy"
    github_app_installation_id = local.tfc_github_app_install_id
  }
}
resource "tfe_workspace_settings" "remote_exec_workspace" {
  for_each = {
    for key, value in local.remote_workspaces :
    key => value
    if lookup(value, "agent_pool_id", "-1") != "-1"
  }
  workspace_id   = tfe_workspace.remote_exec_workspace[each.key].id
  execution_mode = "agent"
  agent_pool_id  = each.value.agent_pool_id
}

resource "tfe_run_trigger" "remote_exec_workspace_secrets" {
  for_each      = local.remote_workspaces
  workspace_id  = tfe_workspace.remote_exec_workspace[each.key].id
  sourceable_id = tfe_workspace.secrets.id
}

# Automatically run most workspaces when the tfcloud workspace is run
resource "tfe_run_trigger" "remote_exec_workspace_tfcloud" {
  for_each = {
    for workspace_key, workspace_value in local.remote_workspaces :
    workspace_key => workspace_value
    if workspace_key != "tfcloud"
  }
  workspace_id  = tfe_workspace.remote_exec_workspace[each.key].id
  sourceable_id = tfe_workspace.remote_exec_workspace["tfcloud"].id
}

# This workspace only executes locally
resource "tfe_workspace" "secrets" {
  name           = "secrets"
  project_id     = data.tfe_project.default.id
  queue_all_runs = false

  terraform_version = local.terraform_version
}
resource "tfe_workspace_settings" "secrets" {
  workspace_id   = tfe_workspace.secrets.id
  execution_mode = "local"
}

# TFE Variable Sets
resource "tfe_variable_set" "proxmox" {
  name = "Proxmox Auth"
}
resource "tfe_variable_set" "tfc" {
  name        = "Terraform Cloud"
  description = "This is an environment variable set that authenticates with TFC's tf provider: https://registry.terraform.io/providers/hashicorp/tfe/latest/docs"
}
resource "tfe_variable_set" "cloudflare" {
  name        = "Cloudflare"
  description = "This is an environment variable set that authenticates cloudflare's tf provider: https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs"
}
resource "tfe_variable_set" "digitalocean" {
  name        = "DigitalOcean"
  description = "This is an environment variable set that authenticates digitalocean's tf provider: https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs"
}
resource "tfe_variable_set" "onepass_connect_server_bedrock" {
  name        = "1PassConnect Server Bedrock"
  description = "This is a terraform variable set that provisions the Bedrock 1PassConnect Server & Access Token: https://developer.1password.com/docs/connect/get-started"
}
resource "tfe_variable_set" "tailscale" {
  name        = "Tailscale"
  description = "This is an environment variable set that authenticates tailscale's tf provider: https://registry.terraform.io/providers/tailscale/tailscale/latest/docs"
}
resource "tfe_variable_set" "unifi" {
  name        = "Unifi Gateway"
  description = "This is an environment variable set that authenticates unifi's tf provider: https://registry.terraform.io/providers/ubiquiti-community/unifi/latest/docs"
}
resource "tfe_variable_set" "homezone_v1" {
  name        = "HomeZone-v1"
  description = "This is an environment variable set that authenticates to my HomeZone-v1 k8s cluster using various Kubernetes providers: https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs#credentials-config"
}

# Assign Variable Sets to TFE Workspaces
resource "tfe_workspace_variable_set" "tailscale" {
  variable_set_id = tfe_variable_set.tailscale.id
  workspace_id    = tfe_workspace.remote_exec_workspace["tailscale"].id
}
resource "tfe_workspace_variable_set" "unifi_to_unifi" {
  variable_set_id = tfe_variable_set.unifi.id
  workspace_id    = tfe_workspace.remote_exec_workspace["unifi"].id
}
resource "tfe_workspace_variable_set" "unifi_to_proxmox" {
  variable_set_id = tfe_variable_set.unifi.id
  workspace_id    = tfe_workspace.remote_exec_workspace["proxmox"].id
}
import {
  id = "vyas-n/proxmox/Proxmox Auth"
  to = tfe_workspace_variable_set.proxmox_to_proxmox
}
resource "tfe_workspace_variable_set" "proxmox_to_proxmox" {
  variable_set_id = tfe_variable_set.proxmox.id
  workspace_id    = tfe_workspace.remote_exec_workspace["proxmox"].id
}

import {
  id = "vyas-n/homezone/HomeZone-v1"
  to = tfe_workspace_variable_set.homezone
}
resource "tfe_workspace_variable_set" "homezone" {
  variable_set_id = tfe_variable_set.homezone_v1.id
  workspace_id    = tfe_workspace.remote_exec_workspace["homezone"].id
}
