/*
 * # DigitalOcean Root
 * 
*/

terraform {
  required_version = ">= 1.11.0"
  cloud {
    organization = "vyas-n"
    workspaces {
      name = "digitalocean_terraform"
    }
  }
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.54.0"
    }
  }
}

provider "digitalocean" {}
