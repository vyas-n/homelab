/*
 * # DigitalOcean NYC3 Root
 * 
*/

terraform {
  required_version = ">= 1.11.0"
  cloud {
    organization = "vyas-n"
    workspaces {
      name = "digitalocean_nyc3"
    }
  }
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.62.0"
    }
  }
}

provider "digitalocean" {}
