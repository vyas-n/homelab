# 1Pass
data "onepassword_vault" "private" {
  name = "Private"
}

# Homelab Proxmox
data "onepassword_item" "proxmox_api_token" {
  vault = data.onepassword_vault.private.uuid
  title = "Proxmox API Token (HomeLab)"
}

data "onepassword_item" "vyas_fast_key_1" {
  vault = data.onepassword_vault.private.uuid
  title = "Vyas-Fast-Key-1"
}

data "proxmox_virtual_environment_node" "proxmox_1" {
  node_name = "proxmox-1"
}

# Unifi Gateway Homelab Creds
data "onepassword_item" "unifi_gateway_homelab" {
  vault = data.onepassword_vault.private.uuid
  title = "Unifi Gateway Local User (1pass-api)"
}
