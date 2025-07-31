variable "k8s_service_port" {
  type      = number
  sensitive = false
}
variable "k8s_endpoint" {
  type      = string
  sensitive = false
}
variable "k8s_pod_cidr" {
  type      = string
  sensitive = false
}
