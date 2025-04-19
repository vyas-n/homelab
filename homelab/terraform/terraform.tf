/*
 * # HomeZone k8s cluster Root
 * 
*/

terraform {
  required_version = ">= 1.11.0"
  cloud {
    organization = "vyas-n"
    workspaces {
      name = "homelab_terraform"
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
  }
}

# K8s Cluster Creds:
# - https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster#kubernetes-terraform-provider-example

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "homezone-v1"
}

provider "kubectl" {
  config_path    = "~/.kube/config"
  config_context = "homezone-v1"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "homezone-v1"
  }
}
