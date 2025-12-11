# Terraform Cloud Root

## Requirements

| Name      | Version   |
|-----------|-----------|
| terraform | >= 1.11.0 |
| tfe       | >= 0.70.0 |

## Providers

| Name | Version |
|------|---------|
| tfe  | 0.71.0  |

## Resources

| Name                                                                                                                                                  | Type        |
|-------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [tfe_agent_pool.homelab](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/agent_pool)                                      | resource    |
| [tfe_organization_default_settings.vyas_n](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization_default_settings) | resource    |
| [tfe_run_trigger.remote_exec_workspace_secrets](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/run_trigger)              | resource    |
| [tfe_run_trigger.remote_exec_workspace_tfcloud](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/run_trigger)              | resource    |
| [tfe_variable_set.cloudflare](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set)                               | resource    |
| [tfe_variable_set.digitalocean](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set)                             | resource    |
| [tfe_variable_set.homezone_v1](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set)                              | resource    |
| [tfe_variable_set.onepass_connect_server_bedrock](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set)           | resource    |
| [tfe_variable_set.proxmox](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set)                                  | resource    |
| [tfe_variable_set.tailscale](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set)                                | resource    |
| [tfe_variable_set.tfc](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set)                                      | resource    |
| [tfe_variable_set.unifi](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set)                                    | resource    |
| [tfe_workspace.remote_exec_workspace](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace)                          | resource    |
| [tfe_workspace.secrets](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace)                                        | resource    |
| [tfe_workspace_settings.remote_exec_workspace](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_settings)        | resource    |
| [tfe_workspace_settings.secrets](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_settings)                      | resource    |
| [tfe_workspace_variable_set.homezone](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_variable_set)             | resource    |
| [tfe_workspace_variable_set.proxmox_to_proxmox](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_variable_set)   | resource    |
| [tfe_workspace_variable_set.tailscale](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_variable_set)            | resource    |
| [tfe_workspace_variable_set.unifi_to_proxmox](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_variable_set)     | resource    |
| [tfe_workspace_variable_set.unifi_to_unifi](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_variable_set)       | resource    |
| [tfe_project.default](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/project)                                         | data source |
