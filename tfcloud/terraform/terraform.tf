/*
 * # Terraform Cloud Root
 * 
*/

terraform {
  required_version = ">= 1.11.0"
  cloud {
    organization = "vyas-n"
    workspaces {
      name = "tfcloud"
    }
  }
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.68.0"
    }
  }
}

provider "tfe" {
  organization = "vyas-n"
}
