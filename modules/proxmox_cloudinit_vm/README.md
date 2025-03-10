# Proxmox Cloud-init VM Module

## Requirements

| Name      | Version   |
| --------- | --------- |
| terraform | >= 1.11.0 |
| cloudinit | 2.3.6     |
| proxmox   | 0.73.0    |

## Providers

| Name      | Version |
| --------- | ------- |
| cloudinit | 2.3.6   |
| proxmox   | 0.73.0  |

## Resources

| Name                                                                                                                                                          | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [proxmox_virtual_environment_file.user_data_cloud_config](https://registry.terraform.io/providers/bpg/proxmox/0.73.0/docs/resources/virtual_environment_file) | resource    |
| [proxmox_virtual_environment_vm.vm](https://registry.terraform.io/providers/bpg/proxmox/0.73.0/docs/resources/virtual_environment_vm)                         | resource    |
| [cloudinit_config.user_data_cloud_config](https://registry.terraform.io/providers/hashicorp/cloudinit/2.3.6/docs/data-sources/config)                         | data source |

## Inputs

| Name                | Description       | Type     | Default | Required |
| ------------------- | ----------------- | -------- | ------- | :------: |
| cloud_init_filepath | n/a               | `string` | n/a     |   yes    |
| cloud_os_image      | n/a               | `string` | n/a     |   yes    |
| disk_space          | In gigabytes (gb) | `number` | `20`    |    no    |
| hostname            | n/a               | `string` | n/a     |   yes    |
| image_datastore_id  | n/a               | `string` | n/a     |   yes    |
| memory              | In megabytes (mb) | `number` | `2048`  |    no    |
| num_cpu_cores       | n/a               | `number` | `1`     |    no    |
| proxmox_node_name   | n/a               | `string` | n/a     |   yes    |
| vm_datastore_id     | n/a               | `string` | n/a     |   yes    |

## Outputs

| Name     | Description |
| -------- | ----------- |
| hostname | n/a         |
| ipv4     | n/a         |
| ipv6     | n/a         |
