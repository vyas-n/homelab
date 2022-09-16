
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
  address = "https://vault.vyas-n.com"
  # Configuration options
}

resource "vault_mount" "kv" {
  path = "kv"
  type = "kv-v2"
  # description = "This is an example mount"
}
