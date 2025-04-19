<!-- BEGIN_TF_DOCS -->

# Monitoring Stack

## Requirements

| Name       | Version |
| ---------- | ------- |
| helm       | ~> 2.6  |
| kubectl    | ~> 1.14 |
| kubernetes | ~> 2.12 |

## Providers

| Name       | Version |
| ---------- | ------- |
| helm       | ~> 2.6  |
| kubectl    | ~> 1.14 |
| kubernetes | ~> 2.12 |

## Modules

No modules.

## Resources

| Name                                                                                                                                       | Type     |
| ------------------------------------------------------------------------------------------------------------------------------------------ | -------- |
| [helm_release.kube_prometheus_stack](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                 | resource |
| [helm_release.loki](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                                  | resource |
| [helm_release.promtail](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                              | resource |
| [kubectl_manifest.loki_bucket](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest)                 | resource |
| [kubectl_manifest.loki_grafana_datasource](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest)     | resource |
| [kubernetes_namespace.kube_prometheus_stack](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.loki](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)                  | resource |

## Inputs

No inputs.

## Outputs

No outputs.

<!-- END_TF_DOCS -->
