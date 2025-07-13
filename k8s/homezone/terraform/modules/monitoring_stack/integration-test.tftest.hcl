# Terraform Test ref: https://developer.hashicorp.com/terraform/language/tests

provider "kubectl" {
  config_path    = "~/.kube/config"
  config_context = "k3d-k3s-default"
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "k3d-k3s-default"
}

provider "helm" {
  kubernetes = {
    config_path    = "~/.kube/config"
    config_context = "k3d-k3s-default"
  }
}

run "valid_helm_deploy" {

  command = apply

  assert {
    condition     = helm_release.kube_prometheus_stack.name == "kube-prometheus-stack"
    error_message = "kube_prometheus_stack didn't deploy correctly"
  }

}
