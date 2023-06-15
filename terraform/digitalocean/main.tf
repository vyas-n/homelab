terraform {
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
      version = "~> 3"
    }
  }
}

provider "cloudflare" {
  # Configuration options
}

provider "digitalocean" {
  # Configuration options
}

data "cloudflare_zone" "vyas-n" {
  name = "vyas-n.com"
}
