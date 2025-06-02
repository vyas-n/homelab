
resource "kubernetes_namespace" "external_secrets" {
  metadata {
    name = "external-secrets"
  }
}

resource "helm_release" "external_secrets" { # https://artifacthub.io/packages/helm/external-secrets-operator/external-secrets
  name       = "external-secrets"
  chart      = "external-secrets"
  repository = "https://charts.external-secrets.io"
  version    = "0.17.0"

  namespace        = kubernetes_namespace.external_secrets.metadata[0].name
  create_namespace = false
  lint             = true
  timeout          = 300

  values = [
    yamlencode(yamldecode(file("${path.module}/helm/external-secrets/values.yaml"))), # remove yaml comments & formatting from diff calculations
    yamlencode({})
  ]
}

resource "kubernetes_secret" "onepassword_homelab_service_account" {
  metadata {
    name      = "onepassword-homelab-service-account"
    namespace = kubernetes_namespace.external_secrets.metadata[0].name
  }
  type = "Opaque"
  data = {
    token = var.external_secrets_onepassword_service_account_token
  }
}

resource "kubectl_manifest" "onepassword_homelab_cluster_secret_store" {
  yaml_body = yamlencode({
    apiVersion = "external-secrets.io/v1"
    kind       = "ClusterSecretStore"
    metadata = {
      name = "onepassword-homelab"
    }
    spec = {
      provider = {
        onepasswordSDK = {
          vault = "HomeLab"
          auth = {
            serviceAccountSecretRef = {
              name = kubernetes_secret.onepassword_homelab_service_account.metadata[0].name
              namespace = kubernetes_namespace.external_secrets.metadata[0].name
              key = "token"
            }
          }
        }
      }
    }
  })
  server_side_apply = true

  depends_on = [helm_release.external_secrets]
}

# resource "kubernetes_namespace" "cert_manager" {
#   metadata {
#     name = "cert-manager"
#     labels = {
#       # fix webhook validation issues
#       # ref: https://github.com/cert-manager/cert-manager/issues/6864#issuecomment-2027293360
#       "cert-manager.io/disable-validation" : true
#     }
#   }
# }

# resource "helm_release" "cert_manager" { # https://artifacthub.io/packages/helm/cert-manager/cert-manager
#   name       = "cert-manager"
#   chart      = "cert-manager"
#   repository = "https://charts.jetstack.io"
#   version    = "1.15.3"

#   namespace        = kubernetes_namespace.cert_manager.metadata[0].name
#   create_namespace = false
#   lint             = true
#   timeout          = 300

#   values = [
#     yamlencode(yamldecode(file("${path.module}/helm/cert-manager/values.yaml"))), # remove yaml comments & formatting from diff calculations
#     yamlencode({})
#   ]
# }

# resource "kubernetes_secret" "cert_manager_aws_creds" {
#   metadata {
#     name      = "cert-manager-aws-creds"
#     namespace = kubernetes_namespace.cert_manager.metadata[0].name
#   }
#   type = "Opaque"
#   data = {
#     aws_access_key_id     = var.cert_manager_aws_iam_access_key
#     aws_secret_access_key = var.cert_manager_aws_iam_secret_key
#   }
# }

# resource "kubectl_manifest" "cert_manager_zerossl_eab_creds" {
#   yaml_body = yamlencode({
#     apiVersion = "external-secrets.io/v1beta1"
#     kind       = "ExternalSecret"
#     metadata = {
#       name      = "cert-manager-zerossl-eab-creds"
#       namespace = kubernetes_namespace.cert_manager.metadata[0].name
#     }
#     spec = {
#       refreshInterval = "5m"
#       secretStoreRef = {
#         name = "aws-nonprod"
#         kind = "ClusterSecretStore"
#       }
#       target = {
#         name           = "cert-manager-zerossl-eab-creds"
#         creationPolicy = "Owner"
#       }
#       data = [
#         {
#           secretKey = "eab_key_id"
#           remoteRef = {
#             key      = "devzone/k8s/terraform"
#             property = "eab_key_id"
#           }
#         },
#         {
#           secretKey = "eab_hmac_key"
#           remoteRef = {
#             key      = "devzone/k8s/terraform"
#             property = "eab_hmac_key"
#           }
#         },
#       ]
#     }
#   })

#   server_side_apply = true
#   depends_on        = [helm_release.cert_manager]
# }


# resource "kubectl_manifest" "zerossl_clusterissuer" {
#   # ClusterIsssuer Ref: https://cert-manager.io/docs/configuration/acme/#configuration
#   yaml_body = yamlencode({
#     apiVersion = "cert-manager.io/v1"
#     kind       = "ClusterIssuer"
#     metadata = {
#       name = "zerossl-prod"
#     }
#     spec = {
#       acme = {
#         email  = "infrateam@wasabi.com"
#         server = "https://acme.zerossl.com/v2/DV90"
#         externalAccountBinding = {
#           keyID = "Ol6hYwftw8sz_dO2wROJGQ"
#           keySecretRef = {
#             name = kubectl_manifest.cert_manager_zerossl_eab_creds.name
#             key  = "eab_hmac_key"
#           }
#         }
#         privateKeySecretRef = {
#           name = "zerossl-issuer-account-key"
#         }
#         solvers = [
#           {
#             selector = {
#               dnsZones = [
#                 "wsbidev.net"
#               ]
#             }
#             dns01 = {
#               route53 = {
#                 region      = "us-east-1"
#                 accessKeyID = var.cert_manager_aws_iam_access_key
#                 secretAccessKeySecretRef = {
#                   name = kubernetes_secret.cert_manager_aws_creds.metadata[0].name
#                   key  = "aws_secret_access_key"
#                 }
#               }
#             }
#           }
#         ]
#       }
#     }
#   })
#   server_side_apply = true

