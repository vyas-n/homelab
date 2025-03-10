
module "fedora_vm" {
  # Module
  source = "../../modules/proxmox_cloudinit_vm"

  ## Variables
  # Proxmox configs
  vm_datastore_id = "ceph_block"
  image_datastore_id = "proxmox-smb-from-truenas"
  proxmox_node_name = "proxmox-2"

  # VM Configs
  hostname = "fedora-test"
  cloud_os_image = proxmox_virtual_environment_download_file.fedora_cloud_image.id
  cloud_init_filepath = "${path.module}/k8s-nodes.cloudinit.yaml"
}
