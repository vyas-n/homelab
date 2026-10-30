# ArgoCD module

## Requirements

| Name      | Version   |
|-----------|-----------|
| terraform | >= 1.11.0 |
| helm      | >= 3.0.2  |

## Providers

| Name | Version  |
|------|----------|
| helm | >= 3.0.2 |

## Resources

| Name                                                                                                         | Type     |
|--------------------------------------------------------------------------------------------------------------|----------|
| [helm_release.argo_cd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name                  | Description                        | Type          | Default | Required |
|-----------------------|------------------------------------|---------------|---------|:--------:|
| ingress\_annotations  | n/a                                | `map(string)` | n/a     |   yes    |
| ingress\_class        | n/a                                | `string`      | n/a     |   yes    |
| ingress\_domain       | example format: argocd.example.com | `string`      | n/a     |   yes    |
| ingress\_host         | n/a                                | `string`      | n/a     |   yes    |
| kubernetes\_namespace | n/a                                | `string`      | n/a     |   yes    |
