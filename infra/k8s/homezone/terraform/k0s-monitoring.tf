
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
