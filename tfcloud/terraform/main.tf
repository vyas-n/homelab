
resource "tfe_workspace" "tfcloud_terraform" {
  name = "tfcloud_terraform"
  vcs_repo {
    identifier                 = "vyas-n/deploy"
    github_app_installation_id = local.tfc_github_app_install_id
  }
}

resource "tfe_workspace" "digitalocean_terraform" {
  name = "digitalocean_terraform"
  vcs_repo {
    identifier                 = "vyas-n/deploy"
    github_app_installation_id = local.tfc_github_app_install_id
  }
}

resource "tfe_workspace" "digitalocean_nyc3_terraform" {
  name = "digitalocean_nyc3_terraform"
  vcs_repo {
    identifier                 = "vyas-n/deploy"
    github_app_installation_id = local.tfc_github_app_install_id
  }
}

resource "tfe_workspace" "digitalocean_nyc3_do-k8s_terraform" {
  name = "digitalocean_nyc3_do-k8s_terraform"
  vcs_repo {
    identifier                 = "vyas-n/deploy"
    github_app_installation_id = local.tfc_github_app_install_id
  }
}
