/*
 * # Tailscale Global Config Root
 *
*/

terraform {
  required_version = ">= 1.11.0"
  cloud {
    organization = "vyas-n"
    workspaces {
      name = "tailscale_terraform"
    }
  }
  required_providers {
    tailscale = {
      source  = "tailscale/tailscale"
      version = "0.21.1"
    }
  }
}

provider "tailscale" {}
