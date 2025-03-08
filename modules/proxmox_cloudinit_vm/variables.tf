variable "hostname" {
  type = string
  sensitive = false
}

variable "vm_datastore_id" {
  type = string
  sensitive = false
}

variable "image_datastore_id" {
  type = string
  sensitive = false
}

variable "proxmox_node_name" {
  type = string
  sensitive = false
}
variable "cloud_init_filepath" {
  type = string
  sensitive = false
}

variable "cloud_os_image" {
  type = string
  sensitive = false
}

variable "num_cpu_cores" {
  type = number
  default = 2
}

variable "memory" {
  description = "In megabytes (mb)"
  type = number
  default = 4096
}

variable "disk_space" {
  description = "In gigabytes (gb)"
  type = number
  default = 20
}
