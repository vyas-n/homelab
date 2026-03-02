# UniFi Host DNS Records Module

## Requirements

| Name      | Version   |
|-----------|-----------|
| terraform | >= 1.11.0 |
| unifi     | >= 0.41.3 |

## Providers

| Name  | Version   |
|-------|-----------|
| unifi | >= 0.41.3 |

## Resources

| Name                                                                                                                        | Type     |
|-----------------------------------------------------------------------------------------------------------------------------|----------|
| [unifi_client.client_device](https://registry.terraform.io/providers/ubiquiti-community/unifi/latest/docs/resources/client) | resource |

## Inputs

| Name        | Description | Type     | Default | Required |
|-------------|-------------|----------|---------|:--------:|
| fqdn        | n/a         | `string` | n/a     |   yes    |
| ipv4        | n/a         | `string` | n/a     |   yes    |
| mac_address | n/a         | `string` | n/a     |   yes    |
| name        | n/a         | `string` | n/a     |   yes    |

## Outputs

| Name        | Description |
|-------------|-------------|
| fqdn        | n/a         |
| hostname    | n/a         |
| ipv4        | n/a         |
| mac_address | n/a         |
