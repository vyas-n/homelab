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
| digitalocean | 2.71.0  |
| kubernetes   | 3.0.1   |

## Resources

| Name                                                                                                                                                    | Type        |
|---------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [kubernetes_namespace.authentik](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)                          | resource    |
| [kubernetes_namespace.traefik](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)                            | resource    |
| [digitalocean_kubernetes_cluster.do_k8s](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/kubernetes_cluster) | data source |
