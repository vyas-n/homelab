
module "proxmox_secrets" {
  source = "./modules/proxmox_secrets"
}

module "tfe_secrets" {
  source = "./modules/tfe_secrets"

  onepass_vault = data.onepassword_vault.private
}

module "gh_secrets" {
  source = "./modules/gh_secrets"
}

output "proxmox_secrets" {
  value = module.proxmox_secrets
}

output "tfe_secrets" {
  value = module.tfe_secrets
}

output "gh_secrets" {
  value = module.gh_secrets
}
