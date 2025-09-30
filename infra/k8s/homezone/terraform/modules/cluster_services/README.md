# Cluster-wide Services

## Requirements

| Name       | Version |
|------------|---------|
| helm       | >= 3.0  |
| kubectl    | >= 1.14 |
| kubernetes | >= 2.12 |

## Providers

| Name       | Version |
|------------|---------|
| helm       | >= 3.0  |
| kubectl    | >= 1.14 |
| kubernetes | >= 2.12 |

## Resources

| Name                                                                                                                                      | Type     |
|-------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [helm_release.argo_cd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                              | resource |
| [helm_release.stackgres_operator](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                   | resource |
| [kubectl_manifest.deploy_app](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest)                 | resource |
| [kubectl_manifest.repo_creds_externalsecret](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest)  | resource |
| [kubernetes_ingress_v1.stackgres_operator](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_namespace.argo_cd](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)              | resource |
| [kubernetes_namespace.stackgres_operator](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)   | resource |
| [kubernetes_secret.deploy_repo](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret)                | resource |
