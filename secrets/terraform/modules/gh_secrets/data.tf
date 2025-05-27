
# Cloudflare
data "cloudflare_api_token_permission_groups_list" "all" {}
data "cloudflare_account" "vyas" {
  filter = {
    name = "Vyas"
  }
}
