resource "random_password" "admin_password" {
  length = 24
}

resource "random_password" "signing_key" {
  length = 48
}

resource "kubernetes_secret_v1" "admin_account_creds" {
  metadata {
    name      = "admin-account-creds"
    namespace = var.kubernetes_namespace
  }

  data = {
    ADMIN_ACCOUNT_PASSWORD_HASH     = random_password.admin_password.bcrypt_hash
    ADMIN_ACCOUNT_TOKEN_SIGNING_KEY = base64encode(random_password.signing_key.result)
  }
}


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
          secret = {
            name = kubernetes_namespace_v1.admin_account_creds.metadata[0].name
          }
          adminAccount = {
            enabled = true
          }
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
