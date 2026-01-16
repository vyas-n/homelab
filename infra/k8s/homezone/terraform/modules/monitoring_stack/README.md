# Monitoring Stack

## Requirements

| Name       | Version   |
|------------|-----------|
| terraform  | >= 1.14.2 |
| helm       | >= 3.0    |
| kubectl    | >= 1.14   |
| kubernetes | >= 2.12   |

## Providers

| Name       | Version |
|------------|---------|
| helm       | >= 3.0  |
| kubectl    | >= 1.14 |
| kubernetes | >= 2.12 |

## Resources

| Name                                                                                                                                             | Type     |
|--------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [helm_release.kube_prometheus_stack](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                       | resource |
| [helm_release.loki](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                                        | resource |
| [helm_release.promtail](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                                    | resource |
| [kubectl_manifest.loki_bucket](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest)                       | resource |
| [kubectl_manifest.loki_grafana_datasource](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest)           | resource |
| [kubernetes_namespace_v1.kube_prometheus_stack](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |
| [kubernetes_namespace_v1.loki](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1)                  | resource |
