
module "proxmox_secrets" {
  source = "./modules/proxmox_secrets"
}

module "tfe_secrets" {
  source = "./modules/tfe_secrets"
}
