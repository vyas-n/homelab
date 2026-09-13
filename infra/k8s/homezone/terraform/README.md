# HomeZone k8s cluster Root

## Requirements

| Name       | Version   |
|------------|-----------|
| terraform  | >= 1.11.0 |
| helm       | >= 2.17.0 |
| kubectl    | >= 1.19.0 |
| kubernetes | >= 2.37.1 |

## Providers

| Name       | Version |
|------------|---------|
| helm       | 3.1.1   |
| kubectl    | 1.19.0  |
| kubernetes | 3.0.1   |

## Modules

| Name               | Source                      | Version |
|--------------------|-----------------------------|---------|
| cilium             | ./modules/cilium            | n/a     |
| cluster\_operators | ./modules/cluster_operators | n/a     |
| cluster\_services  | ./modules/cluster_services  | n/a     |
| monitoring\_stack  | ./modules/monitoring_stack  | n/a     |
| rook\_ceph         | ./modules/rook_ceph         | n/a     |

## Resources

| Name                                                                                                                               | Type     |
|------------------------------------------------------------------------------------------------------------------------------------|----------|
| [helm_release.prometheus_operator_crds](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)      | resource |
| [kubectl_manifest.k0s_service_monitor](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace.rook_ceph](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)     | resource |

## Inputs

| Name                                                    | Description | Type     | Default                      | Required |
|---------------------------------------------------------|-------------|----------|------------------------------|:--------:|
| cert\_manager\_cloudflare\_api\_token                   | n/a         | `string` | n/a                          |   yes    |
| cert\_manager\_zerossl\_eab\_hmac\_key                  | n/a         | `string` | n/a                          |   yes    |
| cert\_manager\_zerossl\_eab\_id                         | n/a         | `string` | n/a                          |   yes    |
| cert\_manager\_zerossl\_eab\_kid                        | n/a         | `string` | n/a                          |   yes    |
| external\_dns\_cloudflare\_api\_token                   | n/a         | `string` | n/a                          |   yes    |
| external\_dns\_unifi\_secret\_api\_key                  | n/a         | `string` | n/a                          |   yes    |
| external\_secrets\_onepassword\_service\_account\_token | n/a         | `string` | n/a                          |   yes    |
| kube\_client\_cert\_data                                | n/a         | `string` | n/a                          |   yes    |
| kube\_client\_key\_data                                 | n/a         | `string` | n/a                          |   yes    |
| kube\_cluster\_ca\_cert\_data                           | n/a         | `string` | n/a                          |   yes    |
| kube\_host                                              | n/a         | `string` | n/a                          |   yes    |
| k8s\_endpoint                                           | n/a         | `string` | `"k8s-ctr-0.vms.vyas-n.dev"` |    no    |
| k8s\_loadbalancer\_cidr\_ipv4                           | n/a         | `string` | `"192.168.5.128/25"`         |    no    |
| k8s\_pod\_cidr                                          | n/a         | `string` | `"10.244.0.0/16"`            |    no    |
| k8s\_service\_cidr                                      | n/a         | `string` | `"10.96.0.0/12"`             |    no    |
| k8s\_service\_port                                      | n/a         | `number` | `6443`                       |    no    |
