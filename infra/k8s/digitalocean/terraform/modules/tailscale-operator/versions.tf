/*
 * # Tailscale operator module
 *
*/

terraform {
  required_version = ">= 1.11.0"
  required_providers {
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
    tailscale = {
      source  = "tailscale/tailscale"
      version = ">= 0.22.0"
    }
  }
}
