
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
