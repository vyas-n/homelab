
## DigitalOcean
variable "digitalocean_token" {
  sensitive = true
  type      = string
}

variable "digitalocean_spaces_access_key_id" {
  sensitive = true
  type      = string
}

variable "digitalocean_spaces_secret_access_key" {
  sensitive = true
  type      = string
}
