
resource "kubernetes_namespace" "tailscale" {
  metadata {
    name = "tailscale"
  }
}

resource "tailscale_oauth_client" "k8s_tailscale_operator" {
  description = "digitalocean-k8s-tailscale-operator"
  scopes      = [
    "services",
    "devices:core",
    "auth_keys",
  ]
  tags        = []
}
