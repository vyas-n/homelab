# ref: https://artifacthub.io/packages/helm/argo/argo-cd
resource "helm_release" "argo_cd" {
  chart      = "argo-cd"
  repository = "oci://ghcr.io/argoproj/argo-helm"
  name       = "argo-cd"
  namespace  = var.kubernetes_namespace
  version    = "10.9.1"
  lint       = true
  wait       = true

  values = concat(
    [
      # Sort the fileset to preserve the ordering of the values files
      for file in sort(fileset(path.module, "values/*.{yaml,yml}")) :
      # Decode & encode to remove yaml comments & formatting from diff calculations
      yamlencode(yamldecode(file("${path.module}/${file}")))
      ], [yamlencode({
        global = {
          domain = var.ingress_domain
        }
        server = {
          ingress = {
            enabled : true
            ingressClassName : var.ingress_class
            annotations = var.ingress_annotations
            extraTls = [{
              hosts = [
                var.ingress_host
              ]
            }]
          }
        }
  })])
}
