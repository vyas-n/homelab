
module "argo_cd" {
  source = "./modules/argo-cd"

  kubernetes_namespace = kubernetes_namespace_v1.argo_cd.id
  ingress_annotations  = module.tailscale_operator.ingress_annotations
  ingress_class        = module.tailscale_operator.ingress_class
  ingress_host         = "argocd-do"
  ingress_domain       = "argocd-do.tail5c72f1.ts.net"
}

module "argo_rollouts" {
  source = "./modules/argo-rollouts"

  kubernetes_namespace = kubernetes_namespace_v1.argo_rollouts.id
  ingress_annotations  = module.tailscale_operator.ingress_annotations
  ingress_class        = module.tailscale_operator.ingress_class
  ingress_host         = "argo-rollouts-do"
  ingress_domain       = "argo-rollouts-do.tail5c72f1.ts.net"
}

module "tailscale_operator" {
  source = "./modules/tailscale-operator"

  kubernetes_namespace = kubernetes_namespace_v1.tailscale.id
}

module "cert_manager" {
  source = "./modules/cert-manager"

  kubernetes_namespace = kubernetes_namespace_v1.cert_manager.id
}

module "kargo" {
  source = "./modules/kargo"

  kubernetes_namespace = kubernetes_namespace_v1.kargo.id
  ingress_annotations  = module.tailscale_operator.ingress_annotations
  ingress_class        = module.tailscale_operator.ingress_class
  ingress_host         = "kargo-do"
  ingress_domain       = "kargo-do.tail5c72f1.ts.net"

  # https://docs.kargo.io/operator-guide/basic-installation#prerequisites
  depends_on = [
    module.cert_manager,
    module.argo_cd,
    module.argo_rollouts
  ]
}
