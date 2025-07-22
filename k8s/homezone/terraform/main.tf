
resource "helm_release" "prometheus_operator_crds" { # https://artifacthub.io/packages/helm/prometheus-community/prometheus-operator-crds
  name       = "prometheus-operator-crds"
  chart      = "prometheus-operator-crds"
  repository = "https://prometheus-community.github.io/helm-charts"
  version    = "21.0.0"

  # CRDs are cluster-wide resources so the namespace only stores helm metadata
  namespace        = "kube-system"
  create_namespace = false
  lint             = true
  timeout          = 300

  values = []
}

# ref: https://docs.k0sproject.io/stable/system-monitoring/#system-components-monitoring
resource "kubectl_manifest" "k0s_service_monitor" {
  yaml_body = yamlencode({
    apiVersion : "monitoring.coreos.com/v1"
    kind : "ServiceMonitor"
    metadata : {
      name : "k0s"
      namespace : "k0s-system"
    }
    spec : {
      endpoints = [
        { port : "http" }
      ]
      selector = {
        matchLabels = {
          app : "k0s-observability"
          component : "pushgateway"
          "k0s.k0sproject.io/stack" : "metrics"
        }
      }
    }
  })

  depends_on = [helm_release.prometheus_operator_crds]
}


