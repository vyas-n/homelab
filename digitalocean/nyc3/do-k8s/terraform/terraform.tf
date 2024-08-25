terraform {
  cloud {
    organization = "vyas-n"
    workspaces {
      name = "digitalocean_nyc3_do-k8s_terraform"
    }
  }
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.14.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.31.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.58.1"
    }
  }
}

# K8s Cluster Creds:
# - https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster#kubernetes-terraform-provider-example

provider "kubernetes" {
  host                   = data.tfe_outputs.digitalocean_nyc3_terraform.nonsensitive_values.do_k8s_host
  token                  = data.tfe_outputs.digitalocean_nyc3_terraform.values.do_k8s_token
  cluster_ca_certificate = data.tfe_outputs.digitalocean_nyc3_terraform.values.do_k8s_cluster_ca_certificate
}

provider "helm" {
  kubernetes {
    host                   = data.tfe_outputs.digitalocean_nyc3_terraform.nonsensitive_values.do_k8s_host
    token                  = data.tfe_outputs.digitalocean_nyc3_terraform.values.do_k8s_token
    cluster_ca_certificate = data.tfe_outputs.digitalocean_nyc3_terraform.values.do_k8s_cluster_ca_certificate
  }
}

provider "tfe" {}
