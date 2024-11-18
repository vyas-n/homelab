/*
This Terraform workspace is used to sync secrets/tokens from 1Password over to the various places that they are used.

This workspace will only execute locally and will not store its state remotely.

It uses .envrc to load 1Password secrets into environment variables to authenticate each provider.
It also uses .envrc to load 1Password secrets into terraform variables to load into each provider.
*/

terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.60.1"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "2.1.2"
    }
  }
}


provider "onepassword" {
  # verify that this matches with: `op account ls | from ssv | get "URL".0`
  account = "my.1password.com"
}

provider "tfe" {
  organization = "vyas-n"
  token        = data.onepassword_item.tfcloud_pat.credential
}
