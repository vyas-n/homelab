data "digitalocean_kubernetes_versions" "do_k8s" {
  # Grab the latest k8s version slug with `doctl kubernetes options versions`
  version_prefix = "1.27."
}

resource "digitalocean_kubernetes_cluster" "do_k8s" {
  name          = "do-k8s"
  region        = var.region
  version       = data.digitalocean_kubernetes_versions.example.latest_version
  surge_upgrade = true
  auto_upgrade  = true

  node_pool {
    name = "default"
    # Grab available droplet sizes with `doctl compute size list`
    size       = "s-1vcpu-2gb"
    node_count = 3
  }
}
