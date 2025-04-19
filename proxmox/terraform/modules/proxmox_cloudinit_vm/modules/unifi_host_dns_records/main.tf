
resource "unifi_user" "client_device" {
  mac  = var.mac_address
  name = var.name

  fixed_ip         = var.ipv4
  local_dns_record = var.fqdn
}
