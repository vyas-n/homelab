
resource "kubernetes_namespace" "kube_prometheus_stack" {
  metadata {
    name = "kube-prometheus-stack"
  }
}

resource "helm_release" "kube_prometheus_stack" { # https://artifacthub.io/packages/helm/prometheus-community/kube-prometheus-stack
  name       = "kube-prometheus-stack"
  chart      = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  version    = "69.4.1"

  namespace        = kubernetes_namespace.kube_prometheus_stack.metadata[0].name
  create_namespace = false
  lint             = true
  timeout          = 1200

  values = [
    yamlencode(yamldecode(file("${path.module}/helm/kube-prometheus-stack/values.yaml"))), # remove yaml comments & formatting from diff calculations
    yamlencode({})
  ]
}

resource "kubernetes_namespace" "loki" {
  metadata {
    name = "loki"
  }
}

resource "kubectl_manifest" "loki_bucket" {
  yaml_body = yamlencode({
    apiVersion = "objectbucket.io/v1alpha1"
    kind       = "ObjectBucketClaim"
    metadata = {
      name      = "loki-bucket"
      namespace = kubernetes_namespace.loki.metadata[0].name
    }
    spec = {
      bucketName       = "loki-bucket"
      storageClassName = "ceph-bucket"
    }
  })
  server_side_apply = true
}

resource "helm_release" "loki" { # https://artifacthub.io/packages/helm/grafana/loki
  name       = "loki"
  chart      = "loki"
  repository = "https://grafana.github.io/helm-charts"
  version    = "5.48.0"

  namespace        = kubernetes_namespace.loki.metadata[0].name
  create_namespace = false
  lint             = true
  timeout          = 900

  values = [
    yamlencode(yamldecode(file("${path.module}/helm/loki/values.yaml"))), # remove yaml comments & formatting from diff calculations
    yamlencode({})
  ]
  depends_on = [
    kubectl_manifest.loki_bucket
  ]
}

resource "kubectl_manifest" "loki_grafana_datasource" {
  yaml_body = yamlencode({
    apiVersion = "v1"
    kind       = "ConfigMap"
    metadata = {
      name      = "loki-grafana-datasource"
      namespace = kubernetes_namespace.loki.metadata[0].name
      labels = {
        grafana_datasource : "1"
      }
    }
    data = {
      "loki-stack-datasource.yaml" = yamlencode({
        apiVersion = 1
        datasources = [{
          name      = "Loki"
          type      = "loki"
          access    = "proxy"
          url       = "http://loki-gateway:80"
          isDefault = false
          jsonData = {
            timeout  = 60
            maxLines = 1000
          }
        }]
      })
    }
  })
  server_side_apply = true
}

resource "helm_release" "promtail" { # https://artifacthub.io/packages/helm/grafana/promtail
  name       = "promtail"
  chart      = "promtail"
  repository = "https://grafana.github.io/helm-charts"
  version    = "6.16.6"

  namespace        = kubernetes_namespace.loki.metadata[0].name
  create_namespace = false
  lint             = true

  values = [
    yamlencode(yamldecode(file("${path.module}/helm/promtail/values.yaml"))), # remove yaml comments & formatting from diff calculations
    yamlencode({})
  ]
  depends_on = [
    helm_release.loki
  ]
}
