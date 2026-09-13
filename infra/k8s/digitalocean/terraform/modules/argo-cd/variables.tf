variable "kubernetes_namespace" {
  type = string
}

variable "ingress_class" {
  type = string
}

variable "ingress_annotations" {
  type = map(string)
}

variable "ingress_host" {
  type = string
}

variable "ingress_domain" {
  description = "example format: argocd.example.com"

  type = string
}
