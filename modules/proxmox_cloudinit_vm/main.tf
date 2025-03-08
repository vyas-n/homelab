
resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = var.image_datastore_id
  node_name    = var.proxmox_node_name

  source_raw {
    data = data.cloudinit_config.user_data_cloud_config.rendered

    file_name = "${var.hostname}.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
  name      = var.hostname
  node_name = var.proxmox_node_name

  agent {
    enabled = true
    trim = true
  }

  cpu {
    cores        = var.num_cpu_cores
    type         = "x86-64-v4"
  }
  machine = "q35"

  memory {
    dedicated = var.memory
    floating  = var.memory
  }

  operating_system {
    type = "l26"
  }
  disk {
    datastore_id = var.vm_datastore_id
    file_id      = var.cloud_os_image
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = var.disk_space
    cache = "writeback"
  }
  bios = "ovmf"
  efi_disk {
    datastore_id = var.vm_datastore_id
    type = "4m"
  }

  # This block is necessary in order to create a network device,
  # but is empty b/c we use all the default values
  network_device {}

  # 
  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
      ipv6 {
        address = "dhcp"
      }
    }
    datastore_id = var.vm_datastore_id

    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
  }
}
