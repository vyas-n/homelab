# ref: https://artifacthub.io/packages/helm/argo/argo-rollouts
resource "helm_release" "argo_rollouts" {
  chart      = "argo-rollouts"
  repository = "oci://ghcr.io/argoproj/argo-helm"
  name       = "argo-rollouts"
  namespace  = var.kubernetes_namespace
  version    = "2.43.1"
  lint       = true
  wait       = true

  values = concat(
    [
      # Sort the fileset to preserve the ordering of the values files
      for file in sort(fileset(path.module, "values/*.{yaml,yml}")) :
      # Decode & encode to remove yaml comments & formatting from diff calculations
      yamlencode(yamldecode(file("${path.module}/${file}")))
      ], [yamlencode({
        dashboard = {
          ingress = {
            enabled : true
            ingressClassName : var.ingress_class
            annotations = var.ingress_annotations
            hosts = [
              var.ingress_domain
            ]
            tls = [{
              hosts = [
                var.ingress_host
              ]
            }]
          }
        }
  })])
}
