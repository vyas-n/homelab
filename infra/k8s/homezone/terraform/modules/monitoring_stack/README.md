# Monitoring Stack

## Requirements

| Name       | Version   |
|------------|-----------|
| terraform  | >= 1.14.2 |
| helm       | >= 3.0    |
| kubernetes | >= 2.12   |

## Providers

| Name       | Version |
|------------|---------|
| helm       | >= 3.0  |
| kubernetes | >= 2.12 |

## Resources

| Name                                                                                                                                             | Type     |
|--------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [helm_release.kube_prometheus_stack](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                       | resource |
| [kubernetes_namespace_v1.kube_prometheus_stack](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |
