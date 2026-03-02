
resource "kubernetes_namespace_v1" "stackgres_operator" {
  metadata {
    name = "stackgres-operator"
  }
}

resource "helm_release" "stackgres_operator" { # https://artifacthub.io/packages/helm/stackgres-charts/stackgres-operator
  name       = "stackgres-operator"
  chart      = "stackgres-operator"
  repository = "https://stackgres.io/downloads/stackgres-k8s/stackgres/helm"
  version    = "1.18.6"

  namespace        = kubernetes_namespace_v1.stackgres_operator.metadata[0].name
  create_namespace = false
  lint             = true
  wait             = false # The Helm webhooks only run properly if wait is set to false.
  timeout          = 300

  values = [
    yamlencode(yamldecode(file("${path.module}/helm/stackgres-operator/values.yaml"))), # remove yaml comments & formatting from diff calculations
    yamlencode({})
  ]
}

resource "kubernetes_ingress_v1" "stackgres_operator" {
  metadata {
    name      = "stackgres-restapi"
    namespace = kubernetes_namespace_v1.stackgres_operator.metadata[0].name
    annotations = {
      "cert-manager.io/cluster-issuer" = "zerossl-prod"

      # https://docs.cilium.io/en/stable/network/servicemesh/ingress/#supported-ingress-annotations
      "ingress.cilium.io/tls-passthrough" = "enabled"
    }
  }
  spec {
    ingress_class_name = "cilium"
    tls {
      hosts       = ["stackgres.homezone-v1.vyas-n.dev"]
      secret_name = "stackgres.homezone-v1.vyas-n.dev"
    }
    rule {
      host = "stackgres.homezone-v1.vyas-n.dev"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "stackgres-restapi"
              port {
                name = "https"
              }
            }
          }
        }
      }
    }
  }

  depends_on = [helm_release.stackgres_operator]
}
