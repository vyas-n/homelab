
locals {
  region = "nyc3"
}

resource "digitalocean_kubernetes_cluster" "do_k8s" {
  name          = "do-k8s"
  region        = "nyc3"
  version       = data.digitalocean_kubernetes_versions.do_k8s.latest_version
  surge_upgrade = true
  auto_upgrade  = true

  node_pool {
    name = "default"
    # Grab available droplet sizes with `doctl compute size list`
    size       = "s-1vcpu-512mb-10gb"
    node_count = 1
  }
}
