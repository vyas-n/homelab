
# Cloudflare
data "cloudflare_user" "me" {}
data "cloudflare_api_token_permission_groups" "all" {}
data "cloudflare_accounts" "vyas" {
  name = "Vyas"
}
