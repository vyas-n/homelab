/*
 * This Terraform workspace is used to sync secrets/tokens from 1Password over to the various places that they are used.
 * It will store its state in Terraform Cloud, but only execute locally.
 * The files are named after the location that the secrets are synchronized to (not necessarily the provider that the credentials are used for)
*/

terraform {
  required_version = ">= 1.11.0"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.73.0"
    }

    cloudinit = {
      source = "hashicorp/cloudinit"
      version = "2.3.6"
    }
  }
}
