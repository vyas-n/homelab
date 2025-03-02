/*
 * This Terraform module is to sync secrets into proxmox
*/

terraform {
  required_providers {
    time = {
      source = "hashicorp/time"
    }
    github = {
      source = "integrations/github"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}
