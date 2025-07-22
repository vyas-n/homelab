resource "zerossl_eab_credentials" "homezone_cert_manager_zerossl_eab_credentials" {
  api_key = var.zerossl_api_key
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
