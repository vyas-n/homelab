
resource "kubernetes_namespace" "authentik" {
  metadata {
    name = "authentik"
  }
}

# ref: https://artifacthub.io/packages/helm/goauthentik/authentik
resource "helm_release" "authentik" {
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
    # remove yaml comments & formatting from diff calculations
    yamlencode(yamldecode(file("${path.module}/helm/authentik/values.yaml"))),
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
    "1password-credentials.json" = var.onepassword_credentials_json
  }
}

# ref: https://artifacthub.io/packages/helm/onepassword-connect/connect
resource "helm_release" "onepassconnect" {
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
    # remove yaml comments & formatting from diff calculations
    yamlencode(yamldecode(file("${path.module}/helm/onepassconnect/values.yaml"))),
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

# ref: https://artifacthub.io/packages/helm/external-secrets-operator/external-secrets
resource "helm_release" "external_secrets" {
  name       = "external-secrets"
  chart      = "external-secrets"
  repository = "oci://ghcr.io/external-secrets/charts"
  version    = "0.10.7"

  max_history      = 5
  namespace        = kubernetes_namespace.external_secrets.metadata[0].name
  create_namespace = false
  lint             = true
  timeout          = 600
  wait             = true
  wait_for_jobs    = true

  values = [
    # remove yaml comments & formatting from diff calculations
    yamlencode(yamldecode(file("${path.module}/helm/external-secrets/values.yaml"))),
    yamlencode({})
  ]
}

resource "kubernetes_secret" "onepassword_connect_access_token" {
  metadata {
    name      = "onepassword-connect-token"
    namespace = kubernetes_namespace.external_secrets.metadata[0].name
  }
  data = {
    token = var.onepassword_access_token
  }
}

resource "kubernetes_manifest" "onepass_cluster_secret_store" {
  manifest = {
    apiVersion = "external-secrets.io/v1beta1"
    kind       = "ClusterSecretStore"
    metadata = {
      name = "onepass"
    }
    spec = {
      provider = {
        onepassword = {
          connectHost = "http://onepassword-connect.onepassconnect.svc:8080"
          vaults = {
            # look in this vault first & only
            Bedrock = 1
          }
          auth = {
            secretRef = {
              connectTokenSecretRef = {
                name = kubernetes_secret.onepassword_connect_access_token.metadata[0].name
                key  = token
              }
            }
          }
        }
      }
    }
  }
}
