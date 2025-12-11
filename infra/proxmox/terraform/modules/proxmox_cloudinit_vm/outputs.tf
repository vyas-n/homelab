
output "ipv4" {
  sensitive = false

  value = module.dns.ipv4
}

output "mac_address" {
  sensitive = false

  value = module.dns.mac_address
}

output "hostname" {
  sensitive = false
  value     = module.dns.hostname
}

output "fqdn" {
  sensitive = false
  value     = module.dns.fqdn
}
