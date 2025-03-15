
output "nodes" {
  sensitive = false
  value     = [module.k8s_ctr_1, module.k8s_wkr_1, module.k8s_wkr_2]
}

output "hosts" {
  sensitive = false
  value     = [module.k8s_ctr_1.fqdn, module.k8s_wkr_1.fqdn, module.k8s_wkr_2.fqdn]
}
