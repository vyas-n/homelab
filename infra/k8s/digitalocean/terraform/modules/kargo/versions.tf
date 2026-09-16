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
    random = {
      source  = "hashicorp/random"
      version = ">= 3.9.1"
    }
  }
}
