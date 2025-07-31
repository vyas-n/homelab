# GitHub Actions Secrets Seeding

## Providers

| Name       | Version |
| ---------- | ------- |
| cloudflare | 5.1.0   |
| github     | 6.6.0   |
| time       | 0.13.0  |

## Resources

| Name                                                                                                                                                             | Type        |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [cloudflare_api_token.cf_pages_vyas_n_com](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/api_token)                        | resource    |
| [github_actions_secret.vyas_n_cloudflare_account_id](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret)           | resource    |
| [github_actions_secret.vyas_n_cloudflare_api_token](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret)            | resource    |
| [github_dependabot_secret.vyas_n_cloudflare_account_id](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/dependabot_secret)     | resource    |
| [github_dependabot_secret.vyas_n_cloudflare_api_token](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/dependabot_secret)      | resource    |
| [time_rotating.cf_pages_vyas_n_com](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating)                                       | resource    |
| [cloudflare_accounts.vyas](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/accounts)                                      | data source |
| [cloudflare_api_token_permission_groups.all](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/api_token_permission_groups) | data source |
| [cloudflare_user.me](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/user)                                                | data source |
