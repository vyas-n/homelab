terraform {
  required_version = "1.5.7"
  cloud {
    organization = "vyas-n"
    workspaces {
      name = "deploy_digitalocean"
    }
  }
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }
}

provider "cloudflare" {
  # Configuration options
}

provider "digitalocean" {
  # Configuration options
}
