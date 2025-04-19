<!-- BEGIN_TF_DOCS -->

# Rook Ceph CSI Deployment & Config

## Requirements

| Name       | Version |
| ---------- | ------- |
| helm       | ~> 2.6  |
| kubernetes | ~> 2.12 |

## Providers

| Name       | Version |
| ---------- | ------- |
| helm       | ~> 2.6  |
| kubernetes | ~> 2.12 |

## Modules

No modules.

## Resources

| Name                                                                                                                                    | Type     |
| --------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [helm_release.rook_ceph_cluster](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                  | resource |
| [helm_release.rook_ceph_operator](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                 | resource |
| [kubernetes_namespace.rook_ceph](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)          | resource |
| [kubernetes_namespace.rook_ceph_operator](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |

## Inputs

No inputs.

## Outputs

No outputs.

<!-- END_TF_DOCS -->
