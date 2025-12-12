# Secrets Seeding Root

This Terraform workspace is used to sync secrets/tokens from 1Password over to the various places that they are used.
It will store its state in Terraform Cloud, but only execute locally.
The files are named after the location that the secrets are synchronized to (not necessarily the provider that the credentials are used for)

## Requirements

| Name        | Version           |
|-------------|-------------------|
| terraform   | >= 1.11.0         |
| cloudflare  | < 5.0.0           |
| github      | = 6.7.5           |
| onepassword | >= 2.1.2, < 3.0.0 |
| proxmox     | >= 0.83.2         |
| tfe         | >= 0.69.0         |
| time        | >= 0.13.1         |
| zerossl     | >= 0.1.1          |

## Providers

| Name        | Version |
|-------------|---------|
| onepassword | 2.2.1   |

## Modules

| Name            | Source                    | Version |
|-----------------|---------------------------|---------|
| gh_secrets      | ./modules/gh_secrets      | n/a     |
| proxmox_secrets | ./modules/proxmox_secrets | n/a     |
| tfe_secrets     | ./modules/tfe_secrets     | n/a     |

## Resources

| Name                                                                                                                                      | Type        |
|-------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [onepassword_item.cloudflare_global_api_key](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/data-sources/item) | data source |
| [onepassword_item.gh_pat](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/data-sources/item)                    | data source |
| [onepassword_item.proxmox_api_token](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/data-sources/item)         | data source |
| [onepassword_item.tfcloud_pat](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/data-sources/item)               | data source |
| [onepassword_item.zerossl_api_key](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/data-sources/item)           | data source |
| [onepassword_vault.private](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/data-sources/vault)                 | data source |

## Outputs

| Name            | Description |
|-----------------|-------------|
| gh_secrets      | n/a         |
| proxmox_secrets | n/a         |
| tfe_secrets     | n/a         |
