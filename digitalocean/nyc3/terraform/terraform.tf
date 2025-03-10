/*
 * # DigitalOcean NYC3 Root
 * 
*/

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
      version = "2.49.1"
    }
  }
}

provider "digitalocean" {}
