# Tailscale Global Config Root

## Requirements

| Name      | Version   |
|-----------|-----------|
| terraform | >= 1.11.0 |
| tailscale | >= 0.22.0 |

## Providers

| Name      | Version |
|-----------|---------|
| tailscale | 0.25.0  |

## Resources

| Name                                                                                                                                                      | Type     |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [tailscale_contacts.global](https://registry.terraform.io/providers/tailscale/tailscale/latest/docs/resources/contacts)                                   | resource |
| [tailscale_dns_preferences.global](https://registry.terraform.io/providers/tailscale/tailscale/latest/docs/resources/dns_preferences)                     | resource |
| [tailscale_dns_search_paths.global](https://registry.terraform.io/providers/tailscale/tailscale/latest/docs/resources/dns_search_paths)                   | resource |
| [tailscale_dns_split_nameservers.homezone_hosts](https://registry.terraform.io/providers/tailscale/tailscale/latest/docs/resources/dns_split_nameservers) | resource |
| [tailscale_dns_split_nameservers.homezone_svcs](https://registry.terraform.io/providers/tailscale/tailscale/latest/docs/resources/dns_split_nameservers)  | resource |
| [tailscale_dns_split_nameservers.homezone_vms](https://registry.terraform.io/providers/tailscale/tailscale/latest/docs/resources/dns_split_nameservers)   | resource |
