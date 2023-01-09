locals {
  region = "sfo3"
  ctr-nodes = {
    "k8s-ctr-1" : {}
    "k8s-worker-1" : {}
    "k8s-worker-2" : {}
    "k8s-worker-3" : {}
  }
}

resource "digitalocean_project" "k8s" {
  name        = "K8s Sandbox"
  description = "A project to represent development resources."
  purpose     = "Web Application"
  environment = "Development"

  resources = flatten([
    [for droplet in digitalocean_droplet.k8s-ctr : droplet.urn],
    [for vol in digitalocean_volume.k8s-ctr-vol1 : vol.urn],
  ])
}

data "digitalocean_ssh_key" "vyas-workbook-8" {
  name = "Vyas-Workbook-8"
}

resource "digitalocean_droplet" "k8s-ctr" {
  for_each    = local.ctr-nodes
  name        = each.key
  size        = "s-1vcpu-2gb"
  image       = "ubuntu-20-04-x64"
  region      = local.region
  ssh_keys    = [data.digitalocean_ssh_key.vyas-workbook-8.id]
  user_data   = file("${path.module}/k0s.cloud-init.yaml")
  resize_disk = false
  ipv6        = true
  monitoring  = true
}

resource "digitalocean_volume" "k8s-ctr-vol1" {
  for_each                = local.ctr-nodes
  name                    = "${each.key}-vol1"
  region                  = local.region
  size                    = 50
  initial_filesystem_type = "ext4"
  description             = "A Volume used to connect ${each.key} to Ceph."
}

resource "digitalocean_volume_attachment" "k8s-ctr" {
  for_each   = local.ctr-nodes
  droplet_id = digitalocean_droplet.k8s-ctr[each.key].id
  volume_id  = digitalocean_volume.k8s-ctr-vol1[each.key].id
}

output "nodes" {
  value = {
    for k, droplet in digitalocean_droplet.k8s-ctr : k => {
      ipv4 : droplet.ipv4_address,
      priv-ipv4 : droplet.ipv4_address_private,
    }
  }
}
