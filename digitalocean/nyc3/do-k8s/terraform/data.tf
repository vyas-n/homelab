
data "tfe_outputs" "digitalocean_nyc3_terraform" {
  organization = "vyas-n"
  workspace    = "digitalocean_nyc3_terraform"
}

data "hcp_vault_secrets_app" "digitalocean_nyc3_do_k8s_terraform" {
  app_name = "digitalocean-nyc3-do-k8s-terraform"
}
