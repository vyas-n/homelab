terraform {
  cloud {
    organization = "vyas-n"
    workspaces {
      name = "digitalocean_nyc3_terraform"
    }
  }
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.45.0"
    }
  }
}

provider "digitalocean" {}
