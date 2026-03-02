
module "proxmox_secrets" {
  source                = "./modules/proxmox_secrets"
  cloudflare_account_id = local.cloudflare_account_id
}

module "tfe_secrets" {
  source = "./modules/tfe_secrets"

  onepass_vault   = data.onepassword_vault.seeding
  zerossl_api_key = data.onepassword_item.zerossl_api_key.credential
}

module "gh_secrets" {
  source = "./modules/gh_secrets"

  cloudflare_account_id = local.cloudflare_account_id
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
