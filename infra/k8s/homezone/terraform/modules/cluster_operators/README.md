# Cluster-wide K8s Operators

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

| Name                                                                                                                                                    | Type     |
|---------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [helm_release.cert_manager](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                                       | resource |
| [helm_release.external_dns_cloudflare](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                            | resource |
| [helm_release.external_secrets](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                                   | resource |
| [helm_release.kyverno](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                                            | resource |
| [helm_release.policy_reporter](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                                    | resource |
| [helm_release.vertical_pod_autoscaler](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                            | resource |
| [kubectl_manifest.onepassword_homelab_cluster_secret_store](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.zerossl_clusterissuer](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest)                    | resource |
| [kubernetes_namespace.cert_manager](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)                       | resource |
| [kubernetes_namespace.external_dns](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)                       | resource |
| [kubernetes_namespace.external_secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)                   | resource |
| [kubernetes_namespace.kyverno](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)                            | resource |
| [kubernetes_namespace.policy_reporter](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)                    | resource |
| [kubernetes_namespace.vertical_pod_autoscaler](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)            | resource |
| [kubernetes_secret.cert_manager_cloudflare_creds](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret)            | resource |
| [kubernetes_secret.cert_manager_zerossl_eab_creds](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret)           | resource |
| [kubernetes_secret.external_dns_cloudflare_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret)           | resource |
| [kubernetes_secret.external_dns_unifi_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret)                | resource |
| [kubernetes_secret.onepassword_homelab_service_account](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret)      | resource |

## Inputs

| Name                                               | Description | Type     | Default | Required |
|----------------------------------------------------|-------------|----------|---------|:--------:|
| cert_manager_cloudflare_api_token                  | n/a         | `string` | n/a     |   yes    |
| cert_manager_zerossl_eab_hmac_key                  | n/a         | `string` | n/a     |   yes    |
| cert_manager_zerossl_eab_id                        | n/a         | `string` | n/a     |   yes    |
| cert_manager_zerossl_eab_kid                       | n/a         | `string` | n/a     |   yes    |
| external_dns_cloudflare_api_token                  | n/a         | `string` | n/a     |   yes    |
| external_dns_unifi_secret_api_key                  | n/a         | `string` | n/a     |   yes    |
| external_secrets_onepassword_service_account_token | n/a         | `string` | n/a     |   yes    |
