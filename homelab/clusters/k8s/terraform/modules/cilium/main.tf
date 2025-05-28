
resource "helm_release" "cilium" { # https://artifacthub.io/packages/helm/cilium/cilium
  name       = "cilium"
  chart      = "cilium"
  repository = "https://helm.cilium.io"
  version    = "1.15.14"

  namespace        = "kube-system"
  create_namespace = false
  lint             = true
  timeout          = 600

  # TODO: This line is only a workaround for: https://github.com/cilium/cilium/issues/27000#issuecomment-1648245965
  wait = false

  values = [
    yamlencode(yamldecode(file("${path.module}/helm/cilium/values.yaml"))), # remove yaml comments & formatting from diff calculations
    yamlencode({
      k8sServicePort = var.k8s_service_port
      k8sServiceHost = var.k8s_endpoint
      ipam = {
        operator = {
          clusterPoolIPv4PodCIDRList = [
            var.k8s_pod_cidr
          ]
        }
      }
    }),
  ]
}

# resource "kubectl_manifest" "bgp_peering_policy_er7" {
#   yaml_body = yamlencode({
#     apiVersion = "cilium.io/v2alpha1"
#     kind       = "CiliumBGPPeeringPolicy"
#     metadata = {
#       name = "01-bgp-peering-policy-er7"
#     }
#     spec = { # CiliumBGPPeeringPolicySpec
#       nodeSelector = {
#         matchLabels = {
#           "topology.kubernetes.io/region" = "needham"
#         }
#       }
#       virtualRouters = [ # []CiliumBGPVirtualRouter
#         {
#           localASN      = 64512
#           exportPodCIDR = false
#           serviceSelector = {
#             matchExpressions = [
#               {
#                 key      = "somekey"
#                 operator = "NotIn"
#                 values   = ["never-used-value"]
#               }
#             ]
#           }
#           neighbors : [ # []CiliumBGPNeighbor
#             {
#               peerAddress     = "10.0.94.2/32"
#               peerASN         = 64513
#               eBGPMultihopTTL = 5
#             },
#             {
#               peerAddress     = "10.0.94.3/32"
#               peerASN         = 64513
#               eBGPMultihopTTL = 10
#             }
#           ]
#         }
#       ]
#     }
#   })
#   server_side_apply = true

#   depends_on = [helm_release.cilium, time_sleep.wait_for_cilium]
# }

resource "time_sleep" "wait_for_cilium" {
  create_duration = "60s"

  depends_on = [helm_release.cilium]
}

resource "kubectl_manifest" "pool1" {
  yaml_body = yamlencode({
    apiVersion = "cilium.io/v2alpha1"
    kind       = "CiliumLoadBalancerIPPool"
    metadata = {
      name = "pool1"
    }
    spec = {
      blocks = [
        { cidr = "192.168.4.128/28" }
      ]
    }
  })
  server_side_apply = true

  depends_on = [helm_release.cilium, time_sleep.wait_for_cilium]
}

resource "kubectl_manifest" "policy1" {
  yaml_body = yamlencode({
    apiVersion = "cilium.io/v2alpha1"
    kind       = "CiliumL2AnnouncementPolicy"
    metadata = {
      name = "policy1"
    }
    spec = {
      nodeSelector = {
        matchExpressions = [
          {
            key      = "node-role.kubernetes.io/control-plane"
            operator = "DoesNotExist"
          }
        ]
      }
    }
  })
  server_side_apply = true

  depends_on = [helm_release.cilium, time_sleep.wait_for_cilium]
}