#   depends_on = [helm_release.cert_manager]
# }

# resource "kubernetes_namespace" "external_dns" {
#   metadata {
#     name = "external-dns"
#   }
# }

# resource "kubernetes_secret" "external_dns_aws_access_key" {
#   metadata {
#     name      = "external-dns-aws-access-key"
#     namespace = kubernetes_namespace.external_dns.metadata[0].name
#   }
#   type = "Opaque"
#   data = {
#     aws_access_key_id     = var.external_dns_aws_iam_access_key
#     aws_secret_access_key = var.external_dns_aws_iam_secret_key
#   }

#   depends_on = [kubectl_manifest.aws_nonprod_secretstore]
# }

# resource "helm_release" "external_dns" { # https://artifacthub.io/packages/helm/external-dns/external-dns
#   name       = "external-dns"
#   chart      = "external-dns"
#   repository = "https://kubernetes-sigs.github.io/external-dns"
#   version    = "1.15.2"

#   namespace        = kubernetes_namespace.external_dns.metadata[0].name
#   create_namespace = false
#   lint             = true
#   timeout          = 300

#   values = [
#     yamlencode(yamldecode(file("${path.module}/helm/external-dns/values.yaml"))), # remove yaml comments & formatting from diff calculations
#     yamlencode({
#       provider = "aws"
#       env = [
#         {
#           name  = "AWS_DEFAULT_REGION"
#           value = "us-east-1"
#         },
#         {
#           name = "AWS_ACCESS_KEY_ID"
#           valueFrom = {
#             secretKeyRef = {
#               name     = kubernetes_secret.external_dns_aws_access_key.metadata[0].name
#               key      = "aws_access_key_id"
#               optional = false
#             }
#           }
#         },
#         {
#           name = "AWS_SECRET_ACCESS_KEY"
#           valueFrom = {
#             secretKeyRef = {
#               name     = kubernetes_secret.external_dns_aws_access_key.metadata[0].name
#               key      = "aws_secret_access_key"
#               optional = false
#             }
#           }
#         }
#       ]
#     })
#   ]
# }


# resource "kubernetes_namespace" "kyverno" {
#   metadata {
#     name = "kyverno"
#   }
# }

# resource "helm_release" "kyverno" { # https://artifacthub.io/packages/helm/kyverno/kyverno
#   name       = "kyverno"
#   chart      = "kyverno"
#   repository = "https://kyverno.github.io/kyverno"
#   version    = "3.3.7"

#   namespace        = kubernetes_namespace.kyverno.metadata[0].name
#   create_namespace = false
#   lint             = true
#   timeout          = 300

#   values = [
#     yamlencode(yamldecode(file("${path.module}/helm/kyverno/values.yaml"))), # remove yaml comments & formatting from diff calculations
#     yamlencode({})
#   ]
# }

# resource "kubernetes_namespace" "policy_reporter" {
#   metadata {
#     name = "policy-reporter"
#   }
# }

# resource "helm_release" "policy_reporter" { # https://artifacthub.io/packages/helm/policy-reporter/policy-reporter
#   name       = "policy-reporter"
#   chart      = "policy-reporter"
#   repository = "oci://ghcr.io/kyverno/charts"
#   version    = "3.0.4"

#   namespace        = kubernetes_namespace.policy_reporter.metadata[0].name
#   create_namespace = false
#   lint             = true
#   timeout          = 300

#   values = [
#     yamlencode(yamldecode(file("${path.module}/helm/policy_reporter/values.yaml"))), # remove yaml comments & formatting from diff calculations
#     yamlencode({})
#   ]

#   depends_on = [helm_release.kyverno]
# }

# resource "kubernetes_namespace" "vertical_pod_autoscaler" {
#   metadata {
#     name = "vertical-pod-autoscaler"
#   }
# }

# resource "helm_release" "vertical_pod_autoscaler" { # https://artifacthub.io/packages/helm/cowboysysop/vertical-pod-autoscaler
#   name       = "vertical-pod-autoscaler"
#   chart      = "vertical-pod-autoscaler"
#   repository = "https://cowboysysop.github.io/charts"
#   version    = "10.0.0"

#   namespace        = kubernetes_namespace.vertical_pod_autoscaler.metadata[0].name
#   create_namespace = false
#   lint             = true
#   timeout          = 300

#   values = [
#     yamlencode(yamldecode(file("${path.module}/helm/vertical-pod-autoscaler/values.yaml"))), # remove yaml comments & formatting from diff calculations
#     yamlencode({})
#   ]
# }
