terraform {
  cloud {
    organization = "vyas-n"

    workspaces {
      name = "deploy_k8s_k0s-cluster_terraform"
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
