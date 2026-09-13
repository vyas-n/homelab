# Tailscale operator module

## Requirements

| Name       | Version   |
|------------|-----------|
| terraform  | >= 1.11.0 |
| helm       | >= 3.0.2  |
| kubectl    | >= 1.19.0 |
| kubernetes | >= 2.38.0 |
| tailscale  | >= 0.22.0 |

## Providers

| Name       | Version   |
|------------|-----------|
| helm       | >= 3.0.2  |
| kubectl    | >= 1.19.0 |
| kubernetes | >= 2.38.0 |
| tailscale  | >= 0.22.0 |

## Resources

| Name                                                                                                                                            | Type     |
|-------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [helm_release.tailscale_operator](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                         | resource |
| [kubectl_manifest.tailscale_ingress_proxy_group](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest)    | resource |
| [kubernetes_secret_v1.operator_oauth](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1)             | resource |
| [tailscale_oauth_client.k8s_tailscale_operator](https://registry.terraform.io/providers/tailscale/tailscale/latest/docs/resources/oauth_client) | resource |

## Inputs

| Name                    | Description | Type     | Default             | Required |
|-------------------------|-------------|----------|---------------------|:--------:|
| kubernetes\_namespace   | n/a         | `string` | n/a                 |   yes    |
| ingress\_class          | n/a         | `string` | `"tailscale"`       |    no    |
| tailscale\_proxy\_group | n/a         | `string` | `"ingress-proxies"` |    no    |

## Outputs

| Name                    | Description |
|-------------------------|-------------|
| ingress\_annotations    | n/a         |
| ingress\_class          | n/a         |
| tailscale\_proxy\_group | n/a         |
