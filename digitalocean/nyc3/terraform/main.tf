
locals {
  region = "nyc3"
}

resource "digitalocean_project" "bedrock" {
  name = "bedrock"
}

resource "digitalocean_project_resources" "bedrock" {
  project = digitalocean_project.bedrock.id
  resources = [
    digitalocean_kubernetes_cluster.do_k8s.urn
  ]
}

resource "digitalocean_kubernetes_cluster" "do_k8s" {
  name          = "do-k8s"
  region        = local.region
  version       = data.digitalocean_kubernetes_versions.do_k8s.latest_version
  surge_upgrade = true
  auto_upgrade  = true

  node_pool {
    name = "default"
    # Grab available droplet sizes with `doctl kubernetes options sizes`
    # Since this pool size can't be changed later, I'm only adding the smallest node type they have.
    # Additional pools will actually be the size of the cluster.
    size       = "s-1vcpu-2gb"
    node_count = 1
  }
}
