
terraform {
  cloud {
    organization = "vyas-n"

    workspaces {
      name = "deploy_vault"
    }
  }

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3"
    }
  }
}

provider "vault" {
  # Configuration options
}

