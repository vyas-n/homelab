terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2"
    }
  }
}

provider "kubernetes" {
  config_context = "k8s.vyas-n.dev"
  config_path    = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_context = "k8s.vyas-n.dev"
    config_path    = "~/.kube/config"
  }
}

variable "cloudflare_api_token" {
  sensitive = true
  type      = string
}

locals {
  helm-charts = {
    cert-manager = { # https://artifacthub.io/packages/helm/cert-manager/cert-manager
      repository = "https://charts.jetstack.io"
      version    = "1.8.2"
    }
  }
  kube-files = { for f in fileset(path.module, "static/*") : f => yamldecode(file("${path.module}/${f}")) }
  namespaces = setsubtract(
    setunion(
      [for name, value in local.helm-charts : lookup(value, "namespace", name)],
      [for _, contents in local.kube-files : lookup(contents.metadata, "namespace", "default")]
    ),
    ["kube-system", "kube-node-lease", "kube-public", "default"]
  )
}

resource "kubernetes_namespace" "ns" {
  for_each = local.namespaces
  metadata {
    name = each.key
  }
}

resource "helm_release" "chart" {
  for_each   = local.helm-charts
  name       = each.key
  chart      = each.key
  repository = each.value["repository"]
  version    = each.value["version"]

  namespace        = lookup(each.value, "namespace", each.key)
  create_namespace = false
  lint             = true
  timeout          = lookup(each.value, "timeout", 300)

  values = [
    file("${path.module}/helm/${each.key}/values.yaml"),
    yamlencode(lookup(each.value, "values", {}))
  ]

  depends_on = [
    kubernetes_namespace.ns
  ]
}

resource "kubernetes_manifest" "static" {
  for_each = local.kube-files
  manifest = each.value

  depends_on = [
    kubernetes_namespace.ns,
    helm_release.chart
  ]
}

resource "kubernetes_secret" "cloudflare" {
  metadata {
    name      = "cloudflare-api-token-secret"
    namespace = "cert-manager"
  }

  data = {
    api-token = var.cloudflare_api_token
  }

  type = "Opaque"

  depends_on = [
    kubernetes_namespace.ns
  ]
}
