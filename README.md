<!-- TODO: use documentation generation to manage this file -->

# Homelab

Hi there! This is my homelab where I try out new technologies, run home services, & play games with.

Feel free to checkout any of the following directories for more information about the terraform workspaces & modules that bring it all together.

Each terraform workspace / module has documentation generated by terraform-docs that shows a rough idea of what is going on.

<!-- This list is generated from the following nushell script -->
<!-- glob ./**/*.tf | path dirname | uniq | each {|| $in | path relative-to (pwd) } | each {|| $"[($in)]\(($in)\)"} | to yaml | str replace --all "'" "" -->
<!-- TODO: automatically generate this list via ./format.nu -->

- [proxmox/terraform](proxmox/terraform)
- [proxmox/terraform/modules/proxmox_cloudinit_vm](proxmox/terraform/modules/proxmox_cloudinit_vm)
- [proxmox/terraform/modules/proxmox_cloudinit_vm/modules/unifi_host_dns_records](proxmox/terraform/modules/proxmox_cloudinit_vm/modules/unifi_host_dns_records)
- [k8s/digitalocean/terraform](k8s/digitalocean/terraform)
- [k8s/homezone/terraform](k8s/homezone/terraform)
- [k8s/homezone/terraform/modules/rook_ceph](k8s/homezone/terraform/modules/rook_ceph)
- [k8s/homezone/terraform/modules/cluster_operators](k8s/homezone/terraform/modules/cluster_operators)
- [k8s/homezone/terraform/modules/monitoring_stack](k8s/homezone/terraform/modules/monitoring_stack)
- [k8s/homezone/terraform/modules/cilium](k8s/homezone/terraform/modules/cilium)
- [k8s/homezone/terraform/modules/cluster_services](k8s/homezone/terraform/modules/cluster_services)
- [secrets/terraform](secrets/terraform)
- [secrets/terraform/modules/proxmox_secrets](secrets/terraform/modules/proxmox_secrets)
- [secrets/terraform/modules/tfe_secrets](secrets/terraform/modules/tfe_secrets)
- [secrets/terraform/modules/gh_secrets](secrets/terraform/modules/gh_secrets)
- [digitalocean/terraform](digitalocean/terraform)
- [digitalocean/nyc3/terraform](digitalocean/nyc3/terraform)
- [tfcloud/terraform](tfcloud/terraform)
- [unifi/terraform](unifi/terraform)
- [tailscale/terraform](tailscale/terraform)
