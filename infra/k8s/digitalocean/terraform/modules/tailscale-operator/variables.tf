variable "kubernetes_namespace" {
  type = string
}

variable "ingress_class" {
  type    = string
  default = "tailscale"
}

variable "tailscale_ingress_proxy_group" {
  type    = string
  default = "ingress-proxies"
}

variable "tailscale_egress_proxy_group" {
  type    = string
  default = "egress-proxies"
}
