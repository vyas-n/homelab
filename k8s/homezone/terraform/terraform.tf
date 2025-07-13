/*
 * # HomeZone k8s cluster Root
 * 
*/

terraform {
  required_version = ">= 1.11.0"
  cloud {
    organization = "vyas-n"
    workspaces {
      name = "k8s_homezone"
    }
  }
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.17.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.37.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.19.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.13.1"
    }
  }
}

# K8s Cluster Creds:
# - https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster#kubernetes-terraform-provider-example

provider "kubernetes" {
  host                   = var.kube_host
  cluster_ca_certificate = var.kube_cluster_ca_cert_data
  client_certificate     = var.kube_client_cert_data
  client_key             = var.kube_client_key_data
}

provider "kubectl" {
  host                   = var.kube_host
  cluster_ca_certificate = var.kube_cluster_ca_cert_data
  client_certificate     = var.kube_client_cert_data
  client_key             = var.kube_client_key_data
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    host                   = var.kube_host
    cluster_ca_certificate = var.kube_cluster_ca_cert_data
    client_certificate     = var.kube_client_cert_data
    client_key             = var.kube_client_key_data
  }
}
