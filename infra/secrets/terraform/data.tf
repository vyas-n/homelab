
# 1Pass
data "onepassword_vault" "seeding" {
  name = "Seeding"
}
data "onepassword_vault" "homelab" {
  name = "HomeLab"
}

# Terraform Cloud
data "onepassword_item" "tfcloud_pat" {
  vault = data.onepassword_vault.seeding.uuid
  title = "TerraformCloud-PAT"
}

# GitHub PAT
# data "onepassword_item" "gh_pat" {
#   vault = data.onepassword_vault.seeding.uuid
#   title = "GitHub-PAT-vyas-n"
# }

# Cloudflare
data "onepassword_item" "cloudflare_global_api_key" {
  vault = data.onepassword_vault.seeding.uuid
  title = "Cloudflare: Global API Key"
}
data "onepassword_item" "cloudflare_api_token" {
  vault = data.onepassword_vault.seeding.uuid
  title = "Cloudflare API Token: Create Additional Tokens"
}

# Homelab Proxmox
data "onepassword_item" "proxmox_api_token" {
  vault = data.onepassword_vault.seeding.uuid
  title = "Proxmox API Token (HomeLab)"
}

# ZeroSSL
data "onepassword_item" "zerossl_api_key" {
  vault = data.onepassword_vault.seeding.uuid
  title = "ZeroSSL API Key"
}
