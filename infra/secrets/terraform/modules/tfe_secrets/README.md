# Terraform Cloud Secrets Seeding

## Requirements

| Name        | Version            |
|-------------|--------------------|
| terraform   | >= 1.11.0          |
| cloudflare  | >= 4.52.0, < 5.0.0 |
| onepassword | >= 2.1.2           |
| tfe         | >= 0.69.0          |
| time        | >= 0.13.0          |
| zerossl     | >= 0.1.1           |

## Providers

| Name        | Version            |
|-------------|--------------------|
| cloudflare  | >= 4.52.0, < 5.0.0 |
| onepassword | >= 2.1.2           |
| tfe         | >= 0.69.0          |
| time        | >= 0.13.0          |
| zerossl     | >= 0.1.1           |

## Resources

| Name                                                                                                                                                                   | Type        |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [cloudflare_api_token.homezone_cert_manager_cloudflare_api_token](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/api_token)       | resource    |
| [cloudflare_api_token.tfe_cloudflare_api_token](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/api_token)                         | resource    |
| [cloudflare_api_token.tfe_external_dns_cloudflare_api_token](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/api_token)            | resource    |
| [onepassword_item.tfe_organization_token](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/resources/item)                                    | resource    |
| [tfe_organization_token.vyas_n](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization_token)                                        | resource    |
| [tfe_variable.cloudflare_api_token](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                                              | resource    |
| [tfe_variable.digitalocean_spaces_access_key_id](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                                 | resource    |
| [tfe_variable.digitalocean_spaces_secret_access_key](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                             | resource    |
| [tfe_variable.digitalocean_token](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                                                | resource    |
| [tfe_variable.external_dns_cloudflare_api_token](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                                 | resource    |
| [tfe_variable.external_dns_unifi_secret_api_key](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                                 | resource    |
| [tfe_variable.external_secrets_onepassword_service_account_token](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                | resource    |
| [tfe_variable.homezone_cert_manager_cloudflare_api_token](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                        | resource    |
| [tfe_variable.homezone_cert_manager_zerossl_eab_hmac_key](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                        | resource    |
| [tfe_variable.homezone_cert_manager_zerossl_eab_id](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                              | resource    |
| [tfe_variable.homezone_cert_manager_zerossl_eab_kid](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                             | resource    |
| [tfe_variable.kube_client_cert_data](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                                             | resource    |
| [tfe_variable.kube_client_key_data](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                                              | resource    |
| [tfe_variable.kube_cluster_ca_cert_data](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                                         | resource    |
| [tfe_variable.kube_host](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                                                         | resource    |
| [tfe_variable.proxmox_ve_api_token](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                                              | resource    |
| [tfe_variable.proxmox_ve_endpoint](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                                               | resource    |
| [tfe_variable.proxmox_ve_ssh_private_key](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                                        | resource    |
| [tfe_variable.proxmox_ve_ssh_username](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                                           | resource    |
| [tfe_variable.tailscale_api_key](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                                                 | resource    |
| [tfe_variable.tfe_token](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                                                         | resource    |
| [tfe_variable.unifi_api](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                                                         | resource    |
| [tfe_variable.unifi_insecure](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                                                    | resource    |
| [tfe_variable.unifi_password](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                                                    | resource    |
| [tfe_variable.unifi_username](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable)                                                    | resource    |
| [time_rotating.homezone_cert_manager_cloudflare_api_token](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating)                      | resource    |
| [time_rotating.tfe_cloudflare_api_token](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating)                                        | resource    |
| [time_rotating.tfe_external_dns_cloudflare_api_token](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating)                           | resource    |
| [time_rotating.tfe_organization_token](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating)                                          | resource    |
| [zerossl_eab_credentials.homezone_cert_manager_zerossl_eab_credentials](https://registry.terraform.io/providers/toowoxx/zerossl/latest/docs/resources/eab_credentials) | resource    |
| [cloudflare_api_token_permission_groups.all](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/api_token_permission_groups)       | data source |
| [onepassword_item.digitalocean_pat_for_tfcloud_vyasn](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/data-sources/item)                     | data source |
| [onepassword_item.digitalocean_s3access_for_tfcloud_vyasn](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/data-sources/item)                | data source |
| [onepassword_item.proxmox_api_token](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/data-sources/item)                                      | data source |
| [onepassword_item.proxmox_root_ssh_key](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/data-sources/item)                                   | data source |
| [onepassword_item.tailscale_api_key_for_vyasn](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/data-sources/item)                            | data source |
| [onepassword_item.unifi_gateway_homelab](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/data-sources/item)                                  | data source |
| [onepassword_item.unifi_homezone_externaldns_apikey](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/data-sources/item)                      | data source |
| [tfe_variable_set.cloudflare](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/variable_set)                                             | data source |
| [tfe_variable_set.digitalocean](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/variable_set)                                           | data source |
| [tfe_variable_set.homezone](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/variable_set)                                               | data source |
| [tfe_variable_set.proxmox](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/variable_set)                                                | data source |
| [tfe_variable_set.tailscale](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/variable_set)                                              | data source |
| [tfe_variable_set.tfc](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/variable_set)                                                    | data source |
| [tfe_variable_set.unifi](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/variable_set)                                                  | data source |
| [tfe_workspace.k8s_homezone](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/workspace)                                                 | data source |

## Inputs

| Name            | Description                                                   | Type                        | Default | Required |
|-----------------|---------------------------------------------------------------|-----------------------------|---------|:--------:|
| onepass_vault   | The 1Password Vault id to grab from and store credentials in. | `object({ uuid : string })` | n/a     |   yes    |
| zerossl_api_key | ZeroSSL API Key to generate ACME Credentials                  | `string`                    | n/a     |   yes    |
