# Proxmox Root

## Requirements

| Name       | Version   |
|------------|-----------|
| terraform  | >= 1.11.0 |
| cloudflare | >= 5.0.0  |
| cloudinit  | >= 2.3.6  |
| proxmox    | >= 0.73.0 |
| time       | >= 0.13.0 |
| unifi      | >= 0.41.2 |

## Providers

| Name       | Version |
|------------|---------|
| cloudflare | 5.18.0  |
| proxmox    | 0.101.1 |

## Modules

| Name             | Source                         | Version |
|------------------|--------------------------------|---------|
| docker_server_0  | ./modules/proxmox_cloudinit_vm | n/a     |
| k8s_ctr          | ./modules/proxmox_cloudinit_vm | n/a     |
| k8s_wkr          | ./modules/proxmox_cloudinit_vm | n/a     |
| k8s_wkr_proxmox0 | ./modules/proxmox_cloudinit_vm | n/a     |
| k8s_wkr_proxmox2 | ./modules/proxmox_cloudinit_vm | n/a     |

## Resources

| Name                                                                                                                                                                   | Type        |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [cloudflare_dns_record.homezone_vrrp](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record)                                  | resource    |
| [cloudflare_dns_record.pet_0](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record)                                          | resource    |
| [proxmox_virtual_environment_download_file.fedora_41](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_download_file)     | resource    |
| [proxmox_virtual_environment_download_file.fedora_43_1_6](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_download_file) | resource    |
| [proxmox_virtual_environment_file.ubuntu_2404_iso](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/data-sources/virtual_environment_file)              | data source |
| [proxmox_virtual_environment_node.proxmox_0](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/data-sources/virtual_environment_node)                    | data source |
| [proxmox_virtual_environment_node.proxmox_1](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/data-sources/virtual_environment_node)                    | data source |
| [proxmox_virtual_environment_node.proxmox_2](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/data-sources/virtual_environment_node)                    | data source |

## Inputs

| Name                       | Description | Type     | Default | Required |
|----------------------------|-------------|----------|---------|:--------:|
| proxmox_ve_ssh_private_key | n/a         | `string` | n/a     |   yes    |

## Outputs

| Name          | Description |
|---------------|-------------|
| k8s_ctr_nodes | n/a         |
| k8s_wkr_nodes | n/a         |
