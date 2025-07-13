# Proxmox Root

## Requirements

| Name        | Version   |
| ----------- | --------- |
| terraform   | >= 1.11.0 |
| cloudinit   | 2.3.6     |
| onepassword | 2.1.2     |
| proxmox     | 0.73.0    |
| time        | 0.12.1    |
| unifi       | 0.41.2    |

## Providers

| Name        | Version |
| ----------- | ------- |
| onepassword | 2.1.2   |
| proxmox     | 0.73.0  |

## Modules

| Name      | Source                             | Version |
| --------- | ---------------------------------- | ------- |
| fedora_vm | ../../modules/proxmox_cloudinit_vm | n/a     |

## Resources

| Name                                                                                                                                                                        | Type        |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [proxmox_virtual_environment_download_file.fedora_cloud_image](https://registry.terraform.io/providers/bpg/proxmox/0.73.0/docs/resources/virtual_environment_download_file) | resource    |
| [proxmox_virtual_environment_download_file.ubuntu_cloud_image](https://registry.terraform.io/providers/bpg/proxmox/0.73.0/docs/resources/virtual_environment_download_file) | resource    |
| [onepassword_item.fast_ssh_key](https://registry.terraform.io/providers/1Password/onepassword/2.1.2/docs/data-sources/item)                                                 | data source |
| [onepassword_item.proxmox_api_token](https://registry.terraform.io/providers/1Password/onepassword/2.1.2/docs/data-sources/item)                                            | data source |
| [onepassword_item.unifi_gateway_homelab](https://registry.terraform.io/providers/1Password/onepassword/2.1.2/docs/data-sources/item)                                        | data source |
| [onepassword_vault.private](https://registry.terraform.io/providers/1Password/onepassword/2.1.2/docs/data-sources/vault)                                                    | data source |
| [proxmox_virtual_environment_node.proxmox_1](https://registry.terraform.io/providers/bpg/proxmox/0.73.0/docs/data-sources/virtual_environment_node)                         | data source |
| [proxmox_virtual_environment_node.proxmox_2](https://registry.terraform.io/providers/bpg/proxmox/0.73.0/docs/data-sources/virtual_environment_node)                         | data source |

## Outputs

| Name      | Description |
| --------- | ----------- |
| fedora_vm | n/a         |
| proxmox_1 | n/a         |
| proxmox_2 | n/a         |
