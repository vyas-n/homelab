
resource "kubernetes_namespace" "tailscale" {
  metadata {
    name = "tailscale"
  }
}
