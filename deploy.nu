#! /usr/bin/env NIXPKGS_ALLOW_UNFREE=1 nix-shell
#! nix-shell -i nu --packages nushell nix

def main [] {
    # cd k8s/homezone/k0sctl

    # TODO: k0s apply
    # ./deploy.nu

    # cd ../../..

    # TODO: secrets tf workspace
    # cd secrets/terraform
    # ./deploy.nu
    # cd ../..

    # Ansible provisioning
    ./ansible/all.ansible-playbook.yaml
}
