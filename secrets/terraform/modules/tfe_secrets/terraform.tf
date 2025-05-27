/*
 * # Terraform Cloud Secrets Seeding
 *
*/

terraform {
  required_version = ">= 1.11.0"
  required_providers {
    onepassword = {
      source  = "1Password/onepassword"
      version = ">= 2.1.2"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = ">= 0.65.1"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.13.0"
    }
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.76.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 5.0.0"
    }
  }
}
