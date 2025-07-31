# Secrets Seeding Root

This Terraform workspace is used to sync secrets/tokens from 1Password over to the various places that they are used.
It will store its state in Terraform Cloud, but only execute locally.
The files are named after the location that the secrets are synchronized to (not necessarily the provider that the credentials are used for)

## Requirements

| Name        | Version   |
| ----------- | --------- |
| terraform   | >= 1.11.0 |
| cloudflare  | 4.52.0    |
| github      | 6.6.0     |
| onepassword | 2.1.2     |
| proxmox     | 0.73.0    |
| tfe         | 0.64.0    |
| time        | 0.12.1    |

## Providers

| Name        | Version |
| ----------- | ------- |
| onepassword | 2.1.2   |

## Modules

| Name            | Source                    | Version |
| --------------- | ------------------------- | ------- |
| gh_secrets      | ./modules/gh_secrets      | n/a     |
| proxmox_secrets | ./modules/proxmox_secrets | n/a     |
| tfe_secrets     | ./modules/tfe_secrets     | n/a     |

## Resources

| Name                                                                                                                                     | Type        |
| ---------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [onepassword_item.cloudflare_global_api_key](https://registry.terraform.io/providers/1Password/onepassword/2.1.2/docs/data-sources/item) | data source |
| [onepassword_item.github_pat_vyas_n](https://registry.terraform.io/providers/1Password/onepassword/2.1.2/docs/data-sources/item)         | data source |
| [onepassword_item.proxmox_api_token](https://registry.terraform.io/providers/1Password/onepassword/2.1.2/docs/data-sources/item)         | data source |
| [onepassword_item.tfcloud_pat](https://registry.terraform.io/providers/1Password/onepassword/2.1.2/docs/data-sources/item)               | data source |
| [onepassword_vault.private](https://registry.terraform.io/providers/1Password/onepassword/2.1.2/docs/data-sources/vault)                 | data source |

## Outputs

| Name            | Description |
| --------------- | ----------- |
| gh_secrets      | n/a         |
| proxmox_secrets | n/a         |
| tfe_secrets     | n/a         |
