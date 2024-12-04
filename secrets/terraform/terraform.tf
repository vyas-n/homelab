/*
This Terraform workspace is used to sync secrets/tokens from 1Password over to the various places that they are used.

This workspace will store its state in Terraform Cloud, but only execute locally.
*/

terraform {
  cloud {
    organization = "vyas-n"
    workspaces {
      name = "secrets_terraform"
    }
  }
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.60.1"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "2.1.2"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.12.1"
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

provider "time" {}
