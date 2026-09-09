removed {
  from = module.proxmox_secrets.proxmox_virtual_environment_acme_dns_plugin.cloudflare

  lifecycle {
    destroy = false
  }
}
