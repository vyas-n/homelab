
module "k8s_ctr_1" {
  # Module
  source = "./modules/proxmox_cloudinit_vm"

  ## Variables
  # Proxmox configs
  vm_datastore_id    = "ceph_block"
  image_datastore_id = proxmox_virtual_environment_download_file.fedora_41.datastore_id
  proxmox_node_name  = data.proxmox_virtual_environment_node.proxmox_1.node_name

  # VM Configs
  hostname            = "k8s-ctr-1"
  domain              = "vms.vyas-n.dev"
  cloud_os_image      = proxmox_virtual_environment_download_file.fedora_41.id
  cloud_init_filepath = "${path.module}/k8s-nodes.cloudinit.yaml"

  num_cpu_cores = 2
  memory        = 4096
  disk_space    = 32
}

module "k8s_wkr_1" {
  # Module
  source = "./modules/proxmox_cloudinit_vm"

  ## Variables
  # Proxmox configs
  vm_datastore_id    = "ceph_block"
  image_datastore_id = proxmox_virtual_environment_download_file.fedora_41.datastore_id
  proxmox_node_name  = data.proxmox_virtual_environment_node.proxmox_1.node_name

  # VM Configs
  hostname            = "k8s-wkr-1"
  domain              = "vms.vyas-n.dev"
  cloud_os_image      = proxmox_virtual_environment_download_file.fedora_41.id
  cloud_init_filepath = "${path.module}/k8s-nodes.cloudinit.yaml"

  num_cpu_cores = 8
  memory        = 8192
  disk_space    = 64
}

module "k8s_wkr_2" {
  # Module
  source = "./modules/proxmox_cloudinit_vm"

  ## Variables
  # Proxmox configs
  vm_datastore_id    = "ceph_block"
  image_datastore_id = proxmox_virtual_environment_download_file.fedora_41.datastore_id
  proxmox_node_name  = data.proxmox_virtual_environment_node.proxmox_2.node_name

  # VM Configs
  hostname            = "k8s-wkr-2"
  domain              = "vms.vyas-n.dev"
  cloud_os_image      = proxmox_virtual_environment_download_file.fedora_41.id
  cloud_init_filepath = "${path.module}/k8s-nodes.cloudinit.yaml"

  num_cpu_cores = 8
  memory        = 8192
  disk_space    = 64
}
