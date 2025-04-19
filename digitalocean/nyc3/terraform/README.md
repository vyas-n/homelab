# DigitalOcean NYC3 Root

## Requirements

| Name         | Version |
| ------------ | ------- |
| digitalocean | 2.49.1  |

## Providers

| Name         | Version |
| ------------ | ------- |
| digitalocean | 2.49.1  |

## Resources

| Name                                                                                                                                                      | Type        |
| --------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [digitalocean_kubernetes_cluster.do_k8s](https://registry.terraform.io/providers/digitalocean/digitalocean/2.49.1/docs/resources/kubernetes_cluster)      | resource    |
| [digitalocean_kubernetes_node_pool.pool1](https://registry.terraform.io/providers/digitalocean/digitalocean/2.49.1/docs/resources/kubernetes_node_pool)   | resource    |
| [digitalocean_project.bedrock](https://registry.terraform.io/providers/digitalocean/digitalocean/2.49.1/docs/resources/project)                           | resource    |
| [digitalocean_project_resources.bedrock](https://registry.terraform.io/providers/digitalocean/digitalocean/2.49.1/docs/resources/project_resources)       | resource    |
| [digitalocean_kubernetes_versions.do_k8s](https://registry.terraform.io/providers/digitalocean/digitalocean/2.49.1/docs/data-sources/kubernetes_versions) | data source |

## Outputs

| Name                          | Description                                                              |
| ----------------------------- | ------------------------------------------------------------------------ |
| do_k8s_cluster_ca_certificate | The public certificate for the cluster's certificate authority.          |
| do_k8s_host                   | The URL of the API server on the Kubernetes control plane.               |
| do_k8s_token                  | The DigitalOcean API access token used by clients to access the cluster. |
