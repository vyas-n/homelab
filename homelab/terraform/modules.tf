
module "docker_server" {
  # Module
  source = "./modules/proxmox_cloudinit_vm"

  ## Variables
  # Proxmox configs
  vm_datastore_id      = "local-zfs"
  snippet_datastore_id = "cephfs"
  proxmox_node_name    = data.proxmox_virtual_environment_node.proxmox_1.node_name

  # VM Configs
  hostname            = "docker-server"
  domain              = "vms.vyas-n.dev"
  cloud_os_image      = proxmox_virtual_environment_download_file.fedora_41.id
  cloud_init_filepath = "${path.module}/docker-server.cloudinit.yaml"

  cpu_type      = "host"
  num_cpu_cores = 4
  memory        = pow(2, 14) # 16GiB
  disk_space    = 64
}

module "k8s_ctr" {
  count = 3
  # Module
  source = "./modules/proxmox_cloudinit_vm"

  ## Variables
  # Proxmox configs
  vm_datastore_id      = "ceph_rbd_nvme_osd"
  snippet_datastore_id = "cephfs"
  proxmox_node_name    = data.proxmox_virtual_environment_node.proxmox_1.node_name

  # VM Configs
  cpu_type            = "x86-64-v2-AES"
  hostname            = "k8s-ctr-${count.index}"
  domain              = "vms.vyas-n.dev"
  cloud_os_image      = proxmox_virtual_environment_download_file.fedora_41.id
  cloud_init_filepath = "${path.module}/k8s-nodes.cloudinit.yaml"

  num_cpu_cores = 1
  memory        = 4096
  disk_space    = 32
}

module "k8s_wkr" {
  count = 2
  # Module
  source = "./modules/proxmox_cloudinit_vm"

  ## Variables
  # Proxmox configs
  vm_datastore_id      = "ceph_rbd_nvme_osd"
  snippet_datastore_id = "cephfs"
  proxmox_node_name    = data.proxmox_virtual_environment_node.proxmox_1.node_name

  # VM Configs
  cpu_type            = "host"
  hostname            = "k8s-wkr-${count.index}"
  domain              = "vms.vyas-n.dev"
  cloud_os_image      = proxmox_virtual_environment_download_file.fedora_41.id
  cloud_init_filepath = "${path.module}/k8s-nodes.cloudinit.yaml"

  num_cpu_cores = 8
  memory        = pow(2, 15) # 32 GiB
  disk_space    = 128

  depends_on = [ module.k8s_ctr ]
}
