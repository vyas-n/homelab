/*
 * # Cluster-wide Services
 */
terraform {
  required_version = ">= 1.14.2"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.12"
    }
    argocd = {
      source  = "argoproj-labs/argocd"
      version = ">= 7.15.3"
    }
  }
}
