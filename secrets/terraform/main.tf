
## TFC TF Provider
resource "tfe_variable_set" "tfc" {
  name        = "Terraform Cloud"
  description = "This is an environment variable set that authenticates with TFC's tf provider: https://registry.terraform.io/providers/hashicorp/tfe/latest/docs"
}

resource "tfe_variable" "tfe_token" {
  key             = "TFE_TOKEN"
  value           = var.tfc_org_token
  category        = "env"
  sensitive       = true
  description     = <<EOF
    This is a Terraform Cloud Org Token for the vyas-n TFC Org.

    Stored here: https://start.1password.com/open/i?a=JUCISKH67RAPBO6RKNPIERCVI4&v=t4f4664r2vhpryeipyn3dax5em&i=slxckwzmatkjcvuswlq54r3i4e&h=my.1password.com
    EOF
  variable_set_id = tfe_variable_set.tfc.id
}

## Cloudflare TF Provider
resource "tfe_variable_set" "cloudflare" {
  name        = "Cloudflare"
  description = "This is an environment variable set that authenticates cloudflare's tf provider: https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs"
}

resource "tfe_variable" "cloudflare_api_token" {
  key             = "CLOUDFLARE_API_TOKEN"
  value           = var.cloudflare_api_token
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
  value           = var.digitalocean_token
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
  value           = var.digitalocean_spaces_access_key_id
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
  value           = var.digitalocean_spaces_secret_access_key
  category        = "env"
  sensitive       = true
  description     = <<EOF
    This is a DigitalOcean Spaces Access Key for vyas-n's digitalocean account.

    Stored here: https://start.1password.com/open/i?a=JUCISKH67RAPBO6RKNPIERCVI4&v=t4f4664r2vhpryeipyn3dax5em&i=mzhzw6qkxvnvvh7ybltof7c7ge&h=my.1password.com
    EOF
  variable_set_id = tfe_variable_set.digitalocean.id
}

# Bedrock 1PassConnect Server


# Bedrock 1PassConnect Service Account
