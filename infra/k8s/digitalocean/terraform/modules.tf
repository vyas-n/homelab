module "tailscale_operator" {
  source = "./modules/tailscale-operator"

  kubernetes_namespace = kubernetes_namespace_v1.tailscale.id
}
