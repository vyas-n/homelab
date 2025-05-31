
resource "helm_release" "prometheus_operator_crds" { # https://artifacthub.io/packages/helm/prometheus-community/prometheus-operator-crds
  name       = "prometheus-operator-crds"
  chart      = "prometheus-operator-crds"
  repository = "https://prometheus-community.github.io/helm-charts"
  version    = "18.0.0"

  # CRDs are cluster-wide resources so the namespace only stores helm metadata
  namespace        = "kube-system"
  create_namespace = false
  lint             = true
  timeout          = 300

  values = []
}
