
data "onepassword_vault" "private" {
  name = "Private"
}

# Terraform Cloud
data "onepassword_item" "tfcloud_pat" {
  vault = data.onepassword_vault.private.uuid
  title = "TerraformCloud-PAT"
}
data "onepassword_item" "tfcloud_org_token_vyasn" {
  vault = data.onepassword_vault.private.uuid
  title = "TFC Org Token - vyas-n"
}

# Cloudflare
data "onepassword_item" "cloudflare_pat" {
  vault = data.onepassword_vault.private.uuid
  title = "Cloudflare-PAT"
}

# DigitalOcean
# TF_VAR_digitalocean_token="$(op read 'op://personal/DigitalOcean-PAT-for-Terraform-Cloud-vyas-n/token')"
# TF_VAR_digitalocean_spaces_access_key_id="$(op read 'op://personal/DigitalOcean-S3Access-for-Terraform-Cloud-vyas-n/access key id')"
# TF_VAR_digitalocean_spaces_secret_access_key="$(op read 'op://personal/DigitalOcean-S3Access-for-Terraform-Cloud-vyas-n/secret access key')"
# export TF_VAR_digitalocean_token TF_VAR_digitalocean_spaces_access_key_id TF_VAR_digitalocean_spaces_secret_access_key
data "onepassword_item" "digitalocean_pat_for_tfcloud_vyasn" {
  vault = data.onepassword_vault.private.uuid
  title = "DigitalOcean-PAT-for-Terraform-Cloud-vyas-n"
}
data "onepassword_item" "digitalocean_s3access_for_tfcloud_vyasn" {
  vault = data.onepassword_vault.private.uuid
  title = "DigitalOcean-S3Access-for-Terraform-Cloud-vyas-n"
}
