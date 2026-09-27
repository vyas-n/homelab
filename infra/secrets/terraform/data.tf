
# 1Pass
data "onepassword_vault" "seeding" {
  name = "Seeding"
}
data "onepassword_vault" "homelab" {
  name = "HomeLab"
}

# Terraform Cloud
ephemeral "onepassword_item" "tfcloud_pat" {
  vault = data.onepassword_vault.seeding.uuid
  title = "TerraformCloud-PAT"
}

# GitHub PAT
ephemeral "onepassword_item" "gh_pat" {
  vault = data.onepassword_vault.seeding.uuid
  title = "GitHub-PAT-vyas-n"
}

# Cloudflare
ephemeral "onepassword_item" "cloudflare_api_token" {
  vault = data.onepassword_vault.seeding.uuid
  title = "Cloudflare API Token: Create Additional Tokens"
}

# Homelab Proxmox
ephemeral "onepassword_item" "proxmox_api_token" {
  vault = data.onepassword_vault.seeding.uuid
  title = "Proxmox API Token (HomeLab)"
}

# ZeroSSL
data "onepassword_item" "zerossl_api_key" {
  vault = data.onepassword_vault.seeding.uuid
  title = "ZeroSSL API Key"
}
