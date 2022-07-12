terraform {
  cloud {
    organization = "vyas-n"

    workspaces {
      name = "deploy"
    }
  }
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2"
    }
    # aws = {
    #   source  = "hashicorp/aws"
    #   version = "~> 4"
    # }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3"
    }
  }
}

provider "cloudflare" {
  # Configuration options
}


provider "digitalocean" {
  # Configuration options
}

data "cloudflare_zone" "vyas-n" {
  name = "vyas-n.com"
}

resource "cloudflare_record" "netbox-a" {
  zone_id = data.cloudflare_zone.vyas-n.zone_id
  name    = "netbox"
  value   = digitalocean_droplet.netbox.ipv4_address
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "netbox-aaaa" {
  zone_id = data.cloudflare_zone.vyas-n.zone_id
  name    = "netbox"
  value   = digitalocean_droplet.netbox.ipv6_address
  type    = "AAAA"
  proxied = true
}

resource "digitalocean_droplet" "netbox" {
  image      = "ubuntu-18-04-x64"
  name       = "netbox.vyas-n.com"
  region     = "sfo3"
  size       = "s-1vcpu-2gb"
  monitoring = true
  ipv6       = true
  backups    = true
}

data "digitalocean_kubernetes_versions" "k8s" {
  version_prefix = "1.22"
}

resource "digitalocean_kubernetes_cluster" "k8s" {
  name   = "k8s-2"
  region = "sfo3"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = data.digitalocean_kubernetes_versions.k8s.latest_version

  surge_upgrade = true
  auto_upgrade  = true

  maintenance_policy {
    start_time = "04:00"
    day        = "sunday"
  }

  node_pool {
    name       = "default-pool-1"
    size       = "s-1vcpu-2gb"
    node_count = 1
  }
}

output "kubeconfig" {
  value     = digitalocean_kubernetes_cluster.k8s.kube_config[0].raw_config
  sensitive = true
}

resource "digitalocean_database_cluster" "pg" {
  name       = "pgsql"
  engine     = "pg"
  version    = "14"
  size       = "db-s-1vcpu-1gb"
  region     = "sfo3"
  node_count = 1
}

resource "digitalocean_database_cluster" "mysql" {
  name       = "mysql"
  engine     = "mysql"
  version    = "8"
  size       = "db-s-1vcpu-1gb"
  region     = "sfo3"
  node_count = 1
}

resource "digitalocean_kubernetes_node_pool" "gitpod-meta-2" {
  cluster_id = digitalocean_kubernetes_cluster.k8s.id

  name       = "gitpod-meta-2"
  size       = "s-8vcpu-16gb"
  node_count = 1

  labels = {
    "gitpod.io/workload_meta" = true
    "gitpod.io/workload_ide"  = true
  }
}

resource "digitalocean_kubernetes_node_pool" "gitpod-workspace-2" {
  cluster_id = digitalocean_kubernetes_cluster.k8s.id

  name       = "gitpod-workspace-2"
  size       = "s-8vcpu-16gb"
  node_count = 1

  labels = {
    "gitpod.io/workload_workspace_services" = true
    "gitpod.io/workload_workspace_regular"  = true
    "gitpod.io/workload_workspace_headless" = true
  }
}

provider "kubernetes" {
  host  = digitalocean_kubernetes_cluster.k8s.endpoint
  token = digitalocean_kubernetes_cluster.k8s.kube_config[0].token
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.k8s.kube_config[0].cluster_ca_certificate
  )
}

provider "helm" {
  kubernetes {
    host  = digitalocean_kubernetes_cluster.k8s.endpoint
    token = digitalocean_kubernetes_cluster.k8s.kube_config[0].token
    cluster_ca_certificate = base64decode(
      digitalocean_kubernetes_cluster.k8s.kube_config[0].cluster_ca_certificate
    )
  }
}

locals {
  helm-charts = {
    actions-runner-controller = { # https://github.com/actions-runner-controller/actions-runner-controller/tree/master/charts/actions-runner-controller
      repository = "https://actions-runner-controller.github.io/actions-runner-controller"
      version    = "0.19.1"
    }
    # argo-cd = { # https://artifacthub.io/packages/helm/argo/argo-cd
    #   repository = "https://argoproj.github.io/argo-helm"
    #   version    = "4.9.7"
    # }
    artifactory-jcr = { # https://artifacthub.io/packages/helm/jfrog/artifactory-jcr
      repository = "https://charts.jfrog.io"
      version    = "107.41.4"
    }
    cert-manager = { # https://artifacthub.io/packages/helm/cert-manager/cert-manager
      repository = "https://charts.jetstack.io"
      version    = "1.8.2"
    }
    external-dns = { # https://artifacthub.io/packages/helm/external-dns/external-dns
      repository = "https://kubernetes-sigs.github.io/external-dns/"
      version    = "1.9.0"
    }
    grafana = { # https://artifacthub.io/packages/helm/grafana/grafana
      repository = "https://grafana.github.io/helm-charts"
      version    = "6.32.1"
    }
    kube-state-metrics = { # https://artifacthub.io/packages/helm/prometheus-community/kube-state-metrics
      # Used to give metrics to the DigitalOcean Insights tab
      repository = "https://prometheus-community.github.io/helm-charts"
      version    = "4.10.0"
      namespace  = "kube-system"
    }
    metrics-server = { # https://artifacthub.io/packages/helm/metrics-server/metrics-server
      # Used to give metrics to the DigitalOcean Insights tab
      repository = "https://kubernetes-sigs.github.io/metrics-server/"
      version    = "3.8.2"
    }
    prometheus = { # https://artifacthub.io/packages/helm/prometheus-community/prometheus
      repository = "https://prometheus-community.github.io/helm-charts"
      version    = "15.10.3"
    }
    traefik = { # https://artifacthub.io/packages/helm/traefik/traefik
      repository = "https://helm.traefik.io/traefik"
      version    = "10.22.0"
    }
  }
  kube-files = { for f in fileset(path.module, "k8s/static/*") : f => yamldecode(file("${path.module}/${f}")) }
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

  values = [
    file("${path.module}/k8s/helm/${each.key}/values.yaml")
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
    namespace = "external-dns"
  }

  data = {
    api-token = var.cloudflare_api_token
  }

  type = "Opaque"

  depends_on = [
    kubernetes_namespace.ns
  ]
}
