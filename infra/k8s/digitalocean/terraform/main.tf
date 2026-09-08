
resource "kubernetes_namespace_v1" "tailscale" {
  metadata {
    name = "tailscale"
  }
}

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
    name      = "operator-oauth"
    namespace = kubernetes_namespace_v1.tailscale.id
  }
  data = {
    client_id     = tailscale_oauth_client.k8s_tailscale_operator.id
    client_secret = tailscale_oauth_client.k8s_tailscale_operator.key
  }
}

resource "helm_release" "tailscale_operator" {
  chart      = "tailscale-operator"
  repository = "https://pkgs.tailscale.com/helmcharts/tailscale"
  name       = "tailscale-operator"
  namespace  = kubernetes_namespace_v1.tailscale.id
  wait       = true

  values = [yamlencode({
  })]

  depends_on = [kubernetes_secret_v1.operator_oauth]
}
