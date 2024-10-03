
terraform {
  cloud {
    organization = "vyas-n"
    workspaces {
      name = "tfcloud_terraform"
    }
  }
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.59.0"
    }
  }
}

provider "tfe" {
  organization = "vyas-n"
}
