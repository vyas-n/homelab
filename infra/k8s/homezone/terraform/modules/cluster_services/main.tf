
resource "kubernetes_namespace" "argo_cd" {
  metadata {
    name = "argo-cd"
  }
}

resource "helm_release" "argo_cd" { # https://artifacthub.io/packages/helm/argo/argo-cd
  name       = "argo-cd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  version    = "7.8.5"

  namespace        = kubernetes_namespace.argo_cd.metadata[0].name
  create_namespace = false
  lint             = true
  timeout          = 600

  values = [
    yamlencode(yamldecode(file("${path.module}/helm/argo-cd/values.yaml"))), # remove yaml comments & formatting from diff calculations
    yamlencode({})
  ]
}

resource "kubectl_manifest" "repo_creds_externalsecret" {
  yaml_body = yamlencode({
    apiVersion = "external-secrets.io/v1beta1"
    kind       = "ExternalSecret"
    metadata = {
      name      = "repo-creds"
      namespace = kubernetes_namespace.argo_cd.metadata[0].name

      # labels and annotations are copied over to the secret that will be created
      labels = {
        "argocd.argoproj.io/secret-type" : "repo-creds"
      }
    }
    spec = {
      refreshInterval = "5m"
      secretStoreRef = {
        name = "aws-nonprod"
        kind = "ClusterSecretStore"
      }
      target = {
        name           = "repo-creds"
        creationPolicy = "Owner"
      }
      data = [
        {
          secretKey = "type"
          remoteRef = {
            key      = "devzone/argo-cd/github-app"
            property = "type"
          }
        },
        {
          secretKey = "url"
          remoteRef = {
            key      = "devzone/argo-cd/github-app"
            property = "url"
          }
        },
        {
          secretKey = "githubAppID"
          remoteRef = {
            key      = "devzone/argo-cd/github-app"
            property = "githubAppID"
          }
        },
        {
          secretKey = "githubAppInstallationID"
          remoteRef = {
            key      = "devzone/argo-cd/github-app"
            property = "githubAppInstallationID"
          }
        },
        {
          secretKey = "githubAppPrivateKey"
          remoteRef = {
            decodingStrategy = "Base64"
            key              = "devzone/argo-cd/github-app"
            property         = "githubAppPrivateKey-base64"
          }
        },
      ]
    }
  })

  server_side_apply = true
}

resource "kubernetes_secret" "deploy_repo" {
  metadata {
    name      = "deploy-repo"
    namespace = kubernetes_namespace.argo_cd.metadata[0].name
    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }
  type = "Opaque"
  data = {
    type = "git"
    url  = "https://github.com/BlueArchive/deploy"
  }
  depends_on = [kubectl_manifest.repo_creds_externalsecret]
}

# Ref: https://argo-cd.readthedocs.io/en/stable/user-guide/application-specification/
resource "kubectl_manifest" "deploy_app" {
  yaml_body = yamlencode({
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "deploy"
      namespace = kubernetes_namespace.argo_cd.metadata[0].name
    }
    spec = {
      project = "default"
      source = {
        repoURL        = "https://github.com/BlueArchive/deploy.git"
        targetRevision = "main"
        path           = "needham/vaults/devzone-v2/argo-cd"
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = kubernetes_namespace.argo_cd.metadata[0].name
      }
      syncPolicy = {
        syncOptions = [
          "ServerSideApply=true"
        ]
      }
    }
  })

  server_side_apply = true

  lifecycle {
    ignore_changes = all
  }
}

resource "kubernetes_namespace" "stackgres_operator" {
  metadata {
    name = "stackgres-operator"
  }
}

resource "helm_release" "stackgres_operator" { # https://artifacthub.io/packages/helm/stackgres-charts/stackgres-operator
  name       = "stackgres-operator"
  chart      = "stackgres-operator"
  repository = "https://stackgres.io/downloads/stackgres-k8s/stackgres/helm"
  version    = "1.13.0"

  namespace        = kubernetes_namespace.stackgres_operator.metadata[0].name
  create_namespace = false
  lint             = true
  wait             = false # The Helm webhooks only run properly if wait is set to false.
  timeout          = 300

  values = [
    yamlencode(yamldecode(file("${path.module}/helm/stackgres-operator/values.yaml"))), # remove yaml comments & formatting from diff calculations
    yamlencode({})
  ]
}

resource "kubernetes_ingress_v1" "stackgres_operator" {
  metadata {
    name      = "stackgres-restapi"
    namespace = kubernetes_namespace.stackgres_operator.metadata[0].name
    annotations = {
      "cert-manager.io/cluster-issuer" = "zerossl-prod"

      # https://docs.cilium.io/en/stable/network/servicemesh/ingress/#supported-ingress-annotations
      "ingress.cilium.io/tls-passthrough" = "enabled"
    }
  }
  spec {
    ingress_class_name = "cilium"
    tls {
      hosts       = ["stackgres.needham.wsbidev.net"]
      secret_name = "stackgres-needham-wsbidev-net"
    }
    rule {
      host = "stackgres.needham.wsbidev.net"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "stackgres-restapi"
              port {
                name = "https"
              }
            }
          }
        }
      }
    }
  }

  depends_on = [helm_release.stackgres_operator]
}
