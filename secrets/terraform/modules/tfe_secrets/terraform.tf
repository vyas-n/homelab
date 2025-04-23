/*
 * # Terraform Cloud Secrets Seeding 
 * 
*/

terraform {
  required_version = ">= 1.11.0"
  required_providers {
    onepassword = {
      source  = "1Password/onepassword"
      version = "2.1.2"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.65.2"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.12.1"
    }
    proxmox = {
      source = "bpg/proxmox"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.52.0"
    }
  }
}
