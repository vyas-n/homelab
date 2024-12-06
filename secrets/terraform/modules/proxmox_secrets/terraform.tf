/*
 * This Terraform module is to sync secrets into proxmox
*/

terraform {
  required_providers {
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
