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
  }
}

provider "tfe" {
  organization = "vyas-n"
}
