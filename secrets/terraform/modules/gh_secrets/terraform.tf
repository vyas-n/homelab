/*
 * # GitHub Actions Secrets Seeding
 *
*/

terraform {
  required_version = ">= 1.11.0"
  required_providers {
    time = {
      source  = "hashicorp/time"
      version = ">= 0.13.0"
    }
    github = {
      source  = "integrations/github"
      version = ">= 6.6.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 4.52.0"
    }
  }
}
