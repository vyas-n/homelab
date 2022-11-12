
terraform {
  cloud {
    organization = "vyas-n"
    workspaces {
      name = "vultr"
    }
  }
  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "~> 2"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3"
    }
  }
}

provider "vultr" {}

provider "cloudflare" {}

locals {
  nodes = toset([
    "k8s-node-1",
    "k8s-node-2",
    "k8s-node-3"
  ])
}

data "cloudflare_zone" "vyas-n" {
  name = "vyas-n.com"
}

resource "vultr_ssh_key" "vyas-workbook-8" {
  name    = "vyas-workbook-8"
  ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDKM++68IJCdPHvKyXLFH/GieCgC7ag3aUvYria2DlybKXzlodyHtNgD+Af5zGSkqddBqUVrwGnnlp0oZpuw4Dxq67ba97oRUmsFaEZUoF3yMDJ0583fnPFCVxYEmgrOUwbKa76o9Wf0Rrgl0SThlAj162XpSFoT1OKL/+vqqHhEjXZJ32R0uOhLEYG1MaJSmfPMFsEo470BXoiywYC3LauR29YG6duF8hZLgHVZnRmX4Kf+044njZqUs65dFob8KS1kXzNnraiEJ2cuK1abyof7xCcz7G7DC1uZRkLzh5GMquks5a8rCWKwhoPvvjyvhZbzEKMSJFuvZdAEyeRPweJm4bICk7WzkiPOSD2Q4JLHSCq7Zrg6gOlCgu+MXLP5KI5OT2Qxp6LW4Tn8lPRPiXqiYUKsRIFcdqnBCjl5zpXW7ibwqbLB8KQAwbbapnHUZ2NP3vvOdfzK5ShoOT01YOY14bHfNu5nOI6fqzW1uPPANlQ3uqkAW2+Zp0pUM1Pwuk="
}

resource "vultr_instance" "k8s-node" {
  for_each    = local.nodes
  plan        = "vhp-2c-4gb-amd" # curl "https://api.vultr.com/v2/plans" -X GET -H "Authorization: Bearer $VULTR_API_KEY" | dasel -p json -m --color '.plans.(ram=8192)' | less -r
  os_id       = 1743             # curl "https://api.vultr.com/v2/os" -X GET -H "Authorization: Bearer $VULTR_API_KEY" | dasel -p json -m --color '.os.(family=ubuntu)' | less -r
  hostname    = each.key
  region      = "dfw"
  user_data   = file("${path.module}/k0s.cloud-init.yaml")
  enable_ipv6 = true
  ssh_key_ids = [vultr_ssh_key.vyas-workbook-8.id]
}

# resource "vultr_reserved_ip" "k8s-node-ipv6" {
#   for_each    = local.nodes
#   label       = "${each.key}-ipv6"
#   region      = "dfw"
#   ip_type     = "v6"
#   instance_id = vultr_instance.k8s-node[each.key].id
# }

# resource "vultr_reserved_ip" "k8s-node-ipv4" {
#   for_each    = local.nodes
#   label       = "${each.key}-ipv4"
#   region      = "dfw"
#   ip_type     = "v4"
#   instance_id = vultr_instance.k8s-node[each.key].id
# }

resource "vultr_block_storage" "vol1" {
  for_each             = local.nodes
  label                = "${each.key}-vol1"
  size_gb              = 50
  block_type           = "storage_opt"
  region               = "dfw"
  live                 = true
  attached_to_instance = vultr_instance.k8s-node[each.key].id
}

resource "vultr_block_storage" "vol2" {
  for_each             = local.nodes
  label                = "${each.key}-vol2"
  size_gb              = 50
  block_type           = "storage_opt"
  region               = "dfw"
  live                 = true
  attached_to_instance = vultr_instance.k8s-node[each.key].id
}

resource "cloudflare_record" "k8s-node-a" {
  for_each = local.nodes
  zone_id  = data.cloudflare_zone.vyas-n.zone_id
  name     = each.key
  value    = vultr_instance.k8s-node[each.key].main_ip
  type     = "A"
  proxied  = true
}

resource "cloudflare_record" "k8s-node-aaaa" {
  for_each = local.nodes
  zone_id  = data.cloudflare_zone.vyas-n.zone_id
  name     = each.key
  value    = vultr_instance.k8s-node[each.key].v6_main_ip
  type     = "AAAA"
  proxied  = true
}

output "ipv4" {
  value = [for k in vultr_instance.k8s-node : k.main_ip]
}

output "ipv6" {
  value = [for k in vultr_instance.k8s-node : k.v6_main_ip]
}
