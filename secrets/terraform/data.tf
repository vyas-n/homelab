
data "onepassword_vault" "private" {
  name = "Private"
}

# Terraform Cloud
data "onepassword_item" "tfcloud_pat" {
  vault = data.onepassword_vault.private.uuid
  title = "TerraformCloud-PAT"
}

# Cloudflare
data "onepassword_item" "cloudflare_pat" {
  vault = data.onepassword_vault.private.uuid
  title = "Cloudflare API Token"
}
data "onepassword_item" "cloudflare_origin_ca_key" {
  vault = data.onepassword_vault.private.uuid
  title = "Cloudflare: Origin CA Key"
}
data "onepassword_item" "cloudflare_global_api_key" {
  vault = data.onepassword_vault.private.uuid
  title = "Cloudflare: Global API Key"
}
data "cloudflare_user" "me" {}
data "cloudflare_api_token_permission_groups" "all" {}

# DigitalOcean
data "onepassword_item" "digitalocean_pat_for_tfcloud_vyasn" {
  vault = data.onepassword_vault.private.uuid
  title = "DigitalOcean-PAT-for-Terraform-Cloud-vyas-n"
}
data "onepassword_item" "digitalocean_s3access_for_tfcloud_vyasn" {
  vault = data.onepassword_vault.private.uuid
  title = "DigitalOcean-S3Access-for-Terraform-Cloud-vyas-n"
}

# Bedrock 1PassConnect Server
data "onepassword_item" "onepass_connect_credentials_json" {
  vault = data.onepassword_vault.private.uuid
  title = "1Pass Connect Server: Bedrock"
}

# Bedrock 1PassConnect Access Token
data "onepassword_item" "onepass_connect_access_token" {
  vault = data.onepassword_vault.private.uuid
  title = "1Pass Connect Bedrock Access Token: Kubernetes"
}

# Homelab Proxmox
data "onepassword_item" "proxmox_api_token" {
  vault = data.onepassword_vault.private.uuid
  title = "Proxmox API Token (HomeLab)"
}
