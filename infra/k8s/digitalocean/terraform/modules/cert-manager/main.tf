# https://artifacthub.io/packages/helm/cert-manager/cert-manager
resource "helm_release" "cert_manager" {
  chart      = "cert-manager"
  repository = "oci://quay.io/jetstack/charts"
  name       = "cert-manager"
  version    = "1.21.2"
  namespace  = var.kubernetes_namespace
  lint       = true
  wait       = true


  values = concat([
    # Sort the fileset to preserve the ordering of the values files
    for file in sort(fileset(path.module, "values/*.{yaml,yml}")) :
    # Decode & encode to remove yaml comments & formatting from diff calculations
    yamlencode(yamldecode(file("${path.module}/${file}")))
    ], [yamlencode({

    })
  ])
}
