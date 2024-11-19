
locals {
  terraform_version = "~> 1.9.0"
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

resource "tfe_workspace" "tfcloud_terraform" {
  name              = "tfcloud_terraform"
  working_directory = "tfcloud/terraform"
  project_id        = data.tfe_project.default.id

  terraform_version     = local.terraform_version
  auto_apply            = true
  queue_all_runs        = false
  file_triggers_enabled = false

  vcs_repo {
    identifier                 = "vyas-n/deploy"
    github_app_installation_id = local.tfc_github_app_install_id
  }
}

resource "tfe_workspace" "digitalocean_terraform" {
  name              = "digitalocean_terraform"
  working_directory = "digitalocean/terraform"
  project_id        = data.tfe_project.default.id

  terraform_version     = local.terraform_version
  auto_apply            = true
  queue_all_runs        = false
  file_triggers_enabled = false

  vcs_repo {
    identifier                 = "vyas-n/deploy"
    github_app_installation_id = local.tfc_github_app_install_id
  }
}

resource "tfe_workspace" "digitalocean_nyc3_terraform" {
  name              = "digitalocean_nyc3_terraform"
  working_directory = "digitalocean/nyc3/terraform"
  project_id        = data.tfe_project.default.id

  terraform_version     = local.terraform_version
  auto_apply            = true
  queue_all_runs        = false
  file_triggers_enabled = false

  remote_state_consumer_ids = [
    tfe_workspace.digitalocean_nyc3_do_k8s_terraform.id
  ]

  vcs_repo {
    identifier                 = "vyas-n/deploy"
    github_app_installation_id = local.tfc_github_app_install_id
  }
}

resource "tfe_workspace" "digitalocean_nyc3_do_k8s_terraform" {
  name              = "digitalocean_nyc3_do_k8s_terraform"
  working_directory = "digitalocean/nyc3/do-k8s/terraform"
  project_id        = data.tfe_project.default.id

  terraform_version     = local.terraform_version
  auto_apply            = true
  queue_all_runs        = false
  file_triggers_enabled = false

  vcs_repo {
    identifier                 = "vyas-n/deploy"
    github_app_installation_id = local.tfc_github_app_install_id
  }
}
