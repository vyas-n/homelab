/*
 * # Proxmox Root
 *
*/

terraform {
  required_version = ">= 1.11.0"
  cloud {
    organization = "vyas-n"
    workspaces {
      name = "proxmox_terraform"
    }
  }
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
      version = "0.73.0"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "2.3.6"
    }
    unifi = {
      source  = "ubiquiti-community/unifi"
      version = "0.41.2"
    }
  }
}

provider "cloudinit" {}

provider "onepassword" {
  # verify that this matches with: `op account ls | from ssv | get "URL".0`
  account = "my.1password.com"
}

provider "time" {}

provider "proxmox" {
  endpoint  = "https://proxmox-1.hosts.vyas-n.dev"
  api_token = "root@pam!onepass=${data.onepassword_item.proxmox_api_token.credential}"
  ssh {
    agent    = true
    username = "root"
  }
}

provider "unifi" {
  api_url        = "https://192.168.2.1"
  allow_insecure = true

  username = data.onepassword_item.unifi_gateway_homelab.username
  password = data.onepassword_item.unifi_gateway_homelab.password
}
