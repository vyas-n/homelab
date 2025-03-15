variable "hostname" {
  type      = string
  sensitive = false
}

variable "domain" {
  type      = string
  sensitive = false
}

variable "vm_datastore_id" {
  description = "ID of the datastore to host VM's OS & EFI Disks."
  type        = string
  sensitive   = false
}

variable "snippet_datastore_id" {
  description = "ID of the datastore to host VM's cloud-init snippet."
  type        = string
  sensitive   = false
}

variable "proxmox_node_name" {
  type      = string
  sensitive = false
}
variable "cloud_init_filepath" {
  type      = string
  sensitive = false
}

variable "cloud_os_image" {
  type      = string
  sensitive = false
}

variable "num_cpu_cores" {
  type    = number
  default = 1
}

variable "memory" {
  description = "In megabytes (mb)"
  type        = number
  default     = 2048
}

variable "disk_space" {
  description = "In gigabytes (gb)"
  type        = number
  default     = 20
}
