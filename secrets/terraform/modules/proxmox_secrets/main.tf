
resource "time_rotating" "proxmox_acme" {
  rotation_months = 6
}

# Token allowed to edit DNS entries for all zones from specific account.
resource "cloudflare_api_token" "proxmox_acme" {
  name = "proxmox_acme"

  not_before = time_rotating.proxmox_acme.rfc3339
  expires_on = time_rotating.proxmox_acme.rotation_rfc3339

  # include all zones from specific account
  policies = [{
    effect = "allow"
    permission_groups = [{
      # Note: Cloudflare made some very questionable decisions with their terraform provider API.
      # ref: https://github.com/cloudflare/terraform-provider-cloudflare/issues/5062#issuecomment-2749703161
      id = element(
        data.cloudflare_api_token_permission_groups_list.all.result,
        index(
          data.cloudflare_api_token_permission_groups_list.all.result.*.name,
          "DNS Write"
        )
      ) }
    ]
    resources = {
      "com.cloudflare.api.account.*" = "*"
    }
  }]
}

resource "proxmox_virtual_environment_acme_dns_plugin" "cloudflare" {
  plugin = "cloudflare"
  api    = "cf"
  data = {
    CF_Account_ID = data.cloudflare_account.vyas.account_id
    CF_Token      = cloudflare_api_token.proxmox_acme.value
  }
}
