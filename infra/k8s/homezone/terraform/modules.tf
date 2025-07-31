
module "cilium" {
  source = "./modules/cilium"

  k8s_service_port = var.k8s_service_port
  k8s_endpoint     = var.k8s_endpoint
  k8s_pod_cidr     = var.k8s_pod_cidr

  depends_on = [
    helm_release.prometheus_operator_crds
  ]
}

module "cluster_operators" {
  source = "./modules/cluster_operators"

  external_secrets_onepassword_service_account_token = var.external_secrets_onepassword_service_account_token

  cert_manager_cloudflare_api_token = var.cert_manager_cloudflare_api_token
  cert_manager_zerossl_eab_id       = var.cert_manager_zerossl_eab_id
  cert_manager_zerossl_eab_kid      = var.cert_manager_zerossl_eab_kid
  cert_manager_zerossl_eab_hmac_key = var.cert_manager_zerossl_eab_hmac_key

  depends_on = [
    module.cilium,
    helm_release.prometheus_operator_crds
  ]
}

# module "rook_ceph" {
#   source = "./modules/rook_ceph"

#   depends_on = [
#     module.cilium,
#     module.cluster_operators,
#     helm_release.prometheus_operator_crds
#   ]
# }

# module "cluster_services" {
#   source = "./modules/cluster_services"

#   depends_on = [
#     module.cluster_operators,
#     module.cilium,
#     helm_release.prometheus_operator_crds
#   ]
# }

# module "monitoring_stack" {
#   source = "./modules/monitoring_stack"

#   depends_on = [
#     helm_release.prometheus_operator_crds,
#     module.rook_ceph,
#     module.cluster_operators,
#     module.cilium
#   ]
# }
