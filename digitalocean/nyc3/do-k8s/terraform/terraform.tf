/*
 * # DigitalOcean do-k8s Root
 *
*/

terraform {
  required_version = ">= 1.11.0"
  cloud {
    organization = "vyas-n"
    workspaces {
      name = "digitalocean_nyc3_do_k8s_terraform"
    }
  }
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.36.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.19.0"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.52.0"
    }
  }
}

provider "digitalocean" {}

# K8s Cluster Creds:
# - https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster#kubernetes-terraform-provider-example

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

provider "helm" {
  kubernetes {
    host  = data.digitalocean_kubernetes_cluster.do_k8s.endpoint
    token = data.digitalocean_kubernetes_cluster.do_k8s.kube_config[0].token
    cluster_ca_certificate = base64decode(
      data.digitalocean_kubernetes_cluster.do_k8s.kube_config[0].cluster_ca_certificate
    )
  }
}
