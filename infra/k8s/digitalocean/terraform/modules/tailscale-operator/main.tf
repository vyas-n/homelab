
# https://tailscale.com/docs/kubernetes-operator/quickstart#prerequisites
resource "tailscale_oauth_client" "k8s_tailscale_operator" {
  description = "digitalocean-k8s-tailscale-operator"
  scopes = [
    "services",
    "devices:core",
    "auth_keys",
  ]
  tags = ["tag:k8s-operator"]
}

resource "kubernetes_secret_v1" "operator_oauth" {
  metadata {
    # Has to be this name b/c helm chart hardcode's this secret name.
    name      = "operator-oauth"
    namespace = var.kubernetes_namespace
  }
  data = {
    client_id     = tailscale_oauth_client.k8s_tailscale_operator.id
    client_secret = tailscale_oauth_client.k8s_tailscale_operator.key
  }
}

resource "helm_release" "tailscale_operator" {
  chart      = "tailscale-operator"
  repository = "https://pkgs.tailscale.com/helmcharts"
  name       = "tailscale-operator"
  namespace  = var.kubernetes_namespace
  lint       = true
  wait       = true

  values = [yamlencode({
    ingressClass = {
      name    = var.ingress_class
      enabled = true
    }
  })]

  depends_on = [kubernetes_secret_v1.operator_oauth]
}

resource "kubectl_manifest" "tailscale_ingress_proxy_group" {
  yaml_body = yamlencode({
    apiVersion = "tailscale.com/v1alpha1"
    kind       = "ProxyGroup"
    metadata = {
      name      = var.tailscale_proxy_group
      namespace = var.kubernetes_namespace
    }
    spec = {
      type     = "ingress"
      replicas = 2
    }
  })

  depends_on = [helm_release.tailscale_operator]
}
