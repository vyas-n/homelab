#! /usr/bin/env NIXPKGS_ALLOW_UNFREE=1 nix-shell
#! nix-shell -i nu --packages nushell nix

def main [] {
    # k0s apply
    ./k8s/homezone/k0sctl/deploy.nu

    # TODO: secrets tf workspace
    # cd secrets/terraform
    # ./deploy.nu
    # cd ../..

    # Ansible provisioning
    ./ansible/all.ansible-playbook.yaml
}
