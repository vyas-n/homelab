/*
 * # UniFi Root
 *
*/

terraform {
  required_version = ">= 1.11.0"
  cloud {
    organization = "vyas-n"
    workspaces {
      name = "unifi"
    }
  }
  required_providers {
    unifi = {
      source  = "ubiquiti-community/unifi"
      version = "0.41.3"
    }
  }
}

provider "unifi" {}
