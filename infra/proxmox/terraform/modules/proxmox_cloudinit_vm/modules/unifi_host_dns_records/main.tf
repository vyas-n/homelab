
resource "unifi_client" "client_device" {
  mac  = var.mac_address
  name = var.name

  allow_existing   = true
  fixed_ip         = var.ipv4
  local_dns_record = var.fqdn
}
