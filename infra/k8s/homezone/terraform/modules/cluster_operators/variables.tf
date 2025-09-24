variable "external_secrets_onepassword_service_account_token" {
  sensitive = true
  type      = string
}

variable "external_dns_unifi_secret_api_key" {
  sensitive = true
  type      = string
}

variable "cert_manager_cloudflare_api_token" {
  sensitive = true
  type      = string
}

variable "cert_manager_zerossl_eab_id" {
  sensitive = false
  type      = string
}

variable "cert_manager_zerossl_eab_kid" {
  sensitive = true
  type      = string
}

variable "cert_manager_zerossl_eab_hmac_key" {
  sensitive = true
  type      = string
}
