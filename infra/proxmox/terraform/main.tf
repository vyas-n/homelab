
resource "proxmox_virtual_environment_download_file" "fedora_41" {
  content_type       = "iso"
  datastore_id       = "cephfs"
  node_name          = data.proxmox_virtual_environment_node.proxmox_1.node_name
  url                = "https://download.fedoraproject.org/pub/fedora/linux/releases/41/Cloud/x86_64/images/Fedora-Cloud-Base-Generic-41-1.4.x86_64.qcow2"
  file_name          = "Fedora-Cloud-Base-Generic-41-1.4.x86_64.img"
  checksum           = "6205ae0c524b4d1816dbd3573ce29b5c44ed26c9fbc874fbe48c41c89dd0bac2"
  checksum_algorithm = "sha256"
}

resource "proxmox_virtual_environment_download_file" "fedora_43_1_6" {
  content_type       = "iso"
  datastore_id       = "cephfs"
  node_name          = data.proxmox_virtual_environment_node.proxmox_1.node_name
  url                = "https://download.fedoraproject.org/pub/fedora/linux/releases/43/Cloud/x86_64/images/Fedora-Cloud-Base-Generic-43-1.6.x86_64.qcow2"
  file_name          = "Fedora-Cloud-Base-Generic-43-1.6.x86_64.img"
  checksum           = "846574c8a97cd2d8dc1f231062d73107cc85cbbbda56335e264a46e3a6c8ab2f"
  checksum_algorithm = "sha256"
}

resource "cloudflare_dns_record" "pet_0" {
  for_each = {
    "homepage.svc" : {}
    "netbox.svc" : {}
    "wud.svc" : {}
    "dockhand.svc" : {}
  }
  name = each.key
  type = "A"
  ttl  = 300

  # TODO: dynamic lookup of this value
  zone_id = "a78dfca2a263cf049cd9f5af4d6affd7"
  content = "192.168.2.6"
}

resource "cloudflare_dns_record" "homezone_vrrp" {
  name = "homezone-v1.svc"
  type = "A"
  ttl  = 300

  # TODO: dynamic lookup of this value
  zone_id = "a78dfca2a263cf049cd9f5af4d6affd7"
  content = "192.168.5.7"
}
