/*
 * # Kargo module
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
      version = ">= 3.2.1"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.9.1"
    }
  }
}
