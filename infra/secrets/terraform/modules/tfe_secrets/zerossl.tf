resource "zerossl_eab_credentials" "homezone_cert_manager_zerossl_eab_credentials" {
  api_key = var.zerossl_api_key
}



resource "time_rotating" "homezone_cert_manager_cloudflare_api_token" {
  rotation_months = 6
}

# Token allowed to edit DNS entries for all zones from specific account.
resource "cloudflare_api_token" "homezone_cert_manager_cloudflare_api_token" {
  name = "homezone_cert_manager_cloudflare_api_token"

  not_before = time_rotating.tfe_cloudflare_api_token.rfc3339
  expires_on = time_rotating.tfe_cloudflare_api_token.rotation_rfc3339

  # include all zones from specific account
  # ref: https://cert-manager.io/docs/configuration/acme/dns01/cloudflare/#api-tokens
  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.zone["DNS Write"],
      data.cloudflare_api_token_permission_groups.all.zone["Zone Read"],
    ]
    resources = {
      "com.cloudflare.api.account.*" = "*"
    }
  }
}

resource "tfe_variable" "homezone_cert_manager_cloudflare_api_token" {
  key          = "cert_manager_cloudflare_api_token"
  value        = cloudflare_api_token.tfe_cloudflare_api_token.value
  category     = "terraform"
  sensitive    = true
  workspace_id = data.tfe_workspace.k8s_homezone.id
}

resource "tfe_variable" "homezone_cert_manager_zerossl_eab_hmac_key" {
  key          = "cert_manager_zerossl_eab_hmac_key"
  value        = zerossl_eab_credentials.homezone_cert_manager_zerossl_eab_credentials.hmac_key
  category     = "terraform"
  sensitive    = true
  workspace_id = data.tfe_workspace.k8s_homezone.id
}

resource "tfe_variable" "homezone_cert_manager_zerossl_eab_id" {
  key          = "cert_manager_zerossl_eab_id"
  value        = zerossl_eab_credentials.homezone_cert_manager_zerossl_eab_credentials.id
  category     = "terraform"
  sensitive    = false
  workspace_id = data.tfe_workspace.k8s_homezone.id
}

resource "tfe_variable" "homezone_cert_manager_zerossl_eab_kid" {
  key          = "cert_manager_zerossl_eab_kid"
  value        = zerossl_eab_credentials.homezone_cert_manager_zerossl_eab_credentials.kid
  category     = "terraform"
  sensitive    = true
  workspace_id = data.tfe_workspace.k8s_homezone.id
}
