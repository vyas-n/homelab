/*
 * This Terraform module is to sync secrets into proxmox
*/

terraform {
  required_providers {
    onepassword = {
      source  = "1Password/onepassword"
      version = "2.1.2"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.12.1"
    }
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.67.1"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.47.0"
    }
  }
}
