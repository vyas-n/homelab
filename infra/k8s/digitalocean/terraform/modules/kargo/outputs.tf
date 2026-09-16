output "admin_password" {
  sensitive = true
  value     = random_password.admin_password.result
}

output "admin_token_signing_key" {
  sensitive = true
  value     = random_password.signing_key.result
}

output "admin_token_signing_key_b64" {
  sensitive = true
  value     = base64encode(random_password.signing_key.result)
}
