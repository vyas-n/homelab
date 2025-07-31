
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
  default = "k8s-ctr-0.vms.vyas-n.dev"
}

variable "external_secrets_onepassword_service_account_token" {
  sensitive = true
  type      = string
}

variable "kube_host" {
  sensitive = false
  type      = string
}

variable "kube_cluster_ca_cert_data" {
  sensitive = true
  type      = string
}

variable "kube_client_cert_data" {
  sensitive = true
  type      = string
}

variable "kube_client_key_data" {
  sensitive = true
  type      = string
}

variable "cert_manager_cloudflare_api_token" {
  sensitive = true
  type      = string
}

variable "cert_manager_zerossl_eab_id" {
  sensitive = false
  type      = string
}

variable "cert_manager_zerossl_eab_kid" {
  sensitive = true
  type      = string
}

variable "cert_manager_zerossl_eab_hmac_key" {
  sensitive = true
  type      = string
}
