
locals {
  terraform_version = "~> 1.11.0"
}

# Moved resources
moved {
  from = tfe_workspace.digitalocean_terraform
  to   = tfe_workspace.remote_exec_workspace["digitalocean_terraform"]
}
moved {
  from = tfe_workspace.digitalocean_nyc3_terraform
  to   = tfe_workspace.remote_exec_workspace["digitalocean_nyc3_terraform"]
}
moved {
  from = tfe_workspace.digitalocean_nyc3_do_k8s_terraform
  to   = tfe_workspace.remote_exec_workspace["digitalocean_nyc3_do_k8s_terraform"]
}
moved {
  from = tfe_workspace.tfcloud_terraform
  to   = tfe_workspace.remote_exec_workspace["tfcloud_terraform"]
}

import {
  to = tfe_workspace.homelab_terraform
  id = "vyas-n/homelab_terraform"
}
import {
  to = tfe_workspace_settings.homelab_terraform
  id = "vyas-n/homelab_terraform"
}

import {
  to = tfe_workspace.proxmox_terraform
  id = "vyas-n/proxmox_terraform"
}
import {
  to = tfe_workspace_settings.proxmox_terraform
  id = "vyas-n/proxmox_terraform"
}

import {
  to = tfe_workspace.unifi_terraform
  id = "vyas-n/unifi_terraform"
}
import {
  to = tfe_workspace_settings.unifi_terraform
  id = "vyas-n/unifi_terraform"
}


# List of remote_exec_workspaces

resource "tfe_workspace" "remote_exec_workspace" {
  for_each = {
    digitalocean_terraform : {
      working_directory = "digitalocean/terraform"
    }
    digitalocean_nyc3_terraform : {
      working_directory = "digitalocean/nyc3/terraform"
    }
    digitalocean_nyc3_do_k8s_terraform : {
      working_directory = "digitalocean/nyc3/do-k8s/terraform"
    }
    tfcloud_terraform : {
      working_directory = "tfcloud/terraform"
    }
  }

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

# These workspaces only execute locally
resource "tfe_workspace" "homelab_terraform" {
  name           = "homelab_terraform"
  project_id     = data.tfe_project.default.id
  queue_all_runs = false

  terraform_version = local.terraform_version
}

resource "tfe_workspace_settings" "homelab_terraform" {
  workspace_id   = tfe_workspace.homelab_terraform.id
  execution_mode = "local"
}

resource "tfe_workspace" "proxmox_terraform" {
  name           = "proxmox_terraform"
  project_id     = data.tfe_project.default.id
  queue_all_runs = false

  terraform_version = local.terraform_version
}

resource "tfe_workspace_settings" "proxmox_terraform" {
  workspace_id   = tfe_workspace.proxmox_terraform.id
  execution_mode = "local"
}

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

resource "tfe_workspace" "unifi_terraform" {
  name           = "unifi_terraform"
  project_id     = data.tfe_project.default.id
  queue_all_runs = false

  terraform_version = local.terraform_version
}

resource "tfe_workspace_settings" "unifi_terraform" {
  workspace_id   = tfe_workspace.unifi_terraform.id
  execution_mode = "local"
}
