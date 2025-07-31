# Terraform Cloud Secrets Seeding

## Providers

| Name        | Version |
| ----------- | ------- |
| cloudflare  | 5.1.0   |
| onepassword | 2.1.2   |
| tfe         | 0.64.0  |
| time        | 0.13.0  |

## Resources

| Name                                                                                                                                                             | Type        |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [cloudflare_api_token.tfe_cloudflare_api_token](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/api_token)                   | resource    |
| [onepassword_item.tfe_organization_token](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/resources/item)                              | resource    |
| [tfe_organization_token.vyas_n](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization_token)                                  | resource    |
| [tfe_variable.cloudflare_api_token](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                                        | resource    |
| [tfe_variable.digitalocean_spaces_access_key_id](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                           | resource    |
| [tfe_variable.digitalocean_spaces_secret_access_key](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                       | resource    |
| [tfe_variable.digitalocean_token](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                                          | resource    |
| [tfe_variable.onepass_connect_access_token](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                                | resource    |
| [tfe_variable.onepass_connect_credentials_json](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                            | resource    |
| [tfe_variable.tfe_token](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                                                   | resource    |
| [tfe_variable_set.cloudflare](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set)                                          | resource    |
| [tfe_variable_set.digitalocean](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set)                                        | resource    |
| [tfe_variable_set.onepass_connect_server_bedrock](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set)                      | resource    |
| [tfe_variable_set.tfc](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set)                                                 | resource    |
| [time_rotating.tfe_cloudflare_api_token](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating)                                  | resource    |
| [time_rotating.tfe_organization_token](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating)                                    | resource    |
| [cloudflare_api_token_permission_groups.all](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/api_token_permission_groups) | data source |
| [cloudflare_user.me](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/user)                                                | data source |
| [onepassword_item.digitalocean_pat_for_tfcloud_vyasn](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/data-sources/item)               | data source |
| [onepassword_item.digitalocean_s3access_for_tfcloud_vyasn](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/data-sources/item)          | data source |
| [onepassword_item.onepass_connect_access_token](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/data-sources/item)                     | data source |
| [onepassword_item.onepass_connect_credentials_json](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/data-sources/item)                 | data source |
| [onepassword_vault.private](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/data-sources/vault)                                        | data source |
