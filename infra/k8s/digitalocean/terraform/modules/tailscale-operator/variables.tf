variable "kubernetes_namespace" {
  type = string
}

variable "ingress_class" {
  type    = string
  default = "tailscale"
}

variable "tailscale_proxy_group" {
  type    = string
  default = "ingress-proxies"
}
