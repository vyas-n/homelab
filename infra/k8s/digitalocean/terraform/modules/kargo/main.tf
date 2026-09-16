# ref: https://artifacthub.io/packages/helm/kargo/kargo
resource "helm_release" "kargo" {
  chart      = "kargo"
  repository = "oci://ghcr.io/akuity/kargo-charts"
  name       = "kargo"
  namespace  = var.kubernetes_namespace
  version    = "1.11.4"
  lint       = true
  wait       = true

  values = concat(
    [
      # Sort the fileset to preserve the ordering of the values files
      for file in sort(fileset(path.module, "values/*.{yaml,yml}")) :
      # Decode & encode to remove yaml comments & formatting from diff calculations
      yamlencode(yamldecode(file("${path.module}/${file}")))
      ], [yamlencode({
        api = {
          host = var.ingress_host
          ingress = {
            enabled : true
            annotations      = var.ingress_annotations
            ingressClassName = var.ingress_class
            tls = {
              enabled : true
              selfSignedCert : false
            }
          }
        }
    })]
  )
}
