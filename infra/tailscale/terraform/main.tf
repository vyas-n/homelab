
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
    "vms.vyas-n.dev",
    "host.bos13.wsbidev.net",
    "host.needham.wsbidev.net"
  ]
}

resource "tailscale_dns_split_nameservers" "bos13" {
  domain = "bos13"

  nameservers = ["10.12.10.105", "10.12.10.106", "10.12.11.107"]
}

resource "tailscale_dns_split_nameservers" "needham" {
  domain = "needham"

  nameservers = ["10.0.50.105", "10.0.50.106", "10.0.50.107"]
}

resource "tailscale_dns_split_nameservers" "devzone_bos13" {
  domain = "host.bos13.wsbidev.net"

  nameservers = ["10.12.121.10"]
}

resource "tailscale_dns_split_nameservers" "devzone_needham" {
  domain = "host.needham.wsbidev.net"

  nameservers = ["10.0.92.10"]
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
