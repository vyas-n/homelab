output "ingress_class" {
  type  = string
  value = var.ingress_class
}

output "tailscale_proxy_group" {
  type  = string
  value = var.tailscale_ingress_proxy_group
}

output "ingress_annotations" {
  type = map(string)
  value = {
    "tailscale.com/proxy-group" : var.tailscale_ingress_proxy_group
  }
}
