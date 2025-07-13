# DigitalOcean do-k8s Root

## Requirements

| Name       | Version |
| ---------- | ------- |
| helm       | 2.17.0  |
| kubectl    | 1.19.0  |
| kubernetes | 2.36.0  |
| tfe        | 0.64.0  |

## Providers

| Name       | Version |
| ---------- | ------- |
| helm       | 2.17.0  |
| kubernetes | 2.36.0  |
| tfe        | 0.64.0  |

## Resources

| Name                                                                                                                                            | Type        |
| ----------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [helm_release.authentik](https://registry.terraform.io/providers/hashicorp/helm/2.17.0/docs/resources/release)                                  | resource    |
| [helm_release.external_secrets](https://registry.terraform.io/providers/hashicorp/helm/2.17.0/docs/resources/release)                           | resource    |
| [helm_release.onepassconnect](https://registry.terraform.io/providers/hashicorp/helm/2.17.0/docs/resources/release)                             | resource    |
| [kubernetes_namespace.authentik](https://registry.terraform.io/providers/hashicorp/kubernetes/2.36.0/docs/resources/namespace)                  | resource    |
| [kubernetes_namespace.external_secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/2.36.0/docs/resources/namespace)           | resource    |
| [kubernetes_namespace.onepassconnect](https://registry.terraform.io/providers/hashicorp/kubernetes/2.36.0/docs/resources/namespace)             | resource    |
| [kubernetes_namespace.traefik](https://registry.terraform.io/providers/hashicorp/kubernetes/2.36.0/docs/resources/namespace)                    | resource    |
| [kubernetes_secret.onepass_connect_credentials_json](https://registry.terraform.io/providers/hashicorp/kubernetes/2.36.0/docs/resources/secret) | resource    |
| [kubernetes_secret.onepassword_connect_access_token](https://registry.terraform.io/providers/hashicorp/kubernetes/2.36.0/docs/resources/secret) | resource    |
| [tfe_outputs.digitalocean_nyc3_terraform](https://registry.terraform.io/providers/hashicorp/tfe/0.64.0/docs/data-sources/outputs)               | data source |

## Inputs

| Name                         | Description | Type  | Default | Required |
| ---------------------------- | ----------- | ----- | ------- | :------: |
| onepassword_access_token     | n/a         | `any` | n/a     |   yes    |
| onepassword_credentials_json | n/a         | `any` | n/a     |   yes    |
