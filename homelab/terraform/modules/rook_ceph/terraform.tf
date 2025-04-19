/*
 * # Rook Ceph CSI Deployment & Config
 */
terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.6"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.12"
    }
  }
}
