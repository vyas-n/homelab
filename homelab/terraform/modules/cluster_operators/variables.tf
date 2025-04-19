variable "external_secrets_aws_iam_access_key" {
  sensitive = true
  type      = string
}
variable "external_secrets_aws_iam_secret_key" {
  sensitive = true
  type      = string
}

variable "external_dns_aws_iam_access_key" {
  sensitive = true
  type      = string
}
variable "external_dns_aws_iam_secret_key" {
  sensitive = true
  type      = string
}

variable "cert_manager_aws_iam_access_key" {
  sensitive = true
  type      = string
}
variable "cert_manager_aws_iam_secret_key" {
  sensitive = true
  type      = string
}
