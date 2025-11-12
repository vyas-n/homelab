#!/usr/bin/env nu

def main [] {
    terraform init

    # Parallelism flag required as a workaround for this 1Password issue
    # ref: https://github.com/1Password/terraform-provider-onepassword/issues/140#issuecomment-2446856774
    #
    # TODO remove the `parallelism` flag when these issues are closed
    # ref:
    # - https://github.com/1Password/terraform-provider-onepassword/issues/130
    # - https://github.com/1Password/terraform-provider-onepassword/issues/140
    terraform apply -parallelism=1
}
