<!-- BEGIN_TF_DOCS -->

# Cluster-wide K8s Operators

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

| Name                                                                                                                                           | Type     |
| ---------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [helm_release.cert_manager](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                              | resource |
| [helm_release.external_dns](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                              | resource |
| [helm_release.external_secrets](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                          | resource |
| [helm_release.kyverno](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                                   | resource |
| [helm_release.vertical_pod_autoscaler](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                   | resource |
| [kubectl_manifest.aws_nonprod_secretstore](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest)         | resource |
| [kubectl_manifest.cert_manager_zerossl_eab_creds](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest)  | resource |
| [kubectl_manifest.zerossl_clusterissuer](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest)           | resource |
| [kubernetes_namespace.cert_manager](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)              | resource |
| [kubernetes_namespace.external_dns](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)              | resource |
| [kubernetes_namespace.external_secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)          | resource |
| [kubernetes_namespace.kyverno](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)                   | resource |
| [kubernetes_namespace.vertical_pod_autoscaler](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)   | resource |
| [kubernetes_secret.cert_manager_aws_creds](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret)          | resource |
| [kubernetes_secret.external_dns_aws_access_key](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret)     | resource |
| [kubernetes_secret.external_secrets_aws_access_key](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |

## Inputs

| Name                                | Description | Type     | Default | Required |
| ----------------------------------- | ----------- | -------- | ------- | :------: |
| cert_manager_aws_iam_access_key     | n/a         | `string` | n/a     |   yes    |
| cert_manager_aws_iam_secret_key     | n/a         | `string` | n/a     |   yes    |
| external_dns_aws_iam_access_key     | n/a         | `string` | n/a     |   yes    |
| external_dns_aws_iam_secret_key     | n/a         | `string` | n/a     |   yes    |
| external_secrets_aws_iam_access_key | n/a         | `string` | n/a     |   yes    |
| external_secrets_aws_iam_secret_key | n/a         | `string` | n/a     |   yes    |

## Outputs

No outputs.

<!-- END_TF_DOCS -->
