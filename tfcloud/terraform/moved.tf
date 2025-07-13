
moved {
  from = tfe_workspace.secrets_terraform
  to   = tfe_workspace.secrets
}

moved {
  from = tfe_workspace.remote_exec_workspace["unifi_terraform"]
  to   = tfe_workspace.remote_exec_workspace["unifi"]
}

moved {
  from = tfe_workspace.remote_exec_workspace["tfcloud_terraform"]
  to   = tfe_workspace.remote_exec_workspace["tfcloud"]
}

moved {
  from = tfe_workspace.remote_exec_workspace["tailscale_terraform"]
  to   = tfe_workspace.remote_exec_workspace["tailscale"]
}

moved {
  from = tfe_workspace.remote_exec_workspace["proxmox_terraform"]
  to   = tfe_workspace.remote_exec_workspace["proxmox"]
}

moved {
  from = tfe_workspace.remote_exec_workspace["digitalocean_terraform"]
  to   = tfe_workspace.remote_exec_workspace["digitalocean"]
}

moved {
  from = tfe_workspace.remote_exec_workspace["digitalocean_nyc3_do_k8s_terraform"]
  to   = tfe_workspace.remote_exec_workspace["k8s_digitalocean"]
}
