# TODO: find a way to convert import-external-cluster.sh into a set of CRDs

output "storage_class_rwo" {
  # TODO: dynamically pull this from the cluster
  value = "ceph-rbd"
}
