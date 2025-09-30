# Proxmox Cloud-init VM Module

## Requirements

| Name      | Version   |
|-----------|-----------|
| terraform | >= 1.11.0 |
| cloudinit | >= 2.3.7  |
| proxmox   | >= 0.84.0 |

## Providers

| Name      | Version   |
|-----------|-----------|
| cloudinit | >= 2.3.7  |
| proxmox   | >= 0.84.0 |

## Modules

| Name | Source                           | Version |
|------|----------------------------------|---------|
| dns  | ./modules/unifi_host_dns_records | n/a     |

## Resources

| Name                                                                                                                                                          | Type        |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [proxmox_virtual_environment_file.user_data_cloud_config](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_file) | resource    |
| [proxmox_virtual_environment_vm.vm](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm)                         | resource    |
| [cloudinit_config.user_data_cloud_config](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config)                        | data source |

## Inputs

| Name                 | Description                                          | Type     | Default       | Required |
|----------------------|------------------------------------------------------|----------|---------------|:--------:|
| cloud_init_filepath  | n/a                                                  | `string` | n/a           |   yes    |
| cloud_os_image       | n/a                                                  | `string` | n/a           |   yes    |
| domain               | n/a                                                  | `string` | n/a           |   yes    |
| hostname             | n/a                                                  | `string` | n/a           |   yes    |
| proxmox_node_name    | n/a                                                  | `string` | n/a           |   yes    |
| snippet_datastore_id | ID of the datastore to host VM's cloud-init snippet. | `string` | n/a           |   yes    |
| vm_datastore_id      | ID of the datastore to host VM's OS & EFI Disks.     | `string` | n/a           |   yes    |
| cpu_type             | n/a                                                  | `string` | `"x86-64-v3"` |    no    |
| disk_space           | In gigabytes (gb)                                    | `number` | `20`          |    no    |
| memory               | In megabytes (mb)                                    | `number` | `2048`        |    no    |
| num_cpu_cores        | n/a                                                  | `number` | `1`           |    no    |

## Outputs

| Name        | Description |
|-------------|-------------|
| fqdn        | n/a         |
| hostname    | n/a         |
| ipv4        | n/a         |
| mac_address | n/a         |
