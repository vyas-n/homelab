terraform {
  cloud {
    organization = "vyas-n"

    workspaces {
      name = "deploy_k8s_k0s-cluster"
    }
  }
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "k0s-cluster"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "k0s-cluster"
  }
}

locals {
  secrets = {
    # Coder v2
    coder-db-url = {
      namespace = [] # "coder"]
      type      = "Opaque"
      data = {
      }
    }
    dockerhub-pull-creds = {
      namespace = [] # "actions-runner-controller", "argo-cd", "coder", "docker-registry", "emissary", "harbor"] # , "anchore-engine"]
      type      = "kubernetes.io/dockerconfigjson"
      data = {
        # ".dockerconfigjson" = jsonencode({
        #   auths = {
        #     "docker.io" = {
        #       "username" = var.dockerhub_username
        #       "password" = var.dockerhub_password
        #       "email"    = var.dockerhub_email
        #       "auth"     = base64encode("${var.dockerhub_username}:${var.dockerhub_password}")
        #     }
        #     "https://index.docker.io/v1/" = {
        #       "username" = var.dockerhub_username
        #       "password" = var.dockerhub_password
        #       "email"    = var.dockerhub_email
        #       "auth"     = base64encode("${var.dockerhub_username}:${var.dockerhub_password}")
        #     }
        #   }
        # })
      }
    }
  }
  # Derived resources
  secret-files = {
    for secret in flatten([
      for secret_key, secret_value in local.secrets : [
        for ns in secret_value.namespace : merge(secret_value, { name : secret_key, namespace : ns })
      ]
    ]) : join("/", [secret.namespace, secret.name]) => secret
  }
}

resource "kubernetes_namespace" "argo-cd" {
  metadata {
    name = "argo-cd"
  }
}

resource "kubernetes_secret" "secrets" {
  for_each = local.secret-files
  metadata {
    name      = each.value["name"]
    namespace = each.value["namespace"]
  }
  type = each.value["type"]
  data = each.value["data"]

  depends_on = [
    kubernetes_namespace.argo-cd
  ]
}

resource "helm_release" "cilium" { # https://artifacthub.io/packages/helm/cilium/cilium
  name       = "cilium"
  chart      = "cilium"
  repository = "https://helm.cilium.io"
  version    = "1.14.2"

  namespace        = "kube-system"
  create_namespace = false
  lint             = true
  timeout          = 300

  values = [
    yamlencode(yamldecode(file("${path.module}/helm/cilium/values.yaml")))
  ]
}

resource "helm_release" "argo-cd" { # https://artifacthub.io/packages/helm/argo/argo-cd
  name       = "argo-cd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  version    = "5.46.5"

  namespace        = kubernetes_namespace.argo-cd.metadata[0].name
  create_namespace = false
  lint             = true
  timeout          = 300

  values = [
    yamlencode(yamldecode(file("${path.module}/helm/argo-cd/values.yaml")))
  ]

  depends_on = [
    helm_release.cilium
  ]
}
