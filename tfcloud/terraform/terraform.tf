/*
 * # Terraform Cloud Root
 * 
*/

terraform {
  required_version = ">= 1.11.0"
  cloud {
    organization = "vyas-n"
    workspaces {
      name = "tfcloud_terraform"
    }
  }
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.67.1"
    }
  }
}

provider "tfe" {
  organization = "vyas-n"
}
