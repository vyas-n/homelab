/*
 * # Terraform Cloud Secrets Seeding
 *
*/

terraform {
  required_version = ">= 1.11.0"
  required_providers {
    onepassword = {
      source = "1Password/onepassword"
    }
    tfe = {
      source = "hashicorp/tfe"
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
    zerossl = {
      source = "toowoxx/zerossl"
    }
  }
}
