variable "onepass_vault" {
  sensitive = true
  type = object({
    uuid : string
  })
  description = "The 1Password Vault id to grab from and store credentials in."
}

variable "zerossl_api_key" {
  sensitive   = true
  type        = string
  description = "ZeroSSL API Key to generate ACME Credentials"
}
