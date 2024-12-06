# OnePass
data "onepassword_vault" "private" {
  name = "Private"
}

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

# Cloudflare
data "onepassword_item" "cloudflare_pat" {
  vault = data.onepassword_vault.private.uuid
  title = "Cloudflare API Token"
}
