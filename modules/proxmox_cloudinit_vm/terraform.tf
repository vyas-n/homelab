/*
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
