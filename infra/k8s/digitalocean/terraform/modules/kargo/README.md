# Kargo module

## Requirements

| Name      | Version   |
|-----------|-----------|
| terraform | >= 1.11.0 |
| helm      | >= 3.0.2  |
| random    | >= 3.9.1  |

## Providers

| Name       | Version  |
|------------|----------|
| helm       | >= 3.0.2 |
| kubernetes | n/a      |
| random     | >= 3.9.1 |

## Resources

| Name                                                                                                                                     | Type     |
|------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [helm_release.kargo](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                               | resource |
| [kubernetes_secret_v1.admin_account_creds](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1) | resource |
| [random_password.admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password)                | resource |
| [random_password.signing_key](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password)                   | resource |

## Inputs

| Name                  | Description                        | Type          | Default | Required |
|-----------------------|------------------------------------|---------------|---------|:--------:|
| ingress\_annotations  | n/a                                | `map(string)` | n/a     |   yes    |
| ingress\_class        | n/a                                | `string`      | n/a     |   yes    |
| ingress\_domain       | example format: argocd.example.com | `string`      | n/a     |   yes    |
| ingress\_host         | n/a                                | `string`      | n/a     |   yes    |
| kubernetes\_namespace | n/a                                | `string`      | n/a     |   yes    |

## Outputs

| Name                            | Description |
|---------------------------------|-------------|
| admin\_password                 | n/a         |
| admin\_token\_signing\_key      | n/a         |
| admin\_token\_signing\_key\_b64 | n/a         |
