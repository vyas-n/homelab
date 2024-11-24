
resource "kubernetes_namespace" "authentik" {
  metadata {
    name = "authentik"
  }
}

resource "helm_release" "authentik" { # ref: https://artifacthub.io/packages/helm/goauthentik/authentik
  name       = "authentik"
  chart      = "authentik"
  repository = "oci://ghcr.io/goauthentik/helm-charts"
  version    = "2024.8.2"

  max_history      = 5
  namespace        = kubernetes_namespace.authentik.metadata[0].name
  create_namespace = false
  lint             = true
  timeout          = 600
  wait             = true
  wait_for_jobs    = true

  values = [
    yamlencode(yamldecode(file("${path.module}/helm/authentik/values.yaml"))), # remove yaml comments & formatting from diff calculations
    yamlencode({})
  ]
}

resource "kubernetes_namespace" "onepassconnect" {
  metadata {
    name = "onepassconnect"
  }
}

resource "kubernetes_secret" "onepass_connect_credentials_json" {
  metadata {
    name      = "op-credentials"
    namespace = kubernetes_namespace.onepassconnect.metadata[0].name
  }
  data = {
    "1password-credentials.json" = base64encode(var.onepassword_credentials_json)
  }
}

resource "helm_release" "onepassconnect" { # ref: https://artifacthub.io/packages/helm/onepassword-connect/connect
  name       = "connect"
  chart      = "connect"
  repository = "https://1password.github.io/connect-helm-charts"
  version    = "1.16.0"

  max_history      = 5
  namespace        = kubernetes_namespace.onepassconnect.metadata[0].name
  create_namespace = false
  lint             = true
  timeout          = 600
  wait             = true
  wait_for_jobs    = true

  values = [
    yamlencode(yamldecode(file("${path.module}/helm/onepassconnect/values.yaml"))), # remove yaml comments & formatting from diff calculations
    yamlencode({
      connect = {
        # The name of Kubernetes Secret containing the 1Password Connect credentials
        credentialsName = kubernetes_secret.onepass_connect_credentials_json.metadata[0].name
      }
    })
  ]
}

resource "kubernetes_namespace" "external_secrets" {
  metadata {
    name = "external-secrets"
  }
}
