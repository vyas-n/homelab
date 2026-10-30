# Cluster-wide K8s Operators

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

| Name                                                                                                                                                     | Type     |
|----------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [helm_release.cert_manager](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                                        | resource |
| [helm_release.external_dns_cloudflare](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                             | resource |
| [helm_release.external_secrets](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                                    | resource |
| [kubectl_manifest.onepassword_homelab_cluster_secret_store](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest)  | resource |
| [kubectl_manifest.zerossl_clusterissuer](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest)                     | resource |
| [kubernetes_namespace_v1.cert_manager](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1)                  | resource |
| [kubernetes_namespace_v1.external_dns](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1)                  | resource |
| [kubernetes_namespace_v1.external_secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1)              | resource |
| [kubernetes_namespace_v1.kyverno](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1)                       | resource |
| [kubernetes_namespace_v1.policy_reporter](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1)               | resource |
| [kubernetes_namespace_v1.vertical_pod_autoscaler](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1)       | resource |
| [kubernetes_secret_v1.cert_manager_cloudflare_creds](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1)       | resource |
| [kubernetes_secret_v1.cert_manager_zerossl_eab_creds](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1)      | resource |
| [kubernetes_secret_v1.external_dns_cloudflare_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1)      | resource |
| [kubernetes_secret_v1.external_dns_unifi_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1)           | resource |
| [kubernetes_secret_v1.onepassword_homelab_service_account](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1) | resource |

## Inputs

| Name                                                    | Description | Type     | Default | Required |
|---------------------------------------------------------|-------------|----------|---------|:--------:|
| cert\_manager\_cloudflare\_api\_token                   | n/a         | `string` | n/a     |   yes    |
| cert\_manager\_zerossl\_eab\_hmac\_key                  | n/a         | `string` | n/a     |   yes    |
| cert\_manager\_zerossl\_eab\_id                         | n/a         | `string` | n/a     |   yes    |
| cert\_manager\_zerossl\_eab\_kid                        | n/a         | `string` | n/a     |   yes    |
| external\_dns\_cloudflare\_api\_token                   | n/a         | `string` | n/a     |   yes    |
| external\_dns\_unifi\_secret\_api\_key                  | n/a         | `string` | n/a     |   yes    |
| external\_secrets\_onepassword\_service\_account\_token | n/a         | `string` | n/a     |   yes    |
