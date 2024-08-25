
resource "tfe_workspace" "tfcloud_terraform" {
  name = "tfcloud_terraform"
  vcs_repo {
    identifier                 = "vyas-n/deploy"
    github_app_installation_id = data.tfe_github_app_installation.vyas_n.installation_id
  }
}
