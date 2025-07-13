
output "fqdn" {
  sensitive = false
  value     = unifi_user.client_device.local_dns_record
}

output "mac_address" {
  sensitive = false
  value     = unifi_user.client_device.mac
}

output "ipv4" {
  sensitive = false
  value     = unifi_user.client_device.fixed_ip
}

output "hostname" {
  sensitive = false
  # TODO: currently the unifi_user.client_device.hostname value is wrong
  value = unifi_user.client_device.name
}
