terraform {
  cloud {
    organization = "vyas-n"
    workspaces {
      name = "digitalocean_terraform"
    }
  }
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.48.1"
    }
  }
}

provider "digitalocean" {}
