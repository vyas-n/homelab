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
      version = ">= 2.1.2"
    }
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

provider "onepassword" {
  # verify that this matches with: `op account ls | from ssv | get "URL".0`
  account = "my.1password.com"
}

provider "time" {}

provider "proxmox" {
  endpoint  = "https://${data.onepassword_item.proxmox_api_token.hostname}"
  api_token = "${data.onepassword_item.proxmox_api_token.username}=${data.onepassword_item.proxmox_api_token.credential}"
  ssh {
    agent       = false
    username    = "root"
    private_key = data.onepassword_item.vyas_fast_key_1.private_key
  }
}

provider "unifi" {
  api_url        = data.onepassword_item.unifi_gateway_homelab.url
  allow_insecure = true

  username = data.onepassword_item.unifi_gateway_homelab.username
  password = data.onepassword_item.unifi_gateway_homelab.password
}
