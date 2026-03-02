
# Terraform Cloud
data "tfe_variable_set" "tfc" {
  name = "Terraform Cloud"
}

# DigitalOcean
data "tfe_variable_set" "digitalocean" {
  name = "DigitalOcean"
}
data "onepassword_item" "digitalocean_pat_for_tfcloud_vyasn" {
  vault = var.onepass_vault.uuid
  title = "DigitalOcean-PAT-for-Terraform-Cloud-vyas-n"
}
data "onepassword_item" "digitalocean_s3access_for_tfcloud_vyasn" {
  vault = var.onepass_vault.uuid
  title = "DigitalOcean-S3Access-for-Terraform-Cloud-vyas-n"
}

# Tailscale
data "tfe_variable_set" "tailscale" {
  name = "Tailscale"
}

data "onepassword_item" "tailscale_api_key_for_vyasn" {
  vault = var.onepass_vault.uuid
  title = "Tailscale API Token (vyas@github)"
}

# Cloudflare
data "tfe_variable_set" "cloudflare" {
  name = "Cloudflare"
}
data "cloudflare_api_token_permission_groups" "all" {}

# Unifi
data "tfe_variable_set" "unifi" {
  name = "Unifi Gateway"
}
data "onepassword_item" "unifi_gateway_homelab" {
  vault = var.onepass_vault.uuid
  title = "Unifi Gateway Local User (1pass-api)"
}
data "onepassword_item" "unifi_homezone_externaldns_apikey" {
  vault = var.onepass_vault.uuid
  title = "Unifi-Homezone-externaldns-apikey"
}

# Proxmox
data "tfe_variable_set" "proxmox" {
  name = "Proxmox Auth"
}
data "onepassword_item" "proxmox_api_token" {
  vault = var.onepass_vault.uuid
  title = "Proxmox API Token (HomeLab)"
}
data "onepassword_item" "proxmox_root_ssh_key" {
  vault = var.onepass_vault.uuid
  title = "Proxmox Root SSH Key"
}

# HomeZone k8s cluster
data "tfe_workspace" "k8s_homezone" {
  name = "k8s_homezone"
}
data "tfe_variable_set" "homezone" {
  name = "HomeZone-v1"
}
