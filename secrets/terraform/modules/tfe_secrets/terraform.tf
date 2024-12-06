/*
 * This Terraform module is to sync secrets into proxmox
*/

terraform {
  required_providers {
    onepassword = {
      source = "1Password/onepassword"
    }
    time = {
      source = "hashicorp/time"
    }
    proxmox = {
      source = "bpg/proxmox"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}
