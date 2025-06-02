
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


# Bedrock 1PassConnect Server
data "tfe_variable_set" "onepass_connect_server_bedrock" {
  name = "1PassConnect Server Bedrock"
}
data "onepassword_item" "onepass_connect_credentials_json" {
  vault = var.onepass_vault.uuid
  title = "1Pass Connect Server: Bedrock"
}

# Bedrock 1PassConnect Access Token
data "onepassword_item" "onepass_connect_access_token" {
  vault = var.onepass_vault.uuid
  title = "1Pass Connect Bedrock Access Token: Kubernetes"
}

# Cloudflare
data "tfe_variable_set" "cloudflare" {
  name = "Cloudflare"
}
data "cloudflare_user" "me" {}
data "cloudflare_api_token_permission_groups" "all" {}

# Unifi
data "tfe_variable_set" "unifi" {
  name = "Unifi Gateway"
}
data "onepassword_item" "unifi_gateway_homelab" {
  vault = var.onepass_vault.uuid
  title = "Unifi Gateway Local User (1pass-api)"
}

# Proxmox
data "tfe_variable_set" "proxmox" {
  name = "Proxmox Auth"
}
data "onepassword_item" "proxmox_api_token" {
  vault = var.onepass_vault.uuid
  title = "Proxmox API Token (HomeLab)"
}
data "onepassword_item" "vyas_fast_key_1" {
  vault = var.onepass_vault.uuid
  title = "Vyas-Fast-Key-1"
}

# HomeZone k8s cluster
data "tfe_workspace" "homezone_k8s" {
  name = "homelab_terraform"
}
