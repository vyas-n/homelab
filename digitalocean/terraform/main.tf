
resource "digitalocean_kubernetes_cluster" "do_k8s" {
  name    = "do-k8s"
  region  = "nyc3"
  version = "1.27.6-do.0"

  node_pool {
    name       = "default"
    size       = "s-1vcpu-2gb"
    node_count = 3
  }
}
