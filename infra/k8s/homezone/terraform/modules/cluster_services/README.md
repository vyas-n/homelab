# Cluster-wide Services

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

| Name                                                                                                                                          | Type     |
|-----------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [helm_release.argo_cd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                                  | resource |
| [helm_release.stackgres_operator](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                       | resource |
| [kubernetes_ingress_v1.stackgres_operator](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1)     | resource |
| [kubernetes_namespace_v1.argo_cd](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1)            | resource |
| [kubernetes_namespace_v1.stackgres_operator](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |
