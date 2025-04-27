
## TFC TF Provider
# Uses TFC Organization Token

resource "time_rotating" "tfe_organization_token" {
  rotation_months = 6
}

resource "tfe_organization_token" "vyas_n" {
  organization = "vyas-n"
  expired_at   = time_rotating.tfe_organization_token.rotation_rfc3339
}

# TODO: convert this to an API Credential and include creation date & expiry values
resource "onepassword_item" "tfe_organization_token" {
  vault    = data.onepassword_vault.private.uuid
  title    = "TFC Org Token - vyas-n"
  category = "password"

  password = tfe_organization_token.vyas_n.token
  url      = "https://app.terraform.io/app/vyas-n/settings/authentication-tokens"

  section {
    label = "Details"
    field {
      label = "valid from"
      type  = "DATE"
      value = formatdate("YYYY-MM-DD", time_rotating.tfe_organization_token.rfc3339)
    }

    field {
      label = "expires"
      type  = "DATE"
      value = formatdate("YYYY-MM-DD", time_rotating.tfe_organization_token.rotation_rfc3339)
    }
  }
}

resource "tfe_variable_set" "tfc" {
  name        = "Terraform Cloud"
  description = "This is an environment variable set that authenticates with TFC's tf provider: https://registry.terraform.io/providers/hashicorp/tfe/latest/docs"
}

resource "tfe_variable" "tfe_token" {
  key             = "TFE_TOKEN"
  value           = onepassword_item.tfe_organization_token.password
  category        = "env"
  sensitive       = true
  description     = "This is a Terraform Cloud Org Token for the vyas-n TFC Org."
  variable_set_id = tfe_variable_set.tfc.id
}

## Cloudflare TF Provider
resource "tfe_variable_set" "cloudflare" {
  name        = "Cloudflare"
  description = "This is an environment variable set that authenticates cloudflare's tf provider: https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs"
}

resource "time_rotating" "tfe_cloudflare_api_token" {
  rotation_months = 6
}

# Token allowed to edit DNS entries for all zones from specific account.
resource "cloudflare_api_token" "tfe_cloudflare_api_token" {
  name = "tfe_cloudflare_api_token"

  not_before = time_rotating.tfe_cloudflare_api_token.rfc3339
  expires_on = time_rotating.tfe_cloudflare_api_token.rotation_rfc3339

  # include all zones from specific account
  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.zone["DNS Write"],
    ]
    resources = {
      "com.cloudflare.api.account.*" = "*"
    }
  }
}

resource "tfe_variable" "cloudflare_api_token" {
  key             = "CLOUDFLARE_API_TOKEN"
  value           = cloudflare_api_token.tfe_cloudflare_api_token.value
  category        = "env"
  sensitive       = true
  description     = <<EOF
    This is a Cloudflare API Token for vyas-n's cloudflare account.

    Stored here: https://start.1password.com/open/i?a=JUCISKH67RAPBO6RKNPIERCVI4&v=t4f4664r2vhpryeipyn3dax5em&i=qjgcn7gza5fhlpnxwvetc42hdi&h=my.1password.com
    EOF
  variable_set_id = tfe_variable_set.cloudflare.id
}

## DigitalOcean TF Provider
resource "tfe_variable_set" "digitalocean" {
  name        = "DigitalOcean"
  description = "This is an environment variable set that authenticates digitalocean's tf provider: https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs"
}

resource "tfe_variable" "digitalocean_token" {
  key             = "DIGITALOCEAN_TOKEN"
  value           = data.onepassword_item.digitalocean_pat_for_tfcloud_vyasn.credential
  category        = "env"
  sensitive       = true
  description     = <<EOF
    This is a DigitalOcean API Token for vyas-n's digitalocean account.

    Stored here: https://start.1password.com/open/i?a=JUCISKH67RAPBO6RKNPIERCVI4&v=t4f4664r2vhpryeipyn3dax5em&i=eyuopajlakj4wlefgpdsf7gw3y&h=my.1password.com
    EOF
  variable_set_id = tfe_variable_set.digitalocean.id
}

resource "tfe_variable" "digitalocean_spaces_access_key_id" {
  key             = "SPACES_ACCESS_KEY_ID"
  value           = data.onepassword_item.digitalocean_s3access_for_tfcloud_vyasn.username
  category        = "env"
  sensitive       = true
  description     = <<EOF
    This is a DigitalOcean Spaces Access Key for vyas-n's digitalocean account.

    Stored here: https://start.1password.com/open/i?a=JUCISKH67RAPBO6RKNPIERCVI4&v=t4f4664r2vhpryeipyn3dax5em&i=mzhzw6qkxvnvvh7ybltof7c7ge&h=my.1password.com
    EOF
  variable_set_id = tfe_variable_set.digitalocean.id
}

resource "tfe_variable" "digitalocean_spaces_secret_access_key" {
  key             = "SPACES_SECRET_ACCESS_KEY"
  value           = data.onepassword_item.digitalocean_s3access_for_tfcloud_vyasn.credential
  category        = "env"
  sensitive       = true
  description     = <<EOF
    This is a DigitalOcean Spaces Access Key for vyas-n's digitalocean account.

    Stored here: https://start.1password.com/open/i?a=JUCISKH67RAPBO6RKNPIERCVI4&v=t4f4664r2vhpryeipyn3dax5em&i=mzhzw6qkxvnvvh7ybltof7c7ge&h=my.1password.com
    EOF
  variable_set_id = tfe_variable_set.digitalocean.id
}

# Bedrock 1PassConnect Server & Access Token
resource "tfe_variable_set" "onepass_connect_server_bedrock" {
  name        = "1PassConnect Server Bedrock"
  description = "This is a terraform variable set that provisions the Bedrock 1PassConnect Server & Access Token: https://developer.1password.com/docs/connect/get-started"
}

resource "tfe_variable" "onepass_connect_credentials_json" {
  key             = "onepassword_credentials_json"
  value           = data.onepassword_item.onepass_connect_credentials_json.file.0.content
  category        = "terraform"
  sensitive       = true
  description     = <<EOF
    This is a 1password-credentials.json file used to provision the bedrock 1PassConnect instance.

    Stored here: https://start.1password.com/open/i?a=JUCISKH67RAPBO6RKNPIERCVI4&v=t4f4664r2vhpryeipyn3dax5em&i=utkwbonv5bwhibprmpcwyy73my&h=my.1password.com
    EOF
  variable_set_id = tfe_variable_set.onepass_connect_server_bedrock.id
}

resource "tfe_variable" "onepass_connect_access_token" {
  key             = "onepassword_access_token"
  value           = data.onepassword_item.onepass_connect_access_token.credential
  category        = "terraform"
  sensitive       = true
  description     = <<EOF
    This is a 1password connect access token used to retrieve secrets from the bedrock 1PassConnect instance.

    Stored here: https://start.1password.com/open/i?a=JUCISKH67RAPBO6RKNPIERCVI4&v=t4f4664r2vhpryeipyn3dax5em&i=t7nnsq2rfn6uolkjo6hedl3uve&h=my.1password.com
    EOF
  variable_set_id = tfe_variable_set.onepass_connect_server_bedrock.id
}

# Tailscale API Credentials
resource "tfe_variable_set" "tailscale" {
  name        = "Tailscale"
  description = "This is an environment variable set that authenticates tailscale's tf provider: https://registry.terraform.io/providers/tailscale/tailscale/latest/docs"
}

resource "tfe_variable" "tailscale_api_key" {
  key             = "TAILSCALE_API_KEY"
  value           = data.onepassword_item.tailscale_api_key_for_vyasn.credential
  category        = "terraform"
  sensitive       = true
  description     = <<EOF
    This is a Tailscale API Key for vyas-n's tailnet.

    Stored here: https://start.1password.com/open/i?a=JUCISKH67RAPBO6RKNPIERCVI4&v=t4f4664r2vhpryeipyn3dax5em&i=xyua5yuxnlcjaqrtja2yykbdee&h=my.1password.com
    EOF
  variable_set_id = tfe_variable_set.onepass_connect_server_bedrock.id
}
