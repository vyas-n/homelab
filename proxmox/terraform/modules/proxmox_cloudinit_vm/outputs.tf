
locals {
  # Filter out loopback ipv4 address
  # ref: https://en.wikipedia.org/wiki/Loopback#Virtual_loopback_interface
  ipv4 = [
    for ipv4 in flatten(proxmox_virtual_environment_vm.vm.ipv4_addresses) : ipv4 if !startswith(ipv4, "127.0.0.1")
  ][0]

  # Filter out loop-back macaddress
  mac_address = [
    for mac_address in proxmox_virtual_environment_vm.vm.mac_addresses : mac_address if !startswith(mac_address, "00:00:00:00:00:00")
  ][0]
}

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
