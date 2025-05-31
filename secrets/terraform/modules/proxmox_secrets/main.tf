
resource "time_rotating" "proxmox_acme" {
  rotation_months = 6
}

# Token allowed to edit DNS entries for all zones from specific account.
resource "cloudflare_api_token" "proxmox_acme" {
  name = "proxmox_acme"

  not_before = time_rotating.proxmox_acme.rfc3339
  expires_on = time_rotating.proxmox_acme.rotation_rfc3339

  # include all zones from specific account
  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.zone["DNS Write"],
    ]
    resources = {
      "com.cloudflare.api.account.*" = "*"
    }
  }
}

resource "proxmox_virtual_environment_acme_dns_plugin" "cloudflare" {
  plugin = "cloudflare"
  api    = "cf"
  data = {
    CF_Account_ID = data.cloudflare_accounts.vyas.accounts[0].id
    CF_Token      = cloudflare_api_token.proxmox_acme.value
  }
}
