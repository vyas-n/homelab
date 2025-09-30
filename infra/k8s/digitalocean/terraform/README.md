# DigitalOcean do-k8s Root

## Requirements

| Name         | Version   |
|--------------|-----------|
| terraform    | >= 1.11.0 |
| digitalocean | >= 2.67.0 |
| helm         | >= 3.0.2  |
| kubectl      | >= 1.19.0 |
| kubernetes   | >= 2.38.0 |

## Providers

| Name         | Version |
|--------------|---------|
| digitalocean | 2.67.0  |
| helm         | 3.0.2   |
| kubernetes   | 2.38.0  |

## Resources

| Name                                                                                                                                                    | Type        |
|---------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [helm_release.external_secrets](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                                   | resource    |
| [helm_release.onepassconnect](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                                     | resource    |
| [kubernetes_namespace.authentik](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)                          | resource    |
| [kubernetes_namespace.external_secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)                   | resource    |
| [kubernetes_namespace.onepassconnect](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)                     | resource    |
| [kubernetes_namespace.traefik](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)                            | resource    |
| [kubernetes_secret.onepass_connect_credentials_json](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret)         | resource    |
| [kubernetes_secret.onepassword_connect_access_token](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret)         | resource    |
| [digitalocean_kubernetes_cluster.do_k8s](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/kubernetes_cluster) | data source |

## Inputs

| Name                         | Description | Type     | Default | Required |
|------------------------------|-------------|----------|---------|:--------:|
| onepassword_access_token     | n/a         | `string` | n/a     |   yes    |
| onepassword_credentials_json | n/a         | `string` | n/a     |   yes    |
