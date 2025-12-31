# Homelab Proxmox
data "proxmox_virtual_environment_node" "proxmox_0" {
  node_name = "proxmox-0"
}

data "proxmox_virtual_environment_node" "proxmox_1" {
  node_name = "proxmox-1"
}

data "proxmox_virtual_environment_node" "proxmox_2" {
  node_name = "proxmox-2"
}
