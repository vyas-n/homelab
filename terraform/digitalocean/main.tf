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

resource "cloudflare_record" "netbox-a" {
  zone_id = data.cloudflare_zone.vyas-n.zone_id
  name    = "netbox"
  value   = digitalocean_droplet.netbox.ipv4_address
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "netbox-aaaa" {
  zone_id = data.cloudflare_zone.vyas-n.zone_id
  name    = "netbox"
  value   = digitalocean_droplet.netbox.ipv6_address
  type    = "AAAA"
  proxied = true
}

resource "digitalocean_droplet" "netbox" {
  image      = "ubuntu-18-04-x64"
  name       = "netbox.vyas-n.com"
  region     = "sfo3"
  size       = "s-1vcpu-2gb"
  monitoring = true
  ipv6       = true
  backups    = true
}

resource "digitalocean_database_cluster" "pg" {
  name       = "pgsql"
  engine     = "pg"
  version    = "14"
  size       = "db-s-1vcpu-1gb"
  region     = "sfo3"
  node_count = 1
}

resource "digitalocean_database_db" "netbox" {
  cluster_id = digitalocean_database_cluster.pg.id
  name       = "netbox"
}

resource "digitalocean_database_user" "netbox" {
  cluster_id = digitalocean_database_cluster.pg.id
  name       = "netbox"
}
