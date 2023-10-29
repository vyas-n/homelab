terraform {
  required_version = "1.6.2"
  cloud {
    organization = "vyas-n"
    workspaces {
      name = "digitalocean_nyc3_do-k8s_terraform"
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
