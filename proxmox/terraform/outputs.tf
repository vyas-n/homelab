
output "k8s_ctr_nodes" {
  sensitive = false
  value     = { for node in flatten([module.k8s_ctr[*]]) : node.hostname => node }
}

output "k8s_wkr_nodes" {
  sensitive = false
  value     = { for node in flatten([module.k8s_wkr[*]]) : node.hostname => node }
}
