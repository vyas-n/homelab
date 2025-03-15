<!-- BEGIN_TF_DOCS -->

# Cluster-wide Services

## Requirements

| Name       | Version |
| ---------- | ------- |
| helm       | ~> 2.6  |
| kubectl    | ~> 1.14 |
| kubernetes | ~> 2.12 |
| sdm        | ~> 9.0  |

## Providers

| Name       | Version |
| ---------- | ------- |
| helm       | ~> 2.6  |
| kubectl    | ~> 1.14 |
| kubernetes | ~> 2.12 |
| sdm        | ~> 9.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                                     | Type     |
| ---------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [helm_release.argo_cd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                             | resource |
| [helm_release.sdm_relay](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                           | resource |
| [kubectl_manifest.deploy_app](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest)                | resource |
| [kubectl_manifest.repo_creds_externalsecret](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace.argo_cd](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)             | resource |
| [kubernetes_namespace.sdm_relay](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)           | resource |
| [kubernetes_secret.deploy_repo](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret)               | resource |
| [sdm_node.devzone_v2_needham](https://registry.terraform.io/providers/strongdm/sdm/latest/docs/resources/node)                           | resource |

## Inputs

No inputs.

## Outputs

No outputs.

<!-- END_TF_DOCS -->
