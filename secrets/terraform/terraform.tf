/*
 * # Secrets Seeding Root
 *
 * This Terraform workspace is used to sync secrets/tokens from 1Password over to the various places that they are used.
 * It will store its state in Terraform Cloud, but only execute locally.
 * The files are named after the location that the secrets are synchronized to (not necessarily the provider that the credentials are used for)
*/

terraform {
  required_version = ">= 1.11.0"
  cloud {
    organization = "vyas-n"
    workspaces {
      name = "secrets_terraform"
    }
  }
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.65.2"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "2.1.2"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.13.0"
    }
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.76.1"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.3.0"
    }
    github = {
      source  = "integrations/github"
      version = "6.6.0"
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

provider "proxmox" {
  endpoint = "https://proxmox-1.hosts.vyas-n.dev/"
  # If self-signed TLS certificate is in use
  # insecure  = true
  api_token = "root@pam!onepass=${data.onepassword_item.proxmox_api_token.credential}"
}

provider "cloudflare" {
  email   = "me@vyas-n.com"
  api_key = data.onepassword_item.cloudflare_global_api_key.credential
  # api_token = data.onepassword_item.cloudflare_pat.credential
}

provider "github" {
  owner = "vyas-n"
}
