# Cert Manager module

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

| Name                                                                                                              | Type     |
|-------------------------------------------------------------------------------------------------------------------|----------|
| [helm_release.cert_manager](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name                  | Description | Type     | Default | Required |
|-----------------------|-------------|----------|---------|:--------:|
| kubernetes\_namespace | n/a         | `string` | n/a     |   yes    |
