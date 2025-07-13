/*
 * # Proxmox Root
 *
*/

terraform {
  required_version = ">= 1.11.0"
  cloud {
    organization = "vyas-n"
    workspaces {
      name = "proxmox"
    }
  }
  required_providers {
    time = {
      source  = "hashicorp/time"
      version = ">= 0.13.0"
    }
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.73.0"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = ">= 2.3.6"
    }
    unifi = {
      source  = "ubiquiti-community/unifi"
      version = ">= 0.41.2"
    }
  }
}

provider "cloudinit" {}

provider "time" {}

provider "proxmox" {
  ssh {
    private_key = var.proxmox_ve_ssh_private_key
  }
}

provider "unifi" {}
