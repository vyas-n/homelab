terraform {
  cloud {
    organization = "vyas-n"

    workspaces {
      name = "deploy_digitalocean_sfo3_k8s"
    }
  }
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.36"
    }
  }
}

provider "tfe" {
  # Configuration options
}


data "tfe_outputs" "do-sfo3" {
  organization = "vyas-n"
  workspace    = "deploy_digitalocean_sfo3"
}

provider "kubernetes" {
  host  = data.tfe_outputs.do-sfo3.values.k8s.endpoint
  token = data.tfe_outputs.do-sfo3.values.k8s.kube_config[0].token
  cluster_ca_certificate = base64decode(
    data.tfe_outputs.do-sfo3.values.k8s.kube_config[0].cluster_ca_certificate
  )
}

provider "helm" {
  kubernetes {
    host  = data.tfe_outputs.do-sfo3.values.k8s.endpoint
    token = data.tfe_outputs.do-sfo3.values.k8s.kube_config[0].token
    cluster_ca_certificate = base64decode(
      data.tfe_outputs.do-sfo3.values.k8s.kube_config[0].cluster_ca_certificate
    )
  }
}

locals {
  helm-charts = {
    actions-runner-controller = { # https://github.com/actions-runner-controller/actions-runner-controller/tree/master/charts/actions-runner-controller
      repository = "https://actions-runner-controller.github.io/actions-runner-controller"
      version    = "0.20.2"
    }
    argo-cd = { # https://artifacthub.io/packages/helm/argo/argo-cd
      repository = "https://argoproj.github.io/argo-helm"
      version    = "5.3.6"
    }
    cert-manager = { # https://artifacthub.io/packages/helm/cert-manager/cert-manager
      repository = "https://charts.jetstack.io"
      version    = "1.8.2"
    }
    external-dns = { # https://artifacthub.io/packages/helm/external-dns/external-dns
      repository = "https://kubernetes-sigs.github.io/external-dns/"
      version    = "1.11.0"
    }
    keycloak = { # https://artifacthub.io/packages/helm/bitnami/keycloak
      repository = "https://charts.bitnami.com/bitnami"
      version    = "9.7.2"
    }
    kube-state-metrics = { # https://artifacthub.io/packages/helm/prometheus-community/kube-state-metrics
      # Used to give metrics to the DigitalOcean Insights tab
      repository = "https://prometheus-community.github.io/helm-charts"
      version    = "4.16.0"
      namespace  = "kube-system"
    }
    metrics-server = { # https://artifacthub.io/packages/helm/metrics-server/metrics-server
      # Used to give metrics to the DigitalOcean Insights tab
      repository = "https://kubernetes-sigs.github.io/metrics-server/"
      version    = "3.8.2"
    }
    traefik = { # https://artifacthub.io/packages/helm/traefik/traefik
      repository = "https://helm.traefik.io/traefik"
      version    = "10.24.1"
    }
    vault = { # https://artifacthub.io/packages/helm/hashicorp/vault
      repository = "https://helm.releases.hashicorp.com"
      version    = "0.21.0"
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

variable "cloudflare_api_token" {
  sensitive = true
  type      = string
}

variable "zerossl_eab_hmac_key" {
  sensitive = true
  type      = string
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

resource "kubernetes_secret" "cloudflare-external-dns" {
  metadata {
    name      = "cloudflare-api-token-secret"
    namespace = kubernetes_namespace.ns["external-dns"].metadata[0].name
  }

  data = {
    api-token = var.cloudflare_api_token
  }

  type = "Opaque"
}

resource "kubernetes_secret" "ghactionrunner-regcred" {
  metadata {
    name      = "regcred"
    namespace = kubernetes_namespace.ns["actions-runner-controller"].metadata[0].name
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = "${file("${path.module}/generated/config.json")}"
  }
}
