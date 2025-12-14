# Proxmox Secrets Seeding

## Requirements

| Name       | Version   |
|------------|-----------|
| terraform  | >= 1.11.0 |
| cloudflare | >= 4.52.0 |
| proxmox    | >= 0.76.0 |
| time       | >= 0.13.0 |

## Providers

| Name       | Version   |
|------------|-----------|
| cloudflare | >= 4.52.0 |
| proxmox    | >= 0.76.0 |
| time       | >= 0.13.0 |

## Resources

| Name                                                                                                                                                                    | Type        |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [cloudflare_api_token.proxmox_acme](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/api_token)                                      | resource    |
| [proxmox_virtual_environment_acme_dns_plugin.cloudflare](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_acme_dns_plugin) | resource    |
| [time_rotating.proxmox_acme](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating)                                                     | resource    |
| [cloudflare_accounts.vyas](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/accounts)                                             | data source |
| [cloudflare_api_token_permission_groups.all](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/api_token_permission_groups)        | data source |
