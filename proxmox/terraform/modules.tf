
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

# module "k8s_ctr_1" {
#   # Module
#   source = "./modules/proxmox_cloudinit_vm"

#   ## Variables
#   # Proxmox configs
#   vm_datastore_id      = "local-zfs"
#   snippet_datastore_id = "cephfs"
#   proxmox_node_name    = data.proxmox_virtual_environment_node.proxmox_1.node_name

#   # VM Configs
#   hostname            = "k8s-ctr-1"
#   domain              = "vms.vyas-n.dev"
#   cloud_os_image      = proxmox_virtual_environment_download_file.fedora_41.id
#   cloud_init_filepath = "${path.module}/k8s-nodes.cloudinit.yaml"

#   num_cpu_cores = 2
#   memory        = 4096
#   disk_space    = 32
# }

# module "k8s_wkr_1" {
#   # Module
#   source = "./modules/proxmox_cloudinit_vm"

#   ## Variables
#   # Proxmox configs
#   vm_datastore_id      = "local-zfs"
#   snippet_datastore_id = "cephfs"
#   proxmox_node_name    = data.proxmox_virtual_environment_node.proxmox_1.node_name

#   # VM Configs
#   hostname            = "k8s-wkr-1"
#   domain              = "vms.vyas-n.dev"
#   cloud_os_image      = proxmox_virtual_environment_download_file.fedora_41.id
#   cloud_init_filepath = "${path.module}/k8s-nodes.cloudinit.yaml"

#   num_cpu_cores = 6
#   memory        = 8192
#   disk_space    = 128

#   # TODO: Remove
#   # This is a workaround b/c Ceph currently has a timeout on CephFS lock b/c the current Ceph cluster I/O is too slow
#   depends_on = [module.k8s_ctr_1]
# }

# module "k8s_wkr_2" {
#   # Module
#   source = "./modules/proxmox_cloudinit_vm"

#   ## Variables
#   # Proxmox configs
#   vm_datastore_id      = "local-zfs"
#   snippet_datastore_id = "cephfs"
#   proxmox_node_name    = data.proxmox_virtual_environment_node.proxmox_2.node_name

#   # VM Configs
#   hostname            = "k8s-wkr-2"
#   domain              = "vms.vyas-n.dev"
#   cloud_os_image      = proxmox_virtual_environment_download_file.fedora_41.id
#   cloud_init_filepath = "${path.module}/k8s-nodes.cloudinit.yaml"

#   num_cpu_cores = 4
#   memory        = 16384
#   disk_space    = 128

#   # TODO: Remove
#   # This is a workaround b/c Ceph currently has a timeout on CephFS lock b/c the current Ceph cluster I/O is too slow
#   depends_on = [module.k8s_ctr_1, module.k8s_wkr_1]
# }
