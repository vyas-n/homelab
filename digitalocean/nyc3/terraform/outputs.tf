
# K8s Cluster Creds:
# - https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster#kubernetes-terraform-provider-example

output "do_k8s_host" {
  description = "The URL of the API server on the Kubernetes control plane."
  sensitive   = false
  value       = digitalocean_kubernetes_cluster.do_k8s.endpoint
}

output "do_k8s_token" {
  description = "The DigitalOcean API access token used by clients to access the cluster."
  sensitive   = true
  value       = digitalocean_kubernetes_cluster.do_k8s.kube_config[0].token
}

output "do_k8s_cluster_ca_certificate" {
  description = "The public certificate for the cluster's certificate authority."
  sensitive   = false
  value = base64decode(
    digitalocean_kubernetes_cluster.do_k8s.kube_config[0].cluster_ca_certificate
  )
}
