
# ref: https://tailscale.com/docs/kubernetes-operator/quickstart#prerequisites
resource "tailscale_oauth_client" "k8s_tailscale_operator" {
  description = "digitalocean-k8s-tailscale-operator"
  scopes = [
    "services",
    "devices:core",
    "auth_keys",
  ]
  tags = ["tag:k8s-operator"]
}

resource "kubernetes_secret_v1" "operator_oauth" {
  metadata {
    # Has to be this name b/c helm chart hardcode's this secret name.
    name      = "operator-oauth"
    namespace = var.kubernetes_namespace
  }
  data = {
    client_id     = tailscale_oauth_client.k8s_tailscale_operator.id
    client_secret = tailscale_oauth_client.k8s_tailscale_operator.key
  }
}

# ref: https://artifacthub.io/packages/helm/tailscale/tailscale-operator
resource "helm_release" "tailscale_operator" {
  chart      = "tailscale-operator"
  repository = "https://pkgs.tailscale.com/helmcharts"
  name       = "tailscale-operator"
  version    = "1.102.3"
  namespace  = var.kubernetes_namespace
  lint       = true
  wait       = true

  values = [yamlencode({
    ingressClass = {
      name    = var.ingress_class
      enabled = true
    }
  })]

  depends_on = [kubernetes_secret_v1.operator_oauth]
}

resource "kubectl_manifest" "tailscale_ingress_proxy_group" {
  yaml_body = yamlencode({
    apiVersion = "tailscale.com/v1alpha1"
    kind       = "ProxyGroup"
    metadata = {
      name      = var.tailscale_ingress_proxy_group
      namespace = var.kubernetes_namespace
    }
    spec = {
      type     = "ingress"
      replicas = 2
    }
  })

  wait              = true
  server_side_apply = true

  depends_on = [helm_release.tailscale_operator]
}

resource "kubectl_manifest" "tailscale_egress_proxy_group" {
  yaml_body = yamlencode({
    apiVersion = "tailscale.com/v1alpha1"
    kind       = "ProxyGroup"
    metadata = {
      name      = var.tailscale_egress_proxy_group
      namespace = var.kubernetes_namespace
    }
    spec = {
      type     = "egress"
      replicas = 2
    }
  })

  wait              = true
  server_side_apply = true

  depends_on = [helm_release.tailscale_operator]
}

resource "kubernetes_manifest" "tailscale_dns_nameserver" {
  manifest = {
    apiVersion = "tailscale.com/v1alpha1"
    kind       = "DNSConfig"
    metadata = {
      name = "ts-dns"
    }
    spec = {
      nameserver = {
        image = {
          repo : "tailscale/k8s-nameserver"
          tag : "unstable"
        }
      }
    }
  }

  depends_on = [helm_release.tailscale_operator, kubectl_manifest.tailscale_egress_proxy_group]
}

data "kubernetes_resource" "tailscale_dns_nameserver" {
  api_version = kubernetes_manifest.tailscale_dns_nameserver.object.apiVersion
  kind        = kubernetes_manifest.tailscale_dns_nameserver.object.kind
  metadata {
    name = kubernetes_manifest.tailscale_dns_nameserver.object.metadata[0].name
  }
}

# Setup coredns in-cluster to use this DNS server
# ref:
# - https://tailscale.com/docs/kubernetes-operator/egress/enable-magicdns-resolution#configure-coredns
# - https://techdocs.akamai.com/cloud-computing/docs/coredns-custom-config#custom-coredns-configuration
resource "kubernetes_config_map_v1" "coredns_custom" {
  metadata {
    name      = "coredns-custom"
    namespace = "kube-system"
  }
  data = {
    "tailscale.server" = <<-EOT
      ts.net:53 {
          errors
          cache 30
          forward . ${data.kubernetes_resource.tailscale_dns_nameserver.object.status.nameserver.ip}
      }
    EOT
  }
}
