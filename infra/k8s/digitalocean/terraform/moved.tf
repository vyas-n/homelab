moved {
  from = helm_release.tailscale_operator
  to   = module.tailscale_operator.helm_release.tailscale_operator
}

moved {
  from = kubernetes_secret_v1.operator_oauth
  to   = module.tailscale_operator.kubernetes_secret_v1.operator_oauth
}

moved {
  from = tailscale_oauth_client.k8s_tailscale_operator
  to   = module.tailscale_operator.tailscale_oauth_client.k8s_tailscale_operator
}
