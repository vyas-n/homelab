import {
  id = "cert-manager/cert-manager"
  to = module.cluster_operators.helm_release.cert_manager
}

import {
  id = "kube-prometheus-stack/kube-prometheus-stack"
  to = omodule.monitoring_stack.helm_release.kube_prometheus_stack
}
