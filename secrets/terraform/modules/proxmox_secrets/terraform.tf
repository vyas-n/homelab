/*
 * # Proxmox Secrets Seeding 
 * 
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
