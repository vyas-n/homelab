
resource "kubernetes_namespace_v1" "argo_cd" {
  metadata {
    name = "argo-cd"
  }
}

resource "kubernetes_namespace_v1" "argo_rollouts" {
  metadata {
    name = "argo-rollouts"
  }
}

resource "kubernetes_namespace_v1" "kargo" {
  metadata {
    name = "kargo"
  }
}

resource "kubernetes_namespace_v1" "cert_manager" {
  metadata {
    name = "cert-manager"
  }
}

resource "kubernetes_namespace_v1" "tailscale" {
  metadata {
    name = "tailscale"
  }
}
