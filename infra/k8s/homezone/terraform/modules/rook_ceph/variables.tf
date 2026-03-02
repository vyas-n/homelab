variable "namespace" {
  type        = string
  description = "Name of the pre-existing namespace to deploy rook-ceph operator & rook-ceph cluster into."
  sensitive   = false
}
