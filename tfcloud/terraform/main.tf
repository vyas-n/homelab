
locals {
  # TODO: verify that this matches the version of terraform provided by nix
  terraform_version = "1.12.0"
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
    tailscale_terraform : {
      working_directory = "tailscale/terraform"
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
moved {
  from = tfe_workspace.homelab_terraform
  to = tfe_workspace.local_exec_workspace["homelab_terraform"]
}
resource "tfe_workspace" "local_exec_workspace" {
  for_each = {
    "homelab_terraform" : {}
  }

  name           = each.key
  project_id     = data.tfe_project.default.id
  queue_all_runs = false

  terraform_version = local.terraform_version
}

# Assign Variable Sets to TFE Workspaces
resource "tfe_workspace_variable_set" "tailscale" {
  variable_set_id = tfe_variable_set.tailscale.id
  workspace_id    = tfe_workspace.remote_exec_workspace["tailscale_terraform"].id
}

resource "tfe_workspace_settings" "homelab_terraform" {
  workspace_id   = tfe_workspace.local_exec_workspace["homelab_terraform"].id
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
