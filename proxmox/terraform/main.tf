
resource "proxmox_virtual_environment_download_file" "fedora_41" {
  content_type       = "iso"
  datastore_id       = "cephfs"
  node_name          = data.proxmox_virtual_environment_node.proxmox_2.node_name
  url                = "https://download.fedoraproject.org/pub/fedora/linux/releases/41/Cloud/x86_64/images/Fedora-Cloud-Base-Generic-41-1.4.x86_64.qcow2"
  file_name          = "Fedora-Cloud-Base-Generic-41-1.4.x86_64.img"
  checksum           = "6205ae0c524b4d1816dbd3573ce29b5c44ed26c9fbc874fbe48c41c89dd0bac2"
  checksum_algorithm = "sha256"
}

resource "proxmox_virtual_environment_download_file" "ubuntu_jammy_current" {
  content_type = "iso"
  datastore_id = "cephfs"
  node_name    = data.proxmox_virtual_environment_node.proxmox_2.node_name
  url          = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}
