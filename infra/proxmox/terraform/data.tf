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

data "proxmox_virtual_environment_file" "ubuntu_2404_iso" {
  node_name    = data.proxmox_virtual_environment_node.proxmox_1.node_name
  datastore_id = "cephfs"
  content_type = "iso"
  file_name    = "ubuntu-24.04-live-server-amd64.iso"
}
