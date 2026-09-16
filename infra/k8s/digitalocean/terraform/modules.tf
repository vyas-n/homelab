module "tailscale_operator" {
  source = "./modules/tailscale-operator"

  kubernetes_namespace = kubernetes_namespace_v1.tailscale.id
}

module "argo_cd" {
  source = "./modules/argo-cd"

  kubernetes_namespace = kubernetes_namespace_v1.argocd.id
  ingress_annotations  = module.tailscale_operator.ingress_annotations
  ingress_class        = module.tailscale_operator.ingress_class
  ingress_host         = "argocd-do"
  ingress_domain       = "argocd-do.tail5c72f1.ts.net"
}
