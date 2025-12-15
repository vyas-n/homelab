# Proxmox Root

## Requirements

| Name      | Version   |
|-----------|-----------|
| terraform | >= 1.11.0 |
| cloudinit | >= 2.3.6  |
| proxmox   | >= 0.73.0 |
| time      | >= 0.13.0 |
| unifi     | >= 0.41.2 |

## Providers

| Name    | Version |
|---------|---------|
| proxmox | 0.89.1  |

## Modules

| Name             | Source                         | Version |
|------------------|--------------------------------|---------|
| k8s_ctr          | ./modules/proxmox_cloudinit_vm | n/a     |
| k8s_wkr          | ./modules/proxmox_cloudinit_vm | n/a     |
| k8s_wkr_proxmox0 | ./modules/proxmox_cloudinit_vm | n/a     |

## Resources

| Name                                                                                                                                                               | Type        |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [proxmox_virtual_environment_download_file.fedora_41](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_download_file) | resource    |
| [proxmox_virtual_environment_node.proxmox_0](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/data-sources/virtual_environment_node)                | data source |
| [proxmox_virtual_environment_node.proxmox_1](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/data-sources/virtual_environment_node)                | data source |

## Inputs

| Name                       | Description | Type     | Default | Required |
|----------------------------|-------------|----------|---------|:--------:|
| proxmox_ve_ssh_private_key | n/a         | `string` | n/a     |   yes    |

## Outputs

| Name          | Description |
|---------------|-------------|
| k8s_ctr_nodes | n/a         |
| k8s_wkr_nodes | n/a         |
