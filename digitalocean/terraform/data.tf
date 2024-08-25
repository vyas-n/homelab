# This file shows all the resources in DigitalOcean that aren't managed by the Terraform config

data "digitalocean_project" "default" {
  name = "Default"
}

data "digitalocean_ssh_key" "vyas_fast_key_1" {
  name = "Vyas-Fast-Key-1"
}
