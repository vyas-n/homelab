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
      version = "~> 2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = ">= 0"
    }
    tfe = {
      version = "~> 0"
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

provider "hcp" {
  project_id = "dc8b19f6-5748-4906-a1a3-b23307440a80"
}

provider "tfe" {
  # Configuration options
}
