
output "ipv4" {
  sensitive = false

  value = local.ipv4
}

output "mac_address" {
  sensitive = false

  value = local.mac_address
}

output "hostname" {
  sensitive = false
  value     = var.hostname
}

output "fqdn" {
  sensitive = false
  value     = "${var.hostname}.${var.domain}"
}
