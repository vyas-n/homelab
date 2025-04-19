# 1Pass
data "onepassword_vault" "private" {
  name = "Private"
}

# Unifi Gateway Homelab Creds
data "onepassword_item" "unifi_gateway_homelab" {
  vault = data.onepassword_vault.private.uuid
  title = "Unifi Gateway Local User (1pass-api)"
}

# TrueNAS DNS Record
# data "unifi_dns_record" "truenas" {
#   name = ""
# }
