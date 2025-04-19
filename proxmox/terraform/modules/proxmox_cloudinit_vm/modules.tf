
module "dns" {
  source = "./modules/unifi_host_dns_records"

  fqdn        = "${var.hostname}.${var.domain}"
  ipv4        = local.ipv4
  mac_address = local.mac_address
  name        = var.hostname
}
