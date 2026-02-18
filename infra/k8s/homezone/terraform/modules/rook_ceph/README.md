# Rook Ceph CSI Deployment & Config

This module has a few manual steps involved. In particular you need to:

1. Run this export step on the proxmox cluster running Ceph: https://www.rook.io/docs/rook/v1.19/CRDs/Cluster/external-cluster/provider-export/?h=export
2. terraform apply this module
3. Run this import step on the kubernetes cluster using the exported variables: https://www.rook.io/docs/rook/v1.19/CRDs/Cluster/external-cluster/consumer-import/

## Requirements

| Name      | Version   |
|-----------|-----------|
| terraform | >= 1.14.2 |
| helm      | >= 3.0    |

## Providers

| Name | Version |
|------|---------|
| helm | >= 3.0  |

## Resources

| Name                                                                                                                    | Type     |
|-------------------------------------------------------------------------------------------------------------------------|----------|
| [helm_release.rook_ceph_cluster](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)  | resource |
| [helm_release.rook_ceph_operator](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name           | Description | Type     | Default | Required |
|----------------|-------------|----------|---------|:--------:|
| namespace_name | n/a         | `string` | n/a     |   yes    |
