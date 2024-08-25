
locals {
  terraform_version = "~> 1.9.0"
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
