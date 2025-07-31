<!-- BEGIN_TF_DOCS -->

# Cilium CNI Deployment & Config

## Requirements

| Name       | Version |
| ---------- | ------- |
| helm       | ~> 2.6  |
| kubectl    | ~> 1.14 |
| kubernetes | ~> 2.12 |

## Providers

| Name    | Version |
| ------- | ------- |
| helm    | ~> 2.6  |
| kubectl | ~> 1.14 |
| time    | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                                  | Type     |
| ------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [helm_release.cilium](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                           | resource |
| [kubectl_manifest.bgp_peering_policy_er7](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.pool1_er7](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest)              | resource |
| [time_sleep.wait_for_cilium](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep)                      | resource |

## Inputs

| Name              | Description | Type     | Default | Required |
| ----------------- | ----------- | -------- | ------- | :------: |
| high_availability | n/a         | `bool`   | `true`  |    no    |
| k8s_endpoint      | n/a         | `string` | n/a     |   yes    |
| k8s_pod_cidr      | n/a         | `string` | n/a     |   yes    |
| k8s_service_port  | n/a         | `number` | n/a     |   yes    |

## Outputs

No outputs.

<!-- END_TF_DOCS -->
