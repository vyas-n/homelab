/*
 * # DigitalOcean do-k8s Root
 * 
*/

terraform {
  required_version = ">= 1.11.0"
  cloud {
    organization = "vyas-n"
    workspaces {
      name = "digitalocean_nyc3_do_k8s_terraform"
    }
  }
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.36.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.19.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.64.0"
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

provider "kubectl" {
  host                   = data.tfe_outputs.digitalocean_nyc3_terraform.nonsensitive_values.do_k8s_host
  token                  = data.tfe_outputs.digitalocean_nyc3_terraform.values.do_k8s_token
  cluster_ca_certificate = data.tfe_outputs.digitalocean_nyc3_terraform.values.do_k8s_cluster_ca_certificate
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    host                   = data.tfe_outputs.digitalocean_nyc3_terraform.nonsensitive_values.do_k8s_host
    token                  = data.tfe_outputs.digitalocean_nyc3_terraform.values.do_k8s_token
    cluster_ca_certificate = data.tfe_outputs.digitalocean_nyc3_terraform.values.do_k8s_cluster_ca_certificate
  }
}

provider "tfe" {}
