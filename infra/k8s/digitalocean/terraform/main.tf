
resource "kubernetes_namespace_v1" "tailscale" {
  metadata {
    name = "tailscale"
  }
}
