
resource "proxmox_virtual_environment_download_file" "fedora_cloud_image" {
  content_type = "iso"
  datastore_id = "proxmox-smb-from-truenas"
  node_name    = "proxmox-2"
  url          = "https://download.fedoraproject.org/pub/fedora/linux/releases/41/Cloud/x86_64/images/Fedora-Cloud-Base-Generic-41-1.4.x86_64.qcow2"
  file_name    = "Fedora-Cloud-Base-Generic-41-1.4.x86_64.img"
  checksum = "6205ae0c524b4d1816dbd3573ce29b5c44ed26c9fbc874fbe48c41c89dd0bac2"
  checksum_algorithm = "sha256"
}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "iso"
  datastore_id = "proxmox-smb-from-truenas"
  node_name    = "proxmox-2"
  url          = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}
