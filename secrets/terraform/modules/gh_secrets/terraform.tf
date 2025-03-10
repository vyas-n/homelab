/*
 * # GitHub Actions Secrets Seeding 
 * 
*/

terraform {
  required_providers {
    time = {
      source = "hashicorp/time"
    }
    github = {
      source = "integrations/github"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}
