
output "ipv4" {
  sensitive = false
  value = proxmox_virtual_environment_vm.vm.ipv4_addresses[1][0]
}

output "ipv6" {
  sensitive = false
  value = proxmox_virtual_environment_vm.vm.ipv6_addresses[1][0]
}

output "hostname" {
  sensitive = false
  value = var.hostname
}
