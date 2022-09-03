terraform {
  cloud {
    organization = "vyas-n"

    workspaces {
      name = "deploy_digitalocean_sfo3"
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

data "digitalocean_kubernetes_versions" "k8s" {
  version_prefix = "1.22"
}

resource "digitalocean_kubernetes_cluster" "k8s" {
  name   = "k8s-2"
  region = "sfo3"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = data.digitalocean_kubernetes_versions.k8s.latest_version

  surge_upgrade = true
  auto_upgrade  = true

  maintenance_policy {
    start_time = "04:00"
    day        = "sunday"
  }

  node_pool {
    name       = "default-pool-1"
    size       = "s-1vcpu-2gb"
    node_count = 2
  }
}

resource "digitalocean_database_cluster" "pg" {
  name       = "pgsql"
  engine     = "pg"
  version    = "14"
  size       = "db-s-1vcpu-1gb"
  region     = "sfo3"
  node_count = 1
}

# resource "digitalocean_database_cluster" "mysql" {
#   name       = "mysql"
#   engine     = "mysql"
#   version    = "8"
#   size       = "db-s-1vcpu-1gb"
#   region     = "sfo3"
#   node_count = 1
# }

resource "digitalocean_kubernetes_node_pool" "default-pool-1" {
  cluster_id = digitalocean_kubernetes_cluster.k8s.id

  name       = "default-pool-2"
  size       = "s-2vcpu-4gb"
  node_count = 1
}

# resource "digitalocean_kubernetes_node_pool" "gitpod-meta-2" {
#   cluster_id = digitalocean_kubernetes_cluster.k8s.id

#   name       = "gitpod-meta-2"
#   size       = "s-4vcpu-8gb"
#   node_count = 2

#   labels = {
#     "gitpod.io/workload_meta" = true
#     "gitpod.io/workload_ide"  = true
#   }
# }

# resource "digitalocean_kubernetes_node_pool" "gitpod-workspace-3" {
#   cluster_id = digitalocean_kubernetes_cluster.k8s.id

#   name       = "gitpod-workspace-3"
#   size       = "s-8vcpu-16gb"
#   node_count = 2

#   labels = {
#     "gitpod.io/workload_workspace_services" = true
#     "gitpod.io/workload_workspace_regular"  = true
#     "gitpod.io/workload_workspace_headless" = true
#   }
# }

output "k8s" {
  sensitive = true
  value     = digitalocean_kubernetes_cluster.k8s
}
