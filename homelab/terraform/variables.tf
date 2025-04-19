
variable "k8s_pod_cidr" {
  type    = string
  default = "10.244.0.0/16"
}

variable "k8s_service_cidr" {
  type    = string
  default = "10.96.0.0/12"
}

variable "k8s_service_port" {
  type    = number
  default = 6443
}

variable "k8s_endpoint" {
  type    = string
  default = "k8s-ctr-1.vms.vyas-n.dev"
}
