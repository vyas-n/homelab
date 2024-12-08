
# 1Pass
data "onepassword_vault" "private" {
  name = "Private"
}

# Terraform Cloud
data "onepassword_item" "tfcloud_pat" {
  vault = data.onepassword_vault.private.uuid
  title = "TerraformCloud-PAT"
}

# Cloudflare
data "onepassword_item" "cloudflare_global_api_key" {
  vault = data.onepassword_vault.private.uuid
  title = "Cloudflare: Global API Key"
}

# Homelab Proxmox
data "onepassword_item" "proxmox_api_token" {
  vault = data.onepassword_vault.private.uuid
  title = "Proxmox API Token (HomeLab)"
}

# GitHub (vyas-n)
data "onepassword_item" "github_pat_vyas_n" {
  vault = data.onepassword_vault.private.uuid
  title = "GitHub-PAT-vyas-n"
}
