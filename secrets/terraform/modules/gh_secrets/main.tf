
resource "time_rotating" "cf_pages_vyas_n_com" {
  rotation_months = 6
}

# Token allowed to edit DNS entries for all zones from specific account.
resource "cloudflare_api_token" "cf_pages_vyas_n_com" {
  name = "cf_pages_vyas_n_com"

  not_before = time_rotating.cf_pages_vyas_n_com.rfc3339
  expires_on = time_rotating.cf_pages_vyas_n_com.rotation_rfc3339

  # include all zones from specific account
  policies = [{
    effect = "allow"
    permission_groups = [{
      id = element(
        data.cloudflare_api_token_permission_groups_list.all.result,
        index(
          data.cloudflare_api_token_permission_groups_list.all.result.*.name,
          "Pages Write"
        )
      ) }, {
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
    }, {
    effect = "allow"
    permission_groups = [
      { id = element(
        data.cloudflare_api_token_permission_groups_list.all.result,
        index(
          data.cloudflare_api_token_permission_groups_list.all.result.*.name,
          "User Details Read"
        )
      ) }
    ]
    resources = {
      "com.cloudflare.api.user.${data.cloudflare_account.vyas.account_id}" = "*"
    }
  }]
}

resource "github_actions_secret" "vyas_n_cloudflare_account_id" {
  repository      = "vyas-n"
  secret_name     = "CLOUDFLARE_ACCOUNT_ID"
  plaintext_value = data.cloudflare_account.vyas.account_id
}

resource "github_actions_secret" "vyas_n_cloudflare_api_token" {
  repository      = "vyas-n"
  secret_name     = "CLOUDFLARE_API_TOKEN"
  plaintext_value = cloudflare_api_token.cf_pages_vyas_n_com.value
}

resource "github_dependabot_secret" "vyas_n_cloudflare_account_id" {
  repository      = "vyas-n"
  secret_name     = "CLOUDFLARE_ACCOUNT_ID"
  plaintext_value = data.cloudflare_account.vyas.account_id
}

resource "github_dependabot_secret" "vyas_n_cloudflare_api_token" {
  repository      = "vyas-n"
  secret_name     = "CLOUDFLARE_API_TOKEN"
  plaintext_value = cloudflare_api_token.cf_pages_vyas_n_com.value
}

# output "account_map" {
#   value = data.cloudflare_api_token_permission_groups.all.account
# }
