# DigitalOcean do-k8s Root

## Requirements

| Name         | Version   |
|--------------|-----------|
| terraform    | >= 1.11.0 |
| digitalocean | >= 2.67.0 |
| helm         | >= 3.0.2  |
| kubectl      | >= 1.19.0 |
| kubernetes   | >= 2.38.0 |
| tailscale    | >= 0.22.0 |

## Providers

| Name         | Version |
|--------------|---------|
| digitalocean | 2.100.0 |
| kubernetes   | 3.2.1   |

## Modules

| Name                | Source                       | Version |
|---------------------|------------------------------|---------|
| argo\_cd            | ./modules/argo-cd            | n/a     |
| cert\_manager       | ./modules/cert-manager       | n/a     |
| tailscale\_operator | ./modules/tailscale-operator | n/a     |

## Resources

| Name                                                                                                                                                    | Type        |
|---------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [kubernetes_namespace_v1.argocd](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1)                       | resource    |
| [kubernetes_namespace_v1.cert_manager](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1)                 | resource    |
| [kubernetes_namespace_v1.tailscale](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1)                    | resource    |
| [digitalocean_kubernetes_cluster.do_k8s](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/kubernetes_cluster) | data source |
