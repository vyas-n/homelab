
data "digitalocean_kubernetes_versions" "do_k8s" {
  # Grab the latest k8s version slug with `doctl kubernetes options versions`
  version_prefix = "1.30."
}
