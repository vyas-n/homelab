# Cilium CNI Deployment & Config

## Requirements

| Name      | Version   |
|-----------|-----------|
| terraform | >= 1.14.2 |
| helm      | >= 3.0    |
| kubectl   | >= 1.14   |
| time      | >= 0.13.1 |

## Providers

| Name    | Version   |
|---------|-----------|
| helm    | >= 3.0    |
| kubectl | >= 1.14   |
| time    | >= 0.13.1 |

## Resources

| Name                                                                                                                                  | Type     |
|---------------------------------------------------------------------------------------------------------------------------------------|----------|
| [helm_release.cilium](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                           | resource |
| [kubectl_manifest.bgp_peering_policy_er7](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.policy1](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest)                | resource |
| [kubectl_manifest.pool1](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest)                  | resource |
| [time_sleep.wait_for_cilium](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep)                      | resource |

## Inputs

| Name                          | Description | Type     | Default | Required |
|-------------------------------|-------------|----------|---------|:--------:|
| k8s\_endpoint                 | n/a         | `string` | n/a     |   yes    |
| k8s\_loadbalancer\_cidr\_ipv4 | n/a         | `string` | n/a     |   yes    |
| k8s\_pod\_cidr                | n/a         | `string` | n/a     |   yes    |
| k8s\_service\_port            | n/a         | `number` | n/a     |   yes    |
