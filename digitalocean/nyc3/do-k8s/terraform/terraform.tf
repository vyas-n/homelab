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

# K8s Cluster Creds:
# - https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster#kubernetes-terraform-provider-example

provider "kubernetes" {
  host                   = data.tfe_outputs.digitalocean_nyc3_terraform.nonsensitive_values.host
  token                  = data.tfe_outputs.digitalocean_nyc3_terraform.values.token
  cluster_ca_certificate = data.tfe_outputs.digitalocean_nyc3_terraform.values.cluster_ca_certificate
}

provider "helm" {
  kubernetes {
    host                   = data.tfe_outputs.digitalocean_nyc3_terraform.nonsensitive_values.host
    token                  = data.tfe_outputs.digitalocean_nyc3_terraform.values.token
    cluster_ca_certificate = data.tfe_outputs.digitalocean_nyc3_terraform.values.cluster_ca_certificate
  }
}
