/*
 * # DigitalOcean do-k8s Root
 *
*/

terraform {
  required_version = ">= 1.11.0"
  cloud {
    organization = "vyas-n"
    workspaces {
      name = "k8s_digitalocean"
    }
  }
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.67.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 3.0.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.38.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.19.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.9.1"
    }
    tailscale = {
      source  = "tailscale/tailscale"
      version = ">= 0.22.0"
    }
  }
}

provider "digitalocean" {}

# K8s Cluster Creds:
# - https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster#kubernetes-terraform-provider-example

provider "helm" {
  kubernetes = {
    host  = data.digitalocean_kubernetes_cluster.do_k8s.endpoint
    token = data.digitalocean_kubernetes_cluster.do_k8s.kube_config[0].token
    cluster_ca_certificate = base64decode(
      data.digitalocean_kubernetes_cluster.do_k8s.kube_config[0].cluster_ca_certificate
    )
  }
}

provider "kubernetes" {
  host  = data.digitalocean_kubernetes_cluster.do_k8s.endpoint
  token = data.digitalocean_kubernetes_cluster.do_k8s.kube_config[0].token
  cluster_ca_certificate = base64decode(
    data.digitalocean_kubernetes_cluster.do_k8s.kube_config[0].cluster_ca_certificate
  )
}

provider "kubectl" {
  host  = data.digitalocean_kubernetes_cluster.do_k8s.endpoint
  token = data.digitalocean_kubernetes_cluster.do_k8s.kube_config[0].token
  cluster_ca_certificate = base64decode(
    data.digitalocean_kubernetes_cluster.do_k8s.kube_config[0].cluster_ca_certificate
  )
  load_config_file = false
}

provider "random" {}

provider "tailscale" {}
