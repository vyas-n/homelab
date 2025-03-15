
data "cloudinit_config" "user_data_cloud_config" {
  gzip          = false
  base64_encode = false

  # Set the hostname
  part {
    filename     = "cloud-config.yaml"
    content_type = "text/cloud-config"

    content = <<EOT
      #cloud-config

      hostname: ${var.hostname}
      fqdn: ${var.hostname}.${var.domain}
    EOT
  }

  # Add the rest of the cloud-init
  part {
    filename     = "cloud-config.yaml"
    content_type = "text/cloud-config"

    content = file(var.cloud_init_filepath)
  }
}
