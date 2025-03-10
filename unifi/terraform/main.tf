# Networking
resource "unifi_user" "tplink_managed_switch_1" {
  mac  = "5c:62:8b:40:36:2c"
  name = "TP-Link Managed Switch 1"

  fixed_ip         = "192.168.2.38"
  local_dns_record = "tplink-switch-1.hosts.vyas-n.dev"
}

# TrueNAS

resource "unifi_user" "truenas_ipmi" {
  mac  = "9c:6b:00:13:4a:a7"
  name = "TrueNAS (IPMI)"

  fixed_ip         = "192.168.2.164"
  local_dns_record = "truenas-ipmi.hosts.vyas-n.dev"
}

resource "unifi_user" "truenas" {
  mac  = "6e:c3:83:7e:e6:0d"
  name = "TrueNAS"

  fixed_ip         = "192.168.2.244"
  local_dns_record = "truenas.hosts.vyas-n.dev"
}

# Proxmox

resource "unifi_user" "proxmox_1" {
  mac  = "00:24:27:88:9f:78"
  name = "Proxmox 1"

  fixed_ip         = "192.168.2.17"
  local_dns_record = "proxmox-1.hosts.vyas-n.dev"
}

# TODO: Error: not found
# resource "unifi_user" "proxmox_2" {
#   mac  = "b0:19:21:e3:c5:f0"
#   name = "Proxmox 2"

#   fixed_ip = "192.168.2.78"
#   local_dns_record = "proxmox-2.hosts.vyas-n.dev"
# }
