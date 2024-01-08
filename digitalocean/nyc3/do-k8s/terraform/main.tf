
# resource "kubernetes_namespace" "authentik" {
#   metadata {
#     name = "authentik"
#   }
# }

# resource "helm_release" "authentik" { # https://artifacthub.io/packages/helm/goauthentik/authentik
#   name       = "authentik"
#   chart      = "authentik"
#   repository = "https://charts.goauthentik.io"
#   version    = "2023.10.2"

#   namespace        = kubernetes_namespace.authentik.metadata[0].name
#   create_namespace = false
#   lint             = true
#   timeout          = 300

#   values = [
#     # remove yaml comments & formatting from diff calculations
#     yamlencode(yamldecode(file("${path.module}/helm/authentik/values.yaml"))),
#     # Override with dependent/sensitive values
#     yamlencode({
#       authentik = {
#         secret_key = data.hcp_vault_secrets_app.digitalocean_nyc3_do_k8s_terraform.secrets.authentik_secret_key
#         postgresql = {
#           password = data.hcp_vault_secrets_app.digitalocean_nyc3_do_k8s_terraform.secrets.authentik_postgresql_password
#         }
#       }
#       postgresql = {
#         postgresqlPassword = data.hcp_vault_secrets_app.digitalocean_nyc3_do_k8s_terraform.secrets.authentik_postgresql_password
#       }
#     })
#   ]
# }
