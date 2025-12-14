# Cluster-wide Services

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
| kubernetes | >= 2.12 |

## Resources

| Name                                                                                                                                    | Type     |
|-----------------------------------------------------------------------------------------------------------------------------------------|----------|
| [helm_release.argo_cd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                            | resource |
| [kubernetes_namespace.argo_cd](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)            | resource |
| [kubernetes_namespace.stackgres_operator](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
