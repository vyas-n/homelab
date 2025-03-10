
output "ipv4" {
  sensitive = false

  # Filter out loopback ipv4 address
  # ref: https://en.wikipedia.org/wiki/Loopback#Virtual_loopback_interface
  value = [
    for ipv4 in proxmox_virtual_environment_vm.vm.ipv4_addresses[1] : ipv4 if !startswith(ipv4, "127.0.0.1")
  ][0]
}

output "ipv6" {
  sensitive = false

  # Filter out link-local ipv6 addresses
  # ref: https://en.wikipedia.org/wiki/Link-local_address#IPv6
  value = [
    for ipv6 in proxmox_virtual_environment_vm.vm.ipv6_addresses[1] : ipv6 if !startswith(ipv6, "fe80:")
  ][0]
}

output "mac_address" {
  sensitive = false

  # Filter out loop-back macaddress
  value = [
    for mac_address in proxmox_virtual_environment_vm.vm.mac_addresses : mac_address if !startswith(mac_address, "00:00:00:00:00:00")
  ][0]
}

output "hostname" {
  sensitive = false
  value     = var.hostname
}
