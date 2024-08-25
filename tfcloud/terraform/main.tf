
resource "tfe_workspace" "tfcloud_terraform" {
  name              = "tfcloud_terraform"
  working_directory = "tfcloud/terraform"

  auto_apply            = true
  queue_all_runs        = false
  file_triggers_enabled = true

  vcs_repo {
    identifier                 = "vyas-n/deploy"
    github_app_installation_id = local.tfc_github_app_install_id
  }
}

resource "tfe_workspace" "digitalocean_terraform" {
  name              = "digitalocean_terraform"
  working_directory = "digitalocean/terraform"

  auto_apply            = true
  queue_all_runs        = false
  file_triggers_enabled = true

  vcs_repo {
    identifier                 = "vyas-n/deploy"
    github_app_installation_id = local.tfc_github_app_install_id
  }
}

resource "tfe_workspace" "digitalocean_nyc3_terraform" {
  name              = "digitalocean_nyc3_terraform"
  working_directory = "digitalocean/nyc3/terraform"

  auto_apply            = true
  queue_all_runs        = false
  file_triggers_enabled = true

  vcs_repo {
    identifier                 = "vyas-n/deploy"
    github_app_installation_id = local.tfc_github_app_install_id
  }
}

resource "tfe_workspace" "digitalocean_nyc3_do-k8s_terraform" {
  name              = "digitalocean_nyc3_do-k8s_terraform"
  working_directory = "digitalocean/nyc3/do-k8s/terraform"

  auto_apply            = true
  queue_all_runs        = false
  file_triggers_enabled = true

  vcs_repo {
    identifier                 = "vyas-n/deploy"
    github_app_installation_id = local.tfc_github_app_install_id
  }
}
