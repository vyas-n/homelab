# Networking
resource "unifi_user" "tplink_managed_switch_1" {
  mac  = "5c:62:8b:40:36:2c"
  name = "TP-Link Managed Switch 1"

  fixed_ip         = "192.168.2.38"
  local_dns_record = "tplink-switch-1.hosts.vyas-n.dev"
}

# TrueNAS

resource "unifi_user" "proxmox_1_ipmi" {
  mac  = "9c:6b:00:13:4a:a7"
  name = "Proxmox 1 (IPMI)"

  fixed_ip         = "192.168.2.164"
  local_dns_record = "proxmox-1-ipmi.hosts.vyas-n.dev"
}

resource "unifi_user" "truenas" {
  mac  = "b0:19:21:e3:c5:f0"
  name = "TrueNAS"

  fixed_ip         = "192.168.2.244"
  local_dns_record = "truenas.hosts.vyas-n.dev"
}

# Proxmox
resource "unifi_user" "proxmox_1" {
  mac  = "9c:6b:00:13:4a:12"
  name = "Proxmox 1"

  fixed_ip         = "192.168.2.16"
  local_dns_record = "proxmox-1.hosts.vyas-n.dev"
}

resource "unifi_user" "proxmox_0" {
  mac  = "a4:ae:11:19:b4:26"
  name = "Proxmox 0"

  fixed_ip         = "192.168.2.7"
  local_dns_record = "proxmox-0.hosts.vyas-n.dev"
}
