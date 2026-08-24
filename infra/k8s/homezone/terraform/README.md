# HomeZone k8s cluster Root

## Requirements

| Name       | Version   |
|------------|-----------|
| terraform  | >= 1.11.0 |
| argocd     | >= 7.15.3 |
| helm       | >= 2.17.0 |
| kubectl    | >= 1.19.0 |
| kubernetes | >= 2.37.1 |
| time       | >= 0.13.1 |

## Providers

| Name       | Version |
|------------|---------|
| helm       | 3.1.1   |
| kubectl    | 1.19.0  |
| kubernetes | 3.0.1   |

## Modules

| Name              | Source                      | Version |
|-------------------|-----------------------------|---------|
| cilium            | ./modules/cilium            | n/a     |
| cluster_operators | ./modules/cluster_operators | n/a     |
| cluster_services  | ./modules/cluster_services  | n/a     |
| monitoring_stack  | ./modules/monitoring_stack  | n/a     |
| rook_ceph         | ./modules/rook_ceph         | n/a     |

## Resources

| Name                                                                                                                               | Type        |
|------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [helm_release.prometheus_operator_crds](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)      | resource    |
| [kubectl_manifest.k0s_service_monitor](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource    |
| [kubernetes_namespace.rook_ceph](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)     | resource    |
| [kubernetes_secret_v1.argo_creds](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/secret_v1) | data source |

## Inputs

| Name                                               | Description | Type     | Default                      | Required |
|----------------------------------------------------|-------------|----------|------------------------------|:--------:|
| cert_manager_cloudflare_api_token                  | n/a         | `string` | n/a                          |   yes    |
| cert_manager_zerossl_eab_hmac_key                  | n/a         | `string` | n/a                          |   yes    |
| cert_manager_zerossl_eab_id                        | n/a         | `string` | n/a                          |   yes    |
| cert_manager_zerossl_eab_kid                       | n/a         | `string` | n/a                          |   yes    |
| external_dns_cloudflare_api_token                  | n/a         | `string` | n/a                          |   yes    |
| external_dns_unifi_secret_api_key                  | n/a         | `string` | n/a                          |   yes    |
| external_secrets_onepassword_service_account_token | n/a         | `string` | n/a                          |   yes    |
| kube_client_cert_data                              | n/a         | `string` | n/a                          |   yes    |
| kube_client_key_data                               | n/a         | `string` | n/a                          |   yes    |
| kube_cluster_ca_cert_data                          | n/a         | `string` | n/a                          |   yes    |
| kube_host                                          | n/a         | `string` | n/a                          |   yes    |
| k8s_endpoint                                       | n/a         | `string` | `"k8s-ctr-0.vms.vyas-n.dev"` |    no    |
| k8s_loadbalancer_cidr_ipv4                         | n/a         | `string` | `"192.168.5.128/25"`         |    no    |
| k8s_pod_cidr                                       | n/a         | `string` | `"10.244.0.0/16"`            |    no    |
| k8s_service_cidr                                   | n/a         | `string` | `"10.96.0.0/12"`             |    no    |
| k8s_service_port                                   | n/a         | `number` | `6443`                       |    no    |
