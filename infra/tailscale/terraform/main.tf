
resource "tailscale_contacts" "global" {
  account {
    email = "me@vyas-n.com"
  }

  support {
    email = "me@vyas-n.com"
  }

  security {
    email = "me@vyas-n.com"
  }
}

resource "tailscale_dns_preferences" "global" {
  magic_dns = true
}

resource "tailscale_dns_search_paths" "global" {
  search_paths = [
    "hosts.vyas-n.dev",
    "vms.vyas-n.dev"
  ]
}

resource "tailscale_dns_split_nameservers" "homezone_hosts" {
  domain = "hosts.vyas-n.dev"

  nameservers = ["192.168.2.1"]
}

resource "tailscale_dns_split_nameservers" "homezone_svcs" {
  domain = "svcs.vyas-n.dev"

  nameservers = ["192.168.2.1"]
}

resource "tailscale_dns_split_nameservers" "homezone_vms" {
  domain = "vms.vyas-n.dev"

  nameservers = ["192.168.2.1"]
}

# https://tailscale.com/docs/kubernetes-operator/quickstart#prerequisites
resource "tailscale_acl" "kubernetes_operator_grants" {
  acl = jsonencode({
    tagOwners : {
      "tag:k8s-operator" : ["autogroup:admin"],
      "tag:k8s" : ["tag:k8s-operator"],
    }
    autoApprovers : {
      services : {
        "tag:k8s" : ["tag:k8s"],
      },
    }
    acls : [
      // Allow everything to talk to everything on the tailnet. This should
      // be used on personal and test tailnets only.
      {
        action : "accept"
        src : ["*"]
        dst : ["*:*"]
      },
    ]
    grants : [
      // Allow everything on the tailnet to talk to the API Server Proxy. This should
      // be used on personal and test tailnets only.
      {
        src : ["*"],
        dst : ["tag:k8s-operator"],
        ip : ["tcp:443"]
      }
    ]
    nodeAttrs : [
      // Let the Kubernetes operator use Tailscale Funnel
      {
        target : ["tag:k8s"], // tag that the Tailscale operator uses to tag proxies; defaults to 'tag:k8s'
        attr : ["funnel"],
      }
    ]
  })
}
